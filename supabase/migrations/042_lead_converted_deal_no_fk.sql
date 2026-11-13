-- ============================================================
-- 042_lead_converted_deal_no_fk.sql — fix for 041 (blank Pipelines board)
--
-- 041 added contacts.converted_deal_id with a foreign key to deals. That gave PostgREST two
-- relationships between deals and contacts, so `deals?select=*,contact:contacts(*)` (the
-- Pipelines page, and any other embed) failed with PGRST201 and returned no deals.
--
-- Fix: drop that foreign key (the column stays a plain uuid) and clear it with a trigger when
-- the deal it points to is deleted (same effect as the old ON DELETE SET NULL).
--
-- Idempotent. Safe on databases that never had the FK (fresh 041).
-- ============================================================

ALTER TABLE contacts DROP CONSTRAINT IF EXISTS contacts_converted_deal_id_fkey;

CREATE OR REPLACE FUNCTION public.deals_clear_conversion()
RETURNS TRIGGER
LANGUAGE plpgsql
SECURITY DEFINER
SET search_path = public
AS $$
BEGIN
  UPDATE contacts SET converted_deal_id = NULL, converted_at = NULL WHERE converted_deal_id = OLD.id;
  RETURN OLD;
END;
$$;

DROP TRIGGER IF EXISTS deals_clear_conversion ON deals;
CREATE TRIGGER deals_clear_conversion
  AFTER DELETE ON deals
  FOR EACH ROW EXECUTE FUNCTION public.deals_clear_conversion();

-- Make PostgREST pick up the dropped relationship immediately.
NOTIFY pgrst, 'reload schema';
