'use client';

import { useCallback, useEffect, useState } from 'react';
import { createClient } from '@/lib/supabase/client';
import { useAuth } from '@/hooks/use-auth';
import { toast } from 'sonner';
import { CUSTOM_FIELD_TYPES, type CustomField, type CustomFieldType } from '@/types';
import { KSelect } from '@/components/kit';
import {
  FIELD_SECTIONS,
  REAL_ESTATE_PRESET,
  fieldOptions,
  isMissingColumn,
  parseOptions,
  type FieldSection,
} from '@/lib/contacts/custom-field-presets';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
} from '@/components/ui/dialog';
import { Button } from '@/components/ui/button';
import { Input } from '@/components/ui/input';
import { Loader2, Plus, Sparkles, Trash2 } from 'lucide-react';
import { useTranslations } from 'next-intl';

interface CustomFieldsManagerProps {
  open: boolean;
  onOpenChange: (open: boolean) => void;
}

/**
 * Dialog wrapper around {@link CustomFieldsPanel}, used on the Contacts page.
 * The same panel is rendered inline under Settings → Custom Fields, so the
 * editing UI lives in one place. Radix unmounts the dialog content on close,
 * so the panel remounts (and refetches) on each open.
 */
export function CustomFieldsManager({
  open,
  onOpenChange,
}: CustomFieldsManagerProps) {
  const t = useTranslations('Contacts.customFields');
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="border-border bg-popover text-popover-foreground sm:max-w-md">
        <DialogHeader>
          <DialogTitle className="text-popover-foreground">{t('title')}</DialogTitle>
          <DialogDescription className="text-muted-foreground">
            {t('desc')}
          </DialogDescription>
        </DialogHeader>
        <CustomFieldsPanel />
      </DialogContent>
    </Dialog>
  );
}

/**
 * Create / rename / delete account-wide custom contact field definitions.
 * Per-contact values are edited elsewhere (contact detail → Custom Fields);
 * this only manages the field catalogue. Admin+ gated by the caller — the
 * `custom_fields` RLS also rejects non-admin writes as defense in depth.
 */
export function CustomFieldsPanel() {
  const t = useTranslations('Contacts.customFields');
  const supabase = createClient();
  const { user, accountId } = useAuth();

  const [fields, setFields] = useState<CustomField[]>([]);
  const [loading, setLoading] = useState(true);
  const [newName, setNewName] = useState('');
  const [newType, setNewType] = useState<CustomFieldType>('text');
  const [newSection, setNewSection] = useState<FieldSection>('More details');
  const [newOptions, setNewOptions] = useState('');
  const [creating, setCreating] = useState(false);
  const [presetBusy, setPresetBusy] = useState(false);
  // False until migration 041 is applied: section/position/type UI is hidden-safe, saves fall back to name only.
  const [hasSections, setHasSections] = useState(true);
  const [busyId, setBusyId] = useState<string | null>(null);

  const fetchFields = useCallback(async () => {
    if (!accountId) return;
    setLoading(true);
    const first = await supabase
      .from('custom_fields')
      .select('*')
      .order('position')
      .order('field_name');
    let rows = first.data;
    if (first.error) {
      // Migration 041 not applied yet: `position` does not exist.
      setHasSections(false);
      rows = (await supabase.from('custom_fields').select('*').order('field_name')).data;
    } else {
      setHasSections(true);
    }
    setFields((rows as CustomField[] | null) ?? []);
    setLoading(false);
  }, [supabase, accountId]);

  // Load the field list on mount once the account is known. The setters
  // inside fetchFields run after the Supabase await — not synchronously in
  // the effect body — so the cascade the lint rule warns about doesn't apply.
  useEffect(() => {
    if (accountId) {
      // eslint-disable-next-line react-hooks/set-state-in-effect
      fetchFields();
    }
  }, [accountId, fetchFields]);

  /** Case-insensitive name clash within the loaded list. */
  function isDuplicate(name: string, exceptId?: string): boolean {
    const lower = name.toLowerCase();
    return fields.some(
      (f) => f.id !== exceptId && f.field_name.toLowerCase() === lower
    );
  }

  /** Insert a field; if the section/position columns are missing (041 not applied) retry without them. */
  async function insertField(row: {
    name: string;
    type: CustomFieldType;
    section: FieldSection;
    options?: string[];
    position: number;
  }) {
    if (!accountId || !user) return { error: { message: 'no account' } };
    const base = {
      field_name: row.name,
      field_type: row.type,
      field_options: row.type === 'select' ? { options: row.options ?? [] } : null,
      user_id: user.id,
      account_id: accountId,
    };
    const res = await supabase.from('custom_fields').insert({ ...base, section: row.section, position: row.position });
    if (res.error && isMissingColumn(res.error)) {
      setHasSections(false);
      return supabase.from('custom_fields').insert(base);
    }
    return res;
  }

  async function handleCreate() {
    const name = newName.trim();
    if (!name) return;
    if (!accountId || !user) {
      toast.error(t('toastNoAccount'));
      return;
    }
    if (isDuplicate(name)) {
      toast.error(t('toastDuplicate', { name }));
      return;
    }
    const options = parseOptions(newOptions);
    if (newType === 'select' && options.length === 0) {
      toast.error(t('optionsRequired'));
      return;
    }

    setCreating(true);
    const { error } = await insertField({
      name,
      type: newType,
      section: newSection,
      options,
      position: fields.length,
    });
    setCreating(false);

    if (error) {
      toast.error(t('toastCreateFailed'));
      return;
    }
    toast.success(t('toastCreated', { name }));
    setNewName('');
    setNewOptions('');
    await fetchFields();
  }

  /** One-click starter set; skips names that already exist. */
  async function handlePreset() {
    if (!accountId || !user) {
      toast.error(t('toastNoAccount'));
      return;
    }
    const missing = REAL_ESTATE_PRESET.filter((p) => !isDuplicate(p.name));
    if (missing.length === 0) {
      toast.info(t('toastPresetNone'));
      return;
    }
    setPresetBusy(true);
    let added = 0;
    for (const [i, p] of missing.entries()) {
      const { error } = await insertField({
        name: p.name,
        type: p.type,
        section: p.section,
        options: p.options,
        position: fields.length + i,
      });
      if (error) {
        toast.error(t('toastPresetFailed'));
        break;
      }
      added += 1;
    }
    setPresetBusy(false);
    if (added > 0) toast.success(t('toastPresetAdded', { count: added }));
    await fetchFields();
  }

  async function handleSection(field: CustomField, section: FieldSection) {
    setBusyId(field.id);
    const { error } = await supabase.from('custom_fields').update({ section }).eq('id', field.id);
    setBusyId(null);
    if (error) {
      toast.error(t('toastSectionFailed'));
      return;
    }
    await fetchFields();
  }

  async function handleOptions(field: CustomField, input: string): Promise<boolean> {
    const options = parseOptions(input);
    if (options.length === 0) {
      toast.error(t('optionsRequired'));
      return false;
    }
    if (options.join('\u0000') === fieldOptions(field.field_options).join('\u0000')) return true;
    setBusyId(field.id);
    const { error } = await supabase.from('custom_fields').update({ field_options: { options } }).eq('id', field.id);
    setBusyId(null);
    if (error) {
      toast.error(t('toastOptionsFailed'));
      return false;
    }
    await fetchFields();
    return true;
  }

  /** Returns true on success so the row can keep the new name, false so it
   *  reverts to the previous one. No-ops (blank / unchanged) count as success. */
  async function handleRename(
    field: CustomField,
    nextName: string
  ): Promise<boolean> {
    const name = nextName.trim();
    if (!name || name === field.field_name) return true;
    if (isDuplicate(name, field.id)) {
      toast.error(t('toastDuplicate', { name }));
      return false;
    }
    setBusyId(field.id);
    const { error } = await supabase
      .from('custom_fields')
      .update({ field_name: name })
      .eq('id', field.id);
    setBusyId(null);
    if (error) {
      toast.error(t('toastRenameFailed'));
      return false;
    }
    await fetchFields();
    return true;
  }

  async function handleDelete(field: CustomField) {
    if (
      !window.confirm(
        t('deleteConfirm', { name: field.field_name })
      )
    ) {
      return;
    }
    setBusyId(field.id);
    const { error } = await supabase
      .from('custom_fields')
      .delete()
      .eq('id', field.id);
    setBusyId(null);
    if (error) {
      toast.error(t('toastDeleteFailed'));
      return;
    }
    toast.success(t('toastDeleted', { name: field.field_name }));
    await fetchFields();
  }

  const typeLabel = (ft: string) =>
    (({ text: t('typeText'), textarea: t('typeTextarea'), number: t('typeNumber'), date: t('typeDate'), select: t('typeSelect') }) as Record<string, string>)[ft] ?? ft;
  const sectionLabel = (sec: string) =>
    (({ Details: t('sectionDetails'), Person: t('sectionPerson'), 'More details': t('sectionMore') }) as Record<string, string>)[sec] ?? sec;

  return (
    <div className="space-y-4">
      {/* Create */}
      <div className="space-y-2">
        <div className="flex items-center gap-2">
          <Input
            value={newName}
            onChange={(e) => setNewName(e.target.value)}
            onKeyDown={(e) => {
              if (e.key === 'Enter') {
                e.preventDefault();
                void handleCreate();
              }
            }}
            placeholder={t('fieldName')}
            className="bg-muted text-foreground"
          />
          <Button
            onClick={handleCreate}
            disabled={creating || !newName.trim()}
            className="bg-primary hover:bg-primary/90 text-primary-foreground shrink-0"
          >
            {creating ? (
              <Loader2 className="size-4 animate-spin" />
            ) : (
              <Plus className="size-4" />
            )}
            {t('addField')}
          </Button>
        </div>
        {hasSections ? (
          <div className="flex flex-wrap items-center gap-2">
            <KSelect
              aria-label={t('fieldType')}
              title={t('fieldType')}
              value={newType}
              onChange={(e) => setNewType(e.target.value as CustomFieldType)}
              style={{ width: 'auto' }}
            >
              {CUSTOM_FIELD_TYPES.map((ft) => (
                <option key={ft} value={ft}>{typeLabel(ft)}</option>
              ))}
            </KSelect>
            <KSelect
              aria-label={t('section')}
              title={t('section')}
              value={newSection}
              onChange={(e) => setNewSection(e.target.value as FieldSection)}
              style={{ width: 'auto' }}
            >
              {FIELD_SECTIONS.map((sec) => (
                <option key={sec} value={sec}>{sectionLabel(sec)}</option>
              ))}
            </KSelect>
            {newType === 'select' && (
              <Input
                value={newOptions}
                onChange={(e) => setNewOptions(e.target.value)}
                placeholder={t('optionsPlaceholder')}
                className="min-w-48 flex-1 bg-muted text-foreground"
              />
            )}
          </div>
        ) : (
          <p className="text-xs text-muted-foreground">{t('needMigration')}</p>
        )}
        {hasSections && (
          <Button
            variant="outline"
            size="sm"
            onClick={handlePreset}
            disabled={presetBusy}
            title={t('presetHint')}
            className="border-border text-muted-foreground hover:bg-muted"
          >
            {presetBusy ? <Loader2 className="size-3.5 animate-spin" /> : <Sparkles className="size-3.5" />}
            {t('addPreset')}
          </Button>
        )}
      </div>

      {/* List */}
      <div className="max-h-96 overflow-y-auto rounded-md border border-border">
        {loading ? (
          <div className="flex items-center justify-center gap-2 py-8 text-sm text-muted-foreground">
            <Loader2 className="size-4 animate-spin" />
            {t('loading')}
          </div>
        ) : fields.length === 0 ? (
          <p className="py-8 text-center text-sm text-muted-foreground">
            {t('empty')}
          </p>
        ) : (
          <ul className="divide-y divide-border">
            {fields.map((field) => (
              <FieldRow
                key={field.id}
                field={field}
                busy={busyId === field.id}
                showMeta={hasSections}
                typeLabel={typeLabel(field.field_type)}
                sectionLabel={sectionLabel}
                onRename={handleRename}
                onDelete={handleDelete}
                onSection={handleSection}
                onOptions={handleOptions}
              />
            ))}
          </ul>
        )}
      </div>
    </div>
  );
}

/** A single editable row. Controlled local state lets us commit on blur /
 *  Enter and cleanly revert to the last saved name when a rename fails. */
function FieldRow({
  field,
  busy,
  showMeta,
  typeLabel,
  sectionLabel,
  onRename,
  onDelete,
  onSection,
  onOptions,
}: {
  field: CustomField;
  busy: boolean;
  /** False before migration 041: no section/type controls. */
  showMeta: boolean;
  typeLabel: string;
  sectionLabel: (section: string) => string;
  onRename: (field: CustomField, name: string) => Promise<boolean>;
  onDelete: (field: CustomField) => void;
  onSection: (field: CustomField, section: FieldSection) => void;
  onOptions: (field: CustomField, input: string) => Promise<boolean>;
}) {
  const t = useTranslations('Contacts.customFields');
  const [name, setName] = useState(field.field_name);
  const savedOptions = fieldOptions(field.field_options).join(', ');
  const [options, setOptions] = useState(savedOptions);

  async function commit() {
    if (name.trim() === field.field_name) {
      setName(field.field_name); // normalise any whitespace-only edit
      return;
    }
    const ok = await onRename(field, name);
    if (!ok) setName(field.field_name);
  }

  async function commitOptions() {
    const ok = await onOptions(field, options);
    if (!ok) setOptions(savedOptions);
  }

  return (
    <li className="space-y-1 px-3 py-2">
      <div className="flex items-center gap-2">
        <Input
          value={name}
          disabled={busy}
          onChange={(e) => setName(e.target.value)}
          onBlur={commit}
          onKeyDown={(e) => {
            if (e.key === 'Enter') e.currentTarget.blur();
          }}
          aria-label={t('renameAria', { name: field.field_name })}
          className="focus:border-primary h-8 border-transparent bg-transparent text-foreground hover:border-border"
        />
        {showMeta && (
          <>
            <span className="k-badge k-badge--gray shrink-0">{typeLabel}</span>
            <KSelect
              aria-label={t('section')}
              title={t('section')}
              disabled={busy}
              value={field.section ?? 'More details'}
              onChange={(e) => onSection(field, e.target.value as FieldSection)}
              style={{ width: 'auto' }}
            >
              {FIELD_SECTIONS.map((sec) => (
                <option key={sec} value={sec}>{sectionLabel(sec)}</option>
              ))}
              {field.section && !(FIELD_SECTIONS as readonly string[]).includes(field.section) && (
                <option value={field.section}>{field.section}</option>
              )}
            </KSelect>
          </>
        )}
        <Button
          variant="ghost"
          size="icon-sm"
          disabled={busy}
          onClick={() => onDelete(field)}
          title={t('deleteTitle')}
          className="shrink-0 text-muted-foreground hover:text-red-400"
        >
          {busy ? (
            <Loader2 className="size-4 animate-spin" />
          ) : (
            <Trash2 className="size-4" />
          )}
        </Button>
      </div>
      {showMeta && field.field_type === 'select' && (
        <Input
          value={options}
          disabled={busy}
          onChange={(e) => setOptions(e.target.value)}
          onBlur={commitOptions}
          onKeyDown={(e) => {
            if (e.key === 'Enter') e.currentTarget.blur();
          }}
          aria-label={t('optionsAria', { name: field.field_name })}
          placeholder={t('optionsPlaceholder')}
          className="h-8 bg-muted text-sm text-foreground"
        />
      )}
    </li>
  );
}
