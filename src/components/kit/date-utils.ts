/** Calendar-date helpers on YYYY-MM-DD strings (no timezone drift). Weeks start on Monday. */

const MS = 86400000;
const dayNumber = (ymd: string) => Math.floor(Date.parse(`${ymd}T00:00:00Z`) / MS);

export const pad = (n: number) => String(n).padStart(2, "0");
export const toYmd = (y: number, m: number, d: number) => `${y}-${pad(m + 1)}-${pad(d)}`; // m is 0-11
export const daysBetween = (from: string, to: string) => dayNumber(to) - dayNumber(from);

export function addDays(ymd: string, days: number): string {
  const [y, m, d] = ymd.split("-").map(Number);
  return new Date(Date.UTC(y, m - 1, d + days)).toISOString().slice(0, 10);
}

/** Today in the viewer's local time zone. */
export function todayYmd(): string {
  const n = new Date();
  return toYmd(n.getFullYear(), n.getMonth(), n.getDate());
}

/** Local calendar day of an ISO timestamp. */
export function isoToYmd(iso: string): string {
  const d = new Date(iso);
  return toYmd(d.getFullYear(), d.getMonth(), d.getDate());
}

/** 0 = Monday ... 6 = Sunday */
export const weekdayIndex = (ymd: string) => (new Date(`${ymd}T00:00:00Z`).getUTCDay() + 6) % 7;
export const monthStart = (ymd: string) => `${ymd.slice(0, 7)}-01`;
export const daysInMonth = (year: number, month: number) => new Date(Date.UTC(year, month + 1, 0)).getUTCDate();

export function addMonths(ymd: string, n: number): string {
  const d = new Date(`${monthStart(ymd)}T00:00:00Z`);
  d.setUTCMonth(d.getUTCMonth() + n);
  return d.toISOString().slice(0, 10);
}

export interface GridDay {
  date: string;
  inMonth: boolean;
}

/** Weeks (arrays of 7 days) covering the month; 4-6 rows depending on the month. */
export function monthGrid(year: number, month: number): GridDay[][] {
  const first = toYmd(year, month, 1);
  const offset = weekdayIndex(first);
  const total = daysInMonth(year, month);
  const weeks = Math.ceil((offset + total) / 7);
  const start = addDays(first, -offset);
  return Array.from({ length: weeks }, (_, w) =>
    Array.from({ length: 7 }, (_, d) => {
      const date = addDays(start, w * 7 + d);
      return { date, inMonth: Number(date.slice(5, 7)) === month + 1 };
    }),
  );
}

export const weekDays = (ymd: string): string[] => {
  const start = addDays(ymd, -weekdayIndex(ymd));
  return Array.from({ length: 7 }, (_, i) => addDays(start, i));
};

/** Visible date range of a calendar view around `cursor` (month grids include the leading/trailing days). */
export function rangeFor(view: "month" | "week" | "agenda", cursor: string): { from: string; to: string } {
  if (view === "week") {
    const d = weekDays(cursor);
    return { from: d[0], to: d[6] };
  }
  const y = Number(cursor.slice(0, 4));
  const m = Number(cursor.slice(5, 7)) - 1;
  if (view === "agenda") return { from: toYmd(y, m, 1), to: toYmd(y, m, daysInMonth(y, m)) };
  const grid = monthGrid(y, m);
  return { from: grid[0][0].date, to: grid[grid.length - 1][6].date };
}
