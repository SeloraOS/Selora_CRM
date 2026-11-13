"use client";

import { useCallback, useEffect, useState } from "react";
import { CheckSquare, Loader2, Trash2 } from "lucide-react";
import { toast } from "sonner";
import { useLocale, useTranslations } from "next-intl";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useAuth } from "@/hooks/use-auth";
import type { LeadTask, Profile } from "@/types";
import { EmptyState, KButton, KInput, KSelect } from "@/components/kit";
import { LeadAvatar } from "./lead-avatar";

/** Per-lead to-dos with due date and assignee. */
export function TasksTab({
  supabase,
  contactId,
  profiles,
  canEdit,
  onChanged,
}: {
  supabase: SupabaseClient;
  contactId: string;
  profiles: Profile[];
  canEdit: boolean;
  onChanged?: () => void;
}) {
  const t = useTranslations("Lead");
  const locale = useLocale();
  const { profile, accountId } = useAuth();
  const [tasks, setTasks] = useState<LeadTask[]>([]);
  const [loading, setLoading] = useState(true);
  const [unavailable, setUnavailable] = useState(false);
  // "Now" is captured when the list loads (render must stay pure); overdue is judged against it.
  const [loadedAt, setLoadedAt] = useState(0);
  const [title, setTitle] = useState("");
  const [due, setDue] = useState("");
  const [assignee, setAssignee] = useState("");
  const [saving, setSaving] = useState(false);

  const load = useCallback(async () => {
    const { data, error } = await supabase
      .from("lead_tasks")
      .select("*")
      .eq("contact_id", contactId)
      .order("created_at", { ascending: false });
    setUnavailable(!!error);
    setLoadedAt(Date.now());
    setTasks(((data ?? []) as LeadTask[]).sort((a, b) => Number(a.status === "done") - Number(b.status === "done") || (a.due_at ?? "9").localeCompare(b.due_at ?? "9")));
    setLoading(false);
  }, [supabase, contactId]);

  useEffect(() => {
    // setState runs after the awaited query inside load().
    // eslint-disable-next-line react-hooks/set-state-in-effect
    load();
  }, [load]);

  async function add() {
    const text = title.trim();
    if (!text || !accountId) return;
    setSaving(true);
    const { error } = await supabase.from("lead_tasks").insert({
      account_id: accountId,
      contact_id: contactId,
      title: text,
      due_at: due ? new Date(due).toISOString() : null,
      assigned_to: assignee || profile?.id || null,
      created_by: profile?.id ?? null,
    });
    setSaving(false);
    if (error) {
      toast.error(t("taskFailed"));
      return;
    }
    setTitle("");
    setDue("");
    await load();
    onChanged?.();
  }

  async function toggle(task: LeadTask) {
    const done = task.status !== "done";
    const { error } = await supabase
      .from("lead_tasks")
      .update({ status: done ? "done" : "todo", completed_at: done ? new Date().toISOString() : null })
      .eq("id", task.id);
    if (error) {
      toast.error(t("taskFailed"));
      return;
    }
    await load();
    onChanged?.();
  }

  async function remove(task: LeadTask) {
    if (!window.confirm(t("deleteTaskConfirm"))) return;
    const { error } = await supabase.from("lead_tasks").delete().eq("id", task.id);
    if (error) {
      toast.error(t("taskFailed"));
      return;
    }
    await load();
    onChanged?.();
  }

  if (unavailable && !loading) {
    return <p className="k-muted" style={{ padding: 24, fontSize: 13 }}>{t("needMigration")}</p>;
  }

  return (
    <div style={{ padding: 16, display: "flex", flexDirection: "column", gap: 12 }}>
      {canEdit && (
        <div style={{ display: "flex", flexWrap: "wrap", gap: 8, alignItems: "center" }}>
          <KInput
            style={{ flex: "1 1 220px" }}
            value={title}
            placeholder={t("taskPlaceholder")}
            onChange={(e) => setTitle(e.target.value)}
            onKeyDown={(e) => e.key === "Enter" && void add()}
          />
          <KInput type="datetime-local" aria-label={t("taskDue")} title={t("taskDue")} value={due} onChange={(e) => setDue(e.target.value)} style={{ width: "auto" }} />
          <KSelect aria-label={t("taskAssignee")} title={t("taskAssignee")} value={assignee} onChange={(e) => setAssignee(e.target.value)} style={{ width: "auto" }}>
            <option value="">{t("assignToMe")}</option>
            {profiles.map((p) => (
              <option key={p.id} value={p.id}>{p.full_name || p.email}</option>
            ))}
          </KSelect>
          <KButton variant="primary" disabled={saving || !title.trim()} onClick={add}>
            {saving && <Loader2 size={13} className="animate-spin" />} {t("addTask")}
          </KButton>
        </div>
      )}

      {loading ? (
        <div className="k-muted" style={{ padding: 24, textAlign: "center", fontSize: 13 }}>{t("loading")}</div>
      ) : tasks.length === 0 ? (
        <EmptyState icon={CheckSquare}>{t("noTasks")}</EmptyState>
      ) : (
        <ul style={{ listStyle: "none", margin: 0, padding: 0 }}>
          {tasks.map((task) => {
            const done = task.status === "done";
            const overdue = !done && !!task.due_at && new Date(task.due_at).getTime() < loadedAt;
            const a = profiles.find((p) => p.id === task.assigned_to);
            return (
              <li key={task.id} style={{ display: "flex", alignItems: "center", gap: 10, padding: "10px 0", borderBottom: "1px solid var(--divider-color)" }}>
                <input type="checkbox" className="k-check" checked={done} disabled={!canEdit} onChange={() => toggle(task)} aria-label={t("taskDone")} />
                <div style={{ minWidth: 0, flex: 1 }}>
                  <div style={{ fontSize: 13, textDecoration: done ? "line-through" : "none", color: done ? "var(--text-muted)" : undefined }}>{task.title}</div>
                  {task.due_at && (
                    <div style={{ fontSize: 12, color: overdue ? "var(--danger, #e03636)" : "var(--text-muted)" }}>
                      {overdue ? `${t("overdue")} · ` : ""}
                      {new Date(task.due_at).toLocaleString(locale, { dateStyle: "medium", timeStyle: "short" })}
                    </div>
                  )}
                </div>
                {a && (
                  <span title={a.full_name || a.email}><LeadAvatar name={a.full_name || a.email} url={a.avatar_url} size={22} /></span>
                )}
                {canEdit && (
                  <KButton size="icon" aria-label={t("deleteTask")} title={t("deleteTask")} onClick={() => remove(task)}><Trash2 size={12} /></KButton>
                )}
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
