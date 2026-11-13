import type { CustomFieldType } from '@/types';

/** Canonical section names stored in `custom_fields.section` (translated for display). */
export const FIELD_SECTIONS = ['Details', 'Person', 'More details'] as const;
export type FieldSection = (typeof FIELD_SECTIONS)[number];

export interface FieldPreset {
  name: string;
  type: CustomFieldType;
  section: FieldSection;
  options?: string[];
}

/** One-click starter set (real-estate leads). Core lead fields — owner, status, source,
 *  priority, follow-up date — are real contact columns and are not listed here. */
export const REAL_ESTATE_PRESET: FieldPreset[] = [
  { name: 'Website', type: 'text', section: 'Details' },
  { name: 'Industry', type: 'text', section: 'Details' },
  { name: 'Job Title', type: 'text', section: 'Details' },
  { name: 'Salutation', type: 'select', section: 'Person', options: ['Mr', 'Ms', 'Mrs', 'Dr'] },
  { name: 'Territory', type: 'text', section: 'More details' },
  { name: 'Budget Range', type: 'text', section: 'More details' },
  { name: 'Property Type', type: 'select', section: 'More details', options: ['Flat', 'Villa', 'Row House', 'Plot', 'Commercial'] },
  { name: 'Preferred Area', type: 'text', section: 'More details' },
  { name: 'Requirements', type: 'textarea', section: 'More details' },
];

/** Options of a `select` field (`field_options = { options: string[] }`). */
export function fieldOptions(options: Record<string, unknown> | null | undefined): string[] {
  const raw = options?.options;
  return Array.isArray(raw) ? raw.filter((x): x is string => typeof x === 'string') : [];
}

/** Split "a, b ,c" into trimmed, de-duplicated options. */
export function parseOptions(input: string): string[] {
  return [...new Set(input.split(',').map((o) => o.trim()).filter(Boolean))];
}

/** True for errors caused by the 041 columns not existing yet (section/position). */
export function isMissingColumn(error: { code?: string; message?: string } | null | undefined): boolean {
  return !!error && (error.code === '42703' || error.code === 'PGRST204' || /column .*(section|position)/i.test(error.message ?? ''));
}
