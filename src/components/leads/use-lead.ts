"use client";

import { useCallback, useEffect, useMemo, useRef, useState } from "react";
import { toast } from "sonner";
import { useTranslations } from "next-intl";
import { createClient } from "@/lib/supabase/client";
import type { Contact, CustomField, Pipeline, PipelineStage, Profile, Tag } from "@/types";
import { addContactTag, deleteContactTag } from "@/lib/contacts/tag-api";

/** Everything the lead page needs about one contact, plus the write helpers. */
export function useLead(contactId: string) {
  const t = useTranslations("Lead");
  const supabase = useMemo(() => createClient(), []);
  const [contact, setContact] = useState<Contact | null>(null);
  const [loading, setLoading] = useState(true);
  const [notFound, setNotFound] = useState(false);
  const [leadPipeline, setLeadPipeline] = useState<Pipeline | null>(null);
  const [stages, setStages] = useState<PipelineStage[]>([]);
  const [profiles, setProfiles] = useState<Profile[]>([]);
  const [fields, setFields] = useState<CustomField[]>([]);
  const [values, setValues] = useState<Record<string, string>>({});
  const [allTags, setAllTags] = useState<Tag[]>([]);
  const [tagIds, setTagIds] = useState<string[]>([]);
  const seq = useRef(0);

  const load = useCallback(async () => {
    const mine = ++seq.current;
    const [c, pipe, p, f, v, tg, ct] = await Promise.all([
      supabase.from("contacts").select("*").eq("id", contactId).maybeSingle(),
      // `is_lead_pipeline` only exists after migration 041; an error just means "no lead pipeline".
      supabase.from("pipelines").select("*").eq("is_lead_pipeline", true).maybeSingle(),
      supabase.from("profiles").select("*").order("full_name"),
      supabase.from("custom_fields").select("*").order("position").order("field_name"),
      supabase.from("contact_custom_values").select("custom_field_id, value").eq("contact_id", contactId),
      supabase.from("tags").select("*").order("name"),
      supabase.from("contact_tags").select("tag_id").eq("contact_id", contactId),
    ]);
    if (mine !== seq.current) return;

    if (c.error || !c.data) {
      setNotFound(true);
      setLoading(false);
      return;
    }
    setNotFound(false);
    setContact(c.data as Contact);

    const lp = pipe.error ? null : ((pipe.data as Pipeline | null) ?? null);
    setLeadPipeline(lp);
    if (lp) {
      const { data: st } = await supabase
        .from("pipeline_stages")
        .select("*")
        .eq("pipeline_id", lp.id)
        .order("position");
      if (mine !== seq.current) return;
      setStages((st ?? []) as PipelineStage[]);
    } else {
      setStages([]);
    }

    setProfiles((p.data ?? []) as Profile[]);
    // Before migration 041 the ordering column does not exist: fall back to name order.
    let fieldRows = f.data as CustomField[] | null;
    if (f.error) {
      fieldRows = (await supabase.from("custom_fields").select("*").order("field_name")).data as CustomField[] | null;
      if (mine !== seq.current) return;
    }
    setFields(fieldRows ?? []);
    setValues(Object.fromEntries(((v.data ?? []) as { custom_field_id: string; value: string | null }[]).map((r) => [r.custom_field_id, r.value ?? ""])));
    setAllTags((tg.data ?? []) as Tag[]);
    setTagIds(((ct.data ?? []) as { tag_id: string }[]).map((r) => r.tag_id));
    setLoading(false);
  }, [supabase, contactId]);

  useEffect(() => {
    // setState happens after awaited Supabase calls inside load(), not synchronously here.
    // eslint-disable-next-line react-hooks/set-state-in-effect
    load();
  }, [load]);

  /** Patch the contact row. Returns true on success. */
  const updateContact = useCallback(
    async (patch: Partial<Contact>): Promise<boolean> => {
      const { data, error } = await supabase.from("contacts").update(patch).eq("id", contactId).select("*").single();
      if (error || !data) {
        const missing = error && (error.code === "42703" || error.code === "PGRST204");
        toast.error(missing ? t("needMigration") : t("saveFailed"));
        return false;
      }
      setContact(data as Contact);
      return true;
    },
    [supabase, contactId, t],
  );

  /** Save one custom field value (empty clears it). Upsert, never delete-then-insert. */
  const setCustomValue = useCallback(
    async (fieldId: string, value: string): Promise<boolean> => {
      const clean = value.trim();
      const res = clean
        ? await supabase
            .from("contact_custom_values")
            .upsert({ contact_id: contactId, custom_field_id: fieldId, value: clean }, { onConflict: "contact_id,custom_field_id" })
        : await supabase.from("contact_custom_values").delete().eq("contact_id", contactId).eq("custom_field_id", fieldId);
      if (res.error) {
        toast.error(t("saveFailed"));
        return false;
      }
      setValues((prev) => {
        const next = { ...prev };
        if (clean) next[fieldId] = clean;
        else delete next[fieldId];
        return next;
      });
      return true;
    },
    [supabase, contactId, t],
  );

  const toggleTag = useCallback(
    async (tagId: string) => {
      const has = tagIds.includes(tagId);
      try {
        if (has) await deleteContactTag(contactId, tagId);
        else await addContactTag(contactId, tagId);
        setTagIds((prev) => (has ? prev.filter((x) => x !== tagId) : [...prev, tagId]));
      } catch (e) {
        toast.error(e instanceof Error ? e.message : t("saveFailed"));
      }
    },
    [contactId, tagIds, t],
  );

  return {
    supabase,
    contact,
    loading,
    notFound,
    leadPipeline,
    stages,
    profiles,
    fields,
    values,
    allTags,
    tagIds,
    reload: load,
    updateContact,
    setCustomValue,
    toggleTag,
  };
}
