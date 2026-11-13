"use client";

import { useEffect, useMemo, useState } from "react";
import { useRouter } from "next/navigation";
import { Loader2 } from "lucide-react";
import { toast } from "sonner";
import { useTranslations } from "next-intl";
import type { SupabaseClient } from "@supabase/supabase-js";
import type { Contact, Pipeline, PipelineStage, Profile } from "@/types";
import { useAuth } from "@/hooks/use-auth";
import { CURRENCIES, DEFAULT_CURRENCY } from "@/lib/currency";
import { KButton, KField, KInput, KModal, KSelect, ModalBody, ModalFooter } from "@/components/kit";

/**
 * "Convert to Deal": one atomic database call (convert_contact_to_deal) that creates the deal
 * for this contact and marks the lead converted. The contact, chat and history stay as they are.
 */
export function ConvertDialog({
  supabase,
  contact,
  profiles,
  force,
  onClose,
  onConverted,
}: {
  supabase: SupabaseClient;
  contact: Contact;
  profiles: Profile[];
  /** Create another deal even though this lead was already converted. */
  force: boolean;
  onClose: () => void;
  onConverted: () => void;
}) {
  const t = useTranslations("Lead");
  const router = useRouter();
  const { profile, account } = useAuth();
  const [pipelines, setPipelines] = useState<Pipeline[]>([]);
  const [stages, setStages] = useState<PipelineStage[]>([]);
  const [pipelineId, setPipelineId] = useState("");
  const [stageId, setStageId] = useState("");
  const [title, setTitle] = useState(contact.name || contact.phone);
  const [value, setValue] = useState("");
  const [currency, setCurrency] = useState(account?.default_currency ?? DEFAULT_CURRENCY);
  const [assignee, setAssignee] = useState(contact.owner_id ?? profile?.id ?? "");
  const [closeDate, setCloseDate] = useState("");
  const [saving, setSaving] = useState(false);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const [p, s] = await Promise.all([
        supabase.from("pipelines").select("*").order("created_at"),
        supabase.from("pipeline_stages").select("*").order("position"),
      ]);
      if (cancelled) return;
      const pl = (p.data ?? []) as Pipeline[];
      const st = (s.data ?? []) as PipelineStage[];
      setPipelines(pl);
      setStages(st);
      // Prefer a sales pipeline over the lead-status pipeline.
      const first = pl.find((x) => !x.is_lead_pipeline) ?? pl[0];
      if (first) {
        setPipelineId(first.id);
        setStageId(st.find((x) => x.pipeline_id === first.id)?.id ?? "");
      }
      setLoading(false);
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase]);

  const stageOptions = useMemo(() => stages.filter((s) => s.pipeline_id === pipelineId), [stages, pipelineId]);

  async function submit(e: React.FormEvent) {
    e.preventDefault();
    if (!title.trim() || !pipelineId || !stageId) return;
    const amount = value.trim() === "" ? 0 : Number(value);
    if (Number.isNaN(amount) || amount < 0) {
      toast.error(t("convertValueInvalid"));
      return;
    }
    setSaving(true);
    const { error } = await supabase.rpc("convert_contact_to_deal", {
      p_contact_id: contact.id,
      p_pipeline_id: pipelineId,
      p_stage_id: stageId,
      p_title: title.trim(),
      p_value: amount,
      p_currency: currency,
      p_assigned_to: assignee || null,
      p_expected_close_date: closeDate || null,
      p_notes: null,
      p_force: force,
    });
    setSaving(false);
    if (error) {
      if (/already_converted/.test(error.message)) toast.error(t("alreadyConverted"));
      else if (error.code === "PGRST202" || error.code === "42883") toast.error(t("needMigration"));
      else toast.error(t("convertFailed"));
      return;
    }
    toast.success(t("converted"));
    onConverted();
    onClose();
  }

  return (
    <KModal title={t("convertTitle")} onClose={onClose}>
      <ModalBody onSubmit={submit}>
        {loading ? (
          <div className="k-muted" style={{ textAlign: "center", padding: 16 }}>{t("loading")}</div>
        ) : pipelines.length === 0 ? (
          <div style={{ fontSize: 13 }}>
            {t("noPipelines")}{" "}
            <button type="button" className="k-btn" onClick={() => router.push("/pipelines")}>{t("openPipelines")}</button>
          </div>
        ) : (
          <>
            <KField label={t("dealTitle")} required>
              <KInput className="k-input--lg" value={title} onChange={(e) => setTitle(e.target.value)} required />
            </KField>
            <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 12 }}>
              <KField label={t("dealPipeline")} required>
                <KSelect
                  className="k-input--lg"
                  value={pipelineId}
                  onChange={(e) => {
                    setPipelineId(e.target.value);
                    setStageId(stages.find((s) => s.pipeline_id === e.target.value)?.id ?? "");
                  }}
                >
                  {pipelines.map((p) => (
                    <option key={p.id} value={p.id}>{p.name}</option>
                  ))}
                </KSelect>
              </KField>
              <KField label={t("dealStage")} required>
                <KSelect className="k-input--lg" value={stageId} onChange={(e) => setStageId(e.target.value)}>
                  {stageOptions.map((s) => (
                    <option key={s.id} value={s.id}>{s.name}</option>
                  ))}
                </KSelect>
              </KField>
            </div>
            <div style={{ display: "grid", gridTemplateColumns: "2fr 1fr", gap: 12 }}>
              <KField label={t("dealValue")}>
                <KInput className="k-input--lg" type="number" min={0} step="any" value={value} onChange={(e) => setValue(e.target.value)} />
              </KField>
              <KField label={t("dealCurrency")}>
                <KSelect className="k-input--lg" value={currency} disabled title={t("currencyFromSettings")} onChange={(e) => setCurrency(e.target.value)}>
                  {CURRENCIES.map((c) => (
                    <option key={c.code} value={c.code}>{c.code}</option>
                  ))}
                </KSelect>
              </KField>
            </div>
            <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 12 }}>
              <KField label={t("dealAssignee")}>
                <KSelect className="k-input--lg" value={assignee} onChange={(e) => setAssignee(e.target.value)}>
                  <option value="">{t("unassigned")}</option>
                  {profiles.map((p) => (
                    <option key={p.id} value={p.id}>{p.full_name || p.email}</option>
                  ))}
                </KSelect>
              </KField>
              <KField label={t("dealClose")}>
                <KInput className="k-input--lg" type="date" value={closeDate} onChange={(e) => setCloseDate(e.target.value)} />
              </KField>
            </div>
          </>
        )}
        <ModalFooter>
          <KButton size="lg" onClick={onClose}>{t("cancel")}</KButton>
          <KButton size="lg" variant="primary" type="submit" disabled={saving || loading || pipelines.length === 0 || !title.trim() || !stageId}>
            {saving && <Loader2 size={13} className="animate-spin" />} {t("convertBtn")}
          </KButton>
        </ModalFooter>
      </ModalBody>
    </KModal>
  );
}
