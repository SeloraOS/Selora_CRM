import type { Contact, CustomField, LeadPriority } from '@/types';
import { FIELD_SECTIONS } from '@/lib/contacts/custom-field-presets';

export const PRIORITIES: LeadPriority[] = ['low', 'medium', 'high', 'urgent'];

export const PRIORITY_COLOR: Record<LeadPriority, string> = {
  low: '#6b7280',
  medium: '#3b82f6',
  high: '#f59e0b',
  urgent: '#ef4444',
};

/** True once migration 041 is applied (the lead columns exist on contacts). */
export function hasLeadColumns(contact: Contact | null): boolean {
  return !!contact && 'lead_code' in contact;
}

export function initials(name?: string | null, fallback = '?'): string {
  const source = (name || fallback).trim();
  return source ? source.charAt(0).toUpperCase() : '?';
}

/** Custom fields for one section, in saved order. */
export function fieldsInSection(fields: CustomField[], section: string): CustomField[] {
  return fields
    .filter((f) => (f.section ?? 'More details') === section)
    .sort((a, b) => (a.position ?? 0) - (b.position ?? 0) || a.field_name.localeCompare(b.field_name));
}

/** Sections that are not one of the three built-in ones (admin-defined free text). */
export function extraSections(fields: CustomField[]): string[] {
  const known = new Set<string>(FIELD_SECTIONS);
  return [...new Set(fields.map((f) => f.section ?? 'More details'))].filter((s) => !known.has(s)).sort();
}

/** Short "2h ago" style label (falls back to a date for old items). */
export function timeAgo(iso: string, locale: string): string {
  const diff = Date.now() - new Date(iso).getTime();
  const rtf = new Intl.RelativeTimeFormat(locale, { numeric: 'auto' });
  const min = Math.round(diff / 60000);
  if (min < 1) return rtf.format(0, 'minute');
  if (min < 60) return rtf.format(-min, 'minute');
  const hr = Math.round(min / 60);
  if (hr < 24) return rtf.format(-hr, 'hour');
  const day = Math.round(hr / 24);
  if (day < 30) return rtf.format(-day, 'day');
  return new Date(iso).toLocaleDateString(locale, { year: 'numeric', month: 'short', day: 'numeric' });
}
