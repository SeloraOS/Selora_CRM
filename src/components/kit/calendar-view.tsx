"use client";

import { useEffect, useMemo, useState } from "react";
import { ChevronLeft, ChevronRight } from "lucide-react";
import { useLocale, useTranslations } from "next-intl";
import { addDays, addMonths, monthGrid, monthStart, rangeFor, todayYmd, weekDays } from "./date-utils";

export interface CalendarEvent {
  id: string;
  /** YYYY-MM-DD */
  date: string;
  title: string;
  sub?: string;
  color?: string;
}

type CalView = "month" | "week" | "agenda";
const readView = (key: string): CalView => {
  try {
    const v = localStorage.getItem(key);
    return v === "week" || v === "agenda" ? v : "month";
  } catch {
    return "month";
  }
};

/** Read-only calendar (PMS look): month / week / agenda with prev, Today, next. */
export function CalendarView({
  events,
  onOpen,
  storageKey = "selora-calendar-view",
  onRangeChange,
}: {
  events: CalendarEvent[];
  onOpen?: (id: string) => void;
  storageKey?: string;
  /** Called with the visible date range whenever the view or month changes (and on mount). */
  onRangeChange?: (range: { from: string; to: string }) => void;
}) {
  const t = useTranslations("Kit");
  const tv = useTranslations("KitViews");
  const locale = useLocale();
  const today = todayYmd();
  const [cursor, setCursor] = useState(today);
  const [view, setViewState] = useState<CalView>(() => (typeof window === "undefined" ? "month" : readView(storageKey)));
  const [more, setMore] = useState<string | null>(null);

  const setView = (v: CalView) => {
    setViewState(v);
    try {
      localStorage.setItem(storageKey, v);
    } catch {
      /* storage unavailable */
    }
  };

  const byDay = useMemo(() => {
    const m = new Map<string, CalendarEvent[]>();
    for (const e of events) {
      if (!m.has(e.date)) m.set(e.date, []);
      m.get(e.date)!.push(e);
    }
    return m;
  }, [events]);

  useEffect(() => {
    onRangeChange?.(rangeFor(view, cursor));
    // eslint-disable-next-line react-hooks/exhaustive-deps -- notify only when the visible range changes
  }, [view, cursor]);

  const y = Number(cursor.slice(0, 4));
  const mo = Number(cursor.slice(5, 7)) - 1;
  const step = (dir: 1 | -1) => setCursor(view === "week" ? addDays(cursor, 7 * dir) : addMonths(cursor, dir));

  const title = useMemo(() => {
    if (view === "week") {
      const d = weekDays(cursor);
      const f = new Intl.DateTimeFormat(locale, { month: "short", day: "numeric", timeZone: "UTC" });
      return `${f.format(new Date(`${d[0]}T00:00:00Z`))} – ${f.format(new Date(`${d[6]}T00:00:00Z`))}`;
    }
    return new Intl.DateTimeFormat(locale, { month: "long", year: "numeric", timeZone: "UTC" }).format(new Date(`${monthStart(cursor)}T00:00:00Z`));
  }, [cursor, view, locale]);

  const weekdayLabels = useMemo(() => {
    const f = new Intl.DateTimeFormat(locale, { weekday: "short", timeZone: "UTC" });
    return weekDays("2024-01-01").map((d) => f.format(new Date(`${d}T00:00:00Z`)));
  }, [locale]);

  const chip = (e: CalendarEvent) => (
    <button
      key={e.id}
      type="button"
      title={e.sub ? `${e.title} · ${e.sub}` : e.title}
      onClick={() => onOpen?.(e.id)}
      style={{ display: "block", width: "100%", textAlign: "left", border: 0, cursor: onOpen ? "pointer" : "default", fontFamily: "inherit", fontSize: 11, fontWeight: 600, padding: "2px 6px", borderRadius: 4, marginBottom: 2, color: "#fff", background: e.color ?? "var(--primary)", overflow: "hidden", textOverflow: "ellipsis", whiteSpace: "nowrap" }}
    >
      {e.title}
    </button>
  );

  const cell = (date: string, inMonth: boolean, limit: number) => {
    const list = byDay.get(date) ?? [];
    return (
      <div key={date} style={{ minHeight: 96, padding: 6, borderRight: "1px solid var(--border-color)", borderBottom: "1px solid var(--border-color)", background: inMonth ? "var(--card-bg)" : "var(--surface-gray-1)" }}>
        <div style={{ fontSize: 12, marginBottom: 4, fontWeight: date === today ? 700 : 400, color: date === today ? "var(--primary)" : inMonth ? "var(--text-color)" : "var(--text-muted)" }}>
          {Number(date.slice(8))}
        </div>
        {list.slice(0, limit).map(chip)}
        {list.length > limit && (
          <button type="button" className="k-muted" style={{ border: 0, background: "none", fontSize: 11, cursor: "pointer", fontFamily: "inherit" }} onClick={() => setMore(more === date ? null : date)}>
            {tv("more", { count: list.length - limit })}
          </button>
        )}
        {more === date && list.length > limit && <div style={{ marginTop: 4 }}>{list.slice(limit).map(chip)}</div>}
      </div>
    );
  };

  const agendaDays = useMemo(() => {
    const first = monthStart(cursor);
    return [...byDay.keys()].filter((d) => d.slice(0, 7) === first.slice(0, 7)).sort();
  }, [byDay, cursor]);

  return (
    <div>
      <div className="k-toolbar" style={{ borderBottom: 0 }}>
        <div className="k-toolbar__group">
          <button type="button" className="k-btn k-btn--icon" aria-label="Previous" onClick={() => step(-1)}><ChevronLeft size={14} /></button>
          <button type="button" className="k-btn" onClick={() => setCursor(today)}>{t("today")}</button>
          <button type="button" className="k-btn k-btn--icon" aria-label="Next" onClick={() => step(1)}><ChevronRight size={14} /></button>
          <strong style={{ fontSize: 14, marginLeft: 8 }}>{title}</strong>
        </div>
        <div role="group" style={{ display: "inline-flex", border: "1px solid var(--border-color)", borderRadius: 6, overflow: "hidden" }}>
          {(["month", "week", "agenda"] as CalView[]).map((v) => (
            <button key={v} type="button" className="k-btn" aria-pressed={view === v} onClick={() => setView(v)} style={{ border: "none", borderRadius: 0, background: view === v ? "var(--surface-gray-2)" : "var(--control-bg)", fontWeight: view === v ? 600 : 400 }}>
              {t(v)}
            </button>
          ))}
        </div>
      </div>

      <div style={{ margin: "0 24px 24px" }}>
        {view === "month" && (
          <div style={{ border: "1px solid var(--border-color)", borderRadius: 8, overflow: "hidden", borderRight: 0, borderBottom: 0 }}>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(7, 1fr)" }}>
              {weekdayLabels.map((d) => (
                <div key={d} className="k-muted" style={{ padding: "6px 8px", fontSize: 11, fontWeight: 600, textTransform: "uppercase", letterSpacing: ".05em", borderRight: "1px solid var(--border-color)", borderBottom: "1px solid var(--border-color)", background: "var(--surface-gray-1)" }}>{d}</div>
              ))}
              {monthGrid(y, mo).flat().map((g) => cell(g.date, g.inMonth, 3))}
            </div>
          </div>
        )}
        {view === "week" && (
          <div style={{ border: "1px solid var(--border-color)", borderRadius: 8, overflow: "hidden", borderRight: 0, borderBottom: 0 }}>
            <div style={{ display: "grid", gridTemplateColumns: "repeat(7, 1fr)" }}>
              {weekDays(cursor).map((d, i) => (
                <div key={d} className="k-muted" style={{ padding: "6px 8px", fontSize: 11, fontWeight: 600, textTransform: "uppercase", borderRight: "1px solid var(--border-color)", borderBottom: "1px solid var(--border-color)", background: "var(--surface-gray-1)" }}>{weekdayLabels[i]}</div>
              ))}
              {weekDays(cursor).map((d) => cell(d, true, 8))}
            </div>
          </div>
        )}
        {view === "agenda" && (
          <div style={{ border: "1px solid var(--border-color)", borderRadius: 8, background: "var(--card-bg)" }}>
            {agendaDays.length === 0 ? (
              <div className="k-muted" style={{ padding: 40, textAlign: "center", fontSize: 13 }}>{tv("calendarEmpty")}</div>
            ) : (
              agendaDays.map((d) => (
                <div key={d} style={{ display: "flex", gap: 16, padding: "10px 16px", borderBottom: "1px solid var(--divider-color)" }}>
                  <div style={{ width: 90, flexShrink: 0, fontSize: 12, fontWeight: 600, color: d === today ? "var(--primary)" : "var(--text-muted)" }}>
                    {new Date(`${d}T00:00:00`).toLocaleDateString(locale, { weekday: "short", month: "short", day: "numeric" })}
                  </div>
                  <div style={{ flex: 1, minWidth: 0 }}>{(byDay.get(d) ?? []).map(chip)}</div>
                </div>
              ))
            )}
          </div>
        )}
      </div>
    </div>
  );
}
