"use client";

import { useCallback, useEffect, useState } from "react";
import { Loader2, Phone, PhoneIncoming, PhoneOutgoing, Trash2 } from "lucide-react";
import { toast } from "sonner";
import { useLocale, useTranslations } from "next-intl";
import type { SupabaseClient } from "@supabase/supabase-js";
import { useAuth } from "@/hooks/use-auth";
import type { LeadCall, Profile } from "@/types";
import { EmptyState, KButton, KInput, KSelect } from "@/components/kit";

const OUTCOMES = ["connected", "no_answer", "busy", "voicemail", "wrong_number", "callback"] as const;

/** Manual call log (no telephony): who called whom, outcome, duration, notes. */
export function CallsTab({
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
  const [calls, setCalls] = useState<LeadCall[]>([]);
  const [loading, setLoading] = useState(true);
  const [unavailable, setUnavailable] = useState(false);
  const [direction, setDirection] = useState<"inbound" | "outbound">("outbound");
  const [outcome, setOutcome] = useState<string>("connected");
  const [minutes, setMinutes] = useState("");
  const [notes, setNotes] = useState("");
  const [saving, setSaving] = useState(false);

  const load = useCallback(async () => {
    const { data, error } = await supabase
      .from("lead_calls")
      .select("*")
      .eq("contact_id", contactId)
      .order("called_at", { ascending: false });
    setUnavailable(!!error);
    setCalls((data ?? []) as LeadCall[]);
    setLoading(false);
  }, [supabase, contactId]);

  useEffect(() => {
    // setState runs after the awaited query inside load().
    // eslint-disable-next-line react-hooks/set-state-in-effect
    load();
  }, [load]);

  async function add() {
    if (!accountId) return;
    const mins = minutes.trim() === "" ? null : Number(minutes);
    if (mins !== null && (Number.isNaN(mins) || mins < 0)) {
      toast.error(t("callDurationInvalid"));
      return;
    }
    setSaving(true);
    const { error } = await supabase.from("lead_calls").insert({
      account_id: accountId,
      contact_id: contactId,
      direction,
      outcome,
      duration_seconds: mins === null ? null : Math.round(mins * 60),
      notes: notes.trim() || null,
      logged_by: profile?.id ?? null,
    });
    setSaving(false);
    if (error) {
      toast.error(t("callFailed"));
      return;
    }
    setMinutes("");
    setNotes("");
    await load();
    onChanged?.();
  }

  async function remove(call: LeadCall) {
    if (!window.confirm(t("deleteCallConfirm"))) return;
    const { error } = await supabase.from("lead_calls").delete().eq("id", call.id);
    if (error) {
      toast.error(t("callFailed"));
      return;
    }
    await load();
    onChanged?.();
  }

  if (unavailable && !loading) {
    return <p className="k-muted" style={{ padding: 24, fontSize: 13 }}>{t("needMigration")}</p>;
  }

  const outcomeLabel = (o?: string | null) => (o && (OUTCOMES as readonly string[]).includes(o) ? t(`outcome_${o}`) : o ?? "");
  const duration = (s?: number | null) => (s ? (s >= 60 ? `${Math.floor(s / 60)}m ${s % 60}s` : `${s}s`) : "");

  return (
    <div style={{ padding: 16, display: "flex", flexDirection: "column", gap: 12 }}>
      {canEdit && (
        <div style={{ display: "flex", flexDirection: "column", gap: 8, border: "1px solid var(--border-color)", borderRadius: 8, padding: 10 }}>
          <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
            <KSelect aria-label={t("callDirection")} title={t("callDirection")} value={direction} onChange={(e) => setDirection(e.target.value as "inbound" | "outbound")} style={{ width: "auto" }}>
              <option value="outbound">{t("callOutbound")}</option>
              <option value="inbound">{t("callInbound")}</option>
            </KSelect>
            <KSelect aria-label={t("callOutcome")} title={t("callOutcome")} value={outcome} onChange={(e) => setOutcome(e.target.value)} style={{ width: "auto" }}>
              {OUTCOMES.map((o) => (
                <option key={o} value={o}>{t(`outcome_${o}`)}</option>
              ))}
            </KSelect>
            <KInput type="number" min={0} step="0.5" placeholder={t("callMinutes")} value={minutes} onChange={(e) => setMinutes(e.target.value)} style={{ width: 120 }} />
          </div>
          <textarea className="k-inline" rows={2} value={notes} onChange={(e) => setNotes(e.target.value)} placeholder={t("callNotes")} style={{ border: "1px solid var(--border-color)" }} />
          <div style={{ display: "flex", justifyContent: "flex-end" }}>
            <KButton variant="primary" disabled={saving} onClick={add}>
              {saving && <Loader2 size={13} className="animate-spin" />} {t("logCall")}
            </KButton>
          </div>
        </div>
      )}

      {loading ? (
        <div className="k-muted" style={{ padding: 24, textAlign: "center", fontSize: 13 }}>{t("loading")}</div>
      ) : calls.length === 0 ? (
        <EmptyState icon={Phone}>{t("noCalls")}</EmptyState>
      ) : (
        <ul style={{ listStyle: "none", margin: 0, padding: 0 }}>
          {calls.map((c) => {
            const who = profiles.find((p) => p.id === c.logged_by);
            const Ico = c.direction === "inbound" ? PhoneIncoming : PhoneOutgoing;
            return (
              <li key={c.id} style={{ display: "flex", gap: 10, padding: "10px 0", borderBottom: "1px solid var(--divider-color)" }}>
                <span className="k-avatar" style={{ width: 26, height: 26 }}><Ico size={13} /></span>
                <div style={{ minWidth: 0, flex: 1 }}>
                  <div style={{ fontSize: 13 }}>
                    <strong style={{ fontWeight: 600 }}>{c.direction === "inbound" ? t("callInbound") : t("callOutbound")}</strong>
                    {c.outcome ? ` · ${outcomeLabel(c.outcome)}` : ""}
                    {c.duration_seconds ? ` · ${duration(c.duration_seconds)}` : ""}
                  </div>
                  {c.notes && <p className="k-muted" style={{ margin: "4px 0 0", fontSize: 13, whiteSpace: "pre-wrap" }}>{c.notes}</p>}
                  <div className="k-muted" style={{ fontSize: 12, marginTop: 2 }}>
                    {new Date(c.called_at).toLocaleString(locale, { dateStyle: "medium", timeStyle: "short" })}
                    {who ? ` · ${who.full_name || who.email}` : ""}
                  </div>
                </div>
                {canEdit && (
                  <KButton size="icon" aria-label={t("deleteCall")} title={t("deleteCall")} onClick={() => remove(c)}><Trash2 size={12} /></KButton>
                )}
              </li>
            );
          })}
        </ul>
      )}
    </div>
  );
}
