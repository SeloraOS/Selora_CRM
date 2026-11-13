"use client";

import Link from "next/link";
import { ChevronRight, Pencil, Trash2 } from "lucide-react";
import { useTranslations } from "next-intl";
import type { Contact, Pipeline, PipelineStage, Profile } from "@/types";
import { Dropdown, KButton, MenuItem } from "@/components/kit";
import { LeadAvatar } from "./lead-avatar";
import { hasLeadColumns } from "@/lib/leads/lead-utils";

export interface LeadHeaderProps {
  contact: Contact;
  profiles: Profile[];
  stages: PipelineStage[];
  leadPipeline: Pipeline | null;
  canEdit: boolean;
  onUpdate: (patch: Partial<Contact>) => Promise<boolean>;
  onEdit: () => void;
  onDelete: () => void;
  /** Rendered after Delete (the Convert to Deal button). */
  children?: React.ReactNode;
}

export function LeadHeader({ contact, profiles, stages, leadPipeline, canEdit, onUpdate, onEdit, onDelete, children }: LeadHeaderProps) {
  const t = useTranslations("Lead");
  const leadReady = hasLeadColumns(contact);
  const owner = profiles.find((p) => p.id === contact.owner_id);
  const stage = stages.find((s) => s.id === contact.lead_stage_id);
  const name = contact.name || contact.phone;

  return (
    <div className="k-toolbar" style={{ minHeight: 48 }}>
      <nav aria-label="Breadcrumb" style={{ display: "flex", alignItems: "center", gap: 8, minWidth: 0, fontSize: 14 }}>
        <Link href="/contacts" className="k-muted" style={{ textDecoration: "none" }}>{t("breadcrumbContacts")}</Link>
        <ChevronRight size={14} className="k-muted" />
        <strong style={{ fontWeight: 600, overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{name}</strong>
      </nav>

      <div className="k-toolbar__group">
        {leadReady && (
          <>
            <Dropdown
              align="right"
              disabled={!canEdit}
              ariaLabel={t("owner")}
              trigger={
                <>
                  <LeadAvatar name={owner?.full_name || owner?.email} url={owner?.avatar_url} size={18} />
                  {owner ? owner.full_name || owner.email : t("unassigned")}
                </>
              }
            >
              {({ close }) => (
                <>
                  <MenuItem active={!contact.owner_id} onClick={() => { void onUpdate({ owner_id: null }); close(); }}>{t("unassigned")}</MenuItem>
                  {profiles.map((p) => (
                    <MenuItem key={p.id} active={p.id === contact.owner_id} onClick={() => { void onUpdate({ owner_id: p.id }); close(); }}>
                      <LeadAvatar name={p.full_name || p.email} url={p.avatar_url} size={18} />
                      {p.full_name || p.email}
                    </MenuItem>
                  ))}
                </>
              )}
            </Dropdown>

            <Dropdown
              align="right"
              disabled={!canEdit || stages.length === 0}
              title={stages.length === 0 ? (leadPipeline ? undefined : t("statusHint")) : undefined}
              ariaLabel={t("status")}
              trigger={
                <>
                  <span style={{ width: 8, height: 8, borderRadius: "50%", background: stage?.color ?? "var(--text-muted)" }} />
                  {stage?.name ?? t("noStatus")}
                </>
              }
            >
              {({ close }) =>
                stages.map((s) => (
                  <MenuItem key={s.id} active={s.id === contact.lead_stage_id} onClick={() => { void onUpdate({ lead_stage_id: s.id }); close(); }}>
                    <span style={{ width: 8, height: 8, borderRadius: "50%", background: s.color }} />
                    {s.name}
                  </MenuItem>
                ))
              }
            </Dropdown>
          </>
        )}

        {canEdit && (
          <KButton onClick={onEdit}>
            <Pencil size={13} /> {t("edit")}
          </KButton>
        )}
        {canEdit && (
          <KButton size="icon" aria-label={t("delete")} title={t("delete")} onClick={onDelete}>
            <Trash2 size={14} />
          </KButton>
        )}
        {children}
      </div>
    </div>
  );
}
