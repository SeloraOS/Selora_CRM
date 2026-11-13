"use client";

import { useCallback, useEffect, useState, type ComponentType } from "react";
import {
  Activity,
  ArrowRightLeft,
  Briefcase,
  CheckSquare,
  FileText,
  Loader2,
  Megaphone,
  MessageCircle,
  MessageSquare,
  Phone,
  PlayCircle,
  UserCheck,
  Workflow,
  Zap,
} from "lucide-react";
import { toast } from "sonner";
import { useLocale, useTranslations } from "next-intl";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useAuth } from "@/hooks/use-auth";
import type { Profile } from "@/types";
import { EmptyState, KButton } from "@/components/kit";
import { loadTimeline, type TimelineItem, type TimelineKind } from "@/lib/leads/timeline";
import { timeAgo } from "@/lib/leads/lead-utils";

type Icon = ComponentType<{ size?: number }>;
const ICONS: Record<TimelineKind, Icon> = {
  comment: MessageSquare,
  status: ArrowRightLeft,
  owner: UserCheck,
  converted: Briefcase,
  note: FileText,
  message_in: MessageCircle,
  message_out: MessageCircle,
  deal: Briefcase,
  task_created: CheckSquare,
  task_done: CheckSquare,
  call: Phone,
  automation: Zap,
  flow: Workflow,
  broadcast: Megaphone,
};

/** Comment box + the merged history of everything that happened to this lead. */
export function ActivityTab({
  supabase,
  contactId,
  profiles,
  canEdit,
  refreshKey,
  onChanged,
}: {
  supabase: SupabaseClient;
  contactId: string;
  profiles: Profile[];
  canEdit: boolean;
  /** Bump to reload (e.g. after a note, task or status change elsewhere on the page). */
  refreshKey: number;
  onChanged?: () => void;
}) {
  const t = useTranslations("Lead");
  const locale = useLocale();
  const { profile, accountId } = useAuth();
  const [items, setItems] = useState<TimelineItem[]>([]);
  const [loading, setLoading] = useState(true);
  const [draft, setDraft] = useState("");
  const [saving, setSaving] = useState(false);

  const load = useCallback(async () => {
    setItems(await loadTimeline(supabase, contactId, profiles));
    setLoading(false);
  }, [supabase, contactId, profiles]);

  useEffect(() => {
    // setState runs after the awaited queries inside load().
    // eslint-disable-next-line react-hooks/set-state-in-effect
    load();
  }, [load, refreshKey]);

  async function comment() {
    const text = draft.trim();
    if (!text || !accountId) return;
    setSaving(true);
    const { error } = await supabase
      .from("contact_events")
      .insert({ account_id: accountId, contact_id: contactId, type: "comment", actor_id: profile?.id ?? null, data: { text } });
    setSaving(false);
    if (error) {
      toast.error(t("commentFailed"));
      return;
    }
    setDraft("");
    await load();
    onChanged?.();
  }

  const none = t("noneValue");
  const line = (i: TimelineItem): string => {
    const d = i.data;
    const s = (v: unknown) => (v === null || v === undefined || v === "" ? none : String(v));
    switch (i.kind) {
      case "comment": return t("evComment");
      case "status": return d.from ? t("evStatus", { from: s(d.from), to: s(d.to) }) : t("evStatusSet", { to: s(d.to) });
      case "owner": return d.to ? (d.from ? t("evOwner", { from: s(d.from), to: s(d.to) }) : t("evOwnerSet", { to: s(d.to) })) : t("evOwnerCleared");
      case "converted": return t("evConverted", { title: s(d.title) });
      case "note": return t("evNote");
      case "message_in": return d.template ? t("evTemplateIn", { name: s(d.template) }) : t("evMessageIn");
      case "message_out": return d.template ? t("evTemplateOut", { name: s(d.template) }) : t("evMessageOut");
      case "deal": return t("evDeal", { title: s(d.title) });
      case "task_created": return t("evTaskCreated", { title: s(d.title) });
      case "task_done": return t("evTaskDone", { title: s(d.title) });
      case "call": return t("evCall", { direction: d.direction === "inbound" ? t("callInbound") : t("callOutbound") });
      case "automation": return t("evAutomation", { name: s(d.name), status: s(d.status) });
      case "flow": return t("evFlow", { name: s(d.name), status: s(d.status) });
      case "broadcast": return t("evBroadcast", { name: s(d.name) });
    }
  };

  return (
    <div style={{ padding: 16, display: "flex", flexDirection: "column", gap: 12 }}>
      {canEdit && (
        <div style={{ border: "1px solid var(--border-color)", borderRadius: 8, padding: 10, background: "var(--control-bg)" }}>
          <textarea
            className="k-inline"
            rows={3}
            value={draft}
            onChange={(e) => setDraft(e.target.value)}
            placeholder={t("commentPlaceholder")}
            style={{ border: 0 }}
          />
          <div style={{ display: "flex", justifyContent: "flex-end" }}>
            <KButton variant="primary" disabled={saving || !draft.trim()} onClick={comment}>
              {saving && <Loader2 size={13} className="animate-spin" />} {t("comment")}
            </KButton>
          </div>
        </div>
      )}

      {loading ? (
        <div className="k-muted" style={{ padding: 24, textAlign: "center", fontSize: 13 }}>{t("loading")}</div>
      ) : items.length === 0 ? (
        <EmptyState icon={Activity}>{t("noActivity")}</EmptyState>
      ) : (
        <ol style={{ listStyle: "none", margin: 0, padding: 0, display: "flex", flexDirection: "column" }}>
          {items.map((i) => {
            const Ico = ICONS[i.kind] ?? PlayCircle;
            return (
              <li key={i.id} style={{ display: "flex", gap: 10, padding: "10px 0", borderBottom: "1px solid var(--divider-color)" }}>
                <span className="k-avatar" style={{ width: 26, height: 26 }}><Ico size={13} /></span>
                <div style={{ minWidth: 0, flex: 1 }}>
                  <div style={{ fontSize: 13 }}>
                    {i.actor && <strong style={{ fontWeight: 600 }}>{i.actor} </strong>}
                    <span>{line(i)}</span>
                  </div>
                  {i.text && (
                    <p className="k-muted" style={{ margin: "4px 0 0", fontSize: 13, whiteSpace: "pre-wrap", overflowWrap: "anywhere" }}>
                      {i.text.length > 300 ? `${i.text.slice(0, 300)}…` : i.text}
                    </p>
                  )}
                </div>
                <time className="k-muted" dateTime={i.at} title={new Date(i.at).toLocaleString(locale)} style={{ fontSize: 12, flex: "none" }}>
                  {timeAgo(i.at, locale)}
                </time>
              </li>
            );
          })}
        </ol>
      )}
    </div>
  );
}
