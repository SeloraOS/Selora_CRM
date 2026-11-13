"use client";

import type { ComponentType } from "react";
import { ArrowDown, ArrowUp, ArrowUpDown, Columns, Download, Rows3 } from "lucide-react";
import { Dropdown, MenuHeading, MenuItem } from "./index";
import { downloadCsvFile, downloadXlsFile, type Column, type Sort } from "./list-utils";

type IconType = ComponentType<{ size?: number; className?: string }>;

/** All visible strings are overridable so pages can pass translated text (next-intl). */
export interface MenuLabels {
  sort?: string;
  sortBy?: string;
  ascending?: string;
  descending?: string;
  columns?: string;
  showColumns?: string;
  resetColumns?: string;
  export?: string;
  rows?: (n: number) => string;
  groupBy?: string;
  groupHint?: string;
}
const L = {
  sort: "Sort",
  sortBy: "Sort by",
  ascending: "Ascending",
  descending: "Descending",
  columns: "Columns",
  showColumns: "Show columns",
  resetColumns: "Reset to default",
  export: "Export",
  rows: (n: number) => `${n} row${n === 1 ? "" : "s"}`,
  groupBy: "Group cards by",
  groupHint: "Dragging a card to another column changes that field.",
};

/** "Sort" button: pick the column and direction. `columns` are the sortable ones. */
export function SortMenu<T>({ columns, sort, onChange, labels }: { columns: Column<T>[]; sort: Sort; onChange: (s: Sort) => void; labels?: MenuLabels }) {
  const l = { ...L, ...labels };
  const active = columns.find((c) => c.key === sort.key);
  return (
    <Dropdown
      align="right"
      wide
      ariaLabel={l.sort}
      trigger={
        <>
          <ArrowUpDown size={14} /> {l.sort}
          {active ? <span className="k-strong">· {active.label} {sort.order === "asc" ? "↑" : "↓"}</span> : null}
        </>
      }
    >
      <MenuHeading>{l.sortBy}</MenuHeading>
      {columns.map((c) => (
        <MenuItem
          key={c.key}
          role="menuitemradio"
          checked={c.key === sort.key}
          active={c.key === sort.key}
          onClick={() => onChange({ key: c.key, order: c.key === sort.key ? sort.order : "asc" })}
        >
          {c.label}
        </MenuItem>
      ))}
      <div className="k-menu__sep k-menu__split">
        {(
          [
            ["asc", l.ascending, ArrowUp],
            ["desc", l.descending, ArrowDown],
          ] as Array<["asc" | "desc", string, IconType]>
        ).map(([order, label, Icon]) => (
          <button
            key={order}
            type="button"
            aria-pressed={sort.order === order}
            className={`k-menu__item${sort.order === order ? " is-active" : ""}`}
            onClick={() => onChange({ key: sort.key, order })}
          >
            <Icon size={13} /> {label}
          </button>
        ))}
      </div>
    </Dropdown>
  );
}

/** "Columns" button: checklist of columns to show. Required columns stay on. */
export function ColumnsMenu<T>({
  columns,
  visibleSet,
  onToggle,
  onReset,
  disabled,
  disabledHint,
  labels,
}: {
  columns: Column<T>[];
  visibleSet: Set<string>;
  onToggle: (key: string) => void;
  onReset: () => void;
  disabled?: boolean;
  disabledHint?: string;
  labels?: MenuLabels;
}) {
  const l = { ...L, ...labels };
  const shown = columns.filter((c) => visibleSet.has(c.key)).length;
  return (
    <Dropdown
      align="right"
      wide
      ariaLabel={l.columns}
      disabled={disabled}
      title={disabled ? disabledHint : undefined}
      trigger={
        <>
          <Columns size={14} /> {l.columns} <span className="k-muted">{shown}/{columns.length}</span>
        </>
      }
    >
      <MenuHeading>{l.showColumns}</MenuHeading>
      {columns.map((c) => (
        <label key={c.key} className="k-menu__item" style={{ cursor: c.required ? "default" : "pointer", opacity: c.required ? 0.7 : 1 }}>
          <input type="checkbox" className="k-check" checked={visibleSet.has(c.key)} disabled={c.required} onChange={() => onToggle(c.key)} />
          {c.label}
        </label>
      ))}
      <div className="k-menu__sep">
        <MenuItem className="k-muted" onClick={onReset}>{l.resetColumns}</MenuItem>
      </div>
    </Dropdown>
  );
}

/** "Export" button: the rows currently shown, as CSV or Excel. */
export function ExportMenu<T>({ name, columns, rows, disabled, labels }: { name: string; columns: Column<T>[]; rows: T[]; disabled?: boolean; labels?: MenuLabels }) {
  const l = { ...L, ...labels };
  return (
    <Dropdown align="right" ariaLabel={l.export} disabled={disabled} icon={Download} label={l.export}>
      {({ close }) => (
        <>
          <MenuHeading>{l.rows(rows.length)}</MenuHeading>
          <MenuItem onClick={() => { downloadCsvFile(name, columns, rows); close(); }}>CSV (.csv)</MenuItem>
          <MenuItem onClick={() => { downloadXlsFile(name, columns, rows); close(); }}>Excel (.xls)</MenuItem>
        </>
      )}
    </Dropdown>
  );
}

export interface ViewOption<V extends string> {
  id: V;
  label: string;
  icon: IconType;
}
export interface GroupOption {
  id: string;
  label: string;
}

/**
 * Left side of the toolbar: a view dropdown (List / Kanban / Gantt / Calendar...)
 * and, in kanban view, a group-by picker.
 */
export function ViewMenu<V extends string>({
  view,
  setView,
  views,
  groups,
  group,
  setGroup,
  groupView = "kanban" as V,
  labels,
}: {
  view: V;
  setView: (v: V) => void;
  views: ViewOption<V>[];
  groups?: GroupOption[];
  group?: string;
  setGroup?: (id: string) => void;
  /** The view in which the group-by picker is shown. */
  groupView?: V;
  labels?: MenuLabels;
}) {
  const l = { ...L, ...labels };
  const cur = views.find((v) => v.id === view) ?? views[0];
  const CurIcon = cur.icon;
  const curGroup = groups?.find((g) => g.id === group) ?? groups?.[0];

  if (views.length < 2) {
    return (
      <span className="k-btn k-btn--text" style={{ cursor: "default" }}>
        <CurIcon size={14} /> {cur.label}
      </span>
    );
  }

  return (
    <div className="k-toolbar__group">
      <Dropdown buttonClass="k-btn--text" ariaLabel="View" trigger={<><CurIcon size={14} /> {cur.label}</>}>
        {({ close }) =>
          views.map((v) => (
            <MenuItem key={v.id} active={view === v.id} onClick={() => { setView(v.id); close(); }}>
              <v.icon size={14} /> {v.label}
            </MenuItem>
          ))
        }
      </Dropdown>

      {view === groupView && groups && groups.length > 1 && curGroup && setGroup ? (
        <Dropdown
          role="dialog"
          wide
          buttonClass="k-btn--text"
          ariaLabel={l.groupBy}
          trigger={<><Rows3 size={14} /> {l.groupBy}: <strong style={{ fontWeight: 600 }}>{curGroup.label}</strong></>}
        >
          {({ close }) => (
            <>
              <MenuHeading>{l.groupBy}</MenuHeading>
              {groups.map((g) => (
                <MenuItem key={g.id} role="menuitemradio" checked={g.id === curGroup.id} active={g.id === curGroup.id} onClick={() => { setGroup(g.id); close(); }}>
                  {g.label}
                </MenuItem>
              ))}
              <div className="k-menu__sep k-muted" style={{ fontSize: 11, padding: "8px 10px 4px" }}>{l.groupHint}</div>
            </>
          )}
        </Dropdown>
      ) : null}
    </div>
  );
}
