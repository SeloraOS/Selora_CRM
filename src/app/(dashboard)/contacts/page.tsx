'use client';

import {
  SearchBox,
  KButton,
  KInput,
  KSelect,
  Toolbar,
  FilterBar,
  FilterChips,
  Dropdown,
  EmptyState,
  RecordTable,
  SortMenu,
  ColumnsMenu,
  ExportMenu,
  ViewMenu,
  KanbanBoard,
  useViewMode,
  type KanbanColumn,
  useListPrefs,
  useKitLabels,
  type Column,
  type Selection,
} from '@/components/kit';
import { useState, useEffect, useCallback, useRef, useMemo } from 'react';
import { createClient } from '@/lib/supabase/client';
import { toast } from 'sonner';
import type { Contact, Tag, ContactTag, LeadPriority } from '@/types';
import { useLeadMeta } from '@/components/leads/use-lead-meta';
import { PRIORITIES, PRIORITY_COLOR } from '@/lib/leads/lead-utils';
import { Button } from '@/components/ui/button';
import {
  DropdownMenu,
  DropdownMenuTrigger,
  DropdownMenuContent,
  DropdownMenuItem,
  DropdownMenuSeparator,
} from '@/components/ui/dropdown-menu';
import {
  Dialog,
  DialogContent,
  DialogHeader,
  DialogTitle,
  DialogDescription,
  DialogFooter,
} from '@/components/ui/dialog';
import {
  Plus,
  Upload,
  MoreHorizontal,
  Pencil,
  Trash2,
  Loader2,
  Users,
  ChevronLeft,
  ChevronRight,
  SlidersHorizontal,
  Filter,
  List,
  LayoutGrid,
  X,
} from 'lucide-react';
import { ContactForm } from '@/components/contacts/contact-form';
import { ImportModal } from '@/components/contacts/import-modal';
import { CustomFieldsManager } from '@/components/contacts/custom-fields-manager';
import { useCan } from '@/hooks/use-can';
import { GatedButton } from '@/components/ui/gated-button';
import { useTranslations } from 'next-intl';
import { useRouter } from 'next/navigation';

const PAGE_SIZE = 25;
// The kanban shows everything at once instead of paging, up to this many contacts.
const KANBAN_LIMIT = 200;
const NO_STATUS = '__none';

interface ContactWithTags extends Contact {
  tags?: Tag[];
}

interface ContactFilters {
  name: string;
  phone: string;
  email: string;
  company: string;
  from: string; // yyyy-mm-dd
  to: string; // yyyy-mm-dd
  // lead filters (migration 041)
  owner: string; // profiles.id
  stage: string; // pipeline_stages.id
  priority: string;
  source: string;
  followFrom: string; // yyyy-mm-dd
  followTo: string; // yyyy-mm-dd
}
const EMPTY_FILTERS: ContactFilters = {
  name: '', phone: '', email: '', company: '', from: '', to: '',
  owner: '', stage: '', priority: '', source: '', followFrom: '', followTo: '',
};
const hasLeadFilter = (f: ContactFilters) =>
  !!(f.owner || f.stage || f.priority || f.source.trim() || f.followFrom || f.followTo);

// Columns the server can sort by (anything else is not sortable).
const SERVER_SORT = new Set(['name', 'phone', 'email', 'company', 'created_at', 'lead_code', 'follow_up_date']);

/** Local-day boundaries as ISO timestamps for the created-date filter. */
const dayStartIso = (d: string) => new Date(`${d}T00:00:00`).toISOString();
const dayEndIso = (d: string) => new Date(`${d}T23:59:59.999`).toISOString();

const isMissingFunction = (e: { code?: string; message?: string }) =>
  e.code === 'PGRST202' || e.code === '42883' || /could not find the function/i.test(e.message ?? '');

export default function ContactsPage() {
  const t = useTranslations('Contacts.page');
  const supabase = createClient();
  const router = useRouter();
  const canEdit = useCan('send-messages');
  const canEditSettings = useCan('edit-settings');

  const [contacts, setContacts] = useState<ContactWithTags[]>([]);
  const [loading, setLoading] = useState(true);
  const [search, setSearch] = useState('');
  const [page, setPage] = useState(0);
  const [totalCount, setTotalCount] = useState(0);
  // Tag filter — contacts shown must have ANY of these tags (OR).
  const [selectedTagIds, setSelectedTagIds] = useState<string[]>([]);
  // PMS-style field filters (typed values) + the debounced copy that drives the query.
  const [showFilters, setShowFilters] = useState(false);
  const [filters, setFilters] = useState<ContactFilters>(EMPTY_FILTERS);
  const [appliedFilters, setAppliedFilters] = useState<ContactFilters>(EMPTY_FILTERS);
  // True when the tag path had to fall back to the pre-040 RPC (extra filters/sort not applied).
  const [legacyTagMode, setLegacyTagMode] = useState(false);
  const kitLabels = useKitLabels();
  const tk = useTranslations('Kit');
  const tl = useTranslations('Lead');
  const { stages: leadStages, profiles: leadProfiles } = useLeadMeta();
  const { view, setView } = useViewMode<'list' | 'kanban'>('contacts', ['list', 'kanban']);
  const pageSize = view === 'kanban' ? KANBAN_LIMIT : PAGE_SIZE;
  // True once migration 041 is applied (rows carry the lead columns); hides the lead columns/filters before that.
  const [leadReady, setLeadReady] = useState(false);

  // Column definitions drive the table, Sort/Columns menus and Export.
  const columns = useMemo<Column<ContactWithTags>[]>(
    () => [
      {
        key: 'name',
        label: t('tableColumns.name'),
        required: true,
        primary: true,
        csv: (c) => c.name ?? '',
        render: (c) =>
          c.name || <span className="italic">{t('unnamed')}</span>,
      },
      {
        key: 'phone',
        label: t('tableColumns.phone'),
        csv: (c) => c.phone,
        render: (c) => <span className="font-mono text-xs">{c.phone}</span>,
      },
      { key: 'email', label: t('tableColumns.email'), hideBelow: 'md', csv: (c) => c.email ?? '', render: (c) => c.email || '-' },
      { key: 'company', label: t('tableColumns.company'), hideBelow: 'lg', csv: (c) => c.company ?? '', render: (c) => c.company || '-' },
      {
        key: 'tags',
        label: t('tableColumns.tags'),
        hideBelow: 'md',
        sortable: false,
        csv: (c) => (c.tags ?? []).map((x) => x.name).join(', '),
        render: (c) => (
          <div className="flex flex-wrap gap-1">
            {c.tags && c.tags.length > 0 ? (
              c.tags.slice(0, 3).map((tag) => (
                <span
                  key={tag.id}
                  className="inline-flex items-center rounded-full px-2 py-0.5 text-[10px] font-medium"
                  style={{ backgroundColor: tag.color + '20', color: tag.color }}
                >
                  {tag.name}
                </span>
              ))
            ) : (
              <span className="text-xs">-</span>
            )}
            {c.tags && c.tags.length > 3 && <span className="text-[10px]">+{c.tags.length - 3}</span>}
          </div>
        ),
      },
      ...(leadReady
        ? ([
            {
              key: 'lead_code',
              label: t('colLeadCode'),
              hideBelow: 'lg',
              csv: (c) => c.lead_code ?? '',
              render: (c) => <span className="font-mono text-xs">{c.lead_code ?? '-'}</span>,
            },
            {
              key: 'lead_stage',
              label: t('colStatus'),
              sortable: false,
              csv: (c) => leadStages.find((s) => s.id === c.lead_stage_id)?.name ?? '',
              render: (c) => {
                const st = leadStages.find((s) => s.id === c.lead_stage_id);
                return st ? (
                  <span className="inline-flex items-center gap-1.5">
                    <span className="size-2 rounded-full" style={{ background: st.color }} />
                    {st.name}
                  </span>
                ) : (
                  '-'
                );
              },
            },
            {
              key: 'owner',
              label: t('colOwner'),
              sortable: false,
              defaultVisible: false,
              csv: (c) => leadProfiles.find((p) => p.id === c.owner_id)?.full_name ?? '',
              render: (c) => leadProfiles.find((p) => p.id === c.owner_id)?.full_name || '-',
            },
            {
              key: 'priority',
              label: t('colPriority'),
              sortable: false,
              defaultVisible: false,
              csv: (c) => c.priority ?? '',
              render: (c) =>
                c.priority ? (
                  <span className="k-pill" style={{ color: PRIORITY_COLOR[c.priority as LeadPriority] }}>
                    {tl(`priority_${c.priority}`)}
                  </span>
                ) : (
                  '-'
                ),
            },
            {
              key: 'follow_up_date',
              label: t('colFollowUp'),
              hideBelow: 'lg',
              sortType: 'date',
              defaultVisible: false,
              csv: (c) => c.follow_up_date ?? '',
              render: (c) => c.follow_up_date ?? '-',
            },
          ] as Column<ContactWithTags>[])
        : []),
      {
        key: 'created_at',
        label: t('tableColumns.createdAt'),
        hideBelow: 'lg',
        sortType: 'date',
        csv: (c) => c.created_at,
        render: (c) => (
          <span className="text-xs">
            {new Date(c.created_at).toLocaleDateString('en-US', { month: 'short', day: 'numeric', year: 'numeric' })}
          </span>
        ),
      },
    ],
    [t, tl, leadReady, leadStages, leadProfiles],
  );
  const prefs = useListPrefs<ContactWithTags>('contacts', columns, { key: 'created_at', order: 'desc' });

  // Modals
  const [formOpen, setFormOpen] = useState(false);
  const [editContact, setEditContact] = useState<Contact | null>(null);
  const [editContactTags, setEditContactTags] = useState<ContactTag[]>([]);
  const [importOpen, setImportOpen] = useState(false);
  const [customFieldsOpen, setCustomFieldsOpen] = useState(false);
  const [deleteConfirmOpen, setDeleteConfirmOpen] = useState(false);
  const [deleteTarget, setDeleteTarget] = useState<Contact | null>(null);
  const [deleting, setDeleting] = useState(false);

  // Bulk selection (page-scoped — only the loaded rows are selectable)
  const [selected, setSelected] = useState<Set<string>>(new Set());
  const [bulkDeleteOpen, setBulkDeleteOpen] = useState(false);

  // All tags for display
  const [tagsMap, setTagsMap] = useState<Record<string, Tag>>({});

  // Guards against out-of-order fetch responses: each fetchContacts run
  // claims a sequence number and only the latest is allowed to commit its
  // results. Without this, rapidly toggling tag filters could let a slower
  // earlier request resolve last and render stale rows.
  const fetchSeq = useRef(0);

  const fetchTags = useCallback(async () => {
    const { data } = await supabase.from('tags').select('*');
    if (data) {
      const map: Record<string, Tag> = {};
      data.forEach((t) => (map[t.id] = t));
      setTagsMap(map);
      // Drop any filter selections whose tag no longer exists (e.g. a tag
      // deleted elsewhere) so it can't linger invisibly in the query.
      setSelectedTagIds((prev) => {
        const pruned = prev.filter((id) => map[id]);
        return pruned.length === prev.length ? prev : pruned;
      });
    }
  }, [supabase]);

  const fetchContacts = useCallback(async () => {
    const seq = ++fetchSeq.current;
    setLoading(true);
    // The visible rows are about to change — drop any selection that
    // referred to the old page/search results so the bulk bar can't
    // act on rows the user can no longer see.
    setSelected(new Set());

    const from = page * pageSize;
    const to = from + pageSize - 1;
    const term = search.trim();

    let contactRows: Contact[];
    let count: number;

    const f = appliedFilters;
    const sortCol = SERVER_SORT.has(prefs.sort.key) ? prefs.sort.key : 'created_at';
    const ascending = prefs.sort.order === 'asc';

    if (selectedTagIds.length > 0) {
      // Tag filter active — resolve it server-side (join + distinct +
      // windowed total count + pagination) so a tag covering many
      // contacts can't silently truncate the result or overflow an IN
      // clause. See migrations 025 (tags + search) and 040 (adds field
      // filters + sort; used first, with 025 as the fallback).
      const v2Args = {
        p_tag_ids: selectedTagIds,
        p_search: term || null,
        p_name: f.name.trim() || null,
        p_phone: f.phone.trim() || null,
        p_email: f.email.trim() || null,
        p_company: f.company.trim() || null,
        p_created_from: f.from ? dayStartIso(f.from) : null,
        p_created_to: f.to ? dayEndIso(f.to) : null,
        p_sort_col: sortCol,
        p_sort_dir: ascending ? 'asc' : 'desc',
        p_limit: pageSize,
        p_offset: from,
      };
      // Newest first: v3 (lead filters, migration 041), then v2 (field filters, 040), then 025 (tags only).
      let { data, error } = await supabase.rpc('filter_contacts_v3', {
        ...v2Args,
        p_owner_id: f.owner || null,
        p_stage_id: f.stage || null,
        p_priority: f.priority || null,
        p_source: f.source.trim() || null,
        p_follow_from: f.followFrom || null,
        p_follow_to: f.followTo || null,
      });
      let legacy = false;
      if (error && isMissingFunction(error)) {
        // Migration 041 not applied: lead filters cannot be combined with a tag filter.
        legacy = hasLeadFilter(f);
        ({ data, error } = await supabase.rpc('filter_contacts_v2', v2Args));
      }
      if (error && isMissingFunction(error)) {
        // Migration 040 not applied either: previous behaviour (tags + search only).
        legacy = true;
        ({ data, error } = await supabase.rpc('filter_contacts_by_tags', {
          p_tag_ids: selectedTagIds,
          p_search: term || null,
          p_limit: pageSize,
          p_offset: from,
        }));
      }
      if (seq !== fetchSeq.current) return; // superseded by a newer fetch
      setLegacyTagMode(legacy);
      if (error) {
        toast.error(t('toastFailedLoad'));
        setLoading(false);
        return;
      }
      const rows = (data ?? []) as { contact: Contact; total_count: number }[];
      contactRows = rows.map((r) => r.contact);
      count = rows.length > 0 ? Number(rows[0].total_count) : 0;
    } else {
      let query = supabase
        .from('contacts')
        .select('*', { count: 'exact' })
        .order(sortCol, { ascending, nullsFirst: false });
      if (sortCol !== 'created_at') query = query.order('created_at', { ascending: false });
      query = query.range(from, to);

      if (term) {
        const like = `%${term}%`;
        query = query.or(`name.ilike.${like},phone.ilike.${like},email.ilike.${like}`);
      }
      if (f.name.trim()) query = query.ilike('name', `%${f.name.trim()}%`);
      if (f.phone.trim()) query = query.ilike('phone', `%${f.phone.trim()}%`);
      if (f.email.trim()) query = query.ilike('email', `%${f.email.trim()}%`);
      if (f.company.trim()) query = query.ilike('company', `%${f.company.trim()}%`);
      if (f.from) query = query.gte('created_at', dayStartIso(f.from));
      if (f.to) query = query.lte('created_at', dayEndIso(f.to));
      // Lead filters are only added when used, so this keeps working before migration 041.
      if (f.owner) query = query.eq('owner_id', f.owner);
      if (f.stage) query = query.eq('lead_stage_id', f.stage);
      if (f.priority) query = query.eq('priority', f.priority);
      if (f.source.trim()) query = query.ilike('source', `%${f.source.trim()}%`);
      if (f.followFrom) query = query.gte('follow_up_date', f.followFrom);
      if (f.followTo) query = query.lte('follow_up_date', f.followTo);

      const { data, count: exactCount, error } = await query;
      if (seq !== fetchSeq.current) return; // superseded by a newer fetch
      setLegacyTagMode(false);
      if (error) {
        toast.error(t('toastFailedLoad'));
        setLoading(false);
        return;
      }
      contactRows = data ?? [];
      count = exactCount ?? 0;
    }

    setTotalCount(count);
    if (contactRows.length > 0) setLeadReady('lead_code' in contactRows[0]);

    if (contactRows.length === 0) {
      setContacts([]);
      setLoading(false);
      return;
    }

    // Fetch tags for these contacts
    const contactIds = contactRows.map((c) => c.id);
    const { data: contactTags } = await supabase
      .from('contact_tags')
      .select('contact_id, tag_id')
      .in('contact_id', contactIds);
    if (seq !== fetchSeq.current) return; // superseded by a newer fetch

    const tagsByContact: Record<string, string[]> = {};
    contactTags?.forEach((ct) => {
      if (!tagsByContact[ct.contact_id]) tagsByContact[ct.contact_id] = [];
      tagsByContact[ct.contact_id].push(ct.tag_id);
    });

    const enriched: ContactWithTags[] = contactRows.map((c) => ({
      ...c,
      tags: (tagsByContact[c.id] ?? [])
        .map((tid) => tagsMap[tid])
        .filter(Boolean),
    }));

    setContacts(enriched);
    setLoading(false);
  }, [supabase, page, search, selectedTagIds, tagsMap, t, appliedFilters, prefs.sort.key, prefs.sort.order, pageSize]);

  // Load-once-on-mount-ish data fetches. Each setter inside runs
  // inside an async promise completion (Supabase await), not
  // synchronously in the effect body, so the cascade the lint rule
  // warns about doesn't apply here.
  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    fetchTags();
  }, [fetchTags]);

  useEffect(() => {
    // eslint-disable-next-line react-hooks/set-state-in-effect
    fetchContacts();
  }, [fetchContacts]);

  // Field filters hit the server, so apply them after the user pauses typing.
  useEffect(() => {
    const id = setTimeout(() => setAppliedFilters(filters), 300);
    return () => clearTimeout(id);
  }, [filters]);

  function updateFilter(key: keyof ContactFilters, value: string) {
    setFilters((prev) => ({ ...prev, [key]: value }));
    setPage(0);
  }

  function clearAllFilters() {
    setFilters(EMPTY_FILTERS);
    setAppliedFilters(EMPTY_FILTERS);
    setSelectedTagIds([]);
    setPage(0);
  }

  function openAddForm() {
    setEditContact(null);
    setEditContactTags([]);
    setFormOpen(true);
  }

  async function openEditForm(contact: Contact) {
    const { data } = await supabase
      .from('contact_tags')
      .select('*')
      .eq('contact_id', contact.id);
    setEditContact(contact);
    setEditContactTags(data ?? []);
    setFormOpen(true);
  }

  // Each contact has its own page (lead page): /contacts/[id].
  function openDetail(contactId: string) {
    router.push(`/contacts/${contactId}`);
  }

  function confirmDelete(contact: Contact) {
    setDeleteTarget(contact);
    setDeleteConfirmOpen(true);
  }

  async function handleDelete() {
    if (!deleteTarget) return;
    setDeleting(true);

    const { error } = await supabase
      .from('contacts')
      .delete()
      .eq('id', deleteTarget.id);

    if (error) {
      toast.error(t('toastFailedDelete'));
    } else {
      toast.success(t('toastDeleted'));
      fetchContacts();
    }

    setDeleting(false);
    setDeleteConfirmOpen(false);
    setDeleteTarget(null);
  }

  function toggleSelect(id: string) {
    setSelected((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  }

  async function handleBulkDelete() {
    const ids = [...selected];
    if (ids.length === 0) return;
    setDeleting(true);

    const { error } = await supabase.from('contacts').delete().in('id', ids);

    if (error) {
      toast.error(t('toastBulkFailedDelete'));
    } else {
      toast.success(t('toastBulkDeleted', { count: ids.length }));
      setSelected(new Set());
      fetchContacts();
    }

    setDeleting(false);
    setBulkDeleteOpen(false);
  }

  /** Bulk: set the selected contacts' lead status to the first stage of the lead pipeline ("New Lead"). */
  async function handleConvertToLead() {
    const first = leadStages[0];
    if (!first) {
      toast.error(t('convertNeedsLeadPipeline'));
      return;
    }
    const ids = [...selected];
    if (ids.length === 0) return;
    setDeleting(true);
    const { error } = await supabase.from('contacts').update({ lead_stage_id: first.id }).in('id', ids);
    setDeleting(false);
    if (error) {
      toast.error(t('convertToLeadFailed'));
      return;
    }
    toast.success(t('convertedToLead', { count: ids.length, status: first.name }));
    setSelected(new Set());
    fetchContacts();
  }

  /** Kanban drag: change one contact's lead status. Returns false to snap the card back. */
  async function moveContactStatus(contact: ContactWithTags, columnId: string): Promise<boolean> {
    const next = columnId === NO_STATUS ? null : columnId;
    const { error } = await supabase.from('contacts').update({ lead_stage_id: next }).eq('id', contact.id);
    if (error) {
      toast.error(t('moveFailed'));
      return false;
    }
    setContacts((prev) => prev.map((c) => (c.id === contact.id ? { ...c, lead_stage_id: next } : c)));
    return true;
  }

  const kanbanColumns: KanbanColumn[] = [
    ...(contacts.some((c) => !c.lead_stage_id || !leadStages.some((s) => s.id === c.lead_stage_id))
      ? [{ id: NO_STATUS, label: t('noStatusColumn'), color: 'var(--text-muted)' }]
      : []),
    ...leadStages.map((s) => ({ id: s.id, label: s.name, color: s.color })),
  ];

  const totalPages = Math.ceil(totalCount / pageSize);
  const hasNext = page < totalPages - 1;
  const hasPrev = page > 0;

  // Tag filter helpers. Every change resets to page 0 — the result set
  // shrinks/grows so page N may no longer be valid (mirrors the search box).
  const allTags = Object.values(tagsMap).sort((a, b) =>
    a.name.localeCompare(b.name)
  );
  const filterValueLabel = (k: keyof ContactFilters): string => {
    const v = filters[k];
    if (k === 'owner') return leadProfiles.find((p) => p.id === v)?.full_name || v;
    if (k === 'stage') return leadStages.find((s) => s.id === v)?.name || v;
    if (k === 'priority') return PRIORITIES.includes(v as LeadPriority) ? tl(`priority_${v}`) : v;
    return v;
  };
  const fieldFilterChips = (
    [
      ['name', t('filterName')],
      ['phone', t('filterPhone')],
      ['email', t('filterEmail')],
      ['company', t('filterCompany')],
      ['from', t('createdFrom')],
      ['to', t('createdTo')],
      ['owner', t('colOwner')],
      ['stage', t('colStatus')],
      ['priority', t('colPriority')],
      ['source', t('filterSource')],
      ['followFrom', t('followFrom')],
      ['followTo', t('followTo')],
    ] as Array<[keyof ContactFilters, string]>
  )
    .filter(([k]) => filters[k].trim() !== '')
    .map(([k, label]) => ({
      key: k,
      label: `${label}: ${filterValueLabel(k)}`,
      onRemove: () => updateFilter(k, ''),
    }));
  const activeFilterCount = fieldFilterChips.length + (selectedTagIds.length > 0 ? 1 : 0);
  const hasActiveFilters = search.trim().length > 0 || activeFilterCount > 0;

  // Table selection adapter over the page-scoped `selected` set (cleared on every fetch).
  const selection: Selection = {
    ids: selected,
    has: (id) => selected.has(id),
    toggle: toggleSelect,
    toggleAll: (ids, on) => setSelected(on ? new Set(ids) : new Set()),
    clear: () => setSelected(new Set()),
    count: selected.size,
  };

  function toggleTagFilter(tagId: string) {
    setSelectedTagIds((prev) =>
      prev.includes(tagId)
        ? prev.filter((id) => id !== tagId)
        : [...prev, tagId]
    );
    setPage(0);
  }

  function clearTagFilters() {
    setSelectedTagIds([]);
    setPage(0);
  }

  return (
    <div className="space-y-6">
      {/* Header */}
      <div className="flex flex-col sm:flex-row sm:items-center sm:justify-between gap-4">
        <div>
          <h1 className="text-2xl font-bold text-foreground">{t('title')}</h1>
          <p className="text-sm text-muted-foreground mt-1">
            {totalCount > 0 ? t('subtitle', { count: totalCount }) : t('subtitleZero')}
          </p>
        </div>
        <div className="flex items-center gap-2">
          {canEditSettings && (
            <Button
              variant="outline"
              onClick={() => setCustomFieldsOpen(true)}
              className="border-border text-muted-foreground hover:bg-muted"
            >
              <SlidersHorizontal className="size-4" />
              {t('customFieldsBtn')}
            </Button>
          )}
          <GatedButton
            variant="outline"
            canAct={canEdit}
            gateReason="add or import contacts"
            onClick={() => setImportOpen(true)}
            className="border-border text-muted-foreground hover:bg-muted"
          >
            <Upload className="size-4" />
            {t('importBtn')}
          </GatedButton>
          <GatedButton
            canAct={canEdit}
            gateReason="add or import contacts"
            onClick={openAddForm}
            className="bg-primary hover:bg-primary/90 text-primary-foreground"
          >
            <Plus className="size-4" />
            {t('addContactBtn')}
          </GatedButton>
        </div>
      </div>

      {/* Toolbar + filters + table share one PMS-style panel */}
      <div className="overflow-hidden rounded-lg border border-border bg-card">
        <Toolbar
          left={
            <>
              <ViewMenu
                view={view}
                setView={(v) => {
                  setView(v);
                  setPage(0);
                  setSelected(new Set());
                }}
                views={[
                  { id: 'list', label: tk('listView'), icon: List },
                  { id: 'kanban', label: tk('kanbanView'), icon: LayoutGrid },
                ]}
              />
              <SearchBox
                value={search}
                onChange={(v) => {
                  setSearch(v);
                  // Reset pagination when the query changes — the result
                  // set shrinks/grows, page N may no longer be valid.
                  setPage(0);
                }}
                placeholder={t('searchPlaceholder')}
                width={280}
              />
            </>
          }
          right={
            <>
              <KButton aria-pressed={showFilters} onClick={() => setShowFilters((v) => !v)}>
                <Filter className="size-3.5" />
                {tk('filter')}
                {activeFilterCount > 0 && <span className="k-count">{activeFilterCount}</span>}
              </KButton>
              <SortMenu
                columns={columns.filter((c) => SERVER_SORT.has(c.key))}
                sort={prefs.sort}
                onChange={(next) => {
                  prefs.setSort(next);
                  setPage(0);
                }}
                labels={kitLabels}
              />
              <ColumnsMenu
                columns={columns}
                visibleSet={prefs.visibleSet}
                onToggle={prefs.toggleColumn}
                onReset={prefs.resetColumns}
                disabled={view === 'kanban'}
                labels={kitLabels}
              />
              <ExportMenu
                name="contacts"
                columns={prefs.visibleColumns}
                rows={contacts}
                disabled={contacts.length === 0}
                labels={kitLabels}
              />
            </>
          }
        />

        {showFilters && (
          <FilterBar columns={4}>
            <KInput placeholder={t('filterName')} value={filters.name} onChange={(e) => updateFilter('name', e.target.value)} />
            <KInput placeholder={t('filterPhone')} value={filters.phone} onChange={(e) => updateFilter('phone', e.target.value)} />
            <KInput placeholder={t('filterEmail')} value={filters.email} onChange={(e) => updateFilter('email', e.target.value)} />
            <KInput placeholder={t('filterCompany')} value={filters.company} onChange={(e) => updateFilter('company', e.target.value)} />
            <KInput type="date" aria-label={t('createdFrom')} title={t('createdFrom')} value={filters.from} onChange={(e) => updateFilter('from', e.target.value)} />
            <KInput type="date" aria-label={t('createdTo')} title={t('createdTo')} value={filters.to} onChange={(e) => updateFilter('to', e.target.value)} />
            {leadReady && (
              <>
                <KSelect value={filters.owner} onChange={(e) => updateFilter('owner', e.target.value)}>
                  <option value="">{t('filterOwner')}</option>
                  {leadProfiles.map((p) => (
                    <option key={p.id} value={p.id}>{p.full_name || p.email}</option>
                  ))}
                </KSelect>
                <KSelect value={filters.stage} onChange={(e) => updateFilter('stage', e.target.value)} disabled={leadStages.length === 0}>
                  <option value="">{t('filterStatus')}</option>
                  {leadStages.map((s) => (
                    <option key={s.id} value={s.id}>{s.name}</option>
                  ))}
                </KSelect>
                <KSelect value={filters.priority} onChange={(e) => updateFilter('priority', e.target.value)}>
                  <option value="">{t('filterPriority')}</option>
                  {PRIORITIES.map((p) => (
                    <option key={p} value={p}>{tl(`priority_${p}`)}</option>
                  ))}
                </KSelect>
                <KInput placeholder={t('filterSource')} value={filters.source} onChange={(e) => updateFilter('source', e.target.value)} />
                <KInput type="date" aria-label={t('followFrom')} title={t('followFrom')} value={filters.followFrom} onChange={(e) => updateFilter('followFrom', e.target.value)} />
                <KInput type="date" aria-label={t('followTo')} title={t('followTo')} value={filters.followTo} onChange={(e) => updateFilter('followTo', e.target.value)} />
              </>
            )}
            <Dropdown
              role="dialog"
              wide
              ariaLabel={t('filterByTags')}
              trigger={
                <>
                  <Filter className="size-3.5" />
                  {t('tagsAny')}
                  {selectedTagIds.length > 0 && <span className="k-count">{selectedTagIds.length}</span>}
                </>
              }
            >
              {allTags.length === 0 ? (
                <p className="k-muted px-3 py-3 text-center text-sm">{t('noTagsYet')}</p>
              ) : (
                <div className="max-h-64 overflow-y-auto">
                  {allTags.map((tag) => (
                    <label key={tag.id} className="k-menu__item" style={{ cursor: 'pointer' }}>
                      <input
                        type="checkbox"
                        className="k-check"
                        checked={selectedTagIds.includes(tag.id)}
                        onChange={() => toggleTagFilter(tag.id)}
                        aria-label={`Filter by ${tag.name}`}
                      />
                      <span className="size-2.5 shrink-0 rounded-full" style={{ backgroundColor: tag.color }} />
                      <span className="truncate">{tag.name}</span>
                    </label>
                  ))}
                </div>
              )}
            </Dropdown>
            <KButton onClick={clearAllFilters} disabled={activeFilterCount === 0}>
              <Filter className="size-3.5" /> {tk('clearFilters')}
            </KButton>
          </FilterBar>
        )}

        <FilterChips items={fieldFilterChips} />

        {/* Active tag-filter chips */}
        {selectedTagIds.length > 0 && (
          <div className="k-chips">
            {selectedTagIds.map((id) => {
              const tag = tagsMap[id];
              if (!tag) return null;
              return (
                <span
                  key={id}
                  className="inline-flex items-center gap-1 rounded-full px-2 py-0.5 text-[11px] font-medium"
                  style={{ backgroundColor: tag.color + '20', color: tag.color }}
                >
                  {tag.name}
                  <button onClick={() => toggleTagFilter(id)} aria-label={`Remove ${tag.name} filter`} className="hover:opacity-70">
                    <X className="size-3" />
                  </button>
                </span>
              );
            })}
            <button onClick={clearTagFilters} className="k-muted px-1 text-xs hover:text-foreground">
              {t('clearAll')}
            </button>
          </div>
        )}
        {legacyTagMode && (fieldFilterChips.length > 0 || prefs.sort.key !== 'created_at' || prefs.sort.order !== 'desc') && (
          <p className="k-muted px-6 pt-2 text-xs">{t('filtersNote')}</p>
        )}
        <div style={{ height: 8 }} />

      {/* Bulk action bar */}
      {selected.size > 0 && (
        <div className="mx-6 mb-3 flex items-center justify-between gap-4 rounded-lg border border-border bg-muted/40 px-4 py-2">
          <p className="text-sm text-foreground">
            {t('selectedCount', { count: selected.size })}
          </p>
          <div className="flex items-center gap-2">
            <Button
              variant="ghost"
              size="sm"
              onClick={() => setSelected(new Set())}
              className="text-muted-foreground hover:text-foreground"
            >
              {t('clearSelection')}
            </Button>
            <GatedButton
              variant="outline"
              size="sm"
              canAct={canEdit}
              gateReason="change lead status"
              onClick={handleConvertToLead}
              disabled={deleting}
              className="border-border text-foreground hover:bg-muted"
            >
              {t('convertToLead')}
            </GatedButton>
            <GatedButton
              variant="destructive"
              size="sm"
              canAct={canEdit}
              gateReason="delete contacts"
              onClick={() => setBulkDeleteOpen(true)}
            >
              <Trash2 className="size-4" />
              {t('deleteSelected')}
            </GatedButton>
          </div>
        </div>
      )}

      {/* Table */}
      {loading ? (
        <div className="flex flex-col items-center gap-2 py-12">
          <Loader2 className="size-6 animate-spin text-primary" />
          <p className="k-muted text-sm">{t('loading')}</p>
        </div>
      ) : contacts.length === 0 ? (
        <EmptyState
          icon={Users}
          action={
            !hasActiveFilters ? (
              <GatedButton
                canAct={canEdit}
                gateReason="add or import contacts"
                variant="outline"
                size="sm"
                onClick={openAddForm}
                className="mt-2 border-border text-muted-foreground hover:bg-muted"
              >
                <Plus className="size-3.5" />
                {t('addFirstContact')}
              </GatedButton>
            ) : undefined
          }
        >
          {hasActiveFilters ? t('noContactsMatch') : t('noContactsYet')}
        </EmptyState>
      ) : view === 'kanban' ? (
        leadStages.length === 0 ? (
          <EmptyState
            icon={LayoutGrid}
            action={<KButton onClick={() => router.push('/pipelines')}>{t('openPipelines')}</KButton>}
          >
            {t('kanbanNeedsLeadPipeline')}
          </EmptyState>
        ) : (
          <>
            {totalCount > contacts.length && (
              <p className="k-muted px-6 pt-1 text-xs">{t('kanbanLimit', { count: contacts.length, total: totalCount })}</p>
            )}
            <div className="overflow-x-auto">
              <KanbanBoard
                columns={kanbanColumns}
                items={contacts}
                getColumn={(c) => (c.lead_stage_id && leadStages.some((s) => s.id === c.lead_stage_id) ? c.lead_stage_id : NO_STATUS)}
                getId={(c) => c.id}
                onOpen={(c) => openDetail(c.id)}
                onMove={canEdit && leadReady ? moveContactStatus : undefined}
                emptyLabel={tk('noItems')}
                renderCard={(c) => (
                  <>
                    <div style={{ fontSize: 13, fontWeight: 600 }}>{c.name || c.phone}</div>
                    <div className="k-muted" style={{ fontSize: 12, margin: '2px 0 6px' }}>
                      {c.name ? c.phone : ''}{c.company ? `${c.name ? ' · ' : ''}${c.company}` : ''}
                    </div>
                    <div style={{ display: 'flex', flexWrap: 'wrap', gap: 4, alignItems: 'center' }}>
                      {c.priority && (
                        <span className="k-pill" style={{ color: PRIORITY_COLOR[c.priority as LeadPriority] }}>
                          {tl(`priority_${c.priority}`)}
                        </span>
                      )}
                      {(c.tags ?? []).slice(0, 2).map((tag) => (
                        <span key={tag.id} style={{ borderRadius: 12, padding: '1px 8px', fontSize: 11, fontWeight: 500, background: `${tag.color}20`, color: tag.color }}>
                          {tag.name}
                        </span>
                      ))}
                    </div>
                  </>
                )}
              />
            </div>
          </>
        )
      ) : (
        <RecordTable
          columns={prefs.visibleColumns}
          rows={contacts}
          getId={(c) => c.id}
          selection={selection}
          onOpen={(c) => openDetail(c.id)}
          sort={prefs.sort}
          onSort={(key) => {
            if (!SERVER_SORT.has(key)) return;
            prefs.setSort({ key, order: prefs.sort.key === key && prefs.sort.order === 'asc' ? 'desc' : 'asc' });
            setPage(0);
          }}
          selectAllLabel="Select all contacts on this page"
          actions={(contact) => (
            <DropdownMenu>
              <DropdownMenuTrigger
                render={
                  <Button
                    variant="ghost"
                    size="icon-sm"
                    className="text-muted-foreground hover:text-foreground"
                    onClick={(e) => e.stopPropagation()}
                  />
                }
              >
                <MoreHorizontal className="size-4" />
              </DropdownMenuTrigger>
              <DropdownMenuContent align="end" className="bg-popover border-border">
                <DropdownMenuItem
                  onClick={(e) => {
                    e.stopPropagation();
                    openEditForm(contact);
                  }}
                  className="text-popover-foreground focus:bg-muted focus:text-foreground"
                >
                  <Pencil className="size-4" />
                  {t('editAction')}
                </DropdownMenuItem>
                <DropdownMenuSeparator className="bg-border" />
                <DropdownMenuItem
                  variant="destructive"
                  onClick={(e) => {
                    e.stopPropagation();
                    confirmDelete(contact);
                  }}
                >
                  <Trash2 className="size-4" />
                  {t('deleteAction')}
                </DropdownMenuItem>
              </DropdownMenuContent>
            </DropdownMenu>
          )}
        />
      )}
      </div>

      {/* Pagination */}
      {totalPages > 1 && (
        <div className="flex items-center justify-between">
          <p className="text-xs text-muted-foreground">
            {t('showingPagination', {
              start: page * pageSize + 1,
              end: Math.min((page + 1) * pageSize, totalCount),
              total: totalCount
            })}
          </p>
          <div className="flex items-center gap-1">
            <Button
              variant="outline"
              size="icon-sm"
              disabled={!hasPrev}
              onClick={() => setPage((p) => p - 1)}
              className="border-border text-muted-foreground hover:bg-muted hover:text-foreground disabled:opacity-30"
            >
              <ChevronLeft className="size-4" />
            </Button>
            <span className="text-xs text-muted-foreground px-2">
              {t('pageCount', { page: page + 1, total: totalPages })}
            </span>
            <Button
              variant="outline"
              size="icon-sm"
              disabled={!hasNext}
              onClick={() => setPage((p) => p + 1)}
              className="border-border text-muted-foreground hover:bg-muted hover:text-foreground disabled:opacity-30"
            >
              <ChevronRight className="size-4" />
            </Button>
          </div>
        </div>
      )}

      {/* Contact Form Dialog */}
      <ContactForm
        open={formOpen}
        onOpenChange={setFormOpen}
        contact={editContact}
        contactTags={editContactTags}
        onSaved={() => {
          fetchContacts();
          fetchTags();
        }}
        onViewExisting={(id) => {
          setFormOpen(false);
          openDetail(id);
        }}
      />

      {/* Import Modal */}
      <ImportModal
        open={importOpen}
        onOpenChange={setImportOpen}
        onImported={fetchContacts}
      />

      {/* Custom Fields Manager (admin+) */}
      {canEditSettings && (
        <CustomFieldsManager
          open={customFieldsOpen}
          onOpenChange={setCustomFieldsOpen}
        />
      )}

      {/* Delete Confirmation */}
      <Dialog open={deleteConfirmOpen} onOpenChange={setDeleteConfirmOpen}>
        <DialogContent className="bg-popover border-border text-popover-foreground sm:max-w-sm">
          <DialogHeader>
            <DialogTitle className="text-popover-foreground">{t('deleteContactTitle')}</DialogTitle>
            <DialogDescription className="text-muted-foreground">
              {t('deleteContactDesc', { name: deleteTarget?.name || deleteTarget?.phone || '' })}
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="bg-popover border-border">
            <Button
              variant="outline"
              onClick={() => setDeleteConfirmOpen(false)}
              className="border-border text-muted-foreground hover:bg-muted"
            >
              {t('cancel')}
            </Button>
            <Button
              variant="destructive"
              onClick={handleDelete}
              disabled={deleting}
            >
              {deleting && <Loader2 className="size-4 animate-spin" />}
              {t('deleteBtn')}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>

      {/* Bulk Delete Confirmation */}
      <Dialog open={bulkDeleteOpen} onOpenChange={setBulkDeleteOpen}>
        <DialogContent className="bg-popover border-border text-popover-foreground sm:max-w-sm">
          <DialogHeader>
            <DialogTitle className="text-popover-foreground">
              {t('deleteBulkTitle')}
            </DialogTitle>
            <DialogDescription className="text-muted-foreground">
              {t('deleteBulkDesc', { count: selected.size })}
            </DialogDescription>
          </DialogHeader>
          <DialogFooter className="bg-popover border-border">
            <Button
              variant="outline"
              onClick={() => setBulkDeleteOpen(false)}
              className="border-border text-muted-foreground hover:bg-muted"
            >
              {t('cancel')}
            </Button>
            <Button
              variant="destructive"
              onClick={handleBulkDelete}
              disabled={deleting}
            >
              {deleting && <Loader2 className="size-4 animate-spin" />}
              {t('deleteBtn')}
            </Button>
          </DialogFooter>
        </DialogContent>
      </Dialog>
    </div>
  );
}
