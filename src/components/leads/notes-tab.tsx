"use client";

import { useCallback, useEffect, useState } from "react";
import { Loader2, Pencil, Trash2 } from "lucide-react";
import { toast } from "sonner";
import { useLocale, useTranslations } from "next-intl";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useAuth } from "@/hooks/use-auth";
import type { ContactNote, Profile } from "@/types";
import { EmptyState, KButton } from "@/components/kit";
import { FileText } from "lucide-react";
import { LeadAvatar } from "./lead-avatar";
import { timeAgo } from "@/lib/leads/lead-utils";

/** Existing `contact_notes`, with author names and in-place editing. */
export function NotesTab({
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
  /** Called after any change so the Activity timeline can refresh. */
  onChanged?: () => void;
}) {
  const t = useTranslations("Lead");
  const locale = useLocale();
  const { user, accountId } = useAuth();
  const [notes, setNotes] = useState<ContactNote[]>([]);
  const [loading, setLoading] = useState(true);
  const [draft, setDraft] = useState("");
  const [saving, setSaving] = useState(false);
  const [editingId, setEditingId] = useState<string | null>(null);
  const [editText, setEditText] = useState("");

  const load = useCallback(async () => {
    const { data } = await supabase
      .from("contact_notes")
      .select("*")
      .eq("contact_id", contactId)
      .order("created_at", { ascending: false });
    setNotes((data ?? []) as ContactNote[]);
    setLoading(false);
  }, [supabase, contactId]);

  useEffect(() => {
    // setState runs after the awaited query inside load().
    // eslint-disable-next-line react-hooks/set-state-in-effect
    load();
  }, [load]);

  const author = (userId: string) => profiles.find((p) => p.user_id === userId);

  async function add() {
    const text = draft.trim();
    if (!text || !user || !accountId) return;
    setSaving(true);
    const { error } = await supabase
      .from("contact_notes")
      .insert({ contact_id: contactId, user_id: user.id, account_id: accountId, note_text: text });
    setSaving(false);
    if (error) {
      toast.error(t("noteFailed"));
      return;
    }
    setDraft("");
    await load();
    onChanged?.();
  }

  async function saveEdit(id: string) {
    const text = editText.trim();
    if (!text) return;
    const { error } = await supabase.from("contact_notes").update({ note_text: text }).eq("id", id);
    if (error) {
      toast.error(t("noteFailed"));
      return;
    }
    setEditingId(null);
    await load();
    onChanged?.();
  }

  async function remove(id: string) {
    if (!window.confirm(t("deleteNoteConfirm"))) return;
    const { error } = await supabase.from("contact_notes").delete().eq("id", id);
    if (error) {
      toast.error(t("noteFailed"));
      return;
    }
    await load();
    onChanged?.();
  }

  return (
    <div style={{ padding: 16, display: "flex", flexDirection: "column", gap: 12 }}>
      {canEdit && (
        <div style={{ border: "1px solid var(--border-color)", borderRadius: 8, padding: 10, background: "var(--control-bg)" }}>
          <textarea
            className="k-inline"
            rows={3}
            value={draft}
            onChange={(e) => setDraft(e.target.value)}
            placeholder={t("notePlaceholder")}
            style={{ border: 0 }}
          />
          <div style={{ display: "flex", justifyContent: "flex-end" }}>
            <KButton variant="primary" disabled={saving || !draft.trim()} onClick={add}>
              {saving && <Loader2 size={13} className="animate-spin" />} {t("addNote")}
            </KButton>
          </div>
        </div>
      )}

      {loading ? (
        <div className="k-muted" style={{ padding: 24, textAlign: "center", fontSize: 13 }}>{t("loading")}</div>
      ) : notes.length === 0 ? (
        <EmptyState icon={FileText}>{t("noNotes")}</EmptyState>
      ) : (
        notes.map((n) => {
          const a = author(n.user_id);
          return (
            <div key={n.id} style={{ border: "1px solid var(--border-color)", borderRadius: 8, padding: "10px 12px", background: "var(--card-bg)" }}>
              <div style={{ display: "flex", alignItems: "center", gap: 8, marginBottom: 6 }}>
                <LeadAvatar name={a?.full_name || a?.email} url={a?.avatar_url} size={20} />
                <span style={{ fontSize: 13, fontWeight: 600 }}>{a?.full_name || a?.email || t("someone")}</span>
                <span className="k-muted" style={{ fontSize: 12 }}>{timeAgo(n.created_at, locale)}</span>
                {canEdit && editingId !== n.id && (
                  <span style={{ marginLeft: "auto", display: "flex", gap: 4 }}>
                    <KButton size="icon" aria-label={t("editNote")} title={t("editNote")} onClick={() => { setEditingId(n.id); setEditText(n.note_text); }}><Pencil size={12} /></KButton>
                    <KButton size="icon" aria-label={t("deleteNote")} title={t("deleteNote")} onClick={() => remove(n.id)}><Trash2 size={12} /></KButton>
                  </span>
                )}
              </div>
              {editingId === n.id ? (
                <>
                  <textarea className="k-inline" rows={3} value={editText} onChange={(e) => setEditText(e.target.value)} style={{ border: "1px solid var(--border-color)" }} />
                  <div style={{ display: "flex", justifyContent: "flex-end", gap: 6, marginTop: 6 }}>
                    <KButton onClick={() => setEditingId(null)}>{t("cancel")}</KButton>
                    <KButton variant="primary" disabled={!editText.trim()} onClick={() => saveEdit(n.id)}>{t("saveNote")}</KButton>
                  </div>
                </>
              ) : (
                <p style={{ fontSize: 13, whiteSpace: "pre-wrap", margin: 0 }}>{n.note_text}</p>
              )}
            </div>
          );
        })
      )}
    </div>
  );
}
