"use client";

/**
 * Selora UI kit (CRM copy). Same component names and props exist in
 * Selora_PMS (src/ui). Styling lives in ./kit.css, driven by the theme
 * variables in globals.css, so every accent theme restyles it.
 */
import {
  useEffect,
  useRef,
  useState,
  type ButtonHTMLAttributes,
  type ComponentType,
  type InputHTMLAttributes,
  type ReactNode,
  type SelectHTMLAttributes,
} from "react";
import { Check, ChevronDown, Search, X } from "lucide-react";

const cx = (...a: Array<string | false | null | undefined>) =>
  a.filter(Boolean).join(" ");

type IconType = ComponentType<{ size?: number; className?: string; strokeWidth?: number }>;

/** Open/close state for a popover; closes on outside click and Escape. */
export function useDropdown<T extends HTMLElement = HTMLDivElement>() {
  const [open, setOpen] = useState(false);
  const ref = useRef<T>(null);
  useEffect(() => {
    if (!open) return;
    const close = (e: MouseEvent) => {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    };
    const esc = (e: KeyboardEvent) => {
      if (e.key === "Escape") setOpen(false);
    };
    document.addEventListener("mousedown", close);
    document.addEventListener("keydown", esc);
    return () => {
      document.removeEventListener("mousedown", close);
      document.removeEventListener("keydown", esc);
    };
  }, [open]);
  return { open, setOpen, ref };
}

/* ---------- Buttons & inputs ---------- */
interface ButtonProps extends ButtonHTMLAttributes<HTMLButtonElement> {
  variant?: "default" | "primary" | "danger" | "text";
  size?: "md" | "lg" | "icon";
}
export function KButton({ variant = "default", size = "md", className, type = "button", ...rest }: ButtonProps) {
  return (
    <button
      type={type}
      className={cx("k-btn", variant !== "default" && `k-btn--${variant}`, size !== "md" && `k-btn--${size}`, className)}
      {...rest}
    />
  );
}

export function KInput({ className, ...rest }: InputHTMLAttributes<HTMLInputElement>) {
  return <input className={cx("k-input", className)} {...rest} />;
}

export function KSelect({ className, children, ...rest }: SelectHTMLAttributes<HTMLSelectElement>) {
  return <select className={cx("k-input", className)} {...rest}>{children}</select>;
}

export function KField({ label, required, children }: { label: string; required?: boolean; children: ReactNode }) {
  return (
    <div>
      <label className="k-label">
        {label}
        {required && <> <span className="k-req">*</span></>}
      </label>
      {children}
    </div>
  );
}

export function KCheckbox(props: InputHTMLAttributes<HTMLInputElement>) {
  return <input type="checkbox" className="k-check" {...props} />;
}

/** Search field used in list toolbars. */
export function SearchBox({
  value,
  onChange,
  placeholder = "Search…",
  width = 220,
}: {
  value: string;
  onChange: (v: string) => void;
  placeholder?: string;
  width?: number;
}) {
  return (
    <div className="k-search">
      <Search size={13} />
      <input
        className="k-input"
        type="search"
        aria-label={placeholder}
        placeholder={placeholder}
        value={value}
        onChange={(e) => onChange(e.target.value)}
        style={{ width }}
      />
    </div>
  );
}

export function Toggle({ checked, onChange, label }: { checked: boolean; onChange: (v: boolean) => void; label?: string }) {
  return <button type="button" role="switch" aria-checked={checked} aria-label={label} className="k-toggle" onClick={() => onChange(!checked)} />;
}

/* ---------- Toolbar & filter bar ---------- */
export function Toolbar({ left, right }: { left?: ReactNode; right?: ReactNode }) {
  return (
    <div className="k-toolbar">
      <div className="k-toolbar__group">{left}</div>
      <div className="k-toolbar__group">{right}</div>
    </div>
  );
}

/** Expandable filter grid under the toolbar. `columns` sets the grid width (default 6). */
export function FilterBar({ columns = 6, children }: { columns?: number; children: ReactNode }) {
  return <div className="k-filterbar" style={{ ["--k-cols" as string]: columns }}>{children}</div>;
}

/** Removable chips for the active filters. */
export function FilterChips({ items }: { items: Array<{ key: string; label: string; onRemove: () => void }> }) {
  if (!items.length) return null;
  return (
    <div className="k-chips">
      {items.map((i) => (
        <button key={i.key} type="button" className="k-chip" onClick={i.onRemove}>
          {i.label} <X size={11} />
        </button>
      ))}
    </div>
  );
}

/* ---------- Dropdown menus ---------- */
interface DropdownProps {
  label?: string;
  icon?: IconType;
  trigger?: ReactNode;
  align?: "left" | "right";
  wide?: boolean;
  disabled?: boolean;
  title?: string;
  buttonClass?: string;
  ariaLabel?: string;
  role?: "menu" | "dialog";
  children: ReactNode | ((api: { close: () => void }) => ReactNode);
}
/** Trigger button + floating menu. */
export function Dropdown({ label, icon: Icon, trigger, align = "left", wide, disabled, title, buttonClass, ariaLabel, role = "menu", children }: DropdownProps) {
  const { open, setOpen, ref } = useDropdown();
  return (
    <div ref={ref} className="k-dd">
      <button
        type="button"
        className={cx("k-btn", buttonClass)}
        aria-haspopup={role}
        aria-expanded={open}
        aria-label={ariaLabel}
        disabled={disabled}
        title={title}
        onClick={() => setOpen(!open)}
      >
        {trigger ?? (<>{Icon && <Icon size={14} />} {label}</>)}
        <ChevronDown size={14} className="k-muted" />
      </button>
      {open && !disabled && (
        <div role={role} aria-label={ariaLabel || label} className={cx("k-menu", align === "right" && "k-menu--right", wide && "k-menu--wide")}>
          {typeof children === "function" ? children({ close: () => setOpen(false) }) : children}
        </div>
      )}
    </div>
  );
}

export const MenuHeading = ({ children }: { children: ReactNode }) => <div className="k-menu__heading">{children}</div>;

export function MenuItem({
  active,
  role = "menuitem",
  checked,
  className,
  children,
  ...rest
}: ButtonHTMLAttributes<HTMLButtonElement> & { active?: boolean; checked?: boolean }) {
  return (
    <button type="button" role={role} aria-checked={checked} className={cx("k-menu__item", active && "is-active", className)} {...rest}>
      {children}
      {active && <Check size={14} className="k-menu__check" />}
    </button>
  );
}

/* ---------- Badges ---------- */
export function KBadge({ tone = "blue", dot = true, children }: { tone?: "blue" | "green" | "amber" | "red" | "gray"; dot?: boolean; children: ReactNode }) {
  return (
    <span className={cx("k-badge", tone !== "blue" && `k-badge--${tone}`)}>
      {dot && <span className="k-badge__dot" />}
      {children}
    </span>
  );
}

/** Outlined colored pill used on kanban cards. */
export function Pill({ children, color = "#6b7280" }: { children: ReactNode; color?: string }) {
  return <span className="k-pill" style={{ color }}>{children}</span>;
}

export const PRIORITY_COLORS: Record<string, string> = { Low: "#6b7280", Medium: "#3b82f6", High: "#f59e0b", Urgent: "#ef4444" };

/* ---------- Overlays ---------- */
export function KModal({ title, onClose, width, children }: { title: string; onClose: () => void; width?: number; children: ReactNode }) {
  return (
    <div className="k-overlay" role="presentation">
      <div className="k-modal" role="dialog" aria-modal="true" aria-label={title} style={width ? { ["--k-w" as string]: `${width}px` } : undefined}>
        <div className="k-modal__head">
          <h2>{title}</h2>
          <button type="button" className="k-modal__x" aria-label="Close" onClick={onClose}><X size={18} /></button>
        </div>
        {children}
      </div>
    </div>
  );
}
export const ModalBody = ({ children, ...rest }: React.FormHTMLAttributes<HTMLFormElement>) => <form className="k-modal__body" {...rest}>{children}</form>;
export const ModalFooter = ({ children }: { children: ReactNode }) => <div className="k-modal__foot">{children}</div>;

export function KDrawer({ onClose, width, children }: { onClose: () => void; width?: number; children: ReactNode }) {
  return (
    <div className="k-overlay k-overlay--drawer" onClick={onClose} role="presentation">
      <aside className="k-drawer" role="dialog" aria-modal="true" onClick={(e) => e.stopPropagation()} style={width ? { ["--k-w" as string]: `${width}px` } : undefined}>
        {children}
      </aside>
    </div>
  );
}

/* ---------- Tabs, empty state, stat ---------- */
export function KTabs({ tabs, value, onChange }: { tabs: Array<{ id: string; label: string }>; value: string; onChange: (id: string) => void }) {
  return (
    <div className="k-tabs" role="tablist">
      {tabs.map((t) => (
        <button key={t.id} type="button" role="tab" aria-selected={value === t.id} className={cx("k-tab", value === t.id && "is-active")} onClick={() => onChange(t.id)}>
          {t.label}
        </button>
      ))}
    </div>
  );
}

export function EmptyState({ icon: Icon, children, action }: { icon?: IconType; children: ReactNode; action?: ReactNode }) {
  return (
    <div className="k-empty">
      {Icon && <Icon size={48} strokeWidth={1} />}
      <p>{children}</p>
      {action}
    </div>
  );
}

export function StatCard({ label, value, hint }: { label: string; value: ReactNode; hint?: string }) {
  return (
    <div className="k-stat">
      <div className="k-stat__label">{label}</div>
      <div className="k-stat__value">{value}</div>
      {hint && <div className="k-stat__label">{hint}</div>}
    </div>
  );
}

/* Re-exports so pages import everything from "@/components/kit". */
export * from "./list-utils";
export * from "./use-list";
export * from "./list-menus";
export * from "./record-table";
export * from "./kanban-board";
export * from "./use-kit-labels";
export * from "./date-utils";
export * from "./gantt-chart";
export * from "./calendar-view";
