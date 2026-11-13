-- ============================================================
-- 040_filter_contacts_v2.sql — tag filter + field filters + sort
--
-- Why
--
--   The Contacts page (PMS-style filter bar) can now filter by name,
--   phone, email, company and created-date range, and sort by column.
--   Without a tag filter that is a plain PostgREST query. WITH a tag
--   filter the page goes through an RPC (see 025) that only knew about
--   tags + a search term and a fixed order. This function adds the
--   extra filters and a whitelisted sort to that same RPC path.
--
-- Backwards compatible
--
--   This is a NEW function (different name). filter_contacts_by_tags
--   from 025 is untouched. If this migration has not been applied, the
--   app falls back to the 025 function (tags + search only).
--
-- Security
--
--   SECURITY INVOKER, like 025: RLS on contacts / contact_tags scopes
--   the result to the caller's account.
--
-- Idempotent — safe to run multiple times.
-- ============================================================

CREATE OR REPLACE FUNCTION public.filter_contacts_v2(
  p_tag_ids UUID[] DEFAULT NULL,
  p_search TEXT DEFAULT NULL,
  p_name TEXT DEFAULT NULL,
  p_phone TEXT DEFAULT NULL,
  p_email TEXT DEFAULT NULL,
  p_company TEXT DEFAULT NULL,
  p_created_from TIMESTAMPTZ DEFAULT NULL,
  p_created_to TIMESTAMPTZ DEFAULT NULL,
  p_sort_col TEXT DEFAULT 'created_at',
  p_sort_dir TEXT DEFAULT 'desc',
  p_limit INT DEFAULT 25,
  p_offset INT DEFAULT 0
)
RETURNS TABLE (contact contacts, total_count BIGINT)
LANGUAGE sql
STABLE
SECURITY INVOKER
SET search_path = public
AS $$
  WITH matched AS (
    SELECT c.id, c.created_at, c.name, c.phone, c.email, c.company
    FROM contacts c
    WHERE (
        p_tag_ids IS NULL
        OR cardinality(p_tag_ids) = 0
        OR EXISTS (
          SELECT 1 FROM contact_tags ct
          WHERE ct.contact_id = c.id AND ct.tag_id = ANY(p_tag_ids)
        )
      )
      AND (
        p_search IS NULL
        OR c.name ILIKE '%' || p_search || '%'
        OR c.phone ILIKE '%' || p_search || '%'
        OR c.email ILIKE '%' || p_search || '%'
      )
      AND (p_name IS NULL OR c.name ILIKE '%' || p_name || '%')
      AND (p_phone IS NULL OR c.phone ILIKE '%' || p_phone || '%')
      AND (p_email IS NULL OR c.email ILIKE '%' || p_email || '%')
      AND (p_company IS NULL OR c.company ILIKE '%' || p_company || '%')
      AND (p_created_from IS NULL OR c.created_at >= p_created_from)
      AND (p_created_to IS NULL OR c.created_at <= p_created_to)
  ),
  ranked AS (
    -- count(*) OVER() is the full match total; row_number() carries the
    -- requested order through the join below. Only whitelisted columns
    -- are sortable (anything else falls back to created_at).
    SELECT
      m.id,
      count(*) OVER() AS total_count,
      row_number() OVER (
        ORDER BY
          CASE WHEN p_sort_col = 'name'    AND p_sort_dir = 'asc'  THEN lower(m.name)    END ASC  NULLS LAST,
          CASE WHEN p_sort_col = 'name'    AND p_sort_dir = 'desc' THEN lower(m.name)    END DESC NULLS LAST,
          CASE WHEN p_sort_col = 'phone'   AND p_sort_dir = 'asc'  THEN m.phone          END ASC  NULLS LAST,
          CASE WHEN p_sort_col = 'phone'   AND p_sort_dir = 'desc' THEN m.phone          END DESC NULLS LAST,
          CASE WHEN p_sort_col = 'email'   AND p_sort_dir = 'asc'  THEN lower(m.email)   END ASC  NULLS LAST,
          CASE WHEN p_sort_col = 'email'   AND p_sort_dir = 'desc' THEN lower(m.email)   END DESC NULLS LAST,
          CASE WHEN p_sort_col = 'company' AND p_sort_dir = 'asc'  THEN lower(m.company) END ASC  NULLS LAST,
          CASE WHEN p_sort_col = 'company' AND p_sort_dir = 'desc' THEN lower(m.company) END DESC NULLS LAST,
          CASE WHEN p_sort_col = 'created_at' AND p_sort_dir = 'asc' THEN m.created_at   END ASC,
          m.created_at DESC,
          m.id
      ) AS rn
    FROM matched m
  )
  SELECT c AS contact, r.total_count
  FROM ranked r
  JOIN contacts c ON c.id = r.id
  WHERE r.rn > p_offset AND r.rn <= p_offset + p_limit
  ORDER BY r.rn;
$$;

ALTER FUNCTION public.filter_contacts_v2(UUID[], TEXT, TEXT, TEXT, TEXT, TEXT, TIMESTAMPTZ, TIMESTAMPTZ, TEXT, TEXT, INT, INT) OWNER TO postgres;
REVOKE ALL ON FUNCTION public.filter_contacts_v2(UUID[], TEXT, TEXT, TEXT, TEXT, TEXT, TIMESTAMPTZ, TIMESTAMPTZ, TEXT, TEXT, INT, INT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.filter_contacts_v2(UUID[], TEXT, TEXT, TEXT, TEXT, TEXT, TIMESTAMPTZ, TIMESTAMPTZ, TEXT, TEXT, INT, INT) TO authenticated;
