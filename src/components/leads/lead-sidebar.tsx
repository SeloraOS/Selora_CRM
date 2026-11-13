"use client";

import { useState, type ReactNode } from "react";
import { ChevronDown, ChevronRight, Link as LinkIcon, Mail, MessageCircle, Phone, Plus, X } from "lucide-react";
import { toast } from "sonner";
import { useTranslations } from "next-intl";
import type { Contact, CustomField, LeadPriority, Profile, Tag } from "@/types";
import { Dropdown, MenuItem } from "@/components/kit";
import { LeadAvatar } from "./lead-avatar";
import { fieldOptions } from "@/lib/contacts/custom-field-presets";
import { PRIORITIES, extraSections, fieldsInSection, hasLeadColumns } from "@/lib/leads/lead-utils";

type FieldKind = "text" | "textarea" | "number" | "date" | "select" | "email";

/**
 * One label + inline-editable value. Saves on blur (text-like) or on change (select/date).
 * The parent keys it by the saved value, so the draft resets whenever the saved value changes.
 */
function InlineField({
  label,
  value,
  kind = "text",
  options,
  placeholder = "—",
  readOnly,
  onSave,
  display,
}: {
  label: string;
  value: string;
  kind?: FieldKind;
  options?: Array<{ value: string; label: string }>;
  placeholder?: string;
  readOnly?: boolean;
  onSave?: (next: string) => Promise<boolean> | boolean;
  /** Read-only rendering (e.g. a link) instead of an input. */
  display?: ReactNode;
}) {
  const [draft, setDraft] = useState(value);
  const id = `lead-field-${label.replace(/\s+/g, "-").toLowerCase()}`;

  const commit = async (next: string) => {
    if (!onSave || next === value) return;
    const ok = await onSave(next);
    if (!ok) setDraft(value);
  };

  return (
    <div className={`k-field-row${kind === "textarea" ? " is-top" : ""}`}>
      <label htmlFor={id}>{label}</label>
      {display ? (
        <div style={{ flex: 1, minWidth: 0, fontSize: 13, padding: "3px 6px", overflow: "hidden", textOverflow: "ellipsis" }}>{display}</div>
      ) : kind === "select" ? (
        <select
          id={id}
          className="k-inline"
          disabled={readOnly}
          value={draft}
          onChange={(e) => {
            setDraft(e.target.value);
            void commit(e.target.value);
          }}
        >
          <option value="">{placeholder}</option>
          {options?.map((o) => (
            <option key={o.value} value={o.value}>{o.label}</option>
          ))}
          {draft && !options?.some((o) => o.value === draft) && <option value={draft}>{draft}</option>}
        </select>
      ) : kind === "textarea" ? (
        <textarea
          id={id}
          className="k-inline"
          disabled={readOnly}
          rows={3}
          value={draft}
          placeholder={placeholder}
          onChange={(e) => setDraft(e.target.value)}
          onBlur={() => void commit(draft.trim())}
        />
      ) : (
        <input
          id={id}
          className="k-inline"
          type={kind === "date" ? "date" : kind === "number" ? "number" : kind === "email" ? "email" : "text"}
          disabled={readOnly}
          value={draft}
          placeholder={placeholder}
          onChange={(e) => {
            setDraft(e.target.value);
            if (kind === "date") void commit(e.target.value);
          }}
          onBlur={() => kind !== "date" && void commit(draft.trim())}
          onKeyDown={(e) => {
            if (e.key === "Enter") e.currentTarget.blur();
          }}
        />
      )}
    </div>
  );
}

function Section({ title, children, defaultOpen = true }: { title: string; children: ReactNode; defaultOpen?: boolean }) {
  const [open, setOpen] = useState(defaultOpen);
  return (
    <section style={{ marginTop: 14 }}>
      <button type="button" className="k-section-head" aria-expanded={open} onClick={() => setOpen((v) => !v)}>
        {open ? <ChevronDown size={12} /> : <ChevronRight size={12} />}
        {title}
      </button>
      {open && <div style={{ display: "flex", flexDirection: "column", gap: 2 }}>{children}</div>}
    </section>
  );
}

export interface LeadSidebarProps {
  contact: Contact;
  profiles: Profile[];
  fields: CustomField[];
  values: Record<string, string>;
  allTags: Tag[];
  tagIds: string[];
  canEdit: boolean;
  onUpdate: (patch: Partial<Contact>) => Promise<boolean>;
  onCustomValue: (fieldId: string, value: string) => Promise<boolean>;
  onToggleTag: (tagId: string) => void;
  onOpenWhatsApp: () => void;
}

export function LeadSidebar({
  contact,
  profiles,
  fields,
  values,
  allTags,
  tagIds,
  canEdit,
  onUpdate,
  onCustomValue,
  onToggleTag,
  onOpenWhatsApp,
}: LeadSidebarProps) {
  const t = useTranslations("Lead");
  const leadReady = hasLeadColumns(contact);
  const sectionLabel = (s: string) =>
    (({ Details: t("sectionDetails"), Person: t("sectionPerson"), "More details": t("sectionMore") }) as Record<string, string>)[s] ?? s;

  const customRow = (f: CustomField) => {
    const kind: FieldKind = f.field_type === "select" ? "select" : f.field_type === "textarea" ? "textarea" : f.field_type === "number" ? "number" : f.field_type === "date" ? "date" : "text";
    const v = values[f.id] ?? "";
    return (
      <InlineField
        key={`${f.id}:${v}`}
        label={f.field_name}
        value={v}
        kind={kind}
        options={kind === "select" ? fieldOptions(f.field_options).map((o) => ({ value: o, label: o })) : undefined}
        readOnly={!canEdit}
        onSave={(next) => onCustomValue(f.id, next)}
      />
    );
  };

  const copyLink = async () => {
    try {
      await navigator.clipboard.writeText(window.location.href);
      toast.success(t("linkCopied"));
    } catch {
      toast.error(t("saveFailed"));
    }
  };

  const contactTags = allTags.filter((tg) => tagIds.includes(tg.id));
  const addable = allTags.filter((tg) => !tagIds.includes(tg.id));

  const quick = (icon: ReactNode, label: string, props: { href?: string; onClick?: () => void }) =>
    props.href ? (
      <a className="k-btn k-btn--icon" style={{ borderRadius: "50%", width: 32, height: 32 }} aria-label={label} title={label} href={props.href}>{icon}</a>
    ) : (
      <button type="button" className="k-btn k-btn--icon" style={{ borderRadius: "50%", width: 32, height: 32 }} aria-label={label} title={label} onClick={props.onClick}>{icon}</button>
    );

  return (
    <aside style={{ padding: "16px 16px 24px" }}>
      {contact.lead_code && (
        <div style={{ fontFamily: "var(--font-geist-mono, ui-monospace, monospace)", fontSize: 12, color: "var(--text-muted)", marginBottom: 14 }}>
          {contact.lead_code}
        </div>
      )}

      <div style={{ display: "flex", flexDirection: "column", alignItems: "center", gap: 8, paddingBottom: 14, borderBottom: "1px solid var(--border-color)" }}>
        <LeadAvatar name={contact.name || contact.phone} url={contact.avatar_url} size={52} />
        <div style={{ fontSize: 16, fontWeight: 600, textAlign: "center" }}>{contact.name || contact.phone}</div>
        <div style={{ display: "flex", gap: 8 }}>
          {quick(<Phone size={14} />, t("callAction"), { href: `tel:${contact.phone}` })}
          {contact.email && quick(<Mail size={14} />, t("emailAction"), { href: `mailto:${contact.email}` })}
          {quick(<MessageCircle size={14} />, t("whatsappAction"), { onClick: onOpenWhatsApp })}
          {quick(<LinkIcon size={14} />, t("copyLink"), { onClick: copyLink })}
        </div>
      </div>

      <Section title={sectionLabel("Details")}>
        <InlineField key={`company:${contact.company ?? ""}`} label={t("fieldOrganization")} value={contact.company ?? ""} readOnly={!canEdit} onSave={(v) => onUpdate({ company: v || undefined })} />
        {fieldsInSection(fields, "Details").map(customRow)}
        {leadReady && (
          <>
            <InlineField key={`source:${contact.source ?? ""}`} label={t("fieldSource")} value={contact.source ?? ""} readOnly={!canEdit} onSave={(v) => onUpdate({ source: v || null })} />
            <InlineField
              key={`owner:${contact.owner_id ?? ""}`}
              label={t("fieldLeadOwner")}
              value={contact.owner_id ?? ""}
              kind="select"
              placeholder={t("unassigned")}
              options={profiles.map((p) => ({ value: p.id, label: p.full_name || p.email }))}
              readOnly={!canEdit}
              onSave={(v) => onUpdate({ owner_id: v || null })}
            />
          </>
        )}
      </Section>

      <Section title={sectionLabel("Person")}>
        {fieldsInSection(fields, "Person").map(customRow)}
        <InlineField key={`name:${contact.name ?? ""}`} label={t("fieldName")} value={contact.name ?? ""} readOnly={!canEdit} onSave={(v) => onUpdate({ name: v || undefined })} />
        <InlineField key={`email:${contact.email ?? ""}`} label={t("fieldEmail")} value={contact.email ?? ""} kind="email" readOnly={!canEdit} onSave={(v) => onUpdate({ email: v || undefined })} />
        <InlineField
          label={t("fieldMobile")}
          value={contact.phone}
          display={<a href={`tel:${contact.phone}`} style={{ color: "var(--primary)" }}>{contact.phone}</a>}
        />
      </Section>

      <Section title={sectionLabel("More details")}>
        {fieldsInSection(fields, "More details").map(customRow)}
        {leadReady && (
          <>
            <InlineField key={`follow:${contact.follow_up_date ?? ""}`} label={t("fieldFollowUp")} value={contact.follow_up_date ?? ""} kind="date" readOnly={!canEdit} onSave={(v) => onUpdate({ follow_up_date: v || null })} />
            <InlineField
              key={`prio:${contact.priority ?? ""}`}
              label={t("fieldPriority")}
              value={contact.priority ?? ""}
              kind="select"
              options={PRIORITIES.map((p) => ({ value: p, label: t(`priority_${p}`) }))}
              readOnly={!canEdit}
              onSave={(v) => onUpdate({ priority: (v || null) as LeadPriority | null })}
            />
          </>
        )}
      </Section>

      {extraSections(fields).map((s) => (
        <Section key={s} title={sectionLabel(s)}>{fieldsInSection(fields, s).map(customRow)}</Section>
      ))}

      <Section title={t("tags")}>
        <div style={{ display: "flex", flexWrap: "wrap", gap: 6, padding: "2px 0" }}>
          {contactTags.length === 0 && <span className="k-muted" style={{ fontSize: 13 }}>{t("noTags")}</span>}
          {contactTags.map((tg) => (
            <span key={tg.id} style={{ display: "inline-flex", alignItems: "center", gap: 4, borderRadius: 12, padding: "2px 8px", fontSize: 11, fontWeight: 500, background: `${tg.color}20`, color: tg.color }}>
              {tg.name}
              {canEdit && (
                <button type="button" aria-label={t("removeTag", { name: tg.name })} onClick={() => onToggleTag(tg.id)} style={{ border: 0, background: "none", color: "inherit", cursor: "pointer", display: "flex" }}>
                  <X size={11} />
                </button>
              )}
            </span>
          ))}
          {canEdit && addable.length > 0 && (
            <Dropdown buttonClass="k-btn--text" trigger={<><Plus size={12} /> {t("addTag")}</>} ariaLabel={t("addTag")}>
              {({ close }) =>
                addable.map((tg) => (
                  <MenuItem key={tg.id} onClick={() => { onToggleTag(tg.id); close(); }}>
                    <span style={{ width: 8, height: 8, borderRadius: "50%", background: tg.color }} /> {tg.name}
                  </MenuItem>
                ))
              }
            </Dropdown>
          )}
        </div>
      </Section>
    </aside>
  );
}
