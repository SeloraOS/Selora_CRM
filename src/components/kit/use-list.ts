"use client";

import { useCallback, useEffect, useMemo, useState } from "react";
import type { Column, Sort } from "./list-utils";

const read = (key: string): unknown => {
  try {
    return JSON.parse(localStorage.getItem(key) ?? "null");
  } catch {
    return null;
  }
};
const write = (key: string, value: unknown) => {
  try {
    localStorage.setItem(key, JSON.stringify(value));
  } catch {
    /* storage unavailable (private mode) */
  }
};

/**
 * Sort + visible columns for a list page, remembered per page in localStorage.
 * `columns` must be a stable reference (define it at module level or useMemo).
 */
export function useListPrefs<T>(entity: string, columns: Column<T>[], defaultSort: Sort) {
  const colKey = `selora-columns:${entity}`;
  const sortKey = `selora-sort:${entity}`;
  const known = useMemo(() => new Set(columns.map((c) => c.key)), [columns]);
  const defaults = useMemo(
    () => columns.filter((c) => c.required || c.defaultVisible !== false).map((c) => c.key),
    [columns],
  );

  // Start from defaults so the server and first client render match (no hydration warning);
  // saved prefs are applied right after mount.
  const [visible, setVisible] = useState<string[]>(defaults);
  const [sort, setSortState] = useState<Sort>(defaultSort);
  useEffect(() => {
    const savedCols = read(colKey);
    if (Array.isArray(savedCols)) setVisible((savedCols as string[]).filter((k) => known.has(k)));
    const savedSort = read(sortKey) as Sort | null;
    if (savedSort && known.has(savedSort.key) && (savedSort.order === "asc" || savedSort.order === "desc")) {
      setSortState(savedSort);
    }
    // eslint-disable-next-line react-hooks/exhaustive-deps -- load once per entity
  }, [colKey, sortKey]);

  const visibleSet = useMemo(
    () => new Set([...visible, ...columns.filter((c) => c.required).map((c) => c.key)]),
    [visible, columns],
  );
  const visibleColumns = useMemo(() => columns.filter((c) => visibleSet.has(c.key)), [columns, visibleSet]);

  const toggleColumn = useCallback(
    (key: string) =>
      setVisible((prev) => {
        const next = prev.includes(key) ? prev.filter((k) => k !== key) : [...prev, key];
        write(colKey, next);
        return next;
      }),
    [colKey],
  );
  const resetColumns = useCallback(() => {
    setVisible(defaults);
    write(colKey, defaults);
  }, [colKey, defaults]);
  const setSort = useCallback(
    (next: Sort) => {
      setSortState(next);
      write(sortKey, next);
    },
    [sortKey],
  );
  const sortColumn = useMemo(() => columns.find((c) => c.key === sort.key), [columns, sort.key]);

  return { visibleColumns, visibleSet, toggleColumn, resetColumns, sort, setSort, sortColumn };
}

/**
 * Per-page view settings remembered in localStorage.
 * `views` are the allowed view ids (first one is the default); `groups` are
 * the fields a kanban can be grouped by (optional).
 */
export function useViewMode<V extends string>(entity: string, views: readonly V[], groups: readonly string[] = []) {
  const [view, setViewState] = useState<V>(views[0]);
  const [group, setGroupState] = useState<string>(groups[0] ?? "");
  useEffect(() => {
    const v = read(`selora-view:${entity}`) as V | null;
    if (v && views.includes(v)) setViewState(v);
    const g = read(`selora-group:${entity}`) as string | null;
    if (g && groups.includes(g)) setGroupState(g);
    // eslint-disable-next-line react-hooks/exhaustive-deps -- load once per entity
  }, [entity]);
  const setView = useCallback(
    (v: V) => {
      setViewState(v);
      write(`selora-view:${entity}`, v);
    },
    [entity],
  );
  const setGroup = useCallback(
    (g: string) => {
      setGroupState(g);
      write(`selora-group:${entity}`, g);
    },
    [entity],
  );
  return { view, setView, group, setGroup };
}

/** Row selection by id (header checkbox selects/clears the visible rows). */
export function useSelection() {
  const [ids, setIds] = useState<Set<string>>(() => new Set());
  const toggle = useCallback(
    (id: string) =>
      setIds((prev) => {
        const next = new Set(prev);
        if (next.has(id)) next.delete(id);
        else next.add(id);
        return next;
      }),
    [],
  );
  const toggleAll = useCallback((visibleIds: string[], on: boolean) => setIds(on ? new Set(visibleIds) : new Set()), []);
  const clear = useCallback(() => setIds(new Set()), []);
  return { ids, toggle, toggleAll, clear, count: ids.size, has: (id: string) => ids.has(id) };
}
export type Selection = ReturnType<typeof useSelection>;
