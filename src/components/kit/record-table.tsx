"use client";

import type { ReactNode } from "react";
import { ArrowDown, ArrowUp } from "lucide-react";
import type { Column, Sort } from "./list-utils";
import type { Selection } from "./use-list";

/**
 * Selectable, sortable table driven by column definitions (PMS list look).
 * Pass `selection` to show checkboxes. Rows need a stable string id via getId.
 */
export function RecordTable<T>({
  columns,
  rows,
  getId,
  selection,
  onOpen,
  sort,
  onSort,
  actions,
  selectAllLabel = "Select all",
}: {
  columns: Column<T>[];
  rows: T[];
  getId: (row: T) => string;
  selection?: Selection;
  onOpen?: (row: T) => void;
  sort?: Sort;
  onSort?: (key: string) => void;
  /** Optional trailing cell (e.g. a row action menu). Click events are stopped. */
  actions?: (row: T) => ReactNode;
  selectAllLabel?: string;
}) {
  const hide = (c: Column<T>) => (c.hideBelow === "md" ? "hidden md:table-cell" : c.hideBelow === "lg" ? "hidden lg:table-cell" : undefined);
  return (
    <div className="k-table-wrap">
      <table className="k-table">
        <thead>
          <tr>
            {selection && (
              <th className="k-sel" style={{ cursor: "default" }}>
                <input
                  type="checkbox"
                  className="k-check"
                  aria-label={selectAllLabel}
                  checked={rows.length > 0 && rows.every((r) => selection.has(getId(r)))}
                  onChange={(e) => selection.toggleAll(rows.map(getId), e.target.checked)}
                />
              </th>
            )}
            {columns.map((c) => {
              const active = sort?.key === c.key;
              const sortable = !!onSort && c.sortable !== false;
              return (
                <th
                  key={c.key}
                  className={[active ? "is-sorted" : "", hide(c) ?? ""].join(" ").trim() || undefined}
                  aria-sort={active ? (sort?.order === "asc" ? "ascending" : "descending") : undefined}
                  onClick={sortable ? () => onSort(c.key) : undefined}
                  style={{ textAlign: c.align ?? "left", cursor: sortable ? "pointer" : "default" }}
                >
                  <span>
                    {c.label}
                    {active && (sort?.order === "asc" ? <ArrowUp size={12} /> : <ArrowDown size={12} />)}
                  </span>
                </th>
              );
            })}
            {actions && <th style={{ cursor: "default", width: 40 }} />}
          </tr>
        </thead>
        <tbody>
          {rows.map((row) => {
            const id = getId(row);
            return (
              <tr key={id} onClick={onOpen ? () => onOpen(row) : undefined} style={onOpen ? undefined : { cursor: "default" }}>
                {selection && (
                  <td className="k-sel" onClick={(e) => e.stopPropagation()}>
                    <input type="checkbox" className="k-check" checked={selection.has(id)} onChange={() => selection.toggle(id)} />
                  </td>
                )}
                {columns.map((c) => (
                  <td key={c.key} className={[c.primary ? "is-primary" : "", hide(c) ?? ""].join(" ").trim() || undefined} style={{ textAlign: c.align ?? "left" }}>
                    {c.render ? c.render(row) : (c.csv ? c.csv(row) : ((row as Record<string, unknown>)[c.key] as ReactNode)) ?? ""}
                  </td>
                ))}
                {actions && (
                  <td onClick={(e) => e.stopPropagation()} style={{ textAlign: "right" }}>
                    {actions(row)}
                  </td>
                )}
              </tr>
            );
          })}
        </tbody>
      </table>
    </div>
  );
}
