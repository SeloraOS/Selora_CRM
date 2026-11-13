-- ============================================================
-- 041_lead_page.sql — every contact is a lead (status, owner, tasks, calls, activity)
--
-- Adds, all additive and nullable so existing code keeps working:
--   * pipelines.is_lead_pipeline      which pipeline's stages are the lead status list
--   * contacts lead fields            owner_id, lead_stage_id, source, priority,
--                                     follow_up_date, lead_code, converted_deal_id/at
--   * custom_fields.section/position  group + order typed custom fields on the lead page
--   * lead_tasks, lead_calls          per-lead to-dos and a manual call log
--   * contact_events                  activity history (comments + status/owner/convert changes)
--   * convert_contact_to_deal()       atomic "Convert to Deal"
--   * filter_contacts_v3()            contacts filter RPC with the lead filters (v2 untouched)
--
-- Triggers fill lead_code and the default lead status on every new contact, so the
-- WhatsApp webhook, CSV import, public API and manual form need no changes.
--
-- Idempotent — safe to run multiple times.
-- ============================================================

-- ------------------------------------------------------------
-- 1. Which pipeline provides the lead statuses (at most one per account)
-- ------------------------------------------------------------
ALTER TABLE pipelines ADD COLUMN IF NOT EXISTS is_lead_pipeline BOOLEAN NOT NULL DEFAULT FALSE;

CREATE UNIQUE INDEX IF NOT EXISTS idx_pipelines_one_lead_per_account
  ON pipelines(account_id) WHERE is_lead_pipeline;

-- ------------------------------------------------------------
-- 2. Lead fields on contacts
-- ------------------------------------------------------------
ALTER TABLE contacts
  ADD COLUMN IF NOT EXISTS owner_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS lead_stage_id UUID REFERENCES pipeline_stages(id) ON DELETE SET NULL,
  ADD COLUMN IF NOT EXISTS source TEXT,
  ADD COLUMN IF NOT EXISTS priority TEXT,
  ADD COLUMN IF NOT EXISTS follow_up_date DATE,
  ADD COLUMN IF NOT EXISTS lead_code TEXT,
  -- Deliberately NO foreign key to deals: a second contacts<->deals relationship makes PostgREST
  -- refuse every `contact:contacts(*)` embed on deals (PGRST201, blank Pipelines board). See 042
  -- (a trigger on deals clears this id when the deal is deleted).
  ADD COLUMN IF NOT EXISTS converted_deal_id UUID,
  ADD COLUMN IF NOT EXISTS converted_at TIMESTAMPTZ;

DO $$ BEGIN
  ALTER TABLE contacts ADD CONSTRAINT contacts_priority_check
    CHECK (priority IS NULL OR priority IN ('low', 'medium', 'high', 'urgent'));
EXCEPTION WHEN duplicate_object THEN NULL; END $$;

CREATE UNIQUE INDEX IF NOT EXISTS idx_contacts_lead_code ON contacts(account_id, lead_code) WHERE lead_code IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_contacts_owner ON contacts(owner_id) WHERE owner_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_contacts_lead_stage ON contacts(lead_stage_id) WHERE lead_stage_id IS NOT NULL;
CREATE INDEX IF NOT EXISTS idx_contacts_follow_up ON contacts(account_id, follow_up_date) WHERE follow_up_date IS NOT NULL;

-- ------------------------------------------------------------
-- 3. Lead code: CRM-LEAD-YYYY-00001 (per account, per year)
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS lead_counters (
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  year INTEGER NOT NULL,
  last_value INTEGER NOT NULL DEFAULT 0,
  PRIMARY KEY (account_id, year)
);
-- RLS on with no policies: only the SECURITY DEFINER trigger below touches it.
ALTER TABLE lead_counters ENABLE ROW LEVEL SECURITY;

CREATE OR REPLACE FUNCTION public.contacts_lead_defaults()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_year INTEGER;
  v_n INTEGER;
BEGIN
  IF NEW.lead_code IS NULL AND NEW.account_id IS NOT NULL THEN
    v_year := EXTRACT(YEAR FROM COALESCE(NEW.created_at, NOW()))::INTEGER;
    INSERT INTO lead_counters (account_id, year, last_value)
    VALUES (NEW.account_id, v_year, 1)
    ON CONFLICT (account_id, year) DO UPDATE SET last_value = lead_counters.last_value + 1
    RETURNING last_value INTO v_n;
    NEW.lead_code := 'CRM-LEAD-' || v_year || '-' || LPAD(v_n::TEXT, 5, '0');
  END IF;

  -- New contacts start at the first stage of the account's lead pipeline (if one is set).
  IF NEW.lead_stage_id IS NULL AND NEW.account_id IS NOT NULL THEN
    SELECT s.id INTO NEW.lead_stage_id
    FROM pipelines p
    JOIN pipeline_stages s ON s.pipeline_id = p.id
    WHERE p.account_id = NEW.account_id AND p.is_lead_pipeline
    ORDER BY s.position ASC, s.created_at ASC
    LIMIT 1;
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS contacts_lead_defaults ON contacts;
CREATE TRIGGER contacts_lead_defaults
  BEFORE INSERT ON contacts
  FOR EACH ROW EXECUTE FUNCTION public.contacts_lead_defaults();

-- Backfill existing contacts in created_at order (per account + year), then seed the counters.
WITH numbered AS (
  SELECT
    c.id,
    c.account_id,
    EXTRACT(YEAR FROM c.created_at)::INTEGER AS yr,
    ROW_NUMBER() OVER (
      PARTITION BY c.account_id, EXTRACT(YEAR FROM c.created_at)
      ORDER BY c.created_at, c.id
    ) AS n
  FROM contacts c
  WHERE c.lead_code IS NULL AND c.account_id IS NOT NULL
)
UPDATE contacts c
SET lead_code = 'CRM-LEAD-' || numbered.yr || '-' || LPAD(numbered.n::TEXT, 5, '0')
FROM numbered
WHERE c.id = numbered.id;

INSERT INTO lead_counters (account_id, year, last_value)
SELECT
  account_id,
  EXTRACT(YEAR FROM created_at)::INTEGER,
  COUNT(*)::INTEGER
FROM contacts
WHERE account_id IS NOT NULL
GROUP BY account_id, EXTRACT(YEAR FROM created_at)
ON CONFLICT (account_id, year) DO UPDATE SET last_value = GREATEST(lead_counters.last_value, EXCLUDED.last_value);

-- ------------------------------------------------------------
-- 4. Typed custom fields: group them into sections and order them
-- ------------------------------------------------------------
ALTER TABLE custom_fields
  ADD COLUMN IF NOT EXISTS section TEXT NOT NULL DEFAULT 'More details',
  ADD COLUMN IF NOT EXISTS position INTEGER NOT NULL DEFAULT 0;

-- ------------------------------------------------------------
-- 5. Tasks, calls, activity
-- ------------------------------------------------------------
CREATE TABLE IF NOT EXISTS lead_tasks (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  title TEXT NOT NULL,
  notes TEXT,
  due_at TIMESTAMPTZ,
  assigned_to UUID REFERENCES profiles(id) ON DELETE SET NULL,
  status TEXT NOT NULL DEFAULT 'todo' CHECK (status IN ('todo', 'done')),
  completed_at TIMESTAMPTZ,
  created_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_lead_tasks_contact ON lead_tasks(contact_id, created_at DESC);
CREATE INDEX IF NOT EXISTS idx_lead_tasks_account_due ON lead_tasks(account_id, due_at) WHERE status = 'todo';

CREATE TABLE IF NOT EXISTS lead_calls (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  direction TEXT NOT NULL DEFAULT 'outbound' CHECK (direction IN ('inbound', 'outbound')),
  outcome TEXT,
  duration_seconds INTEGER CHECK (duration_seconds IS NULL OR duration_seconds >= 0),
  notes TEXT,
  called_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  logged_by UUID REFERENCES profiles(id) ON DELETE SET NULL,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_lead_calls_contact ON lead_calls(contact_id, called_at DESC);

CREATE TABLE IF NOT EXISTS contact_events (
  id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
  account_id UUID NOT NULL REFERENCES accounts(id) ON DELETE CASCADE,
  contact_id UUID NOT NULL REFERENCES contacts(id) ON DELETE CASCADE,
  type TEXT NOT NULL CHECK (type IN ('comment', 'status_changed', 'owner_changed', 'converted')),
  actor_id UUID REFERENCES profiles(id) ON DELETE SET NULL,
  data JSONB NOT NULL DEFAULT '{}'::JSONB,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);
CREATE INDEX IF NOT EXISTS idx_contact_events_contact ON contact_events(contact_id, created_at DESC);

ALTER TABLE lead_tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE lead_calls ENABLE ROW LEVEL SECURITY;
ALTER TABLE contact_events ENABLE ROW LEVEL SECURITY;

DROP POLICY IF EXISTS lead_tasks_select ON lead_tasks;
DROP POLICY IF EXISTS lead_tasks_insert ON lead_tasks;
DROP POLICY IF EXISTS lead_tasks_update ON lead_tasks;
DROP POLICY IF EXISTS lead_tasks_delete ON lead_tasks;
CREATE POLICY lead_tasks_select ON lead_tasks FOR SELECT USING (is_account_member(account_id));
CREATE POLICY lead_tasks_insert ON lead_tasks FOR INSERT WITH CHECK (is_account_member(account_id, 'agent'));
CREATE POLICY lead_tasks_update ON lead_tasks FOR UPDATE USING (is_account_member(account_id, 'agent'));
CREATE POLICY lead_tasks_delete ON lead_tasks FOR DELETE USING (is_account_member(account_id, 'agent'));

DROP POLICY IF EXISTS lead_calls_select ON lead_calls;
DROP POLICY IF EXISTS lead_calls_insert ON lead_calls;
DROP POLICY IF EXISTS lead_calls_update ON lead_calls;
DROP POLICY IF EXISTS lead_calls_delete ON lead_calls;
CREATE POLICY lead_calls_select ON lead_calls FOR SELECT USING (is_account_member(account_id));
CREATE POLICY lead_calls_insert ON lead_calls FOR INSERT WITH CHECK (is_account_member(account_id, 'agent'));
CREATE POLICY lead_calls_update ON lead_calls FOR UPDATE USING (is_account_member(account_id, 'agent'));
CREATE POLICY lead_calls_delete ON lead_calls FOR DELETE USING (is_account_member(account_id, 'agent'));

-- Events are append-only for users (comments); status/owner/convert rows come from the trigger below.
DROP POLICY IF EXISTS contact_events_select ON contact_events;
DROP POLICY IF EXISTS contact_events_insert ON contact_events;
CREATE POLICY contact_events_select ON contact_events FOR SELECT USING (is_account_member(account_id));
CREATE POLICY contact_events_insert ON contact_events FOR INSERT WITH CHECK (is_account_member(account_id, 'agent') AND type = 'comment');

-- ------------------------------------------------------------
-- 6. Record status / owner / conversion changes as events
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.contacts_log_lead_events()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
DECLARE
  v_actor UUID;
BEGIN
  SELECT id INTO v_actor FROM profiles WHERE user_id = auth.uid();

  IF NEW.lead_stage_id IS DISTINCT FROM OLD.lead_stage_id THEN
    INSERT INTO contact_events (account_id, contact_id, type, actor_id, data)
    VALUES (
      NEW.account_id, NEW.id, 'status_changed', v_actor,
      jsonb_build_object(
        'from', (SELECT name FROM pipeline_stages WHERE id = OLD.lead_stage_id),
        'to',   (SELECT name FROM pipeline_stages WHERE id = NEW.lead_stage_id)
      )
    );
  END IF;

  IF NEW.owner_id IS DISTINCT FROM OLD.owner_id THEN
    INSERT INTO contact_events (account_id, contact_id, type, actor_id, data)
    VALUES (
      NEW.account_id, NEW.id, 'owner_changed', v_actor,
      jsonb_build_object(
        'from', (SELECT full_name FROM profiles WHERE id = OLD.owner_id),
        'to',   (SELECT full_name FROM profiles WHERE id = NEW.owner_id)
      )
    );
  END IF;

  IF NEW.converted_deal_id IS DISTINCT FROM OLD.converted_deal_id AND NEW.converted_deal_id IS NOT NULL THEN
    INSERT INTO contact_events (account_id, contact_id, type, actor_id, data)
    VALUES (
      NEW.account_id, NEW.id, 'converted', v_actor,
      jsonb_build_object(
        'deal_id', NEW.converted_deal_id,
        'deal_title', (SELECT title FROM deals WHERE id = NEW.converted_deal_id)
      )
    );
  END IF;

  RETURN NEW;
END;
$$;

DROP TRIGGER IF EXISTS contacts_log_lead_events ON contacts;
CREATE TRIGGER contacts_log_lead_events
  AFTER UPDATE OF lead_stage_id, owner_id, converted_deal_id ON contacts
  FOR EACH ROW EXECUTE FUNCTION public.contacts_log_lead_events();

-- ------------------------------------------------------------
-- 7. Convert to Deal (atomic)
--
-- SECURITY INVOKER: RLS applies, so the caller needs agent+ (deals_insert / contacts_update).
-- Raises 'already_converted' unless p_force is true.
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.convert_contact_to_deal(
  p_contact_id UUID,
  p_pipeline_id UUID,
  p_stage_id UUID,
  p_title TEXT,
  p_value NUMERIC DEFAULT 0,
  p_currency TEXT DEFAULT NULL,
  p_assigned_to UUID DEFAULT NULL,
  p_expected_close_date DATE DEFAULT NULL,
  p_notes TEXT DEFAULT NULL,
  p_force BOOLEAN DEFAULT FALSE
)
RETURNS deals
LANGUAGE plpgsql
SECURITY INVOKER
SET search_path = public
AS $$
DECLARE
  v_contact contacts;
  v_deal deals;
BEGIN
  SELECT * INTO v_contact FROM contacts WHERE id = p_contact_id FOR UPDATE;
  IF NOT FOUND THEN
    RAISE EXCEPTION 'contact_not_found';
  END IF;
  IF v_contact.converted_deal_id IS NOT NULL AND NOT p_force THEN
    RAISE EXCEPTION 'already_converted';
  END IF;

  INSERT INTO deals (
    account_id, user_id, pipeline_id, stage_id, contact_id, conversation_id,
    title, value, currency, assigned_to, expected_close_date, notes, status
  )
  VALUES (
    v_contact.account_id, auth.uid(), p_pipeline_id, p_stage_id, p_contact_id,
    (SELECT c.id FROM conversations c WHERE c.contact_id = p_contact_id AND c.account_id = v_contact.account_id LIMIT 1),
    p_title, COALESCE(p_value, 0), COALESCE(p_currency, 'USD'), p_assigned_to, p_expected_close_date, p_notes, 'open'
  )
  RETURNING * INTO v_deal;

  UPDATE contacts
  SET converted_deal_id = v_deal.id, converted_at = NOW()
  WHERE id = p_contact_id;

  RETURN v_deal;
END;
$$;

REVOKE ALL ON FUNCTION public.convert_contact_to_deal(UUID, UUID, UUID, TEXT, NUMERIC, TEXT, UUID, DATE, TEXT, BOOLEAN) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.convert_contact_to_deal(UUID, UUID, UUID, TEXT, NUMERIC, TEXT, UUID, DATE, TEXT, BOOLEAN) TO authenticated;

-- ------------------------------------------------------------
-- 8. Contacts filter RPC with the lead filters (v2 from 040 stays as is)
-- ------------------------------------------------------------
CREATE OR REPLACE FUNCTION public.filter_contacts_v3(
  p_tag_ids UUID[] DEFAULT NULL,
  p_search TEXT DEFAULT NULL,
  p_name TEXT DEFAULT NULL,
  p_phone TEXT DEFAULT NULL,
  p_email TEXT DEFAULT NULL,
  p_company TEXT DEFAULT NULL,
  p_created_from TIMESTAMPTZ DEFAULT NULL,
  p_created_to TIMESTAMPTZ DEFAULT NULL,
  p_owner_id UUID DEFAULT NULL,
  p_stage_id UUID DEFAULT NULL,
  p_priority TEXT DEFAULT NULL,
  p_source TEXT DEFAULT NULL,
  p_follow_from DATE DEFAULT NULL,
  p_follow_to DATE DEFAULT NULL,
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
    SELECT c.id, c.created_at, c.name, c.phone, c.email, c.company, c.follow_up_date, c.lead_code
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
        OR c.lead_code ILIKE '%' || p_search || '%'
      )
      AND (p_name IS NULL OR c.name ILIKE '%' || p_name || '%')
      AND (p_phone IS NULL OR c.phone ILIKE '%' || p_phone || '%')
      AND (p_email IS NULL OR c.email ILIKE '%' || p_email || '%')
      AND (p_company IS NULL OR c.company ILIKE '%' || p_company || '%')
      AND (p_created_from IS NULL OR c.created_at >= p_created_from)
      AND (p_created_to IS NULL OR c.created_at <= p_created_to)
      AND (p_owner_id IS NULL OR c.owner_id = p_owner_id)
      AND (p_stage_id IS NULL OR c.lead_stage_id = p_stage_id)
      AND (p_priority IS NULL OR c.priority = p_priority)
      AND (p_source IS NULL OR c.source ILIKE '%' || p_source || '%')
      AND (p_follow_from IS NULL OR c.follow_up_date >= p_follow_from)
      AND (p_follow_to IS NULL OR c.follow_up_date <= p_follow_to)
  ),
  ranked AS (
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
          CASE WHEN p_sort_col = 'follow_up_date' AND p_sort_dir = 'asc'  THEN m.follow_up_date END ASC  NULLS LAST,
          CASE WHEN p_sort_col = 'follow_up_date' AND p_sort_dir = 'desc' THEN m.follow_up_date END DESC NULLS LAST,
          CASE WHEN p_sort_col = 'lead_code' AND p_sort_dir = 'asc'  THEN m.lead_code END ASC  NULLS LAST,
          CASE WHEN p_sort_col = 'lead_code' AND p_sort_dir = 'desc' THEN m.lead_code END DESC NULLS LAST,
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

REVOKE ALL ON FUNCTION public.filter_contacts_v3(UUID[], TEXT, TEXT, TEXT, TEXT, TEXT, TIMESTAMPTZ, TIMESTAMPTZ, UUID, UUID, TEXT, TEXT, DATE, DATE, TEXT, TEXT, INT, INT) FROM PUBLIC;
GRANT EXECUTE ON FUNCTION public.filter_contacts_v3(UUID[], TEXT, TEXT, TEXT, TEXT, TEXT, TIMESTAMPTZ, TIMESTAMPTZ, UUID, UUID, TEXT, TEXT, DATE, DATE, TEXT, TEXT, INT, INT) TO authenticated;
