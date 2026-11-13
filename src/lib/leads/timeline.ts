import type { SupabaseClient } from "@supabase/supabase-js";
import type { ContactEvent, ContactNote, Deal, LeadCall, LeadTask, Message, Profile } from "@/types";

export type TimelineKind =
  | "comment"
  | "status"
  | "owner"
  | "converted"
  | "note"
  | "message_in"
  | "message_out"
  | "deal"
  | "task_created"
  | "task_done"
  | "call"
  | "automation"
  | "flow"
  | "broadcast";

export interface TimelineItem {
  id: string;
  kind: TimelineKind;
  /** ISO timestamp */
  at: string;
  /** Who did it (profile name), when known. */
  actor?: string | null;
  /** Free text (comment / note / message body). */
  text?: string | null;
  /** Values for the translated one-liner. */
  data: Record<string, string | number | null | undefined>;
}

const PER_SOURCE = 40;

/** Run one query; a failing source (table not migrated yet, RLS) just contributes nothing. */
async function safe<T>(run: () => PromiseLike<{ data: unknown; error: unknown }>): Promise<T[]> {
  try {
    const { data, error } = await run();
    return error ? [] : ((data as T[] | null) ?? []);
  } catch {
    return [];
  }
}

/**
 * Merge everything that happened to one contact into a single newest-first list.
 * Each source is its own RLS-scoped query; they run in parallel.
 */
export async function loadTimeline(
  supabase: SupabaseClient,
  contactId: string,
  profiles: Profile[],
): Promise<TimelineItem[]> {
  const name = (profileId?: string | null) => {
    const p = profiles.find((x) => x.id === profileId);
    return p ? p.full_name || p.email : null;
  };

  const convs = await safe<{ id: string }>(() => supabase.from("conversations").select("id").eq("contact_id", contactId));
  const convIds = convs.map((c) => c.id);

  const [events, notes, messages, deals, tasks, calls, automations, flows, broadcasts] = await Promise.all([
    safe<ContactEvent>(() => supabase.from("contact_events").select("*").eq("contact_id", contactId).order("created_at", { ascending: false }).limit(PER_SOURCE)),
    safe<ContactNote>(() => supabase.from("contact_notes").select("*").eq("contact_id", contactId).order("created_at", { ascending: false }).limit(PER_SOURCE)),
    convIds.length
      ? safe<Message>(() => supabase.from("messages").select("*").in("conversation_id", convIds).order("created_at", { ascending: false }).limit(PER_SOURCE))
      : Promise.resolve([] as Message[]),
    safe<Pick<Deal, "id" | "title" | "created_at">>(() => supabase.from("deals").select("id, title, created_at").eq("contact_id", contactId).order("created_at", { ascending: false }).limit(PER_SOURCE)),
    safe<LeadTask>(() => supabase.from("lead_tasks").select("*").eq("contact_id", contactId).order("created_at", { ascending: false }).limit(PER_SOURCE)),
    safe<LeadCall>(() => supabase.from("lead_calls").select("*").eq("contact_id", contactId).order("called_at", { ascending: false }).limit(PER_SOURCE)),
    safe<{ id: string; status: string; created_at: string; automation: { name: string } | null }>(() =>
      supabase.from("automation_logs").select("id, status, created_at, automation:automations(name)").eq("contact_id", contactId).order("created_at", { ascending: false }).limit(PER_SOURCE),
    ),
    safe<{ id: string; status: string; started_at: string; flow: { name: string } | null }>(() =>
      supabase.from("flow_runs").select("id, status, started_at, flow:flows(name)").eq("contact_id", contactId).order("started_at", { ascending: false }).limit(PER_SOURCE),
    ),
    safe<{ id: string; sent_at: string | null; broadcast: { name: string } | null }>(() =>
      supabase.from("broadcast_recipients").select("id, sent_at, broadcast:broadcasts(name)").eq("contact_id", contactId).not("sent_at", "is", null).order("sent_at", { ascending: false }).limit(PER_SOURCE),
    ),
  ]);

  const items: TimelineItem[] = [];

  for (const e of events) {
    const d = e.data as Record<string, string | null | undefined>;
    if (e.type === "comment") items.push({ id: `ev:${e.id}`, kind: "comment", at: e.created_at, actor: name(e.actor_id), text: d.text ?? "", data: {} });
    else if (e.type === "status_changed") items.push({ id: `ev:${e.id}`, kind: "status", at: e.created_at, actor: name(e.actor_id), data: { from: d.from, to: d.to } });
    else if (e.type === "owner_changed") items.push({ id: `ev:${e.id}`, kind: "owner", at: e.created_at, actor: name(e.actor_id), data: { from: d.from, to: d.to } });
    else if (e.type === "converted") items.push({ id: `ev:${e.id}`, kind: "converted", at: e.created_at, actor: name(e.actor_id), data: { title: d.deal_title } });
  }
  for (const n of notes) {
    const p = profiles.find((x) => x.user_id === n.user_id);
    items.push({ id: `note:${n.id}`, kind: "note", at: n.created_at, actor: p ? p.full_name || p.email : null, text: n.note_text, data: {} });
  }
  for (const m of messages) {
    const inbound = m.sender_type === "customer";
    items.push({
      id: `msg:${m.id}`,
      kind: inbound ? "message_in" : "message_out",
      at: m.created_at,
      text: m.content_text || null,
      data: { template: m.template_name ?? null, type: m.content_type },
    });
  }
  for (const d of deals) items.push({ id: `deal:${d.id}`, kind: "deal", at: d.created_at, data: { title: d.title } });
  for (const tk of tasks) {
    items.push({ id: `task:${tk.id}`, kind: "task_created", at: tk.created_at, actor: name(tk.created_by), data: { title: tk.title } });
    if (tk.status === "done" && tk.completed_at) items.push({ id: `taskdone:${tk.id}`, kind: "task_done", at: tk.completed_at, data: { title: tk.title } });
  }
  for (const c of calls) items.push({ id: `call:${c.id}`, kind: "call", at: c.called_at, actor: name(c.logged_by), text: c.notes ?? null, data: { direction: c.direction, outcome: c.outcome ?? null, seconds: c.duration_seconds ?? null } });
  for (const a of automations) items.push({ id: `auto:${a.id}`, kind: "automation", at: a.created_at, data: { name: a.automation?.name ?? "", status: a.status } });
  for (const f of flows) items.push({ id: `flow:${f.id}`, kind: "flow", at: f.started_at, data: { name: f.flow?.name ?? "", status: f.status } });
  for (const b of broadcasts) if (b.sent_at) items.push({ id: `bc:${b.id}`, kind: "broadcast", at: b.sent_at, data: { name: b.broadcast?.name ?? "" } });

  return items.sort((a, b) => b.at.localeCompare(a.at)).slice(0, 150);
}
