
INSERT INTO public.pipelines (id, user_id, account_id, name, created_at)
VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Enterprise Sales Pipeline', NOW() - INTERVAL '30 days')
ON CONFLICT DO NOTHING;


    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'New Lead', 0, '#64748b', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'New Lead'
    );
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'Qualified', 1, '#3b82f6', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'Qualified'
    );
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'Demo / Meeting', 2, '#8b5cf6', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'Demo / Meeting'
    );
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'Proposal Sent', 3, '#f59e0b', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'Proposal Sent'
    );
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'Negotiation', 4, '#06b6d4', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'Negotiation'
    );
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'Closed Won', 5, '#22c55e', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'Closed Won'
    );
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, 'Closed Lost', 6, '#ef4444', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = 'Closed Lost'
    );
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'VIP', '#ef4444', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Hot Lead', '#f97316', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Enterprise', '#8b5cf6', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Wholesale', '#06b6d4', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Follow Up', '#eab308', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Inbound', '#10b981', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Demo Requested', '#3b82f6', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Pricing Inquiry', '#ec4899', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Alexander Wright', 'alex.wright@apexgroup.io', '+14155552001', 'Apex Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Alexander%20Wright', '2026-10-03T13:37:03.753683+00:00', '2026-10-03T13:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-03T13:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14155552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-03T13:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14155552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as CEO at Apex Group. Key interest in automated workflows and WhatsApp marketing.', '2026-10-03T13:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14155552001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+14155552001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Won';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Apex Group - Multi-Branch CRM Rollout', 50000, 'USD', 'won', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-03T13:37:03.753683+00:00', '2026-10-03T13:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Sophia Martinez', 'smartinez@nexoratech.com', '+14155552002', 'Nexora Tech', 'https://api.dicebear.com/7.x/initials/svg?seed=Sophia%20Martinez', '2026-09-10T05:37:03.753683+00:00', '2026-09-10T05:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-10T05:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14155552002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-10T05:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14155552002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as CTO at Nexora Tech. Key interest in automated workflows and WhatsApp marketing.', '2026-09-10T05:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14155552002'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+14155552002';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-09-10T05:37:03.753683+00:00', 2, '2026-09-10T05:37:03.753683+00:00', '2026-09-10T05:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-10T05:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-09-10T05:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+14155552002';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Nexora Tech - Annual Enterprise Subscription', 2500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-10T05:37:03.753683+00:00', '2026-09-10T05:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Liam O''Connor', 'liam@vanguardlogistics.co', '+442079460001', 'Vanguard Logistics', 'https://api.dicebear.com/7.x/initials/svg?seed=Liam%20O%27Connor', '2026-09-26T07:37:03.753683+00:00', '2026-09-26T07:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-26T07:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+442079460001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-26T07:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+442079460001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Operations Director at Vanguard Logistics. Key interest in automated workflows and WhatsApp marketing.', '2026-09-26T07:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+442079460001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+442079460001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-26T07:37:03.753683+00:00', 1, '2026-09-26T07:37:03.753683+00:00', '2026-09-26T07:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-26T07:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-26T07:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+442079460001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Negotiation';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Vanguard Logistics - Multi-Branch CRM Rollout', 12000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-26T07:37:03.753683+00:00', '2026-09-26T07:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Elena Rostova', 'elena@quantumdynamic.de', '+493090182001', 'Quantum Dynamics', 'https://api.dicebear.com/7.x/initials/svg?seed=Elena%20Rostova', '2026-09-20T04:37:03.753683+00:00', '2026-09-20T04:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-20T04:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+493090182001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-20T04:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+493090182001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Head of Procurement at Quantum Dynamics. Key interest in automated workflows and WhatsApp marketing.', '2026-09-20T04:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+493090182001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+493090182001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-20T04:37:03.753683+00:00', 1, '2026-09-20T04:37:03.753683+00:00', '2026-09-20T04:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Good day, we are evaluating multichannel CRM tools. Does your API support webhook triggers and automated flow routing?', 'read', ('2026-09-20T04:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-20T04:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Rahul Sharma', 'rahul.sharma@luminahealth.in', '+919820055001', 'Lumina Health', 'https://api.dicebear.com/7.x/initials/svg?seed=Rahul%20Sharma', '2026-10-07T00:37:03.753683+00:00', '2026-10-07T00:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-07T00:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Managing Director at Lumina Health. Key interest in automated workflows and WhatsApp marketing.', '2026-10-07T00:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055001'
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Chloe Dupont', 'c.dupont@bluepeakcap.fr', '+33140052001', 'BluePeak Capital', 'https://api.dicebear.com/7.x/initials/svg?seed=Chloe%20Dupont', '2026-09-17T06:37:03.753683+00:00', '2026-09-17T06:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T06:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+33140052001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Partner at BluePeak Capital. Key interest in automated workflows and WhatsApp marketing.', '2026-09-17T06:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+33140052001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+33140052001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-17T06:37:03.753683+00:00', 1, '2026-09-17T06:37:03.753683+00:00', '2026-09-17T06:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-09-17T06:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-17T06:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+33140052001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Qualified';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'BluePeak Capital - WhatsApp Broadcast & Automation Suite', 24000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-17T06:37:03.753683+00:00', '2026-09-17T06:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Marcus Vance', 'marcus@starlightmedia.com', '+12125552003', 'Starlight Media', 'https://api.dicebear.com/7.x/initials/svg?seed=Marcus%20Vance', '2026-09-27T05:37:03.753683+00:00', '2026-09-27T05:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T05:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+12125552003'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T05:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+12125552003'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as VP Marketing at Starlight Media. Key interest in automated workflows and WhatsApp marketing.', '2026-09-27T05:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+12125552003'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+12125552003';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-27T05:37:03.753683+00:00', 2, '2026-09-27T05:37:03.753683+00:00', '2026-09-27T05:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-27T05:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-27T05:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+12125552003';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Starlight Media - Standard Onboarding & Team License', 4800, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-27T05:37:03.753683+00:00', '2026-09-27T05:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Olivia Chen', 'olivia@horizonretail.sg', '+6567892001', 'Horizon Retail', 'https://api.dicebear.com/7.x/initials/svg?seed=Olivia%20Chen', '2026-09-17T21:37:03.753683+00:00', '2026-09-17T21:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T21:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+6567892001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as E-commerce Lead at Horizon Retail. Key interest in automated workflows and WhatsApp marketing.', '2026-09-17T21:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+6567892001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+6567892001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-17T21:37:03.753683+00:00', 0, '2026-09-17T21:37:03.753683+00:00', '2026-09-17T21:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-17T21:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-17T21:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+6567892001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Won';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Horizon Retail - API & Webhook Custom Integration', 36000, 'USD', 'won', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-17T21:37:03.753683+00:00', '2026-09-17T21:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lucas Silva', 'lucas@solarisenergy.br', '+551198762001', 'Solaris Energy', 'https://api.dicebear.com/7.x/initials/svg?seed=Lucas%20Silva', '2026-09-16T22:37:03.753683+00:00', '2026-09-16T22:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-16T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+551198762001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Chief Commercial Officer at Solaris Energy. Key interest in automated workflows and WhatsApp marketing.', '2026-09-16T22:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+551198762001'
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Aisha Al-Mansoor', 'aisha@gulfventures.ae', '+97143122001', 'Gulf Ventures', 'https://api.dicebear.com/7.x/initials/svg?seed=Aisha%20Al-Mansoor', '2026-09-10T20:37:03.753683+00:00', '2026-09-10T20:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-10T20:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+97143122001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Investment Manager at Gulf Ventures. Key interest in automated workflows and WhatsApp marketing.', '2026-09-10T20:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+97143122001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+97143122001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-10T20:37:03.753683+00:00', 0, '2026-09-10T20:37:03.753683+00:00', '2026-09-10T20:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching.', 'read', ('2026-09-10T20:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-10T20:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'David Kim', 'dkim@seoulautomations.kr', '+8225552001', 'Seoul Automations', 'https://api.dicebear.com/7.x/initials/svg?seed=David%20Kim', '2026-10-05T22:37:03.753683+00:00', '2026-10-05T22:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-05T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+8225552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as General Manager at Seoul Automations. Key interest in automated workflows and WhatsApp marketing.', '2026-10-05T22:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+8225552001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+8225552001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', '2026-10-05T22:37:03.753683+00:00', 1, '2026-10-05T22:37:03.753683+00:00', '2026-10-05T22:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hey! Looking to migrate our team from our legacy WhatsApp tool. What is the timeline for onboarding?', 'read', ('2026-10-05T22:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', 'delivered', '2026-10-05T22:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+8225552001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Lost';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Seoul Automations - API & Webhook Custom Integration', 24000, 'USD', 'lost', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-05T22:37:03.753683+00:00', '2026-10-05T22:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Emma Watson-Bell', 'emma@crestviewconsulting.co.uk', '+442079460002', 'Crestview Consulting', 'https://api.dicebear.com/7.x/initials/svg?seed=Emma%20Watson-Bell', '2026-09-25T02:37:03.753683+00:00', '2026-09-25T02:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-25T02:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+442079460002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Senior Consultant at Crestview Consulting. Key interest in automated workflows and WhatsApp marketing.', '2026-09-25T02:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+442079460002'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+442079460002';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.', '2026-09-25T02:37:03.753683+00:00', 2, '2026-09-25T02:37:03.753683+00:00', '2026-09-25T02:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Good day, we are evaluating multichannel CRM tools. Does your API support webhook triggers and automated flow routing?', 'read', ('2026-09-25T02:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.', 'delivered', '2026-09-25T02:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+442079460002';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Proposal Sent';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Crestview Consulting - Standard Onboarding & Team License', 4800, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-25T02:37:03.753683+00:00', '2026-09-25T02:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Mateo Fernandez', 'mateo@iberiapharma.es', '+34912342001', 'Iberia Pharma', 'https://api.dicebear.com/7.x/initials/svg?seed=Mateo%20Fernandez', '2026-09-12T19:37:03.753683+00:00', '2026-09-12T19:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-12T19:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+34912342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-12T19:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+34912342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Sales Director at Iberia Pharma. Key interest in automated workflows and WhatsApp marketing.', '2026-09-12T19:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+34912342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+34912342001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Demo / Meeting';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Iberia Pharma - Standard Onboarding & Team License', 18500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-12T19:37:03.753683+00:00', '2026-09-12T19:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Fatima Zahra', 'fzahra@casablancagroup.ma', '+212522552001', 'Casablanca Exports', 'https://api.dicebear.com/7.x/initials/svg?seed=Fatima%20Zahra', '2026-09-18T06:37:03.753683+00:00', '2026-09-18T06:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-18T06:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+212522552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-18T06:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+212522552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Supply Chain Head at Casablanca Exports. Key interest in automated workflows and WhatsApp marketing.', '2026-09-18T06:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+212522552001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+212522552001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-09-18T06:37:03.753683+00:00', 1, '2026-09-18T06:37:03.753683+00:00', '2026-09-18T06:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-18T06:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-09-18T06:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Noah Lindqvist', 'noah@nordiccloud.se', '+46812342001', 'Nordic Cloud Labs', 'https://api.dicebear.com/7.x/initials/svg?seed=Noah%20Lindqvist', '2026-10-05T21:37:03.753683+00:00', '2026-10-05T21:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-05T21:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+46812342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Founder at Nordic Cloud Labs. Key interest in automated workflows and WhatsApp marketing.', '2026-10-05T21:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+46812342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+46812342001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-10-05T21:37:03.753683+00:00', 0, '2026-10-05T21:37:03.753683+00:00', '2026-10-05T21:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-10-05T21:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-10-05T21:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Grace Hopperly', 'grace@aerotechsys.com', '+16505552004', 'AeroTech Systems', 'https://api.dicebear.com/7.x/initials/svg?seed=Grace%20Hopperly', '2026-09-27T14:37:03.753683+00:00', '2026-09-27T14:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T14:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+16505552004'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T14:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+16505552004'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Product Director at AeroTech Systems. Key interest in automated workflows and WhatsApp marketing.', '2026-09-27T14:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+16505552004'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+16505552004';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-27T14:37:03.753683+00:00', 1, '2026-09-27T14:37:03.753683+00:00', '2026-09-27T14:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-27T14:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-27T14:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+16505552004';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Lost';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'AeroTech Systems - API & Webhook Custom Integration', 50000, 'USD', 'lost', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-27T14:37:03.753683+00:00', '2026-09-27T14:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Ravi Patel', 'ravi.patel@zenithenterprises.in', '+919820055002', 'Zenith Enterprises', 'https://api.dicebear.com/7.x/initials/svg?seed=Ravi%20Patel', '2026-09-27T11:37:03.753683+00:00', '2026-09-27T11:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T11:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T11:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as President at Zenith Enterprises. Key interest in automated workflows and WhatsApp marketing.', '2026-09-27T11:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055002'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055002';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Negotiation';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Zenith Enterprises - WhatsApp Broadcast & Automation Suite', 7500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-27T11:37:03.753683+00:00', '2026-09-27T11:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Hanna Schmidt', 'h.schmidt@bavariagoods.de', '+498912342001', 'Bavaria Goods', 'https://api.dicebear.com/7.x/initials/svg?seed=Hanna%20Schmidt', '2026-10-03T19:37:03.753683+00:00', '2026-10-03T19:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-03T19:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+498912342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Purchasing Manager at Bavaria Goods. Key interest in automated workflows and WhatsApp marketing.', '2026-10-03T19:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+498912342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+498912342001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-10-03T19:37:03.753683+00:00', 0, '2026-10-03T19:37:03.753683+00:00', '2026-10-03T19:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-10-03T19:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-10-03T19:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+498912342001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Bavaria Goods - API & Webhook Custom Integration', 24000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-03T19:37:03.753683+00:00', '2026-10-03T19:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Gabriel Santos', 'gabriel@paulistalog.com.br', '+551198762002', 'Paulista Logistics', 'https://api.dicebear.com/7.x/initials/svg?seed=Gabriel%20Santos', '2026-10-07T08:37:03.753683+00:00', '2026-10-07T08:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-07T08:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+551198762002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as COO at Paulista Logistics. Key interest in automated workflows and WhatsApp marketing.', '2026-10-07T08:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+551198762002'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+551198762002';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-10-07T08:37:03.753683+00:00', 0, '2026-10-07T08:37:03.753683+00:00', '2026-10-07T08:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-10-07T08:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-10-07T08:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Priya Nair', 'priya@keralaspicesglobal.com', '+919820055003', 'Kerala Global Spices', 'https://api.dicebear.com/7.x/initials/svg?seed=Priya%20Nair', '2026-09-29T06:37:03.753683+00:00', '2026-09-29T06:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-29T06:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055003'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-29T06:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055003'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Export Manager at Kerala Global Spices. Key interest in automated workflows and WhatsApp marketing.', '2026-09-29T06:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055003'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055003';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', '2026-09-29T06:37:03.753683+00:00', 0, '2026-09-29T06:37:03.753683+00:00', '2026-09-29T06:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-09-29T06:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', 'delivered', '2026-09-29T06:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Benjamin Taylor', 'btaylor@acadiasolutions.ca', '+14165552005', 'Acadia Solutions', 'https://api.dicebear.com/7.x/initials/svg?seed=Benjamin%20Taylor', '2026-09-29T21:37:03.753683+00:00', '2026-09-29T21:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-29T21:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14165552005'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as IT Director at Acadia Solutions. Key interest in automated workflows and WhatsApp marketing.', '2026-09-29T21:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+14165552005'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+14165552005';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Acadia Solutions - Annual Enterprise Subscription', 2500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-29T21:37:03.753683+00:00', '2026-09-29T21:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Mia Johansson', 'mia@stockholmfashion.se', '+46812342002', 'Stockholm Fashion House', 'https://api.dicebear.com/7.x/initials/svg?seed=Mia%20Johansson', '2026-09-16T10:37:03.753683+00:00', '2026-09-16T10:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-16T10:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+46812342002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Brand Lead at Stockholm Fashion House. Key interest in automated workflows and WhatsApp marketing.', '2026-09-16T10:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+46812342002'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+46812342002';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-16T10:37:03.753683+00:00', 1, '2026-09-16T10:37:03.753683+00:00', '2026-09-16T10:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching.', 'read', ('2026-09-16T10:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-16T10:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+46812342002';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Qualified';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Stockholm Fashion House - Quarterly Expansion License', 24000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-16T10:37:03.753683+00:00', '2026-09-16T10:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Vikram Singhania', 'vikram@singhaniatextiles.in', '+919820055004', 'Singhania Textiles', 'https://api.dicebear.com/7.x/initials/svg?seed=Vikram%20Singhania', '2026-09-25T07:37:03.753683+00:00', '2026-09-25T07:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-25T07:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055004'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-25T07:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055004'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Managing Director at Singhania Textiles. Key interest in automated workflows and WhatsApp marketing.', '2026-09-25T07:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055004'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055004';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.', '2026-09-25T07:37:03.753683+00:00', 0, '2026-09-25T07:37:03.753683+00:00', '2026-09-25T07:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-25T07:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.', 'delivered', '2026-09-25T07:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055004';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Demo / Meeting';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Singhania Textiles - API & Webhook Custom Integration', 18500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-25T07:37:03.753683+00:00', '2026-09-25T07:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Isabella Rossi', 'i.rossi@milanoapparel.it', '+390212342001', 'Milano Luxury Apparel', 'https://api.dicebear.com/7.x/initials/svg?seed=Isabella%20Rossi', '2026-09-17T13:37:03.753683+00:00', '2026-09-17T13:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T13:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+390212342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T13:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+390212342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Merchandising Lead at Milano Luxury Apparel. Key interest in automated workflows and WhatsApp marketing.', '2026-09-17T13:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+390212342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+390212342001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-09-17T13:37:03.753683+00:00', 2, '2026-09-17T13:37:03.753683+00:00', '2026-09-17T13:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Good day, we are evaluating multichannel CRM tools. Does your API support webhook triggers and automated flow routing?', 'read', ('2026-09-17T13:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-09-17T13:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Tariq Mahmoud', 'tariq@cairotrade.eg', '+20227952001', 'Cairo Trade Link', 'https://api.dicebear.com/7.x/initials/svg?seed=Tariq%20Mahmoud', '2026-09-19T19:37:03.753683+00:00', '2026-09-19T19:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-19T19:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+20227952001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Regional Manager at Cairo Trade Link. Key interest in automated workflows and WhatsApp marketing.', '2026-09-19T19:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+20227952001'
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Charlotte Evans', 'cevans@sydneymedtech.com.au', '+61298762001', 'Sydney MedTech', 'https://api.dicebear.com/7.x/initials/svg?seed=Charlotte%20Evans', '2026-09-30T22:37:03.753683+00:00', '2026-09-30T22:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-30T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+61298762001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-30T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+61298762001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Head of Growth at Sydney MedTech. Key interest in automated workflows and WhatsApp marketing.', '2026-09-30T22:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+61298762001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+61298762001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'closed', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-30T22:37:03.753683+00:00', 0, '2026-09-30T22:37:03.753683+00:00', '2026-09-30T22:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi there! We are interested in integrating WhatsApp CRM for our sales team. Can you share pricing?', 'read', ('2026-09-30T22:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-30T22:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+61298762001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Proposal Sent';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Sydney MedTech - WhatsApp Broadcast & Automation Suite', 36000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-30T22:37:03.753683+00:00', '2026-09-30T22:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Hiroshi Tanaka', 'tanaka@tokyoelectronic.jp', '+81355552001', 'Tokyo Electronics', 'https://api.dicebear.com/7.x/initials/svg?seed=Hiroshi%20Tanaka', '2026-10-02T09:37:03.753683+00:00', '2026-10-02T09:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-02T09:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+81355552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-02T09:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+81355552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Procurement Lead at Tokyo Electronics. Key interest in automated workflows and WhatsApp marketing.', '2026-10-02T09:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+81355552001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+81355552001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-10-02T09:37:03.753683+00:00', 0, '2026-10-02T09:37:03.753683+00:00', '2026-10-02T09:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-10-02T09:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-10-02T09:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+81355552001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Tokyo Electronics - Growth Plan (20 Agents)', 12000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-02T09:37:03.753683+00:00', '2026-10-02T09:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Amara Okafor', 'amara@lagospayments.ng', '+23412342001', 'Lagos Fintech Hub', 'https://api.dicebear.com/7.x/initials/svg?seed=Amara%20Okafor', '2026-09-27T07:37:03.753683+00:00', '2026-09-27T07:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T07:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+23412342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as CEO at Lagos Fintech Hub. Key interest in automated workflows and WhatsApp marketing.', '2026-09-27T07:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+23412342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+23412342001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-27T07:37:03.753683+00:00', 0, '2026-09-27T07:37:03.753683+00:00', '2026-09-27T07:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching.', 'read', ('2026-09-27T07:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-27T07:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+23412342001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Proposal Sent';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Lagos Fintech Hub - WhatsApp Broadcast & Automation Suite', 24000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-27T07:37:03.753683+00:00', '2026-09-27T07:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Daniel Weber', 'dweber@alpineworks.ch', '+41223452001', 'Alpine Industrial Works', 'https://api.dicebear.com/7.x/initials/svg?seed=Daniel%20Weber', '2026-09-14T13:37:03.753683+00:00', '2026-09-14T13:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-14T13:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+41223452001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-14T13:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+41223452001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as VP Operations at Alpine Industrial Works. Key interest in automated workflows and WhatsApp marketing.', '2026-09-14T13:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+41223452001'
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Zoe Kravitz-Lee', 'zoe@pacificevents.com', '+12065552006', 'Pacific Event Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Zoe%20Kravitz-Lee', '2026-10-01T16:37:03.753683+00:00', '2026-10-01T16:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-01T16:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+12065552006'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-01T16:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+12065552006'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Founder at Pacific Event Group. Key interest in automated workflows and WhatsApp marketing.', '2026-10-01T16:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+12065552006'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+12065552006';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', '2026-10-01T16:37:03.753683+00:00', 2, '2026-10-01T16:37:03.753683+00:00', '2026-10-01T16:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching.', 'read', ('2026-10-01T16:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', 'delivered', '2026-10-01T16:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Karthik Raman', 'karthik@chennaisoftware.in', '+919820055005', 'Chennai Cloud Works', 'https://api.dicebear.com/7.x/initials/svg?seed=Karthik%20Raman', '2026-09-14T09:37:03.753683+00:00', '2026-09-14T09:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-14T09:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055005'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Chief Architect at Chennai Cloud Works. Key interest in automated workflows and WhatsApp marketing.', '2026-09-14T09:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055005'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055005';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-14T09:37:03.753683+00:00', 1, '2026-09-14T09:37:03.753683+00:00', '2026-09-14T09:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-14T09:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-14T09:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055005';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Chennai Cloud Works - Growth Plan (20 Agents)', 2500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-14T09:37:03.753683+00:00', '2026-09-14T09:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Larissa Volkova', 'larissa@amberlogistics.pl', '+48221232001', 'Amber Logistics Warsaw', 'https://api.dicebear.com/7.x/initials/svg?seed=Larissa%20Volkova', '2026-10-07T08:37:03.753683+00:00', '2026-10-07T08:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-07T08:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+48221232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-07T08:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+48221232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Business Dev Lead at Amber Logistics Warsaw. Key interest in automated workflows and WhatsApp marketing.', '2026-10-07T08:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+48221232001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+48221232001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-10-07T08:37:03.753683+00:00', 2, '2026-10-07T08:37:03.753683+00:00', '2026-10-07T08:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-10-07T08:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-10-07T08:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+48221232001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Demo / Meeting';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Amber Logistics Warsaw - High-Volume Messaging Tier', 50000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-07T08:37:03.753683+00:00', '2026-10-07T08:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Samuel Green', 'sgreen@austincleanenergy.com', '+15125552007', 'Austin Clean Energy', 'https://api.dicebear.com/7.x/initials/svg?seed=Samuel%20Green', '2026-10-01T07:37:03.753683+00:00', '2026-10-01T07:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-01T07:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+15125552007'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Project Director at Austin Clean Energy. Key interest in automated workflows and WhatsApp marketing.', '2026-10-01T07:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+15125552007'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+15125552007';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'New Lead';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Austin Clean Energy - Annual Enterprise Subscription', 4800, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-01T07:37:03.753683+00:00', '2026-10-01T07:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Freja Nielsen', 'freja@copenhagendesign.dk', '+4533122001', 'Copenhagen Nordic Design', 'https://api.dicebear.com/7.x/initials/svg?seed=Freja%20Nielsen', '2026-09-21T17:37:03.753683+00:00', '2026-09-21T17:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-21T17:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+4533122001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-21T17:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+4533122001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Creative Director at Copenhagen Nordic Design. Key interest in automated workflows and WhatsApp marketing.', '2026-09-21T17:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+4533122001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+4533122001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.', '2026-09-21T17:37:03.753683+00:00', 2, '2026-09-21T17:37:03.753683+00:00', '2026-09-21T17:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hey! Looking to migrate our team from our legacy WhatsApp tool. What is the timeline for onboarding?', 'read', ('2026-09-21T17:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.', 'delivered', '2026-09-21T17:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Ananya Roy', 'ananya@kolkatadigital.in', '+919820055006', 'Kolkata Digital Arts', 'https://api.dicebear.com/7.x/initials/svg?seed=Ananya%20Roy', '2026-09-19T04:37:03.753683+00:00', '2026-09-19T04:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-19T04:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055006'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-19T04:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055006'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Co-Founder at Kolkata Digital Arts. Key interest in automated workflows and WhatsApp marketing.', '2026-09-19T04:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055006'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055006';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-19T04:37:03.753683+00:00', 1, '2026-09-19T04:37:03.753683+00:00', '2026-09-19T04:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching.', 'read', ('2026-09-19T04:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-19T04:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Leo Van Dijk', 'leo@amsterdamfleet.nl', '+31201232001', 'Amsterdam Fleet Services', 'https://api.dicebear.com/7.x/initials/svg?seed=Leo%20Van%20Dijk', '2026-09-26T20:37:03.753683+00:00', '2026-09-26T20:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-26T20:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+31201232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Fleet Manager at Amsterdam Fleet Services. Key interest in automated workflows and WhatsApp marketing.', '2026-09-26T20:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+31201232001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+31201232001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', '2026-09-26T20:37:03.753683+00:00', 0, '2026-09-26T20:37:03.753683+00:00', '2026-09-26T20:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-26T20:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', 'delivered', '2026-09-26T20:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+31201232001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Qualified';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Amsterdam Fleet Services - Standard Onboarding & Team License', 18500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-26T20:37:03.753683+00:00', '2026-09-26T20:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Camila Morales', 'camila@bogotacoffee.co', '+5712342001', 'Bogota Coffee Roasters', 'https://api.dicebear.com/7.x/initials/svg?seed=Camila%20Morales', '2026-09-17T09:37:03.753683+00:00', '2026-09-17T09:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T09:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+5712342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Commercial Director at Bogota Coffee Roasters. Key interest in automated workflows and WhatsApp marketing.', '2026-09-17T09:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+5712342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+5712342001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Demo / Meeting';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Bogota Coffee Roasters - Annual Enterprise Subscription', 50000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-17T09:37:03.753683+00:00', '2026-09-17T09:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Ethan Walker', 'ethan@denveroutdoors.com', '+13035552008', 'Denver Outdoor Gear', 'https://api.dicebear.com/7.x/initials/svg?seed=Ethan%20Walker', '2026-09-11T17:37:03.753683+00:00', '2026-09-11T17:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-11T17:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+13035552008'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-11T17:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+13035552008'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as VP Marketing at Denver Outdoor Gear. Key interest in automated workflows and WhatsApp marketing.', '2026-09-11T17:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+13035552008'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+13035552008';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-11T17:37:03.753683+00:00', 2, '2026-09-11T17:37:03.753683+00:00', '2026-09-11T17:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-09-11T17:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-11T17:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+13035552008';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Negotiation';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Denver Outdoor Gear - Standard Onboarding & Team License', 7500, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-11T17:37:03.753683+00:00', '2026-09-11T17:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Kavita Menon', 'kavita@bangaloredatastack.in', '+919820055007', 'DataStack Analytics', 'https://api.dicebear.com/7.x/initials/svg?seed=Kavita%20Menon', '2026-09-26T15:37:03.753683+00:00', '2026-09-26T15:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-26T15:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055007'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as VP Engineering at DataStack Analytics. Key interest in automated workflows and WhatsApp marketing.', '2026-09-26T15:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055007'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055007';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-09-26T15:37:03.753683+00:00', 0, '2026-09-26T15:37:03.753683+00:00', '2026-09-26T15:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-09-26T15:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-09-26T15:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Simon Becker', 'simon@berlinmicro.de', '+493090182002', 'Berlin Micro Systems', 'https://api.dicebear.com/7.x/initials/svg?seed=Simon%20Becker', '2026-09-24T02:37:03.753683+00:00', '2026-09-24T02:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-24T02:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+493090182002'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Managing Partner at Berlin Micro Systems. Key interest in automated workflows and WhatsApp marketing.', '2026-09-24T02:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+493090182002'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+493090182002';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-24T02:37:03.753683+00:00', 0, '2026-09-24T02:37:03.753683+00:00', '2026-09-24T02:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Good day, we are evaluating multichannel CRM tools. Does your API support webhook triggers and automated flow routing?', 'read', ('2026-09-24T02:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-24T02:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Elena Petrova', 'elena@viennaadvisory.at', '+4312342001', 'Vienna Financial Advisory', 'https://api.dicebear.com/7.x/initials/svg?seed=Elena%20Petrova', '2026-09-28T22:37:03.753683+00:00', '2026-09-28T22:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-28T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+4312342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-28T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+4312342001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Senior Partner at Vienna Financial Advisory. Key interest in automated workflows and WhatsApp marketing.', '2026-09-28T22:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+4312342001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+4312342001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Lost';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Vienna Financial Advisory - Annual Enterprise Subscription', 36000, 'USD', 'lost', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-28T22:37:03.753683+00:00', '2026-09-28T22:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Jack Thompson', 'jack@aucklandagri.co.nz', '+6491232001', 'Auckland Agri Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Jack%20Thompson', '2026-09-14T23:37:03.753683+00:00', '2026-09-14T23:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-14T23:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+6491232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Managing Director at Auckland Agri Group. Key interest in automated workflows and WhatsApp marketing.', '2026-09-14T23:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+6491232001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+6491232001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', '2026-09-14T23:37:03.753683+00:00', 0, '2026-09-14T23:37:03.753683+00:00', '2026-09-14T23:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hey! Looking to migrate our team from our legacy WhatsApp tool. What is the timeline for onboarding?', 'read', ('2026-09-14T23:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account.', 'delivered', '2026-09-14T23:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+6491232001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Lost';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Auckland Agri Group - Standard Onboarding & Team License', 7500, 'USD', 'lost', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-14T23:37:03.753683+00:00', '2026-09-14T23:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Siddharth Gupta', 'sid@delhiecommercelabs.in', '+919820055008', 'Delhi eCommerce Labs', 'https://api.dicebear.com/7.x/initials/svg?seed=Siddharth%20Gupta', '2026-09-12T17:37:03.753683+00:00', '2026-09-12T17:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-12T17:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055008'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as CEO at Delhi eCommerce Labs. Key interest in automated workflows and WhatsApp marketing.', '2026-09-12T17:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055008'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055008';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-12T17:37:03.753683+00:00', 2, '2026-09-12T17:37:03.753683+00:00', '2026-09-12T17:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-09-12T17:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-12T17:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055008';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Lost';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Delhi eCommerce Labs - Multi-Branch CRM Rollout', 2500, 'USD', 'lost', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-12T17:37:03.753683+00:00', '2026-09-12T17:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lucia Moretti', 'lucia@florenceleather.it', '+390551232001', 'Florence Crafts', 'https://api.dicebear.com/7.x/initials/svg?seed=Lucia%20Moretti', '2026-09-23T18:37:03.753683+00:00', '2026-09-23T18:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-23T18:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+390551232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Global Sales Head at Florence Crafts. Key interest in automated workflows and WhatsApp marketing.', '2026-09-23T18:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+390551232001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+390551232001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'pending', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-23T18:37:03.753683+00:00', 1, '2026-09-23T18:37:03.753683+00:00', '2026-09-23T18:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?', 'read', ('2026-09-23T18:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-23T18:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Arthur Pendelton', 'arthur@manchestermfg.co.uk', '+441619462001', 'Manchester Mfg Ltd', 'https://api.dicebear.com/7.x/initials/svg?seed=Arthur%20Pendelton', '2026-09-17T22:37:03.753683+00:00', '2026-09-17T22:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+441619462001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'VIP'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-17T22:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+441619462001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Enterprise'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Plant Director at Manchester Mfg Ltd. Key interest in automated workflows and WhatsApp marketing.', '2026-09-17T22:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+441619462001'
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Yuki Sato', 'yuki@osakabiotech.jp', '+81665552001', 'Osaka BioTech Corp', 'https://api.dicebear.com/7.x/initials/svg?seed=Yuki%20Sato', '2026-09-25T18:37:03.753683+00:00', '2026-09-25T18:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-25T18:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+81665552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-25T18:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+81665552001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Pricing Inquiry'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as R&D Director at Osaka BioTech Corp. Key interest in automated workflows and WhatsApp marketing.', '2026-09-25T18:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+81665552001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+81665552001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', '2026-09-25T18:37:03.753683+00:00', 1, '2026-09-25T18:37:03.753683+00:00', '2026-09-25T18:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.', 'read', ('2026-09-25T18:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', 'delivered', '2026-09-25T18:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+81665552001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Negotiation';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Osaka BioTech Corp - Growth Plan (20 Agents)', 36000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-25T18:37:03.753683+00:00', '2026-09-25T18:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Meera Nambiar', 'meera@hyderabadpharma.in', '+919820055009', 'Hyderabad BioPharma', 'https://api.dicebear.com/7.x/initials/svg?seed=Meera%20Nambiar', '2026-10-04T05:37:03.753683+00:00', '2026-10-04T05:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-04T05:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055009'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Demo Requested'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-10-04T05:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055009'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Head of Clinical Supply at Hyderabad BioPharma. Key interest in automated workflows and WhatsApp marketing.', '2026-10-04T05:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055009'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055009';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', '2026-10-04T05:37:03.753683+00:00', 2, '2026-10-04T05:37:03.753683+00:00', '2026-10-04T05:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hi there! We are interested in integrating WhatsApp CRM for our sales team. Can you share pricing?', 'read', ('2026-10-04T05:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.', 'delivered', '2026-10-04T05:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055009';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Closed Won';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Hyderabad BioPharma - API & Webhook Custom Integration', 50000, 'USD', 'won', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-10-04T05:37:03.753683+00:00', '2026-10-04T05:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Carlos Mendoza', 'carlos@monterreyindustries.mx', '+528181232001', 'Monterrey Heavy Industries', 'https://api.dicebear.com/7.x/initials/svg?seed=Carlos%20Mendoza', '2026-09-13T14:37:03.753683+00:00', '2026-09-13T14:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-13T14:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+528181232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Wholesale'
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-13T14:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+528181232001'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Hot Lead'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Purchasing Director at Monterrey Heavy Industries. Key interest in automated workflows and WhatsApp marketing.', '2026-09-13T14:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+528181232001'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+528181232001';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', '2026-09-13T14:37:03.753683+00:00', 2, '2026-09-13T14:37:03.753683+00:00', '2026-09-13T14:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Good day, we are evaluating multichannel CRM tools. Does your API support webhook triggers and automated flow routing?', 'read', ('2026-09-13T14:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.', 'delivered', '2026-09-13T14:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        

        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+528181232001';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = 'Negotiation';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, 'Monterrey Heavy Industries - Quarterly Expansion License', 24000, 'USD', 'open', 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf', '2026-09-13T14:37:03.753683+00:00', '2026-09-13T14:37:03.753683+00:00')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Hannah Abbott', 'hannah@bostonrobotics.io', '+16175552009', 'Boston Robotics Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Hannah%20Abbott', '2026-09-27T19:37:03.753683+00:00', '2026-09-27T19:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-27T19:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+16175552009'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Follow Up'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as VP Strategy at Boston Robotics Group. Key interest in automated workflows and WhatsApp marketing.', '2026-09-27T19:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+16175552009'
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Rohan Deshmukh', 'rohan@punesoftwarehub.in', '+919820055010', 'Pune Software Hub', 'https://api.dicebear.com/7.x/initials/svg?seed=Rohan%20Deshmukh', '2026-09-13T08:37:03.753683+00:00', '2026-09-13T08:37:03.753683+00:00')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    

        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '2026-09-13T08:37:03.753683+00:00'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055010'
          AND t.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND t.name = 'Inbound'
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', 'Lead identified as Chief Product Officer at Pune Software Hub. Key interest in automated workflows and WhatsApp marketing.', '2026-09-13T08:37:03.753683+00:00'
    FROM public.contacts c
    WHERE c.account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND c.phone = '+919820055010'
    ON CONFLICT DO NOTHING;
    

        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef' AND phone = '+919820055010';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '89e3156b-6316-43e1-b8dc-220d5586d31e', '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef', v_contact_id, 'open', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', '2026-09-13T08:37:03.753683+00:00', 1, '2026-09-13T08:37:03.753683+00:00', '2026-09-13T08:37:03.753683+00:00')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', 'Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching.', 'read', ('2026-09-13T08:37:03.753683+00:00'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', 'Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?', 'delivered', '2026-09-13T08:37:03.753683+00:00'::timestamptz);
            END IF;
          END IF;
        END $$;
        