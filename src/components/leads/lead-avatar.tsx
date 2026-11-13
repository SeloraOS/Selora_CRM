import { initials } from '@/lib/leads/lead-utils';

/** Round avatar: image when available, otherwise the first letter. */
export function LeadAvatar({ name, url, size = 24 }: { name?: string | null; url?: string | null; size?: number }) {
  return (
    <span className="k-avatar" style={{ width: size, height: size, fontSize: Math.max(10, Math.round(size * 0.42)) }} aria-hidden>
      {url ? (
        // eslint-disable-next-line @next/next/no-img-element -- remote avatar URLs of arbitrary hosts
        <img src={url} alt="" />
      ) : (
        initials(name)
      )}
    </span>
  );
}
