"use client";

import { useMemo, useState, type ReactNode } from "react";
import {
  DndContext,
  DragOverlay,
  KeyboardSensor,
  PointerSensor,
  closestCorners,
  useDraggable,
  useDroppable,
  useSensor,
  useSensors,
  type DragEndEvent,
  type DragStartEvent,
} from "@dnd-kit/core";

export interface KanbanColumn {
  id: string;
  label: string;
  color?: string;
  /** Optional line under the title (e.g. a total). */
  subtitle?: ReactNode;
}

/**
 * Generic kanban (PMS look) on dnd-kit.
 *  - items whose column is not listed get their own trailing column
 *  - onMove(item, columnId) resolves truthy on success; a falsy result snaps the card back
 *  - omit onMove (or return false from canMove) for read-only boards
 */
export function KanbanBoard<T>({
  columns,
  items,
  getColumn,
  getId,
  renderCard,
  onOpen,
  onMove,
  canMove = () => true,
  emptyLabel = "No items",
  footer,
}: {
  columns: KanbanColumn[];
  items: T[];
  getColumn: (item: T) => string | null | undefined;
  getId: (item: T) => string;
  renderCard: (item: T) => ReactNode;
  onOpen?: (item: T) => void;
  onMove?: (item: T, columnId: string) => Promise<boolean | void | null> | boolean | void | null;
  canMove?: (item: T) => boolean;
  emptyLabel?: string;
  /** Rendered at the bottom of a column (e.g. an "Add" button). */
  footer?: (column: KanbanColumn) => ReactNode;
}) {
  // Optimistic placement: id -> { to, from }. The override only applies while the item is still in its
  // original column, so it disappears by itself once real data catches up (or changes elsewhere).
  const [moved, setMoved] = useState<Record<string, { to: string; from: string | null | undefined }>>({});
  const [activeId, setActiveId] = useState<string | null>(null);

  const columnOf = (item: T) => {
    const m = moved[getId(item)];
    const real = getColumn(item);
    return m && real === m.from ? m.to : real;
  };

  const allColumns = useMemo(() => {
    const known = new Set(columns.map((c) => c.id));
    const extra = [...new Set(items.map(getColumn))]
      .filter((id): id is string => !!id && !known.has(id))
      .map((id) => ({ id, label: id, color: "var(--text-muted)" }));
    return [...columns, ...extra];
  }, [columns, items, getColumn]);

  const byColumn = useMemo(() => {
    const map: Record<string, T[]> = Object.fromEntries(allColumns.map((c) => [c.id, []]));
    for (const item of items) {
      const col = columnOf(item);
      if (col && map[col]) map[col].push(item);
    }
    return map;
    // eslint-disable-next-line react-hooks/exhaustive-deps -- columnOf only reads moved/getColumn/getId
  }, [allColumns, items, moved, getColumn, getId]);

  const sensors = useSensors(useSensor(PointerSensor, { activationConstraint: { distance: 5 } }), useSensor(KeyboardSensor));
  const activeItem = activeId ? items.find((i) => getId(i) === activeId) : undefined;

  const onDragStart = (e: DragStartEvent) => setActiveId(String(e.active.id));
  const onDragEnd = async (e: DragEndEvent) => {
    setActiveId(null);
    if (!onMove || !e.over) return;
    const id = String(e.active.id);
    const item = items.find((i) => getId(i) === id);
    const to = String(e.over.id);
    if (!item || to === columnOf(item)) return;
    setMoved((m) => ({ ...m, [id]: { to, from: getColumn(item) } }));
    const ok = await onMove(item, to);
    if (ok === false || ok === null) {
      setMoved((m) => {
        const rest = { ...m };
        delete rest[id];
        return rest;
      });
    }
  };

  return (
    <DndContext sensors={sensors} collisionDetection={closestCorners} onDragStart={onDragStart} onDragEnd={onDragEnd} onDragCancel={() => setActiveId(null)}>
      <div className="k-board">
        {allColumns.map((col) => (
          <Column key={col.id} col={col} emptyLabel={emptyLabel} count={byColumn[col.id]?.length ?? 0} footer={footer?.(col)}>
            {(byColumn[col.id] ?? []).map((item) => (
              <Card key={getId(item)} id={getId(item)} disabled={!onMove || !canMove(item)} onOpen={onOpen ? () => onOpen(item) : undefined}>
                {renderCard(item)}
              </Card>
            ))}
          </Column>
        ))}
      </div>
      <DragOverlay>{activeItem ? <div className="k-card is-dragging">{renderCard(activeItem)}</div> : null}</DragOverlay>
    </DndContext>
  );
}

function Column({ col, count, emptyLabel, footer, children }: { col: KanbanColumn; count: number; emptyLabel: string; footer?: ReactNode; children: ReactNode }) {
  const { setNodeRef, isOver } = useDroppable({ id: col.id });
  return (
    <div className="k-col" data-testid={`kanban-col-${col.id}`}>
      <div className="k-col__head">
        <span className="k-col__dot" style={{ background: col.color ?? "var(--text-muted)" }} />
        <span className="k-col__title">{col.label}</span>
        <span className="k-col__count">{count}</span>
      </div>
      {col.subtitle ? <div className="k-muted" style={{ fontSize: 12, padding: "6px 12px 0" }}>{col.subtitle}</div> : null}
      <div ref={setNodeRef} className={`k-col__body${isOver ? " is-over" : ""}`}>
        {children}
        {count === 0 && !isOver && <div className="k-col__empty">{emptyLabel}</div>}
      </div>
      {footer ? <div style={{ padding: "0 8px 8px" }}>{footer}</div> : null}
    </div>
  );
}

function Card({ id, disabled, onOpen, children }: { id: string; disabled: boolean; onOpen?: () => void; children: ReactNode }) {
  const { attributes, listeners, setNodeRef, isDragging } = useDraggable({ id, disabled });
  return (
    <div
      ref={setNodeRef}
      {...listeners}
      {...attributes}
      onClick={onOpen}
      className="k-card"
      style={{ opacity: isDragging ? 0.3 : 1, touchAction: disabled ? "auto" : "none", cursor: onOpen || !disabled ? "pointer" : "default" }}
    >
      {children}
    </div>
  );
}
