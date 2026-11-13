"use client";

import { useState, useEffect, useRef, useCallback, useMemo } from "react";
import { createClient } from "@/lib/supabase/client";
import type { Pipeline, PipelineStage, Deal } from "@/types";
import { PipelineBoard } from "@/components/pipelines/pipeline-board";
import { PipelineSettings } from "@/components/pipelines/pipeline-settings";
import { DealForm } from "@/components/pipelines/deal-form";
import { PipelineAnalytics } from "@/components/pipelines/pipeline-analytics";
import { Button } from "@/components/ui/button";
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogFooter,
} from "@/components/ui/dialog";
import {
  DropdownMenu,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
  DropdownMenuTrigger,
} from "@/components/ui/dropdown-menu";
import { Input } from "@/components/ui/input";
import { Label } from "@/components/ui/label";
import {
  GitBranch,
  Plus,
  ChevronDown,
  Settings,
  Filter as FilterIcon,
  Kanban as KanbanIcon,
  List as ListIcon,
  ChartGantt,
} from "lucide-react";
import {
  Toolbar,
  FilterBar,
  FilterChips,
  KButton,
  KInput,
  KSelect,
  SearchBox,
  ViewMenu,
  SortMenu,
  ColumnsMenu,
  ExportMenu,
  RecordTable,
  KanbanBoard,
  GanttChart,
  EmptyState,
  KBadge,
  useListPrefs,
  useViewMode,
  useKitLabels,
  searchRows,
  sortRows,
  isoToYmd,
  type Column,
  type GanttItem,
} from "@/components/kit";
import { formatCurrency } from "@/lib/currency";
import { toast } from "sonner";
import { useCan } from "@/hooks/use-can";
import { useAuth } from "@/hooks/use-auth";
import { GatedButton } from "@/components/ui/gated-button";
import { useTranslations } from "next-intl";

type DealView = "kanban" | "list" | "gantt";
const DEAL_VIEWS = ["kanban", "list", "gantt"] as const;
const GROUPS = ["stage", "status", "assignee"] as const;

interface DealFilters {
  stage: string;
  status: string;
  assignee: string; // "" = all, "__none" = unassigned, else profile id
  minValue: string;
  maxValue: string;
  closeFrom: string;
  closeTo: string;
}
const EMPTY_DEAL_FILTERS: DealFilters = { stage: "", status: "", assignee: "", minValue: "", maxValue: "", closeFrom: "", closeTo: "" };
const NO_ASSIGNEE = "__none";

// Pipeline creation is admin-class (settings-tier write under
// the new RLS); deal creation is operational and only requires
// agent+. The two CTAs gate on different `useCan` capabilities,
// not on different copy.

// Spec-defined seed — name and color per the product spec.
const SPEC_DEFAULT_STAGES = [
  { name: "New Lead", color: "#3b82f6", position: 0 }, // blue
  { name: "Qualified", color: "#eab308", position: 1 }, // yellow
  { name: "Proposal Sent", color: "#f97316", position: 2 }, // orange
  { name: "Negotiation", color: "#8b5cf6", position: 3 }, // purple
  { name: "Won", color: "#22c55e", position: 4 }, // green
];

export default function PipelinesPage() {
  const t = useTranslations("Pipelines.page");
  const supabase = createClient();
  const canEditSettings = useCan("edit-settings");
  const canCreateDeals = useCan("send-messages");
  const { accountId, defaultCurrency } = useAuth();

  const [pipelines, setPipelines] = useState<Pipeline[]>([]);
  const [selectedPipelineId, setSelectedPipelineId] = useState<string>("");
  const [stages, setStages] = useState<PipelineStage[]>([]);
  const [deals, setDeals] = useState<Deal[]>([]);
  const [loading, setLoading] = useState(true);

  // PMS-style toolbar state. Filters only affect the board/list/gantt below;
  // PipelineAnalytics keeps using ALL deals so its numbers never change with a filter.
  const tp = useTranslations("Pipelines.page");
  const tk = useTranslations("Kit");
  const kitLabels = useKitLabels();
  const [search, setSearch] = useState("");
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState<DealFilters>(EMPTY_DEAL_FILTERS);
  const { view, setView, group, setGroup } = useViewMode<DealView>("pipelines", DEAL_VIEWS, GROUPS);

  // Dialog / sheet state
  const [newPipelineOpen, setNewPipelineOpen] = useState(false);
  const [newPipelineName, setNewPipelineName] = useState("");
  const [creating, setCreating] = useState(false);
  const [settingsOpen, setSettingsOpen] = useState(false);

  // Deal form state is lifted here so both the top-bar "Add Deal" and
  // the per-column "+" trigger the same Sheet.
  const [dealFormOpen, setDealFormOpen] = useState(false);
  const [editingDeal, setEditingDeal] = useState<Deal | null>(null);
  const [defaultStageId, setDefaultStageId] = useState<string>("");

  // Guard against double-seeding (React StrictMode double-effect in dev).
  const seedAttempted = useRef(false);

  const loadPipelines = useCallback(async () => {
    const { data, error } = await supabase
      .from("pipelines")
      .select("*")
      .order("created_at");
    if (error) {
      console.error("Failed to load pipelines:", error.message);
      return [];
    }
    return data ?? [];
  }, [supabase]);

  const loadStages = useCallback(
    async (pipelineId: string) => {
      const { data } = await supabase
        .from("pipeline_stages")
        .select("*")
        .eq("pipeline_id", pipelineId)
        .order("position");
      return data ?? [];
    },
    [supabase],
  );

  const loadDeals = useCallback(
    async (pipelineId: string) => {
      const { data } = await supabase
        .from("deals")
        .select("*, contact:contacts(*), assignee:profiles!deals_assigned_to_fkey(*)")
        .eq("pipeline_id", pipelineId)
        .order("created_at", { ascending: false });
      return (data ?? []) as Deal[];
    },
    [supabase],
  );

  const seedDefaultPipeline = useCallback(async (): Promise<Pipeline | null> => {
    const {
      data: { session },
    } = await supabase.auth.getSession();
    const user = session?.user;
    if (!user) return null;
    // pipelines.account_id is NOT NULL post-017 with no DB default.
    if (!accountId) return null;

    const { data: pipeline, error } = await supabase
      .from("pipelines")
      .insert({ user_id: user.id, account_id: accountId, name: "Sales Pipeline" })
      .select()
      .single();

    if (error || !pipeline) {
      console.error("Failed to seed pipeline:", error?.message);
      return null;
    }

    const stagesPayload = SPEC_DEFAULT_STAGES.map((s) => ({
      pipeline_id: pipeline.id,
      name: s.name,
      color: s.color,
      position: s.position,
    }));
    await supabase.from("pipeline_stages").insert(stagesPayload);

    return pipeline as Pipeline;
  }, [supabase, accountId]);

  // Initial load + seed-if-empty
  useEffect(() => {
    let cancelled = false;
    (async () => {
      setLoading(true);
      let list = await loadPipelines();

      if (list.length === 0 && !seedAttempted.current) {
        seedAttempted.current = true;
        const seeded = await seedDefaultPipeline();
        if (seeded) list = await loadPipelines();
      }

      if (cancelled) return;
      setPipelines(list);
      if (list.length > 0) {
        setSelectedPipelineId((prev) =>
          prev && list.some((p) => p.id === prev) ? prev : list[0].id,
        );
      } else {
        setSelectedPipelineId("");
      }
      setLoading(false);
    })();
    return () => {
      cancelled = true;
    };
  }, [loadPipelines, seedDefaultPipeline]);

  // Load stages + deals whenever selected pipeline changes.
  // Clearing on no-selection is a legitimate sync with URL/prop
  // state; the load completion uses async setters inside promise
  // callbacks (not synchronous in the effect body).
  useEffect(() => {
    if (!selectedPipelineId) {
      // eslint-disable-next-line react-hooks/set-state-in-effect
      setStages([]);
      // eslint-disable-next-line react-hooks/set-state-in-effect
      setDeals([]);
      return;
    }
    let cancelled = false;
    (async () => {
      const [s, d] = await Promise.all([
        loadStages(selectedPipelineId),
        loadDeals(selectedPipelineId),
      ]);
      if (cancelled) return;
      setStages(s);
      setDeals(d);
    })();
    return () => {
      cancelled = true;
    };
  }, [selectedPipelineId, loadStages, loadDeals]);

  const refreshPipelines = useCallback(async () => {
    const list = await loadPipelines();
    setPipelines(list);
    if (list.length === 0) setSelectedPipelineId("");
    else if (!list.some((p) => p.id === selectedPipelineId))
      setSelectedPipelineId(list[0].id);
  }, [loadPipelines, selectedPipelineId]);

  const refreshStages = useCallback(async () => {
    if (!selectedPipelineId) return;
    setStages(await loadStages(selectedPipelineId));
  }, [loadStages, selectedPipelineId]);

  const refreshDeals = useCallback(async () => {
    if (!selectedPipelineId) return;
    setDeals(await loadDeals(selectedPipelineId));
  }, [loadDeals, selectedPipelineId]);

  const handleDealMoved = useCallback(
    async (dealId: string, newStageId: string) => {
      // Optimistic update — board already animated; just persist.
      setDeals((prev) =>
        prev.map((d) => (d.id === dealId ? { ...d, stage_id: newStageId } : d)),
      );
      const { error } = await supabase
        .from("deals")
        .update({ stage_id: newStageId })
        .eq("id", dealId);
      if (error) {
        toast.error(t("toastFailedMoveDeal"));
        refreshDeals();
      }
    },
    [supabase, refreshDeals, t],
  );

  const handleAddDeal = useCallback(
    (stageId?: string) => {
      setEditingDeal(null);
      setDefaultStageId(stageId ?? stages[0]?.id ?? "");
      setDealFormOpen(true);
    },
    [stages],
  );

  const handleEditDeal = useCallback((deal: Deal) => {
    setEditingDeal(deal);
    setDefaultStageId(deal.stage_id);
    setDealFormOpen(true);
  }, []);

  async function handleCreatePipeline() {
    const name = newPipelineName.trim();
    if (!name) return;
    setCreating(true);

    const {
      data: { session },
    } = await supabase.auth.getSession();
    const user = session?.user;
    if (!user) {
      setCreating(false);
      return;
    }
    // pipelines.account_id is NOT NULL post-017 with no DB default.
    if (!accountId) {
      toast.error(t("toastNotLinkedToAccount"));
      setCreating(false);
      return;
    }

    const { data: pipeline, error } = await supabase
      .from("pipelines")
      .insert({ user_id: user.id, account_id: accountId, name })
      .select()
      .single();

    if (error || !pipeline) {
      toast.error(t("toastFailedCreatePipeline"));
      setCreating(false);
      return;
    }

    const stagesPayload = SPEC_DEFAULT_STAGES.map((s) => ({
      pipeline_id: pipeline.id,
      name: s.name,
      color: s.color,
      position: s.position,
    }));
    await supabase.from("pipeline_stages").insert(stagesPayload);

    setNewPipelineName("");
    setNewPipelineOpen(false);
    setSelectedPipelineId(pipeline.id);
    await refreshPipelines();
    setCreating(false);
    toast.success(t("toastPipelineCreated"));
  }

  const selectedPipeline = pipelines.find((p) => p.id === selectedPipelineId);

  const stageById = useMemo(() => new Map(stages.map((st) => [st.id, st])), [stages]);
  const statusLabel = useCallback(
    (st?: string) => (st === "won" ? tp("statusWon") : st === "lost" ? tp("statusLost") : tp("statusOpen")),
    [tp],
  );

  const columns = useMemo<Column<Deal>[]>(
    () => [
      { key: "title", label: tp("colTitle"), required: true, primary: true, csv: (d) => d.title },
      { key: "contact", label: tp("colContact"), csv: (d) => d.contact?.name || d.contact?.phone || "" },
      { key: "stage", label: tp("colStage"), csv: (d) => stageById.get(d.stage_id)?.name ?? "", sortValue: (d) => stageById.get(d.stage_id)?.position,
        sortType: "number",
        render: (d) => {
          const st = stageById.get(d.stage_id);
          return st ? (
            <span className="inline-flex items-center gap-1.5">
              <span className="size-2 rounded-full" style={{ background: st.color }} />
              {st.name}
            </span>
          ) : "";
        } },
      { key: "status", label: tp("colStatus"), csv: (d) => statusLabel(d.status),
        render: (d) => <KBadge tone={d.status === "won" ? "green" : d.status === "lost" ? "red" : "blue"}>{statusLabel(d.status)}</KBadge> },
      { key: "value", label: tp("colValue"), align: "right", sortType: "number", csv: (d) => d.value,
        render: (d) => <span className="font-semibold tabular-nums">{formatCurrency(d.value, defaultCurrency)}</span> },
      { key: "assignee", label: tp("colAssignee"), hideBelow: "md", csv: (d) => d.assignee?.full_name ?? "" },
      { key: "expected_close_date", label: tp("colClose"), hideBelow: "md", sortType: "date", csv: (d) => d.expected_close_date ?? "" },
      { key: "created_at", label: tp("colCreated"), hideBelow: "lg", sortType: "date", defaultVisible: false, csv: (d) => d.created_at },
    ],
    [tp, stageById, statusLabel, defaultCurrency],
  );
  const prefs = useListPrefs<Deal>("pipelines", columns, { key: "created_at", order: "desc" });

  const assignees = useMemo(() => {
    const m = new Map<string, string>();
    deals.forEach((d) => d.assigned_to && m.set(d.assigned_to, d.assignee?.full_name || d.assigned_to));
    return [...m.entries()].sort((a, b) => a[1].localeCompare(b[1]));
  }, [deals]);

  const filteredDeals = useMemo(() => {
    const min = filters.minValue.trim() === "" ? null : Number(filters.minValue);
    const max = filters.maxValue.trim() === "" ? null : Number(filters.maxValue);
    const base = deals.filter((d) => {
      if (filters.stage && d.stage_id !== filters.stage) return false;
      if (filters.status && (d.status ?? "open") !== filters.status) return false;
      if (filters.assignee === NO_ASSIGNEE ? !!d.assigned_to : filters.assignee && d.assigned_to !== filters.assignee) return false;
      if (min !== null && !Number.isNaN(min) && Number(d.value) < min) return false;
      if (max !== null && !Number.isNaN(max) && Number(d.value) > max) return false;
      if (filters.closeFrom && (!d.expected_close_date || d.expected_close_date < filters.closeFrom)) return false;
      if (filters.closeTo && (!d.expected_close_date || d.expected_close_date > filters.closeTo)) return false;
      return true;
    });
    // search runs over every column's text (+ notes), like the PMS list pages
    return searchRows(base, columns, search, (d) => d.notes ?? "");
  }, [deals, filters, search, columns]);

  const sortedDeals = useMemo(
    () => sortRows(filteredDeals, prefs.sortColumn, prefs.sort.order),
    [filteredDeals, prefs.sortColumn, prefs.sort.order],
  );

  const filterChips = useMemo(() => {
    const chips: Array<{ key: string; label: string; onRemove: () => void }> = [];
    const clear = (k: keyof DealFilters) => () => setFilters((f) => ({ ...f, [k]: "" }));
    if (filters.stage) chips.push({ key: "stage", label: `${tp("colStage")}: ${stageById.get(filters.stage)?.name ?? ""}`, onRemove: clear("stage") });
    if (filters.status) chips.push({ key: "status", label: `${tp("colStatus")}: ${statusLabel(filters.status)}`, onRemove: clear("status") });
    if (filters.assignee) chips.push({ key: "assignee", label: `${tp("colAssignee")}: ${filters.assignee === NO_ASSIGNEE ? tp("unassigned") : assignees.find(([id]) => id === filters.assignee)?.[1] ?? ""}`, onRemove: clear("assignee") });
    if (filters.minValue) chips.push({ key: "min", label: `${tp("valueMin")}: ${filters.minValue}`, onRemove: clear("minValue") });
    if (filters.maxValue) chips.push({ key: "max", label: `${tp("valueMax")}: ${filters.maxValue}`, onRemove: clear("maxValue") });
    if (filters.closeFrom) chips.push({ key: "cf", label: `${tp("closeFrom")}: ${filters.closeFrom}`, onRemove: clear("closeFrom") });
    if (filters.closeTo) chips.push({ key: "ct", label: `${tp("closeTo")}: ${filters.closeTo}`, onRemove: clear("closeTo") });
    return chips;
  }, [filters, tp, stageById, statusLabel, assignees]);

  // Gantt: created -> expected close. Deals without a close date have no end, so they are left out (and counted).
  const ganttItems = useMemo<GanttItem[]>(() => {
    const out: GanttItem[] = [];
    for (const d of sortedDeals) {
      if (!d.expected_close_date) continue;
      const start = isoToYmd(d.created_at);
      const end = d.expected_close_date < start ? start : d.expected_close_date;
      const st = stageById.get(d.stage_id);
      const lastPos = Math.max(1, ...stages.map((x) => x.position));
      out.push({
        id: d.id,
        label: d.title,
        group: st?.name ?? "",
        groupColor: st?.color,
        start,
        end,
        color: st?.color,
        done: d.status === "won" || d.status === "lost",
        progress: d.status === "won" ? 100 : st ? Math.round((st.position / lastPos) * 100) : 0,
        tooltip: `${d.title}\n${formatCurrency(d.value, defaultCurrency)} · ${statusLabel(d.status)}\n${start} → ${end}`,
      });
    }
    return out;
  }, [sortedDeals, stageById, stages, statusLabel, defaultCurrency]);
  const unscheduled = sortedDeals.filter((d) => !d.expected_close_date).length;

  const openDealById = useCallback(
    (id: string) => {
      const d = deals.find((x) => x.id === id);
      if (d) handleEditDeal(d);
    },
    [deals, handleEditDeal],
  );

  // Read-only grouped boards (Status / Assignee). Stage grouping keeps the existing draggable board.
  const groupColumns = useMemo(() => {
    if (group === "status")
      return [
        { id: "open", label: tp("statusOpen"), color: "#3b82f6" },
        { id: "won", label: tp("statusWon"), color: "#22c55e" },
        { id: "lost", label: tp("statusLost"), color: "#ef4444" },
      ];
    return [
      { id: NO_ASSIGNEE, label: tp("unassigned"), color: "var(--text-muted)" },
      ...assignees.map(([id, name]) => ({ id, label: name, color: "var(--primary)" })),
    ];
  }, [group, assignees, tp]);
  const groupOf = useCallback(
    (d: Deal) => (group === "status" ? (d.status ?? "open") : (d.assigned_to ?? NO_ASSIGNEE)),
    [group],
  );

  const activeFilterCount = filterChips.length;

  if (loading) {
    return (
      <div className="space-y-6">
        <div className="flex items-center justify-between">
          <div className="h-8 w-48 animate-pulse rounded bg-muted" />
          <div className="h-9 w-28 animate-pulse rounded-lg bg-muted" />
        </div>
        <div className="flex gap-3">
          {[1, 2, 3, 4, 5].map((i) => (
            <div key={i} className="h-96 w-72 animate-pulse rounded-xl bg-muted/50" />
          ))}
        </div>
      </div>
    );
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-wrap items-center justify-between gap-3">
        <div className="flex items-center gap-3">
          {/* Pipeline selector dropdown */}
          <DropdownMenu>
            <DropdownMenuTrigger
              className="inline-flex items-center gap-2 rounded-lg border border-border bg-card px-3 py-2 text-sm text-foreground hover:bg-muted transition-colors data-[popup-open]:bg-muted"
            >
              <GitBranch className="h-4 w-4 text-primary" />
              <span className="font-semibold">
                {selectedPipeline?.name ?? t("selectPipeline")}
              </span>
              <ChevronDown className="h-4 w-4 text-muted-foreground" />
            </DropdownMenuTrigger>
            <DropdownMenuContent
              align="start"
              className="w-64 border-border bg-popover text-popover-foreground"
            >
              {pipelines.length === 0 && (
                <DropdownMenuItem disabled className="text-muted-foreground">
                  {t("noPipelinesYet")}
                </DropdownMenuItem>
              )}
              {pipelines.map((p) => (
                <DropdownMenuItem
                  key={p.id}
                  onClick={() => setSelectedPipelineId(p.id)}
                  className={
                    p.id === selectedPipelineId
                      ? "text-primary"
                      : "text-popover-foreground"
                  }
                >
                  <GitBranch className="mr-2 h-3.5 w-3.5" />
                  {p.name}
                </DropdownMenuItem>
              ))}
              <DropdownMenuSeparator className="bg-border" />
              {selectedPipeline && (
                <DropdownMenuItem
                  onClick={() => setSettingsOpen(true)}
                  className="text-popover-foreground"
                >
                  <Settings className="mr-2 h-3.5 w-3.5" />
                  {t("managePipelines")}
                </DropdownMenuItem>
              )}
            </DropdownMenuContent>
          </DropdownMenu>
        </div>

        <div className="flex items-center gap-2">
          <GatedButton
            variant="outline"
            canAct={canEditSettings}
            gateReason="create pipelines"
            onClick={() => setNewPipelineOpen(true)}
            className="border-border bg-card text-foreground hover:bg-muted"
          >
            <Plus className="mr-1 h-4 w-4" />
            {t("addPipeline")}
          </GatedButton>
          <GatedButton
            canAct={canCreateDeals}
            gateReason="create deals"
            disabled={!selectedPipelineId || stages.length === 0}
            onClick={() => handleAddDeal()}
            className="bg-primary text-primary-foreground hover:bg-primary/90"
          >
            <Plus className="mr-1 h-4 w-4" />
            {t("addDeal")}
          </GatedButton>
        </div>
      </div>

      {/* Board */}
      {pipelines.length === 0 ? (
        <div className="flex flex-col items-center justify-center rounded-xl border border-dashed border-border py-20">
          <GitBranch className="h-12 w-12 text-muted-foreground" />
          <h3 className="mt-4 text-lg font-medium text-foreground">
            {t("noPipelinesYet")}
          </h3>
          <p className="mt-2 text-sm text-muted-foreground">
            {t("createToStartTracking")}
          </p>
          <GatedButton
            canAct={canEditSettings}
            gateReason="create pipelines"
            onClick={() => setNewPipelineOpen(true)}
            className="mt-4 bg-primary text-primary-foreground hover:bg-primary/90"
          >
            <Plus className="mr-1 h-4 w-4" />
            {t("createPipeline")}
          </GatedButton>
        </div>
      ) : (
        <>
          <PipelineAnalytics stages={stages} deals={deals} />

          <div className="overflow-hidden rounded-lg border border-border bg-card">
            <Toolbar
              left={
                <>
                  <ViewMenu
                    view={view}
                    setView={setView}
                    views={[
                      { id: "kanban", label: tk("kanbanView"), icon: KanbanIcon },
                      { id: "list", label: tk("listView"), icon: ListIcon },
                      { id: "gantt", label: tk("ganttView"), icon: ChartGantt },
                    ]}
                    groups={[
                      { id: "stage", label: tp("groupStage") },
                      { id: "status", label: tp("groupStatus") },
                      { id: "assignee", label: tp("groupAssignee") },
                    ]}
                    group={group}
                    setGroup={setGroup}
                    labels={kitLabels}
                  />
                  <SearchBox value={search} onChange={setSearch} placeholder={tp("searchDeals")} />
                </>
              }
              right={
                <>
                  <KButton aria-pressed={showFilters} onClick={() => setShowFilters((v) => !v)}>
                    <FilterIcon className="size-3.5" />
                    {tk("filter")}
                    {activeFilterCount > 0 && <span className="k-count">{activeFilterCount}</span>}
                  </KButton>
                  {view === "list" && (
                    <>
                      <SortMenu columns={columns} sort={prefs.sort} onChange={prefs.setSort} labels={kitLabels} />
                      <ColumnsMenu
                        columns={columns}
                        visibleSet={prefs.visibleSet}
                        onToggle={prefs.toggleColumn}
                        onReset={prefs.resetColumns}
                        labels={kitLabels}
                      />
                    </>
                  )}
                  <ExportMenu
                    name="deals"
                    columns={prefs.visibleColumns}
                    rows={sortedDeals}
                    disabled={sortedDeals.length === 0}
                    labels={kitLabels}
                  />
                </>
              }
            />

            {showFilters && (
              <FilterBar columns={4}>
                <KSelect value={filters.stage} onChange={(e) => setFilters((f) => ({ ...f, stage: e.target.value }))}>
                  <option value="">{tp("stageAll")}</option>
                  {stages.map((st) => (
                    <option key={st.id} value={st.id}>{st.name}</option>
                  ))}
                </KSelect>
                <KSelect value={filters.status} onChange={(e) => setFilters((f) => ({ ...f, status: e.target.value }))}>
                  <option value="">{tk("allStatuses")}</option>
                  <option value="open">{tp("statusOpen")}</option>
                  <option value="won">{tp("statusWon")}</option>
                  <option value="lost">{tp("statusLost")}</option>
                </KSelect>
                <KSelect value={filters.assignee} onChange={(e) => setFilters((f) => ({ ...f, assignee: e.target.value }))}>
                  <option value="">{tp("assigneeAll")}</option>
                  <option value={NO_ASSIGNEE}>{tp("unassigned")}</option>
                  {assignees.map(([id, name]) => (
                    <option key={id} value={id}>{name}</option>
                  ))}
                </KSelect>
                <KInput type="number" min={0} placeholder={tp("valueMin")} value={filters.minValue} onChange={(e) => setFilters((f) => ({ ...f, minValue: e.target.value }))} />
                <KInput type="number" min={0} placeholder={tp("valueMax")} value={filters.maxValue} onChange={(e) => setFilters((f) => ({ ...f, maxValue: e.target.value }))} />
                <KInput type="date" aria-label={tp("closeFrom")} title={tp("closeFrom")} value={filters.closeFrom} onChange={(e) => setFilters((f) => ({ ...f, closeFrom: e.target.value }))} />
                <KInput type="date" aria-label={tp("closeTo")} title={tp("closeTo")} value={filters.closeTo} onChange={(e) => setFilters((f) => ({ ...f, closeTo: e.target.value }))} />
                <KButton onClick={() => { setFilters(EMPTY_DEAL_FILTERS); setSearch(""); }} disabled={activeFilterCount === 0 && !search}>
                  <FilterIcon className="size-3.5" /> {tk("clearFilters")}
                </KButton>
              </FilterBar>
            )}
            <FilterChips items={filterChips} />

            {view === "kanban" && group === "stage" && (
              <PipelineBoard
                stages={stages}
                deals={filteredDeals}
                onDealMoved={handleDealMoved}
                onAddDeal={handleAddDeal}
                onEditDeal={handleEditDeal}
              />
            )}
            {view === "kanban" && group !== "stage" && (
              <KanbanBoard
                columns={groupColumns}
                items={sortedDeals}
                getColumn={groupOf}
                getId={(d) => d.id}
                onOpen={handleEditDeal}
                emptyLabel={tk("noItems")}
                renderCard={(d) => (
                  <>
                    <div style={{ fontSize: 13, fontWeight: 600 }}>{d.title}</div>
                    <div className="k-muted" style={{ fontSize: 12, margin: "2px 0 6px" }}>
                      {d.contact?.name || d.contact?.phone || ""}
                    </div>
                    <div style={{ fontSize: 13, fontWeight: 700, color: "var(--primary)" }}>
                      {formatCurrency(d.value, defaultCurrency)}
                    </div>
                  </>
                )}
              />
            )}
            {view === "list" &&
              (sortedDeals.length === 0 ? (
                <EmptyState icon={GitBranch}>{tp("noDealsMatch")}</EmptyState>
              ) : (
                <RecordTable
                  columns={prefs.visibleColumns}
                  rows={sortedDeals}
                  getId={(d) => d.id}
                  onOpen={handleEditDeal}
                  sort={prefs.sort}
                  onSort={(key) =>
                    prefs.setSort({ key, order: prefs.sort.key === key && prefs.sort.order === "asc" ? "desc" : "asc" })
                  }
                />
              ))}
            {view === "gantt" && (
              <GanttChart
                items={ganttItems}
                onOpen={openDealById}
                headerLabel={tp("ganttHeader")}
                footerNote={unscheduled > 0 ? tp("unscheduledNote", { count: unscheduled }) : undefined}
              />
            )}
          </div>
        </>
      )}

      {/* New Pipeline Dialog */}
      <Dialog open={newPipelineOpen} onOpenChange={setNewPipelineOpen}>
        <DialogContent className="sm:max-w-sm bg-popover border-border">
          <DialogHeader>
            <DialogTitle className="text-popover-foreground">{t("newPipeline")}</DialogTitle>
          </DialogHeader>
          <div className="py-2">
            <Label className="text-muted-foreground">{t("pipelineName")}</Label>
            <Input
              value={newPipelineName}
              onChange={(e) => setNewPipelineName(e.target.value)}
              placeholder={t("pipelineNamePlaceholder")}
              className="mt-2 bg-muted border-border text-foreground"
              onKeyDown={(e) => {
                if (e.key === "Enter") handleCreatePipeline();
              }}
            />
            <p className="mt-2 text-xs text-muted-foreground">
              {t("defaultStagesDesc")}
            </p>
          </div>
          <DialogFooter className="bg-popover/50 border-border">
            <Button
              variant="outline"
              onClick={() => setNewPipelineOpen(false)}
              className="border-border text-muted-foreground hover:bg-muted"
            >
              {t("cancel")}
            </Button>
            <Button
              onClick={handleCreatePipeline}
              disabled={creating || !newPipelineName.trim()}
              className="bg-primary text-primary-foreground hover:bg-primary/90"
            >
              {creating ? t("creating") : t("createPipelineBtn")}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Pipeline Settings */}
      {selectedPipeline && (
        <PipelineSettings
          open={settingsOpen}
          onOpenChange={setSettingsOpen}
          pipeline={selectedPipeline}
          stages={stages}
          onPipelinesChanged={refreshPipelines}
          onStagesChanged={refreshStages}
          onCreateNewPipeline={() => {
            setSettingsOpen(false);
            setNewPipelineOpen(true);
          }}
        />
      )}

      {/* Deal Form (Sheet) */}
      <DealForm
        open={dealFormOpen}
        onOpenChange={setDealFormOpen}
        deal={editingDeal}
        pipelineId={selectedPipelineId}
        stages={stages}
        defaultStageId={defaultStageId}
        onSaved={refreshDeals}
      />
    </div>
  );
}
