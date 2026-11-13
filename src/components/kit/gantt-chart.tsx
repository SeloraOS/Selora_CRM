"use client";

import { useEffect, useMemo, useRef, useState, type ReactNode } from "react";
import { ChevronDown, ChevronRight } from "lucide-react";
import { useLocale, useTranslations } from "next-intl";
import { addDays, daysBetween, todayYmd } from "./date-utils";

/** One bar on the chart. Dates are YYYY-MM-DD. */
export interface GanttItem {
  id: string;
  label: string;
  group?: string;
  groupColor?: string;
  start: string;
  end: string;
  /** 0-100, drawn as a lighter fill inside the bar. */
  progress?: number;
  color?: string;
  /** Finished items can be hidden with the "Hide completed" toggle. */
  done?: boolean;
  tooltip?: string;
}

type Zoom = "day" | "week" | "month";
const ZOOM_PX: Record<Zoom, number> = { day: 32, week: 16, month: 6 };
const ROW = 44;
const BAR = 24;
const LABEL = 230;
const HEAD = 52;

const readPref = (k: string, d: string) => {
  try {
    return localStorage.getItem(`selora-gantt:${k}`) ?? d;
  } catch {
    return d;
  }
};
const writePref = (k: string, v: string) => {
  try {
    localStorage.setItem(`selora-gantt:${k}`, v);
  } catch {
    /* storage unavailable */
  }
};

/**
 * Read-only Gantt chart (PMS look): sticky label column + timeline, Day/Week/Month zoom,
 * today line, collapsible groups. Clicking a bar or label calls onOpen.
 */
export function GanttChart({
  items,
  onOpen,
  headerLabel,
  footerNote,
}: {
  items: GanttItem[];
  onOpen?: (id: string) => void;
  headerLabel?: string;
  footerNote?: ReactNode;
}) {
  const t = useTranslations("Kit");
  const tv = useTranslations("KitViews");
  const locale = useLocale();
  const today = todayYmd();
  const [zoom, setZoomState] = useState<Zoom>("week");
  const [hideDone, setHideDone] = useState(true);
  const [collapsed, setCollapsed] = useState<Record<string, boolean>>({});
  const scroller = useRef<HTMLDivElement>(null);

  useEffect(() => {
    const z = readPref("zoom", "week");
    if (z === "day" || z === "week" || z === "month") setZoomState(z);
    setHideDone(readPref("hideDone", "1") === "1");
  }, []);

  const setZoom = (z: Zoom) => {
    setZoomState(z);
    writePref("zoom", z);
  };
  const px = ZOOM_PX[zoom];

  const visible = useMemo(() => items.filter((i) => !hideDone || !i.done), [items, hideDone]);

  const range = useMemo(() => {
    if (visible.length === 0) return { from: addDays(today, -7), to: addDays(today, 30) };
    let min = visible[0].start;
    let max = visible[0].end;
    for (const i of visible) {
      if (i.start < min) min = i.start;
      if (i.end > max) max = i.end;
    }
    return { from: addDays(min, -2), to: addDays(max, 5) };
  }, [visible, today]);
  const total = daysBetween(range.from, range.to) + 1;
  const width = total * px;

  // Month strip + week/day marks
  const head = useMemo(() => {
    const fmt = new Intl.DateTimeFormat(locale, { month: "short", year: "numeric", timeZone: "UTC" });
    const months: Array<{ label: string; offset: number; span: number }> = [];
    const marks: Array<{ date: string; label: string; offset: number }> = [];
    for (let i = 0; i < total; i++) {
      const d = addDays(range.from, i);
      if (d.slice(8) === "01" || i === 0) months.push({ label: fmt.format(new Date(`${d}T00:00:00Z`)), offset: i, span: 0 });
      months[months.length - 1].span += 1;
      const monday = new Date(`${d}T00:00:00Z`).getUTCDay() === 1;
      if (zoom === "day" || (zoom === "week" && monday)) marks.push({ date: d, label: d.slice(8), offset: i });
    }
    return { months, marks };
  }, [range, total, zoom, locale]);

  const groups = useMemo(() => {
    const map = new Map<string, GanttItem[]>();
    for (const i of visible) {
      const g = i.group ?? "";
      if (!map.has(g)) map.set(g, []);
      map.get(g)!.push(i);
    }
    return [...map.entries()].map(([name, list]) => ({
      name,
      color: list[0].groupColor,
      items: [...list].sort((a, b) => a.start.localeCompare(b.start)),
    }));
  }, [visible]);

  const hasGroups = groups.some((g) => g.name !== "");
  const rows = useMemo(() => {
    const out: Array<{ type: "group"; g: (typeof groups)[number] } | { type: "item"; i: GanttItem }> = [];
    for (const g of groups) {
      if (hasGroups && g.name !== "") out.push({ type: "group", g });
      if (!hasGroups || g.name === "" || !collapsed[g.name]) g.items.forEach((i) => out.push({ type: "item", i }));
    }
    return out;
  }, [groups, collapsed, hasGroups]);

  const goToday = () => {
    const el = scroller.current;
    if (el && today >= range.from && today <= range.to) el.scrollLeft = Math.max(0, daysBetween(range.from, today) * px - 240);
  };
  useEffect(() => {
    goToday();
    // eslint-disable-next-line react-hooks/exhaustive-deps -- jump to today when zoom changes
  }, [zoom]);

  const dateFmt = (d: string) => new Date(`${d}T00:00:00`).toLocaleDateString(locale);

  return (
    <div data-testid="gantt" style={{ display: "flex", flexDirection: "column" }}>
      <div className="k-toolbar" style={{ borderBottom: 0 }}>
        <div role="group" aria-label="Zoom" style={{ display: "inline-flex", border: "1px solid var(--border-color)", borderRadius: 6, overflow: "hidden" }}>
          {(["day", "week", "month"] as Zoom[]).map((z) => (
            <button
              key={z}
              type="button"
              aria-pressed={zoom === z}
              onClick={() => setZoom(z)}
              className="k-btn"
              style={{ border: "none", borderRadius: 0, background: zoom === z ? "var(--surface-gray-2)" : "var(--control-bg)", fontWeight: zoom === z ? 600 : 400 }}
            >
              {t(z)}
            </button>
          ))}
        </div>
        <div className="k-toolbar__group">
          <button
            type="button"
            className="k-btn"
            aria-pressed={hideDone}
            onClick={() => {
              setHideDone(!hideDone);
              writePref("hideDone", hideDone ? "0" : "1");
            }}
          >
            {tv("hideClosed")}
          </button>
          <button type="button" className="k-btn" onClick={goToday}>{t("today")}</button>
        </div>
      </div>
      <div className="k-muted" style={{ padding: "0 24px 8px", fontSize: 12 }}>
        {tv("ganttHint")}
        {footerNote ? <> · {footerNote}</> : null}
      </div>

      {visible.length === 0 ? (
        <div className="k-muted" style={{ padding: 40, textAlign: "center", fontSize: 13 }}>{tv("ganttEmpty")}</div>
      ) : (
        <div
          ref={scroller}
          style={{ overflow: "auto", margin: "0 24px 24px", border: "1px solid var(--border-color)", borderRadius: 8, background: "var(--card-bg)", maxHeight: "calc(100vh - 340px)" }}
        >
          <div style={{ display: "flex", width: LABEL + width, position: "relative" }}>
            {/* label column */}
            <div style={{ width: LABEL, flexShrink: 0, position: "sticky", left: 0, background: "var(--card-bg)", zIndex: 3, borderRight: "1px solid var(--border-color)" }}>
              <div style={{ height: HEAD, borderBottom: "1px solid var(--border-color)", padding: "0 12px", display: "flex", alignItems: "center", fontSize: 12, color: "var(--text-muted)", position: "sticky", top: 0, background: "var(--card-bg)", zIndex: 4 }}>
                {headerLabel ?? ""} {headerLabel ? "· " : ""}{visible.length}
              </div>
              {rows.map((r) =>
                r.type === "group" ? (
                  <div
                    key={`g:${r.g.name}`}
                    onClick={() => setCollapsed((c) => ({ ...c, [r.g.name]: !c[r.g.name] }))}
                    style={{ height: ROW, padding: "0 12px", display: "flex", alignItems: "center", gap: 6, borderBottom: "1px solid var(--divider-color)", background: "var(--surface-gray-1)", cursor: "pointer", fontSize: 13, fontWeight: 600 }}
                  >
                    {collapsed[r.g.name] ? <ChevronRight size={14} /> : <ChevronDown size={14} />}
                    {r.g.color && <span style={{ width: 8, height: 8, borderRadius: "50%", background: r.g.color }} />}
                    <span style={{ overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}>{r.g.name}</span>
                    <span className="k-muted" style={{ marginLeft: "auto", fontSize: 11, fontWeight: 400 }}>{r.g.items.length}</span>
                  </div>
                ) : (
                  <div
                    key={r.i.id}
                    onClick={() => onOpen?.(r.i.id)}
                    title={r.i.label}
                    style={{ height: ROW, padding: `0 12px 0 ${hasGroups ? 28 : 12}px`, display: "flex", alignItems: "center", borderBottom: "1px solid var(--divider-color)", cursor: onOpen ? "pointer" : "default", fontSize: 13, overflow: "hidden", whiteSpace: "nowrap", textOverflow: "ellipsis" }}
                  >
                    <span style={{ overflow: "hidden", textOverflow: "ellipsis" }}>{r.i.label}</span>
                  </div>
                ),
              )}
            </div>

            {/* timeline */}
            <div style={{ width, position: "relative" }}>
              <div style={{ position: "sticky", top: 0, zIndex: 2, background: "var(--card-bg)", height: HEAD, borderBottom: "1px solid var(--border-color)" }}>
                <div style={{ display: "flex", height: HEAD / 2, borderBottom: "1px solid var(--border-color)" }}>
                  {head.months.map((m) => (
                    <div key={m.offset} style={{ width: m.span * px, flexShrink: 0, fontSize: 11, fontWeight: 600, color: "var(--text-light)", padding: "6px 8px", boxSizing: "border-box", borderLeft: "1px solid var(--border-color)", whiteSpace: "nowrap", overflow: "hidden" }}>
                      {m.label}
                    </div>
                  ))}
                </div>
                <div style={{ position: "relative", height: HEAD / 2 }}>
                  {head.marks.map((m) => (
                    <span key={m.date} style={{ position: "absolute", left: m.offset * px, width: zoom === "day" ? px : 7 * px, textAlign: zoom === "day" ? "center" : "left", paddingLeft: zoom === "day" ? 0 : 4, fontSize: 10, color: "var(--text-muted)", top: 7 }}>
                      {m.label}
                    </span>
                  ))}
                </div>
              </div>
              {today >= range.from && today <= range.to && (
                <div title={t("today")} style={{ position: "absolute", top: 0, bottom: 0, left: daysBetween(range.from, today) * px + px / 2, width: 2, background: "#ef4444", opacity: 0.55, pointerEvents: "none", zIndex: 1 }} />
              )}
              {rows.map((r) => {
                if (r.type === "group") {
                  const s = r.g.items.reduce((m, x) => (x.start < m ? x.start : m), r.g.items[0].start);
                  const e = r.g.items.reduce((m, x) => (x.end > m ? x.end : m), r.g.items[0].end);
                  const off = daysBetween(range.from, s);
                  const len = daysBetween(s, e) + 1;
                  return (
                    <div key={`g:${r.g.name}`} style={{ height: ROW, position: "relative", borderBottom: "1px solid var(--divider-color)", background: "var(--surface-gray-1)" }}>
                      <div title={`${r.g.name}: ${dateFmt(s)} → ${dateFmt(e)}`} style={{ position: "absolute", top: 15, height: 14, left: off * px, width: Math.max(4, len * px), background: r.g.color ?? "var(--gray-400)", opacity: 0.6, borderRadius: 3 }} />
                    </div>
                  );
                }
                const i = r.i;
                const off = daysBetween(range.from, i.start);
                const len = daysBetween(i.start, i.end) + 1;
                const barW = Math.max(6, len * px);
                const pct = Math.max(0, Math.min(100, Math.round(i.progress ?? 0)));
                return (
                  <div key={i.id} style={{ height: ROW, position: "relative", borderBottom: "1px solid var(--divider-color)" }}>
                    <div
                      data-testid="gantt-bar"
                      title={i.tooltip ?? `${i.label}\n${dateFmt(i.start)} → ${dateFmt(i.end)}`}
                      onClick={() => onOpen?.(i.id)}
                      style={{ position: "absolute", top: (ROW - BAR) / 2, height: BAR, left: off * px, width: barW, background: i.color ?? "var(--primary)", borderRadius: 5, cursor: onOpen ? "pointer" : "default", overflow: "hidden", opacity: i.done ? 0.55 : 1 }}
                    >
                      {pct > 0 && <div style={{ position: "absolute", inset: 0, width: `${pct}%`, background: "rgba(255,255,255,0.3)" }} />}
                      {barW >= 64 && pct > 0 && (
                        <span style={{ position: "relative", fontSize: 11, fontWeight: 600, color: "#ffffff", padding: "0 8px", lineHeight: `${BAR}px`, whiteSpace: "nowrap" }}>{pct}%</span>
                      )}
                    </div>
                  </div>
                );
              })}
            </div>
          </div>
        </div>
      )}
    </div>
  );
}
