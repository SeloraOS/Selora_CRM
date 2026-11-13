/**
 * List helpers for the kit (no React): column-aware sorting, search over
 * every column, and CSV / Excel export. Ported from the Selora PMS list pages.
 */

export type SortType = "text" | "number" | "date" | "rank";

/** A table column definition shared by RecordTable, Sort/Columns/Export menus. */
export interface Column<T> {
  key: string;
  label: string;
  /** Cell renderer for the table. */
  render?: (row: T) => React.ReactNode;
  /** Plain-text value for search + export (falls back to row[key]). */
  csv?: (row: T) => string | number | null | undefined;
  /** Value used for sorting (falls back to csv(), then row[key]). */
  sortValue?: (row: T) => string | number | null | undefined;
  sortType?: SortType;
  sortable?: boolean;
  required?: boolean;
  defaultVisible?: boolean;
  align?: "left" | "right" | "center";
  /** Hide below this breakpoint in the table (CSS class on th/td). */
  hideBelow?: "md" | "lg";
  primary?: boolean;
}

export interface Sort {
  key: string;
  order: "asc" | "desc";
}

const text = (v: unknown) =>
  v === undefined || v === null ? "" : typeof v === "object" ? "" : String(v);

/** Plain value of a column for a row: explicit csv(), or the row field. */
export function cellValue<T>(col: Column<T>, row: T): string {
  if (col.csv) return text(col.csv(row));
  const v = (row as Record<string, unknown>)[col.key];
  return text(v);
}

const collator = new Intl.Collator(undefined, { numeric: true, sensitivity: "base" });
const isEmpty = (v: unknown) =>
  v === undefined || v === null || v === "" || (typeof v === "number" && Number.isNaN(v));

/** Empty values always sort last (both directions); ties keep original order. */
export function sortRows<T>(rows: T[], column: Column<T> | undefined, order: "asc" | "desc" = "asc"): T[] {
  if (!column) return rows;
  const type = column.sortType ?? "text";
  const dir = order === "desc" ? -1 : 1;
  const read =
    column.sortValue ??
    column.csv ??
    ((r: T) => (r as Record<string, unknown>)[column.key] as string | number | null | undefined);
  const cmp = (a: string | number, b: string | number) => {
    if (type === "number") return Number(a) - Number(b);
    if (type === "date") return a < b ? -1 : a > b ? 1 : 0;
    return collator.compare(String(a), String(b));
  };
  return rows
    .map((row, i) => ({ row, i, v: read(row) }))
    .sort((x, y) => {
      const ex = isEmpty(x.v);
      const ey = isEmpty(y.v);
      if (ex || ey) return ex === ey ? x.i - y.i : ex ? 1 : -1;
      return cmp(x.v as string | number, y.v as string | number) * dir || x.i - y.i;
    })
    .map((x) => x.row);
}

/** Rows whose cells (all columns, not just visible ones) contain every word of `query`. */
export function searchRows<T>(rows: T[], columns: Column<T>[], query: string, extra: (r: T) => string = () => ""): T[] {
  const words = String(query || "").toLowerCase().split(/\s+/).filter(Boolean);
  if (!words.length) return rows;
  return rows.filter((r) => {
    const hay = `${columns.map((c) => cellValue(c, r)).join(" ")} ${extra(r)}`.toLowerCase();
    return words.every((w) => hay.includes(w));
  });
}

export function toCsv<T>(columns: Column<T>[], rows: T[]): string {
  const esc = (v: unknown) => {
    let s = String(v ?? "");
    // no spreadsheet formula injection
    if (/^[=+\-@]/.test(s) && Number.isNaN(Number(s))) s = `'${s}`;
    return `"${s.replace(/"/g, '""')}"`;
  };
  return [
    columns.map((c) => esc(c.label)).join(","),
    ...rows.map((r) => columns.map((c) => esc(cellValue(c, r))).join(",")),
  ].join("\r\n");
}

const html = (s: unknown) =>
  String(s ?? "").replace(/&/g, "&amp;").replace(/</g, "&lt;").replace(/>/g, "&gt;").replace(/"/g, "&quot;");

/** Excel opens an HTML table saved as .xls. */
export function toXls<T>(columns: Column<T>[], rows: T[], title = "Export"): string {
  const head = columns.map((c) => `<th style="background:#f1f5f9;font-weight:bold">${html(c.label)}</th>`).join("");
  const body = rows.map((r) => `<tr>${columns.map((c) => `<td>${html(cellValue(c, r))}</td>`).join("")}</tr>`).join("");
  return `<html xmlns:o="urn:schemas-microsoft-com:office:office" xmlns:x="urn:schemas-microsoft-com:office:excel"><head><meta charset="utf-8"><title>${html(title)}</title></head><body><table border="1"><thead><tr>${head}</tr></thead><tbody>${body}</tbody></table></body></html>`;
}

function download(filename: string, content: string, type: string) {
  const url = URL.createObjectURL(new Blob([type.startsWith("text/csv") ? `﻿${content}` : content], { type }));
  const a = Object.assign(document.createElement("a"), { href: url, download: filename });
  document.body.appendChild(a);
  a.click();
  a.remove();
  URL.revokeObjectURL(url);
}
export const downloadCsvFile = <T,>(name: string, columns: Column<T>[], rows: T[]) =>
  download(`${name}.csv`, toCsv(columns, rows), "text/csv;charset=utf-8");
export const downloadXlsFile = <T,>(name: string, columns: Column<T>[], rows: T[]) =>
  download(`${name}.xls`, toXls(columns, rows, name), "application/vnd.ms-excel");
