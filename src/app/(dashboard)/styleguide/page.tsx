'use client';

import { useState } from 'react';
import { Filter, Plus, FileText, ArrowUpDown } from 'lucide-react';
import { useTheme } from '@/hooks/use-theme';
import { THEMES } from '@/lib/themes';
import {
  KButton, KInput, KSelect, KField, KCheckbox, SearchBox, Toggle, Toolbar, FilterBar,
  FilterChips, Dropdown, MenuItem, MenuHeading, KBadge, Pill, PRIORITY_COLORS, KModal,
  ModalBody, ModalFooter, KTabs, EmptyState, StatCard,
} from '@/components/kit';

const Section = ({ title, children }: { title: string; children: React.ReactNode }) => (
  <section style={{ marginBottom: 32 }}>
    <h2 style={{ fontSize: 13, fontWeight: 600, textTransform: 'uppercase', letterSpacing: '.05em', color: 'var(--text-muted)', marginBottom: 12 }}>{title}</h2>
    {children}
  </section>
);

/** Visual reference for the Selora UI kit: every component in the current mode + accent. */
export default function StyleguidePage() {
  const { theme, setTheme, mode, toggleMode } = useTheme();
  const [search, setSearch] = useState('');
  const [tab, setTab] = useState('a');
  const [on, setOn] = useState(true);
  const [modal, setModal] = useState(false);
  const [filters, setFilters] = useState(['Open', 'High']);

  return (
    <div style={{ maxWidth: 1000 }}>
      <Section title="Theme">
        <div className="k-toolbar__group">
          {THEMES.map((t) => (
            <KButton key={t.id} aria-pressed={theme === t.id} onClick={() => setTheme(t.id)}>
              <span style={{ width: 10, height: 10, borderRadius: '50%', background: t.swatch }} /> {t.name}
            </KButton>
          ))}
          <KButton onClick={toggleMode}>Mode: {mode}</KButton>
        </div>
      </Section>

      <Section title="Buttons">
        <div className="k-toolbar__group">
          <KButton>Default</KButton>
          <KButton variant="primary"><Plus size={14} /> Primary</KButton>
          <KButton variant="danger">Danger</KButton>
          <KButton variant="text">Text</KButton>
          <KButton disabled>Disabled</KButton>
        </div>
      </Section>

      <Section title="Toolbar + filter bar">
        <div style={{ border: '1px solid var(--border-color)', borderRadius: 8, overflow: 'hidden' }}>
          <Toolbar
            left={<SearchBox value={search} onChange={setSearch} placeholder="Search…" />}
            right={<>
              <KButton><Filter size={14} /> Filter <span className="k-count">2</span></KButton>
              <Dropdown align="right" icon={ArrowUpDown} label="Sort">
                <MenuHeading>Sort by</MenuHeading>
                <MenuItem active>Name</MenuItem>
                <MenuItem>Created</MenuItem>
              </Dropdown>
              <KButton variant="primary"><Plus size={14} /> Add</KButton>
            </>}
          />
          <FilterBar columns={4}>
            <KInput placeholder="Name" />
            <KSelect defaultValue=""><option value="">Status (All)</option><option>Open</option></KSelect>
            <KSelect defaultValue=""><option value="">Priority (All)</option><option>High</option></KSelect>
            <KButton>Clear Filters</KButton>
          </FilterBar>
          <FilterChips items={filters.map((f) => ({ key: f, label: f, onRemove: () => setFilters(filters.filter((x) => x !== f)) }))} />
          <div style={{ height: 8 }} />
        </div>
      </Section>

      <Section title="Kanban column + card">
        <div style={{ display: 'flex', gap: 12 }}>
          {['New', 'In progress'].map((c, i) => (
            <div key={c} className="k-col">
              <div className="k-col__head"><span className="k-col__dot" style={{ background: i ? '#f59e0b' : '#3b82f6' }} /><span className="k-col__title">{c}</span><span className="k-col__count">2</span></div>
              <div className="k-col__body">
                {[1, 2].map((n) => (
                  <div key={n} className="k-card">
                    <div style={{ fontSize: 11, color: 'var(--text-muted)' }}>DEAL-00{n}</div>
                    <div style={{ fontSize: 13, fontWeight: 600, margin: '2px 0 6px' }}>Acme onboarding {n}</div>
                    <Pill color={PRIORITY_COLORS.High}>High</Pill>
                  </div>
                ))}
              </div>
            </div>
          ))}
        </div>
      </Section>

      <Section title="Table">
        <div className="k-table-wrap" style={{ padding: 0 }}>
          <table className="k-table">
            <thead><tr><th className="k-sel"><KCheckbox aria-label="all" /></th><th><span>Name</span></th><th><span>Status</span></th><th><span>Value</span></th></tr></thead>
            <tbody>
              <tr><td className="k-sel"><KCheckbox aria-label="row" /></td><td className="is-primary">Acme Ltd</td><td><KBadge tone="green">Won</KBadge></td><td>$12,000</td></tr>
              <tr><td className="k-sel"><KCheckbox aria-label="row" /></td><td className="is-primary">Globex</td><td><KBadge tone="amber">Pending</KBadge></td><td>$4,500</td></tr>
              <tr><td className="k-sel"><KCheckbox aria-label="row" /></td><td className="is-primary">Initech</td><td><KBadge tone="red">Lost</KBadge></td><td>$900</td></tr>
            </tbody>
          </table>
        </div>
      </Section>

      <Section title="Badges, tabs, toggle, stat">
        <div className="k-toolbar__group" style={{ marginBottom: 12 }}>
          <KBadge>Blue</KBadge><KBadge tone="green">Green</KBadge><KBadge tone="amber">Amber</KBadge><KBadge tone="red">Red</KBadge><KBadge tone="gray">Gray</KBadge>
          <Toggle checked={on} onChange={setOn} label="demo" />
        </div>
        <KTabs tabs={[{ id: 'a', label: 'Overview' }, { id: 'b', label: 'Activity' }]} value={tab} onChange={setTab} />
        <div style={{ display: 'flex', gap: 12, marginTop: 16 }}>
          <StatCard label="Open deals" value="24" hint="+3 this week" />
          <StatCard label="Revenue" value="$48.2k" />
        </div>
      </Section>

      <Section title="Empty state + modal">
        <EmptyState icon={FileText} action={<KButton onClick={() => setModal(true)}>Open modal</KButton>}>No records found.</EmptyState>
      </Section>

      {modal && (
        <KModal title="New record" onClose={() => setModal(false)}>
          <ModalBody onSubmit={(e) => { e.preventDefault(); setModal(false); }}>
            <KField label="Name" required><KInput className="k-input--lg" /></KField>
            <ModalFooter>
              <KButton size="lg" onClick={() => setModal(false)}>Cancel</KButton>
              <KButton size="lg" variant="primary" type="submit">Save</KButton>
            </ModalFooter>
          </ModalBody>
        </KModal>
      )}
    </div>
  );
}
