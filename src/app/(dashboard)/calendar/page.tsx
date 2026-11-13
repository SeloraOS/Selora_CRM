"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useTranslations } from "next-intl";
import { toast } from "sonner";
import { Filter as FilterIcon } from "lucide-react";
import { createClient } from "@/lib/supabase/client";
import { useAuth } from "@/hooks/use-auth";
import { formatCurrency } from "@/lib/currency";
import type { Pipeline, PipelineStage } from "@/types";
import {
  CalendarView,
  FilterBar,
  KButton,
  KSelect,
  SearchBox,
  Toolbar,
  isoToYmd,
  type CalendarEvent,
} from "@/components/kit";

/** Every kind of thing the calendar can show. The user toggles them with the chips. */
const TYPES = [
  "dealClose",
  "dealResult",
  "broadcast",
  "automation",
  "flow",
  "contacts",
  "conversations",
  "notifications",
  "followUp",
  "tasksDue",
] as const;
type TypeId = (typeof TYPES)[number];

const TYPE_COLOR: Record<TypeId, string> = {
  dealClose: "#3b82f6",
  dealResult: "#22c55e",
  broadcast: "#f59e0b",
  automation: "#8b5cf6",
  flow: "#06b6d4",
  contacts: "#64748b",
  conversations: "#0ea5e9",
  notifications: "#ec4899",
  followUp: "#14b8a6",
  tasksDue: "#f97316",
};

const TYPES_KEY = "selora-calendar-types";
/** PostgREST returns at most this many rows for the per-day count types. */
const COUNT_LIMIT = 5000;

type Bucket = Record<TypeId, CalendarEvent[]>;
const emptyBuckets = (): Bucket => ({
  dealClose: [], dealResult: [], broadcast: [], automation: [], flow: [],
  contacts: [], conversations: [], notifications: [], followUp: [], tasksDue: [],
});

/** Local-day boundaries as ISO timestamps (the visible range is in the viewer's time zone). */
const startIso = (ymd: string) => new Date(`${ymd}T00:00:00`).toISOString();
const endIso = (ymd: string) => new Date(`${ymd}T23:59:59.999`).toISOString();

export default function CalendarPage() {
  const t = useTranslations("Calendar");
  const tk = useTranslations("Kit");
  const router = useRouter();
  const { defaultCurrency } = useAuth();
  const supabase = useMemo(() => createClient(), []);

  const [range, setRange] = useState<{ from: string; to: string } | null>(null);
  const [buckets, setBuckets] = useState<Bucket>(emptyBuckets);
  const [enabled, setEnabled] = useState<Set<TypeId>>(() => new Set(TYPES));
  const [search, setSearch] = useState("");
  const [pipelineId, setPipelineId] = useState("");
  const [pipelines, setPipelines] = useState<Pipeline[]>([]);
  const [loading, setLoading] = useState(false);
  const [showFilters, setShowFilters] = useState(false);
  // event id -> where a click should go
  const hrefs = useRef<Map<string, string>>(new Map());
  const stageColors = useRef<Map<string, string>>(new Map());
  const seq = useRef(0);

  // Remembered chip selection (loaded after mount so the first render matches the server).
  useEffect(() => {
    try {
      const saved = JSON.parse(localStorage.getItem(TYPES_KEY) ?? "null");
      // eslint-disable-next-line react-hooks/set-state-in-effect -- one-time load of a saved preference after mount
      if (Array.isArray(saved)) setEnabled(new Set(saved.filter((x): x is TypeId => (TYPES as readonly string[]).includes(x))));
    } catch {
      /* storage unavailable */
    }
  }, []);

  const setTypes = (next: Set<TypeId>) => {
    setEnabled(next);
    try {
      localStorage.setItem(TYPES_KEY, JSON.stringify([...next]));
    } catch {
      /* storage unavailable */
    }
  };

  // Pipelines + stage colours (for the deal chips) load once.
  useEffect(() => {
    (async () => {
      const [{ data: pl }, { data: st }] = await Promise.all([
        supabase.from("pipelines").select("*").order("created_at"),
        supabase.from("pipeline_stages").select("id, color"),
      ]);
      setPipelines((pl ?? []) as Pipeline[]);
      stageColors.current = new Map(((st ?? []) as Pick<PipelineStage, "id" | "color">[]).map((s) => [s.id, s.color]));
    })();
  }, [supabase]);

  const load = useCallback(
    async (from: string, to: string, pipeline: string) => {
      const mine = ++seq.current;
      setLoading(true);
      const fromIso = startIso(from);
      const toIso = endIso(to);
      const links = new Map<string, string>();
      const out = emptyBuckets();
      let failed = false;

      const perDay = (
        type: TypeId,
        rows: { created_at: string }[] | null,
        labelKey: "newContacts" | "newConversations" | "notificationsCount",
        href: string,
      ) => {
        const counts = new Map<string, number>();
        for (const r of rows ?? []) {
          const d = isoToYmd(r.created_at);
          counts.set(d, (counts.get(d) ?? 0) + 1);
        }
        const capped = (rows?.length ?? 0) >= COUNT_LIMIT;
        for (const [date, count] of counts) {
          const id = `${type}:${date}`;
          links.set(id, href);
          out[type].push({
            id,
            date,
            title: capped && counts.size === 1 ? t("moreThan", { count }) : t(labelKey, { count }),
            color: TYPE_COLOR[type],
          });
        }
      };

      const dealsBase = () => {
        let q = supabase.from("deals").select("id, title, value, currency, stage_id, status, expected_close_date, updated_at");
        if (pipeline) q = q.eq("pipeline_id", pipeline);
        return q;
      };

      const jobs: Array<Promise<void>> = [
        // 1. deal close dates
        (async () => {
          const { data, error } = await dealsBase().gte("expected_close_date", from).lte("expected_close_date", to);
          if (error) { failed = true; return; }
          for (const d of data ?? []) {
            const id = `dealClose:${d.id}`;
            links.set(id, "/pipelines");
            out.dealClose.push({
              id,
              date: d.expected_close_date as string,
              title: `${d.title} · ${formatCurrency(d.value, defaultCurrency)}`,
              color: stageColors.current.get(d.stage_id) ?? TYPE_COLOR.dealClose,
            });
          }
        })(),
        // 2. deals won / lost (day they were closed)
        (async () => {
          const { data, error } = await dealsBase().in("status", ["won", "lost"]).gte("updated_at", fromIso).lte("updated_at", toIso);
          if (error) { failed = true; return; }
          for (const d of data ?? []) {
            const id = `dealResult:${d.id}`;
            links.set(id, "/pipelines");
            out.dealResult.push({
              id,
              date: isoToYmd(d.updated_at as string),
              title: d.status === "won" ? t("dealWon", { title: d.title }) : t("dealLost", { title: d.title }),
              color: d.status === "won" ? "#22c55e" : "#ef4444",
            });
          }
        })(),
        // 3. broadcasts: scheduled date, otherwise created date
        (async () => {
          const { data, error } = await supabase
            .from("broadcasts")
            .select("id, name, status, scheduled_at, created_at")
            .or(
              `and(scheduled_at.gte.${fromIso},scheduled_at.lte.${toIso}),and(scheduled_at.is.null,created_at.gte.${fromIso},created_at.lte.${toIso})`,
            );
          if (error) { failed = true; return; }
          for (const b of data ?? []) {
            const id = `broadcast:${b.id}`;
            links.set(id, `/broadcasts/${b.id}`);
            out.broadcast.push({
              id,
              date: isoToYmd((b.scheduled_at ?? b.created_at) as string),
              title: b.name as string,
              sub: b.status as string,
              color: TYPE_COLOR.broadcast,
            });
          }
        })(),
        // 4. automation runs (last execution)
        (async () => {
          const { data, error } = await supabase
            .from("automations")
            .select("id, name, last_executed_at")
            .gte("last_executed_at", fromIso)
            .lte("last_executed_at", toIso);
          if (error) { failed = true; return; }
          for (const a of data ?? []) {
            const id = `automation:${a.id}`;
            links.set(id, `/automations/${a.id}/logs`);
            out.automation.push({ id, date: isoToYmd(a.last_executed_at as string), title: t("automationRan", { name: a.name }), color: TYPE_COLOR.automation });
          }
        })(),
        // 5. flow runs (last execution) via the existing flows API
        (async () => {
          const res = await fetch("/api/flows");
          if (!res.ok) { failed = true; return; }
          const json = (await res.json()) as { flows?: Array<{ id: string; name: string; last_executed_at: string | null }> };
          for (const f of json.flows ?? []) {
            if (!f.last_executed_at || f.last_executed_at < fromIso || f.last_executed_at > toIso) continue;
            const id = `flow:${f.id}`;
            links.set(id, `/flows/${f.id}/runs`);
            out.flow.push({ id, date: isoToYmd(f.last_executed_at), title: t("flowRan", { name: f.name }), color: TYPE_COLOR.flow });
          }
        })(),
        // 6-8. per-day counts
        (async () => {
          const { data, error } = await supabase.from("contacts").select("created_at").gte("created_at", fromIso).lte("created_at", toIso).limit(COUNT_LIMIT);
          if (error) { failed = true; return; }
          perDay("contacts", data, "newContacts", "/contacts");
        })(),
        (async () => {
          const { data, error } = await supabase.from("conversations").select("created_at").gte("created_at", fromIso).lte("created_at", toIso).limit(COUNT_LIMIT);
          if (error) { failed = true; return; }
          perDay("conversations", data, "newConversations", "/inbox");
        })(),
        (async () => {
          const { data, error } = await supabase.from("notifications").select("created_at").gte("created_at", fromIso).lte("created_at", toIso).limit(COUNT_LIMIT);
          if (error) { failed = true; return; }
          perDay("notifications", data, "notificationsCount", "/notifications");
        })(),
        // 9. lead follow-up dates (contacts.follow_up_date, migration 041; silent if not applied yet)
        (async () => {
          const { data, error } = await supabase
            .from("contacts")
            .select("id, name, phone, follow_up_date")
            .gte("follow_up_date", from)
            .lte("follow_up_date", to);
          if (error) return;
          for (const c of data ?? []) {
            const id = `followUp:${c.id}`;
            links.set(id, `/contacts/${c.id}`);
            out.followUp.push({ id, date: c.follow_up_date as string, title: t("followUpTitle", { name: c.name || c.phone }), color: TYPE_COLOR.followUp });
          }
        })(),
        // 10. open lead tasks by due date (lead_tasks, migration 041; silent if not applied yet)
        (async () => {
          const { data, error } = await supabase
            .from("lead_tasks")
            .select("id, contact_id, title, due_at")
            .eq("status", "todo")
            .gte("due_at", fromIso)
            .lte("due_at", toIso);
          if (error) return;
          for (const k of data ?? []) {
            const id = `tasksDue:${k.id}`;
            links.set(id, `/contacts/${k.contact_id}`);
            out.tasksDue.push({ id, date: isoToYmd(k.due_at as string), title: t("taskDueTitle", { title: k.title }), color: TYPE_COLOR.tasksDue });
          }
        })(),
      ];

      await Promise.all(jobs.map((j) => j.catch(() => { failed = true; })));
      if (mine !== seq.current) return; // a newer navigation superseded this one
      hrefs.current = links;
      setBuckets(out);
      setLoading(false);
      if (failed) toast.error(t("loadFailed"));
    },
    [supabase, t, defaultCurrency],
  );

  useEffect(() => {
    // The setters inside load() run after awaited Supabase calls, not synchronously in this effect body.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    if (range) load(range.from, range.to, pipelineId);
  }, [range, pipelineId, load]);

  const needle = search.trim().toLowerCase();
  const visible = useMemo(() => {
    const byType = {} as Record<TypeId, CalendarEvent[]>;
    for (const type of TYPES) {
      byType[type] = needle
        ? buckets[type].filter((e) => `${e.title} ${e.sub ?? ""}`.toLowerCase().includes(needle))
        : buckets[type];
    }
    return byType;
  }, [buckets, needle]);

  const events = useMemo(() => TYPES.filter((x) => enabled.has(x)).flatMap((x) => visible[x]), [visible, enabled]);
  const typeLabel = (x: TypeId) =>
    t(
      ({
        dealClose: "typeDealClose",
        dealResult: "typeDealResult",
        broadcast: "typeBroadcast",
        automation: "typeAutomation",
        flow: "typeFlow",
        contacts: "typeContacts",
        conversations: "typeConversations",
        notifications: "typeNotifications",
        followUp: "typeFollowUp",
        tasksDue: "typeTasksDue",
      } as const)[x],
    );

  const toggle = (x: TypeId) => {
    const next = new Set(enabled);
    if (next.has(x)) next.delete(x);
    else next.add(x);
    setTypes(next);
  };

  const activeFilters = (pipelineId ? 1 : 0) + (search ? 1 : 0);

  return (
    <div className="space-y-6">
      <div>
        <h1 className="text-2xl font-bold text-foreground">{t("title")}</h1>
        <p className="mt-1 text-sm text-muted-foreground">{t("subtitle")}</p>
      </div>

      <div className="overflow-hidden rounded-lg border border-border bg-card">
        <Toolbar
          left={<SearchBox value={search} onChange={setSearch} placeholder={t("searchPlaceholder")} width={260} />}
          right={
            <>
              <KButton aria-pressed={showFilters} onClick={() => setShowFilters((v) => !v)}>
                <FilterIcon className="size-3.5" />
                {tk("filter")}
                {activeFilters > 0 && <span className="k-count">{activeFilters}</span>}
              </KButton>
              <KButton onClick={() => setTypes(new Set(TYPES))}>{t("showAll")}</KButton>
              <KButton onClick={() => setTypes(new Set())}>{t("showNone")}</KButton>
            </>
          }
        />

        {showFilters && (
          <FilterBar columns={4}>
            <KSelect value={pipelineId} onChange={(e) => setPipelineId(e.target.value)}>
              <option value="">{t("pipelineAll")}</option>
              {pipelines.map((p) => (
                <option key={p.id} value={p.id}>{p.name}</option>
              ))}
            </KSelect>
            <KButton onClick={() => { setPipelineId(""); setSearch(""); }} disabled={activeFilters === 0}>
              <FilterIcon className="size-3.5" /> {tk("clearFilters")}
            </KButton>
          </FilterBar>
        )}

        {/* One chip per event type: click to show or hide it. */}
        <div className="k-chips" role="group" aria-label={t("typesLabel")} style={{ paddingTop: 12, paddingBottom: 4 }}>
          {TYPES.map((x) => {
            const on = enabled.has(x);
            return (
              <button
                key={x}
                type="button"
                aria-pressed={on}
                onClick={() => toggle(x)}
                className="k-btn"
                style={{ opacity: on ? 1 : 0.55, borderColor: on ? TYPE_COLOR[x] : undefined }}
              >
                <span style={{ width: 8, height: 8, borderRadius: "50%", background: TYPE_COLOR[x] }} />
                {typeLabel(x)}
                <span className="k-muted">{visible[x].length}</span>
              </button>
            );
          })}
        </div>

        <div style={{ height: 8 }} />
        <div style={{ opacity: loading ? 0.6 : 1, transition: "opacity .15s" }}>
          <CalendarView
            events={events}
            storageKey="selora-calendar-view"
            onRangeChange={setRange}
            onOpen={(id) => {
              const href = hrefs.current.get(id);
              if (href) router.push(href);
            }}
          />
        </div>
        {events.length === 0 && !loading && range && (
          <p className="k-muted px-6 pb-4 text-xs">{t("empty")}</p>
        )}
      </div>
    </div>
  );
}
