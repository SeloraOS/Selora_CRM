"use client";

import { useEffect, useMemo, useState } from "react";
import { createClient } from "@/lib/supabase/client";
import type { Pipeline, PipelineStage, Profile } from "@/types";

/** Lead statuses (stages of the lead pipeline) and the account's people, for list columns and filters. */
export function useLeadMeta() {
  const supabase = useMemo(() => createClient(), []);
  const [stages, setStages] = useState<PipelineStage[]>([]);
  const [profiles, setProfiles] = useState<Profile[]>([]);

  useEffect(() => {
    let cancelled = false;
    (async () => {
      const [pipe, p] = await Promise.all([
        // Errors before migration 041 (no such column): treated as "no lead pipeline".
        supabase.from("pipelines").select("*").eq("is_lead_pipeline", true).maybeSingle(),
        supabase.from("profiles").select("*").order("full_name"),
      ]);
      if (cancelled) return;
      setProfiles((p.data ?? []) as Profile[]);
      const lp = pipe.error ? null : (pipe.data as Pipeline | null);
      if (!lp) return;
      const { data } = await supabase.from("pipeline_stages").select("*").eq("pipeline_id", lp.id).order("position");
      if (!cancelled) setStages((data ?? []) as PipelineStage[]);
    })();
    return () => {
      cancelled = true;
    };
  }, [supabase]);

  return { stages, profiles };
}
