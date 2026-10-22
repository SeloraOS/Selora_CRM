-- ===========================================================================
-- SEED SCRIPT FOR demo1@seloraos.online
-- Account: 534a5418-feb0-44c0-8eab-ddd22ec07ff1 | User: f12e3f6d-2986-41a0-bcae-73faef70e41d
-- ===========================================================================
BEGIN;


UPDATE public.profiles
SET full_name = 'Demo Admin', avatar_url = 'https://api.dicebear.com/7.x/initials/svg?seed=Demo%20Admin', updated_at = NOW()
WHERE id = 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8' AND (full_name IS NULL OR full_name = '');


INSERT INTO public.pipelines (id, user_id, account_id, name, created_at)
VALUES 
  ('f5a0c73e-d359-40e6-a19b-a589a81c589d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Enterprise Sales Pipeline', NOW() - INTERVAL '40 days'),
  ('4afe4e07-8680-4f1e-8742-28902a512d7b', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Strategic Partnerships', NOW() - INTERVAL '35 days')
ON CONFLICT DO NOTHING;


    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('f1b95c66-4df7-4799-9df8-d83556a7303b', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'New Lead', 0, '#64748b', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('cf8c23a8-444c-4891-9733-f10ad2f291f5', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'Qualified', 1, '#3b82f6', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'Demo / Meeting', 2, '#8b5cf6', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('831d5cf3-45a1-4b68-ae77-ae984f8edc67', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'Proposal Sent', 3, '#f59e0b', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('67182e5d-b9c5-4cce-8153-c779f3104797', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'Negotiation', 4, '#06b6d4', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('a2215588-0b2d-44c0-92b5-e479b6ce413e', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'Closed Won', 5, '#22c55e', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('3233438d-9b85-4047-b2ab-303dfe27bc63', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'Closed Lost', 6, '#ef4444', NOW() - INTERVAL '40 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('2b36720d-47ba-45d3-8d07-e652bb20f8f1', '4afe4e07-8680-4f1e-8742-28902a512d7b', 'Prospect', 0, '#64748b', NOW() - INTERVAL '35 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('23036ca6-a117-4ea9-b945-cebad0d56831', '4afe4e07-8680-4f1e-8742-28902a512d7b', 'Initial Call', 1, '#3b82f6', NOW() - INTERVAL '35 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('2b52db24-fb73-477c-a66c-01e077d0783a', '4afe4e07-8680-4f1e-8742-28902a512d7b', 'Agreement Review', 2, '#f59e0b', NOW() - INTERVAL '35 days');
    

    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('4b1eef5c-e2ae-4b2d-b04e-cf8dfcdad76f', '4afe4e07-8680-4f1e-8742-28902a512d7b', 'Signed Partner', 3, '#22c55e', NOW() - INTERVAL '35 days');
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'VIP', '#ef4444', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('da7d3d0e-2f05-428d-86c0-2ccd30b62912', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Hot Lead', '#f97316', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('73b9864a-fb5e-4013-81ae-716954e05fa1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Enterprise', '#8b5cf6', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('f14a45e9-e9aa-431e-8fbd-298bb81b01be', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Wholesale', '#06b6d4', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('bffa4ac4-a54f-4103-ac9d-c841869d6b27', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow Up', '#eab308', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('d5376668-4040-418a-b4ba-facd459da7fe', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Inbound', '#10b981', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('c14f10a3-f703-4593-87cb-f03b621f3d24', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Demo Requested', '#3b82f6', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('ad581d2e-a057-4ccb-aeb6-f6f324d52992', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Pricing Inquiry', '#ec4899', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('7e6acec0-3bc4-4d88-9136-9907381d367e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'High Intent', '#6366f1', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('fa319af6-049d-4bac-b2aa-db95924662b8', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Decision Maker', '#14b8a6', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('afab9833-3bad-4172-b4d1-b275b6755cd7', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', 'Welcome Greeting', 'text', 'Hello! Thanks for reaching out to Selora. How can our sales or technical support team assist you today?', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('80fd44a4-8904-451d-b09c-aa5964506f62', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', 'Schedule Live Demo', 'text', 'We''d love to show you a live walkthrough! You can pick a convenient time on our calendar here: https://seloraos.online/demo', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('ec34f48a-dc88-4374-9d70-8c048920ab13', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', 'Enterprise Pricing Overview', 'text', 'Our Enterprise tier includes unlimited agents, priority Cloud API throughput, custom webhook automations, and a dedicated SLA. Would you like a custom quote?', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('fc47cc0a-c9c1-4826-a043-4d3a9ab44ea4', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', 'Meta Cloud API Setup', 'text', 'To link your official WhatsApp Business number, navigate to Settings > WhatsApp Config and follow our 3-step Meta embedded signup wizard.', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('0403792c-16b6-44a1-a818-62c47719317c', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', 'API Documentation', 'text', 'You can explore our developer API documentation and webhook specifications at https://docs.seloraos.online/api', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('67d79a8d-cf75-4b9c-8433-e755242bb60f', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', 'After Hours Response', 'text', 'Thank you for contacting us! Our team is currently offline, but we have logged your inquiry and will reply promptly first thing tomorrow morning.', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.message_templates (id, user_id, account_id, name, category, language, header_type, body_text, status, created_at, updated_at)
    VALUES ('c89a7fb6-5270-42a7-9243-e91f48bd6825', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'welcome_enterprise', 'Marketing', 'en_US', 'text', 'Welcome to Selora, {{1}}! We''re thrilled to have {{2}} onboard. Let us know if you have any questions.', 'APPROVED', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.message_templates (id, user_id, account_id, name, category, language, header_type, body_text, status, created_at, updated_at)
    VALUES ('df2d803e-dd32-4a50-9406-65729cc1301d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'meeting_confirmation', 'Utility', 'en_US', 'text', 'Hi {{1}}, this is a confirmation for our scheduled meeting on {{2}} at {{3}}. Reply YES to confirm.', 'APPROVED', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.message_templates (id, user_id, account_id, name, category, language, header_type, body_text, status, created_at, updated_at)
    VALUES ('58edc49b-8f24-4fa0-8163-233cffd699e8', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'deal_proposal_update', 'Marketing', 'en_US', 'text', 'Hello {{1}}, your customized proposal for {{2}} is ready for review. Access your quote here: {{3}}', 'APPROVED', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.message_templates (id, user_id, account_id, name, category, language, header_type, body_text, status, created_at, updated_at)
    VALUES ('6f686e91-d012-49f1-b906-3a760b486f37', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'renewal_reminder', 'Utility', 'en_US', 'text', 'Hi {{1}}, your Selora CRM subscription for {{2}} will renew on {{3}}. Please verify your billing details.', 'APPROVED', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days')
    ON CONFLICT DO NOTHING;
    

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('7404eeac-d1fa-4f7b-be77-948b307aa10f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Alexander Wright', 'alex.wright@apexgroup.io', '+14155552101', 'Apex Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Alexander%20Wright', '2026-10-03T14:31:49.992896+00:00', '2026-10-03T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('14c7a920-47f0-48ba-aa68-b59272c70440', '7404eeac-d1fa-4f7b-be77-948b307aa10f', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-10-03T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('2705fb99-dcb6-4918-9c23-b8d35901ad14', '7404eeac-d1fa-4f7b-be77-948b307aa10f', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-10-03T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('186bea99-2842-43d9-9de7-586ef9d9a7d5', '7404eeac-d1fa-4f7b-be77-948b307aa10f', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-10-03T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('de1c8c9f-2c08-4e88-a0d1-e0ec6442bd48', '7404eeac-d1fa-4f7b-be77-948b307aa10f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Apex Group.', '2026-10-03T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('c2009626-5e3f-480b-9434-2c12dbdfa980', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '7404eeac-d1fa-4f7b-be77-948b307aa10f', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-10-11T03:31:49.992896+00:00', 1, '2026-10-11T03:31:49.992896+00:00', '2026-10-11T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('3d59b212-6a46-478e-9e86-3bf61cc61e3f', 'c2009626-5e3f-480b-9434-2c12dbdfa980', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-10-11T03:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('079073e2-0030-41d9-bd7e-455ff8c300d0', 'c2009626-5e3f-480b-9434-2c12dbdfa980', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-10-11T03:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('5a464205-ed87-4f59-8623-996d4ebe26dd', 'c2009626-5e3f-480b-9434-2c12dbdfa980', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-10-11T03:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('bfbc27e2-920f-4c18-9612-776667706615', 'c2009626-5e3f-480b-9434-2c12dbdfa980', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'delivered', '2026-10-11T04:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('fbf13173-0199-47fd-9f0f-7dd03d53c539', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Sophia Martinez', 'smartinez@nexoratech.com', '+14155552102', 'Nexora Tech', 'https://api.dicebear.com/7.x/initials/svg?seed=Sophia%20Martinez', '2026-09-13T13:31:49.992896+00:00', '2026-09-13T13:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('62998aff-4884-4b65-9c1f-cdddf788e55b', 'fbf13173-0199-47fd-9f0f-7dd03d53c539', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-13T13:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('e2a0b647-0063-40b1-a693-57ccd7171df8', 'fbf13173-0199-47fd-9f0f-7dd03d53c539', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Nexora Tech.', '2026-09-13T13:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('0cf19c42-77c8-4cd7-956b-d96c58b739d2', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'fbf13173-0199-47fd-9f0f-7dd03d53c539', 'open', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-10-11T05:31:49.992896+00:00', 1, '2026-10-11T05:31:49.992896+00:00', '2026-10-11T05:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('38f8d69f-0f0a-4cfb-8db0-600d1b711d5d', '0cf19c42-77c8-4cd7-956b-d96c58b739d2', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-10-11T05:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6677a912-ba63-4cb1-a85f-f0a169a6b1c5', '0cf19c42-77c8-4cd7-956b-d96c58b739d2', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-10-11T05:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('87bc40a8-a306-4042-8b6b-21dd4c8e10aa', '0cf19c42-77c8-4cd7-956b-d96c58b739d2', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-10-11T05:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1a4e982a-b56b-4f34-90ca-0a9e01c583d9', '0cf19c42-77c8-4cd7-956b-d96c58b739d2', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'delivered', '2026-10-11T06:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('bb6ea873-41a7-4a22-9b6b-f4398e5fc997', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', 'fbf13173-0199-47fd-9f0f-7dd03d53c539', '0cf19c42-77c8-4cd7-956b-d96c58b739d2', 'Nexora Tech — API & Webhook Custom Integration Tier', 78000, 'USD', 'open', 'Primary contact: Sophia Martinez (+14155552102). Target rollout across SaaS operations.', '2026-11-11', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-13T13:31:49.992896+00:00', '2026-09-13T13:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('40aa3cba-d1a2-4712-80be-95ed3111fc2e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Liam O''Connor', 'liam@vanguardlogistics.co', '+442079462103', 'Vanguard Logistics', 'https://api.dicebear.com/7.x/initials/svg?seed=Liam%20O%27Connor', '2026-09-26T00:31:49.992896+00:00', '2026-09-26T00:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('9628e76f-11c0-436d-a368-1731bfbe56f5', '40aa3cba-d1a2-4712-80be-95ed3111fc2e', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-26T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('bfcffa6a-a6e8-4835-b507-8b293ac844df', '40aa3cba-d1a2-4712-80be-95ed3111fc2e', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-09-26T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('148dc409-2abc-48a7-b006-e6b94c936f25', '40aa3cba-d1a2-4712-80be-95ed3111fc2e', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-26T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('3bf0d188-35ab-4b56-bfea-204192185572', '40aa3cba-d1a2-4712-80be-95ed3111fc2e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-09-26T00:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('dc44ed1c-9463-48ea-addd-f7c064f90080', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '40aa3cba-d1a2-4712-80be-95ed3111fc2e', 'open', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', '2026-10-11T09:31:49.992896+00:00', 1, '2026-10-11T09:31:49.992896+00:00', '2026-10-11T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('bf603326-c27d-4d0d-912f-6649d081f8fa', 'dc44ed1c-9463-48ea-addd-f7c064f90080', 'customer', 'text', 'Good day, we need to broadcast promotional catalogs to 20,000 opt-in customer numbers next week. What are the rate limits?', 'read', '2026-10-11T09:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d88305ce-6e43-4a88-962c-97533c108e4d', 'dc44ed1c-9463-48ea-addd-f7c064f90080', 'agent', 'text', 'Hello! With Meta Cloud API Tier 2 & 3 integrations, Selora easily processes 1,000+ messages per minute with rate limiting and retry queues handled automatically.', 'read', '2026-10-11T09:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('3479f3d3-4017-4d63-b3f6-193805b7944d', 'dc44ed1c-9463-48ea-addd-f7c064f90080', 'customer', 'text', 'Understood, that fits our requirements. What templates do we need approved by Meta?', 'read', '2026-10-11T09:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('5c12b32b-1180-4d36-98ea-dd6d85f40252', 'dc44ed1c-9463-48ea-addd-f7c064f90080', 'agent', 'text', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', 'delivered', '2026-10-11T10:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('31c4c55d-dbbc-4075-852c-18a62da7e74d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'cf8c23a8-444c-4891-9733-f10ad2f291f5', '40aa3cba-d1a2-4712-80be-95ed3111fc2e', 'dc44ed1c-9463-48ea-addd-f7c064f90080', 'Vanguard Logistics — Global Messaging Expansion Plan', 5400, 'USD', 'open', 'Primary contact: Liam O''Connor (+442079462103). Target rollout across Logistics operations.', '2026-10-21', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-26T00:31:49.992896+00:00', '2026-09-26T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('cf523521-a697-4d81-a542-4dbaf66155a3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Elena Rostova', 'elena@quantumdynamic.de', '+493090182104', 'Quantum Dynamics', 'https://api.dicebear.com/7.x/initials/svg?seed=Elena%20Rostova', '2026-09-16T11:31:49.992896+00:00', '2026-09-16T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('d1b09c89-0ab4-40f6-8b8d-d4fbb5b5cb90', 'cf523521-a697-4d81-a542-4dbaf66155a3', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-09-16T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('c8eab0f3-2bad-4de8-bacd-c0212e709042', 'cf523521-a697-4d81-a542-4dbaf66155a3', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-16T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('f89c93b8-23d5-44c7-bd8f-6ad9e35d3e8e', 'cf523521-a697-4d81-a542-4dbaf66155a3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Head of Procurement. Company operating in Manufacturing space.', '2026-09-16T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('70f78d79-41ad-4708-8146-7a1161848d9c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'a2215588-0b2d-44c0-92b5-e479b6ce413e', 'cf523521-a697-4d81-a542-4dbaf66155a3', NULL, 'Quantum Dynamics — Annual Enterprise Renewal & SLA', 78000, 'USD', 'won', 'Primary contact: Elena Rostova (+493090182104). Target rollout across Manufacturing operations.', '2026-10-23', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-16T11:31:49.992896+00:00', '2026-09-16T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('6eab5fb3-a01a-466e-8147-32c8ab497bc1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Rahul Sharma', 'rahul.sharma@luminahealth.in', '+919820052105', 'Lumina Health', 'https://api.dicebear.com/7.x/initials/svg?seed=Rahul%20Sharma', '2026-09-16T12:31:49.992896+00:00', '2026-09-16T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('7a1ba308-41e9-4dc6-883c-b2fddcbfd36d', '6eab5fb3-a01a-466e-8147-32c8ab497bc1', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-16T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('7d7375d6-a9f0-492a-8ef7-d0c5b0cd393c', '6eab5fb3-a01a-466e-8147-32c8ab497bc1', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-09-16T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('364628c5-55df-4ed4-a6e6-9295390090da', '6eab5fb3-a01a-466e-8147-32c8ab497bc1', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-16T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('947cdcf1-f172-47b4-9026-7bb93dae6aa9', '6eab5fb3-a01a-466e-8147-32c8ab497bc1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Managing Director. Company operating in Healthcare space.', '2026-09-16T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('16ad202d-f040-4fd2-ae77-757970a3208a', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '6eab5fb3-a01a-466e-8147-32c8ab497bc1', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-10-11T03:31:49.992896+00:00', 1, '2026-10-11T03:31:49.992896+00:00', '2026-10-11T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('94068a40-84c5-46d8-b5be-55d9af57a360', '16ad202d-f040-4fd2-ae77-757970a3208a', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-10-11T03:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b9b32b19-7344-4a92-b94c-693280e70338', '16ad202d-f040-4fd2-ae77-757970a3208a', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-10-11T03:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('a71125f6-5aae-40d8-b283-26ab10cc9088', '16ad202d-f040-4fd2-ae77-757970a3208a', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-10-11T03:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('ef44c6f3-db0f-45ee-ac6a-031e4a82f1ae', '16ad202d-f040-4fd2-ae77-757970a3208a', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'delivered', '2026-10-11T04:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('1617cd33-99c0-4186-b421-f3bd74d8e1cb', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Chloe Dupont', 'c.dupont@bluepeakcap.fr', '+33140052106', 'BluePeak Capital', 'https://api.dicebear.com/7.x/initials/svg?seed=Chloe%20Dupont', '2026-09-22T12:31:49.992896+00:00', '2026-09-22T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('99dc4dd7-582e-47e5-8e10-d4bc230dfabb', '1617cd33-99c0-4186-b421-f3bd74d8e1cb', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-22T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('2213949f-5a46-4d89-870b-ea7131c86064', '1617cd33-99c0-4186-b421-f3bd74d8e1cb', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-09-22T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('635330a9-817d-4725-970c-a2320e25e75b', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '1617cd33-99c0-4186-b421-f3bd74d8e1cb', 'open', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', '2026-10-11T06:31:49.992896+00:00', 2, '2026-10-11T06:31:49.992896+00:00', '2026-10-11T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('19f84918-7102-4e6a-9a09-847deccb7805', '635330a9-817d-4725-970c-a2320e25e75b', 'customer', 'text', 'Good day, we need to broadcast promotional catalogs to 20,000 opt-in customer numbers next week. What are the rate limits?', 'read', '2026-10-11T06:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('38fafb7b-10b2-4244-9ede-b8a492fd0146', '635330a9-817d-4725-970c-a2320e25e75b', 'agent', 'text', 'Hello! With Meta Cloud API Tier 2 & 3 integrations, Selora easily processes 1,000+ messages per minute with rate limiting and retry queues handled automatically.', 'read', '2026-10-11T06:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('3c268e3e-f0c0-404d-a386-b063f9f732e8', '635330a9-817d-4725-970c-a2320e25e75b', 'customer', 'text', 'Understood, that fits our requirements. What templates do we need approved by Meta?', 'read', '2026-10-11T06:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('8b5411c4-77ea-4af1-b222-66c289396b30', '635330a9-817d-4725-970c-a2320e25e75b', 'agent', 'text', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', 'delivered', '2026-10-11T07:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('6a2d3c30-8160-4aa2-a856-f19f2c7e3587', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '23036ca6-a117-4ea9-b945-cebad0d56831', '1617cd33-99c0-4186-b421-f3bd74d8e1cb', '635330a9-817d-4725-970c-a2320e25e75b', 'BluePeak Capital — Global Messaging Expansion Plan', 26000, 'USD', 'open', 'Primary contact: Chloe Dupont (+33140052106). Target rollout across Venture Capital operations.', '2026-10-29', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-22T12:31:49.992896+00:00', '2026-09-22T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('771cb1f0-025d-4068-9c2f-5280ee18ef93', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Marcus Vance', 'marcus@starlightmedia.com', '+12125552107', 'Starlight Media', 'https://api.dicebear.com/7.x/initials/svg?seed=Marcus%20Vance', '2026-09-22T16:31:49.992896+00:00', '2026-09-22T16:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('5eae3c61-19bb-4680-b959-db79aac0978e', '771cb1f0-025d-4068-9c2f-5280ee18ef93', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-22T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('2b9fae26-b59d-4478-80ea-7c7df275afd9', '771cb1f0-025d-4068-9c2f-5280ee18ef93', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-22T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('b672261f-22c4-4b99-a7f0-2f153f94d5a3', '771cb1f0-025d-4068-9c2f-5280ee18ef93', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-22T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('8e7c4936-a25e-4aad-bcc0-2fdb77e86e80', '771cb1f0-025d-4068-9c2f-5280ee18ef93', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Starlight Media.', '2026-09-22T16:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('192a2254-4db5-4c22-a104-31b01ce9560c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '771cb1f0-025d-4068-9c2f-5280ee18ef93', 'closed', 'Great! Let us know if your developers have any questions.', '2026-09-22T16:31:49.992896+00:00', 0, '2026-09-22T16:31:49.992896+00:00', '2026-09-22T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('730b8d9f-0745-4259-9085-575ccfc76a63', '192a2254-4db5-4c22-a104-31b01ce9560c', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-22T16:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('084aa3ec-2519-4889-96ba-4a21ecd7cf41', '192a2254-4db5-4c22-a104-31b01ce9560c', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-22T16:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f11c80f0-a87b-4406-8144-f68374537feb', '192a2254-4db5-4c22-a104-31b01ce9560c', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-22T16:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d2c9dcb5-304d-40a1-ab0d-dd7d3f0d06a9', '192a2254-4db5-4c22-a104-31b01ce9560c', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-22T17:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('4212e2d4-0e65-4138-831d-46555d749972', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', '771cb1f0-025d-4068-9c2f-5280ee18ef93', '192a2254-4db5-4c22-a104-31b01ce9560c', 'Starlight Media — API & Webhook Custom Integration Tier', 26000, 'USD', 'open', 'Primary contact: Marcus Vance (+12125552107). Target rollout across Media operations.', '2026-12-08', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-22T16:31:49.992896+00:00', '2026-09-22T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('29dd82ad-7952-4128-b8b9-d5623aa0c2cb', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Olivia Chen', 'olivia@horizonretail.sg', '+6567892108', 'Horizon Retail', 'https://api.dicebear.com/7.x/initials/svg?seed=Olivia%20Chen', '2026-10-07T07:31:49.992896+00:00', '2026-10-07T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('b7e7ee48-c4cf-4fdf-b0ef-44f7c34e5bb8', '29dd82ad-7952-4128-b8b9-d5623aa0c2cb', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-10-07T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('663c15de-3902-4222-9a00-9203c8fc32d8', '29dd82ad-7952-4128-b8b9-d5623aa0c2cb', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-10-07T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('2d3d2afd-90e5-49ba-b362-4ec8213811be', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', '29dd82ad-7952-4128-b8b9-d5623aa0c2cb', NULL, 'Horizon Retail — Growth Multi-Agent Plan', 12500, 'USD', 'open', 'Primary contact: Olivia Chen (+6567892108). Target rollout across Retail operations.', '2026-11-21', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-07T07:31:49.992896+00:00', '2026-10-07T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('42475b72-faa9-4844-893d-50936d23cdf1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Lucas Silva', 'lucas@solarisenergy.br', '+551198762109', 'Solaris Energy', 'https://api.dicebear.com/7.x/initials/svg?seed=Lucas%20Silva', '2026-09-20T08:31:49.992896+00:00', '2026-09-20T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('0b07db5b-c704-41ce-9c77-88c29e94df5c', '42475b72-faa9-4844-893d-50936d23cdf1', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-20T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('1c080dc2-975c-48b2-80c7-22e283e0fe29', '42475b72-faa9-4844-893d-50936d23cdf1', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-20T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('a38587f2-242f-43af-b0d9-2e5054507e9c', '42475b72-faa9-4844-893d-50936d23cdf1', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-09-20T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('6ae62701-57cc-4a44-aeb0-cae481f9ba0f', '42475b72-faa9-4844-893d-50936d23cdf1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Solaris Energy.', '2026-09-20T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('02442d66-e48a-42c8-90d8-7b111618a39f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '42475b72-faa9-4844-893d-50936d23cdf1', 'open', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', '2026-09-20T08:31:49.992896+00:00', 0, '2026-09-20T08:31:49.992896+00:00', '2026-09-20T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b9e9e6af-dbba-49b8-9ef1-d63abd99f025', '02442d66-e48a-42c8-90d8-7b111618a39f', 'customer', 'text', 'Good day, we need to broadcast promotional catalogs to 20,000 opt-in customer numbers next week. What are the rate limits?', 'read', '2026-09-20T08:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('3439624a-7c01-4537-b8d1-8e2349bd6035', '02442d66-e48a-42c8-90d8-7b111618a39f', 'agent', 'text', 'Hello! With Meta Cloud API Tier 2 & 3 integrations, Selora easily processes 1,000+ messages per minute with rate limiting and retry queues handled automatically.', 'read', '2026-09-20T08:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('e402649b-7e76-47db-94e2-aee51695be40', '02442d66-e48a-42c8-90d8-7b111618a39f', 'customer', 'text', 'Understood, that fits our requirements. What templates do we need approved by Meta?', 'read', '2026-09-20T08:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('9e6979dd-6a8d-462c-9fda-8f02afe6d494', '02442d66-e48a-42c8-90d8-7b111618a39f', 'agent', 'text', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', 'read', '2026-09-20T09:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('5b236abe-bb33-4ee5-a419-45b143ead466', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Aisha Al-Mansoor', 'aisha@gulfventures.ae', '+97143122110', 'Gulf Ventures', 'https://api.dicebear.com/7.x/initials/svg?seed=Aisha%20Al-Mansoor', '2026-09-24T21:31:49.992896+00:00', '2026-09-24T21:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e240a641-fab8-4b61-aa85-63f9fc36e79c', '5b236abe-bb33-4ee5-a419-45b143ead466', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-24T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('df5ffe0c-0dec-416e-9497-36e234725325', '5b236abe-bb33-4ee5-a419-45b143ead466', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-24T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e27dcd74-6098-48ca-9e12-64dce9785e0f', '5b236abe-bb33-4ee5-a419-45b143ead466', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-24T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('197554cd-7f19-43ab-9b1f-7c2faefc3c84', '5b236abe-bb33-4ee5-a419-45b143ead466', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-24T21:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('1e23eda8-c4b0-467e-aca6-22baa5c4e781', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '5b236abe-bb33-4ee5-a419-45b143ead466', 'open', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-24T21:31:49.992896+00:00', 0, '2026-09-24T21:31:49.992896+00:00', '2026-09-24T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1161ac0a-5531-43df-b11e-a2f8265d46d0', '1e23eda8-c4b0-467e-aca6-22baa5c4e781', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-24T21:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('579b0bbb-7c7b-4965-ae7c-bf6c7a8c9dc7', '1e23eda8-c4b0-467e-aca6-22baa5c4e781', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-24T21:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fa67769b-1be4-48a0-8cc3-cf483d48c48a', '1e23eda8-c4b0-467e-aca6-22baa5c4e781', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-24T21:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('296b72d0-e652-4144-a741-23be634dfca4', '1e23eda8-c4b0-467e-aca6-22baa5c4e781', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-24T22:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('8232c595-d7cf-4790-a87c-764a7b220c60', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', '5b236abe-bb33-4ee5-a419-45b143ead466', '1e23eda8-c4b0-467e-aca6-22baa5c4e781', 'Gulf Ventures — Annual Enterprise Renewal & SLA', 5400, 'USD', 'open', 'Primary contact: Aisha Al-Mansoor (+97143122110). Target rollout across Finance operations.', '2026-12-03', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-24T21:31:49.992896+00:00', '2026-09-24T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('de72b695-535e-440b-beb6-cf98412a90c0', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'David Kim', 'dkim@seoulautomations.kr', '+8225552111', 'Seoul Automations', 'https://api.dicebear.com/7.x/initials/svg?seed=David%20Kim', '2026-10-07T11:31:49.992896+00:00', '2026-10-07T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('becce047-9e5f-47ab-aa02-d394af597017', 'de72b695-535e-440b-beb6-cf98412a90c0', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-10-07T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('bf75a867-8597-41f4-be05-265a32856dd2', 'de72b695-535e-440b-beb6-cf98412a90c0', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-10-07T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('38d14dd8-ae01-46c8-a3f7-0b242c6f80fa', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'de72b695-535e-440b-beb6-cf98412a90c0', 'open', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', '2026-10-07T11:31:49.992896+00:00', 0, '2026-10-07T11:31:49.992896+00:00', '2026-10-07T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('7e216198-1fdf-48cb-ae31-227f07948b39', '38d14dd8-ae01-46c8-a3f7-0b242c6f80fa', 'customer', 'text', 'Hey! We are migrating from a legacy WhatsApp web wrapper. Will our team lose existing chat history?', 'read', '2026-10-07T11:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0393fe56-057c-4c75-afcc-7d70e4bb72e8', '38d14dd8-ae01-46c8-a3f7-0b242c6f80fa', 'agent', 'text', 'Hi! Migration is seamless — you can export your contacts via CSV into Selora and connect your WhatsApp Business Account. We also offer automated migration assistance.', 'read', '2026-10-07T11:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f0c9c9fb-36cb-4dd0-b6a1-2bc0e2af4cd9', '38d14dd8-ae01-46c8-a3f7-0b242c6f80fa', 'customer', 'text', 'That''s a huge relief. Who will be our point of contact?', 'read', '2026-10-07T11:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('797bb288-9d2b-44ad-9dbc-fb99b5af7a9c', '38d14dd8-ae01-46c8-a3f7-0b242c6f80fa', 'agent', 'text', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', 'read', '2026-10-07T12:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('6cb5bc82-15bb-4e4c-b69c-2a09189c77a8', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '4b1eef5c-e2ae-4b2d-b04e-cf8dfcdad76f', 'de72b695-535e-440b-beb6-cf98412a90c0', '38d14dd8-ae01-46c8-a3f7-0b242c6f80fa', 'Seoul Automations — Standard Team Onboarding & 1-Year License', 95000, 'USD', 'won', 'Primary contact: David Kim (+8225552111). Target rollout across Robotics operations.', '2026-11-14', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-07T11:31:49.992896+00:00', '2026-10-07T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('83e6403c-2234-4b83-a6be-f4b5c2549729', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Emma Watson-Bell', 'emma@crestviewconsulting.co.uk', '+442079462112', 'Crestview Consulting', 'https://api.dicebear.com/7.x/initials/svg?seed=Emma%20Watson-Bell', '2026-09-07T06:31:49.992896+00:00', '2026-09-07T06:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('b8157de8-84ce-469f-974a-bbd1a23c2423', '83e6403c-2234-4b83-a6be-f4b5c2549729', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-09-07T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4e21e1ea-a446-46a4-861f-d0334e562337', '83e6403c-2234-4b83-a6be-f4b5c2549729', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-07T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4da35158-fa6a-437e-a268-ccf2efaa6924', '83e6403c-2234-4b83-a6be-f4b5c2549729', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-07T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('cb718011-099a-4988-b4d7-553b73e79466', '83e6403c-2234-4b83-a6be-f4b5c2549729', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-07T06:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('d76bbf5f-a653-4a72-ba02-1544968f1091', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'f1b95c66-4df7-4799-9df8-d83556a7303b', '83e6403c-2234-4b83-a6be-f4b5c2549729', NULL, 'Crestview Consulting — Multi-Branch CRM License Rollout', 39000, 'USD', 'open', 'Primary contact: Emma Watson-Bell (+442079462112). Target rollout across Consulting operations.', '2026-10-26', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-07T06:31:49.992896+00:00', '2026-09-07T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('a6aff72e-81dd-4196-8a82-0eeb5de80b83', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Mateo Fernandez', 'mateo@iberiapharma.es', '+34912342113', 'Iberia Pharma', 'https://api.dicebear.com/7.x/initials/svg?seed=Mateo%20Fernandez', '2026-09-11T14:31:49.992896+00:00', '2026-09-11T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('a0fa9129-e82f-47fc-b466-3b96a8f0e782', 'a6aff72e-81dd-4196-8a82-0eeb5de80b83', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-11T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('d72bdc0d-e45a-4a8d-98d9-358eb95c95c2', 'a6aff72e-81dd-4196-8a82-0eeb5de80b83', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-11T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('1a3e431a-ef77-4c86-a05b-26b257c6ebb1', 'a6aff72e-81dd-4196-8a82-0eeb5de80b83', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-11T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('f2032f1c-f60e-41ef-8136-169c2a10dc14', 'a6aff72e-81dd-4196-8a82-0eeb5de80b83', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-11T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('4a2077c4-1d2d-4a65-a769-c20cbd38ce42', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'a6aff72e-81dd-4196-8a82-0eeb5de80b83', 'pending', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-11T14:31:49.992896+00:00', 0, '2026-09-11T14:31:49.992896+00:00', '2026-09-11T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0fe17328-0edd-4faf-8f3e-34c699d36278', '4a2077c4-1d2d-4a65-a769-c20cbd38ce42', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-11T14:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0bec48c7-1c9c-4998-b0ca-d32fd6a792b9', '4a2077c4-1d2d-4a65-a769-c20cbd38ce42', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-11T14:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('473cd602-d046-4d7e-b7e7-61d9ead53699', '4a2077c4-1d2d-4a65-a769-c20cbd38ce42', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-11T14:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('7d29c008-6ba5-413a-9775-634914ecfa2d', '4a2077c4-1d2d-4a65-a769-c20cbd38ce42', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-11T15:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('25ed3e43-0c4e-45f6-9619-71a851e68a5e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Fatima Zahra', 'fzahra@casablancagroup.ma', '+212522552114', 'Casablanca Exports', 'https://api.dicebear.com/7.x/initials/svg?seed=Fatima%20Zahra', '2026-09-07T19:31:49.992896+00:00', '2026-09-07T19:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('ce0dbe0a-ab39-4ce1-9c17-1b1c8548d409', '25ed3e43-0c4e-45f6-9619-71a851e68a5e', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-07T19:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('0883c665-456d-40e1-87f2-2e589aeee457', '25ed3e43-0c4e-45f6-9619-71a851e68a5e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-07T19:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('813d93ac-4708-4d59-8a53-29d692e8a81b', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '25ed3e43-0c4e-45f6-9619-71a851e68a5e', 'open', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-07T19:31:49.992896+00:00', 0, '2026-09-07T19:31:49.992896+00:00', '2026-09-07T19:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('991bb9d6-f4ea-4339-9604-6f196ffa8a42', '813d93ac-4708-4d59-8a53-29d692e8a81b', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-07T19:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0bdc50c1-8053-4a51-983b-64467b1ab9f7', '813d93ac-4708-4d59-8a53-29d692e8a81b', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-07T19:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('9f6d5b59-1283-4687-bd4e-1935526cbba0', '813d93ac-4708-4d59-8a53-29d692e8a81b', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-07T19:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('4104114c-7e8d-43d6-afa8-75db4d73d890', '813d93ac-4708-4d59-8a53-29d692e8a81b', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-07T20:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('8c717d9b-4869-42d1-bc7f-450a5edef2c5', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', '25ed3e43-0c4e-45f6-9619-71a851e68a5e', '813d93ac-4708-4d59-8a53-29d692e8a81b', 'Casablanca Exports — Global Messaging Expansion Plan', 55000, 'USD', 'open', 'Primary contact: Fatima Zahra (+212522552114). Target rollout across Import/Export operations.', '2026-10-17', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-07T19:31:49.992896+00:00', '2026-09-07T19:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('3e8eae9d-3949-43b8-9b24-1b95c5c48513', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Noah Lindqvist', 'noah@nordiccloud.se', '+46812342115', 'Nordic Cloud Labs', 'https://api.dicebear.com/7.x/initials/svg?seed=Noah%20Lindqvist', '2026-10-03T03:31:49.992896+00:00', '2026-10-03T03:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4cbdfe72-f9ec-4129-b632-0b1e1f093a20', '3e8eae9d-3949-43b8-9b24-1b95c5c48513', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-10-03T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e3e1c926-8360-43f2-bea0-623ddf91b327', '3e8eae9d-3949-43b8-9b24-1b95c5c48513', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-10-03T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('016cb24c-de7c-4d39-b57f-99b4b2152419', '3e8eae9d-3949-43b8-9b24-1b95c5c48513', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Nordic Cloud Labs.', '2026-10-03T03:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('295a7fad-2e45-4c3e-a712-4bcbad729e6d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '3e8eae9d-3949-43b8-9b24-1b95c5c48513', 'open', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', '2026-10-03T03:31:49.992896+00:00', 0, '2026-10-03T03:31:49.992896+00:00', '2026-10-03T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('46bf11db-2cc4-4b25-ac75-a51f73995fcc', '295a7fad-2e45-4c3e-a712-4bcbad729e6d', 'customer', 'text', 'Hey! We are migrating from a legacy WhatsApp web wrapper. Will our team lose existing chat history?', 'read', '2026-10-03T03:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1845782f-d8fb-45e2-ba99-4744e9ef5239', '295a7fad-2e45-4c3e-a712-4bcbad729e6d', 'agent', 'text', 'Hi! Migration is seamless — you can export your contacts via CSV into Selora and connect your WhatsApp Business Account. We also offer automated migration assistance.', 'read', '2026-10-03T03:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('969f44ce-ea1a-4c3a-96df-01b9e746b801', '295a7fad-2e45-4c3e-a712-4bcbad729e6d', 'customer', 'text', 'That''s a huge relief. Who will be our point of contact?', 'read', '2026-10-03T03:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('7492b374-94bf-4bda-a28d-befee9908535', '295a7fad-2e45-4c3e-a712-4bcbad729e6d', 'agent', 'text', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', 'read', '2026-10-03T04:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('5add7a47-246c-4775-9d9e-de21bc97a2e7', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'f1b95c66-4df7-4799-9df8-d83556a7303b', '3e8eae9d-3949-43b8-9b24-1b95c5c48513', '295a7fad-2e45-4c3e-a712-4bcbad729e6d', 'Nordic Cloud Labs — Annual Enterprise Renewal & SLA', 5400, 'USD', 'open', 'Primary contact: Noah Lindqvist (+46812342115). Target rollout across Cloud & DevOps operations.', '2026-12-03', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-03T03:31:49.992896+00:00', '2026-10-03T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('453c8083-7be7-4b75-9541-c67634482b6a', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Grace Hopperly', 'grace@aerotechsys.com', '+16505552116', 'AeroTech Systems', 'https://api.dicebear.com/7.x/initials/svg?seed=Grace%20Hopperly', '2026-09-06T10:31:49.992896+00:00', '2026-09-06T10:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('fa2aacd8-ae1b-41b8-9eca-00b3c8451b64', '453c8083-7be7-4b75-9541-c67634482b6a', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-06T10:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('c0132f81-7763-4b11-b4b7-d4926b3aec21', '453c8083-7be7-4b75-9541-c67634482b6a', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-06T10:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('5c569bc5-9532-42cb-8eca-65c3bb7d1a6e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '23036ca6-a117-4ea9-b945-cebad0d56831', '453c8083-7be7-4b75-9541-c67634482b6a', NULL, 'AeroTech Systems — Multi-Branch CRM License Rollout', 78000, 'USD', 'open', 'Primary contact: Grace Hopperly (+16505552116). Target rollout across Aerospace operations.', '2026-12-10', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-06T10:31:49.992896+00:00', '2026-09-06T10:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('9519b47c-5cf0-4b6a-918f-d6801c8faa63', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Ravi Patel', 'ravi.patel@zenithenterprises.in', '+919820052117', 'Zenith Enterprises', 'https://api.dicebear.com/7.x/initials/svg?seed=Ravi%20Patel', '2026-09-13T08:31:49.992896+00:00', '2026-09-13T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('fdd2a6c0-1591-4bf4-afc9-c67888c9049d', '9519b47c-5cf0-4b6a-918f-d6801c8faa63', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-13T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('ec74f52f-8dd9-4c21-a3ec-3a02dc66c871', '9519b47c-5cf0-4b6a-918f-d6801c8faa63', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-13T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('bba185e8-2e9b-437d-8356-fc2c6208b426', '9519b47c-5cf0-4b6a-918f-d6801c8faa63', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-13T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('be1454f8-994d-467c-834b-9d5ecbed940e', '9519b47c-5cf0-4b6a-918f-d6801c8faa63', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-13T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('88e8f52a-c09d-4ce5-8d1e-bb1b1caac862', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '9519b47c-5cf0-4b6a-918f-d6801c8faa63', 'closed', 'Great! Let us know if your developers have any questions.', '2026-09-13T08:31:49.992896+00:00', 0, '2026-09-13T08:31:49.992896+00:00', '2026-09-13T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('19fe40c7-70c4-4f02-95a3-9a489c221ff2', '88e8f52a-c09d-4ce5-8d1e-bb1b1caac862', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-13T08:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('218e24fe-1aa5-4d6f-b43a-06adc8b6b4eb', '88e8f52a-c09d-4ce5-8d1e-bb1b1caac862', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-13T08:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0f84af2c-9f7d-4a02-9504-da4dd6b13132', '88e8f52a-c09d-4ce5-8d1e-bb1b1caac862', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-13T08:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0da9c594-cf31-4c9d-aea9-56a63b418b4a', '88e8f52a-c09d-4ce5-8d1e-bb1b1caac862', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-13T09:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('d9c97faa-a92b-44be-960a-ed96ce6db1f8', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Hanna Schmidt', 'h.schmidt@bavariagoods.de', '+498912342118', 'Bavaria Goods', 'https://api.dicebear.com/7.x/initials/svg?seed=Hanna%20Schmidt', '2026-10-03T07:31:49.992896+00:00', '2026-10-03T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('d7fcd90c-abf6-42fe-92e9-e491d2296879', 'd9c97faa-a92b-44be-960a-ed96ce6db1f8', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-10-03T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('c8713654-e288-4223-a378-7082dea66c0d', 'd9c97faa-a92b-44be-960a-ed96ce6db1f8', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-10-03T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('82fbcacc-36cc-4674-884c-4a9dd387baf8', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'd9c97faa-a92b-44be-960a-ed96ce6db1f8', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-10-03T07:31:49.992896+00:00', 0, '2026-10-03T07:31:49.992896+00:00', '2026-10-03T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('c897d85e-7508-4a70-8946-e1ffa39c3604', '82fbcacc-36cc-4674-884c-4a9dd387baf8', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-10-03T07:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f3e7acd6-9189-4ca6-b0b3-9bc5be9fce0e', '82fbcacc-36cc-4674-884c-4a9dd387baf8', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-10-03T07:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('204c31ad-8b18-4387-aad9-5e510a0df6b9', '82fbcacc-36cc-4674-884c-4a9dd387baf8', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-10-03T07:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0c7cd5b7-6631-4156-b086-622932d51f8e', '82fbcacc-36cc-4674-884c-4a9dd387baf8', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-10-03T08:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('cbb6af2c-2cc3-453a-bcf7-5faf67223275', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', 'd9c97faa-a92b-44be-960a-ed96ce6db1f8', '82fbcacc-36cc-4674-884c-4a9dd387baf8', 'Bavaria Goods — API & Webhook Custom Integration Tier', 3200, 'USD', 'open', 'Primary contact: Hanna Schmidt (+498912342118). Target rollout across Manufacturing operations.', '2026-10-20', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-03T07:31:49.992896+00:00', '2026-10-03T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('125c8e85-c02f-467b-9e3f-913014b6eb81', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Gabriel Santos', 'gabriel@paulistalog.com.br', '+551198762119', 'Paulista Logistics', 'https://api.dicebear.com/7.x/initials/svg?seed=Gabriel%20Santos', '2026-10-07T07:31:49.992896+00:00', '2026-10-07T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('964eb005-354a-49d8-be44-11675879c2e0', '125c8e85-c02f-467b-9e3f-913014b6eb81', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-10-07T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('921e5b86-c3f4-4e45-a738-7acbe3ab8895', '125c8e85-c02f-467b-9e3f-913014b6eb81', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-10-07T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('f3480bff-f031-454c-bade-b694eea13abb', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '125c8e85-c02f-467b-9e3f-913014b6eb81', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-10-07T07:31:49.992896+00:00', 0, '2026-10-07T07:31:49.992896+00:00', '2026-10-07T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('5ba05516-cdd5-4a0b-af79-f96053602faf', 'f3480bff-f031-454c-bade-b694eea13abb', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-10-07T07:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('75704b9b-5633-4798-b198-25ac7ba25b5b', 'f3480bff-f031-454c-bade-b694eea13abb', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-10-07T07:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('aac98208-a42a-4947-a49a-c6099e22d536', 'f3480bff-f031-454c-bade-b694eea13abb', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-10-07T07:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b4794138-369d-4f9f-b0be-3894f2071673', 'f3480bff-f031-454c-bade-b694eea13abb', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-10-07T08:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('3b378188-e051-4edc-8302-4bc567132a93', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', '125c8e85-c02f-467b-9e3f-913014b6eb81', 'f3480bff-f031-454c-bade-b694eea13abb', 'Paulista Logistics — Annual Enterprise Renewal & SLA', 12500, 'USD', 'open', 'Primary contact: Gabriel Santos (+551198762119). Target rollout across Supply Chain operations.', '2026-11-19', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-07T07:31:49.992896+00:00', '2026-10-07T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('57379b3d-4366-4a0e-bcd2-256caaaa9190', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Priya Nair', 'priya@keralaspicesglobal.com', '+919820052120', 'Kerala Global Spices', 'https://api.dicebear.com/7.x/initials/svg?seed=Priya%20Nair', '2026-10-01T20:31:49.992896+00:00', '2026-10-01T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('dc1fcd2d-478c-48b1-9823-ef462d3624c5', '57379b3d-4366-4a0e-bcd2-256caaaa9190', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-10-01T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('bef1a37f-8b99-48ed-b748-5d9a2543df89', '57379b3d-4366-4a0e-bcd2-256caaaa9190', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-10-01T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('8c386367-c186-43a0-8b9c-fbdf2d3c8874', '57379b3d-4366-4a0e-bcd2-256caaaa9190', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-10-01T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('a8a937d2-7d22-48c0-873b-7e0420c1c3ff', '57379b3d-4366-4a0e-bcd2-256caaaa9190', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-10-01T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('0f557155-4519-442d-a331-12674f364aac', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'cf8c23a8-444c-4891-9733-f10ad2f291f5', '57379b3d-4366-4a0e-bcd2-256caaaa9190', NULL, 'Kerala Global Spices — Growth Multi-Agent Plan', 5400, 'USD', 'open', 'Primary contact: Priya Nair (+919820052120). Target rollout across Food & Beverage operations.', '2026-11-27', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-01T20:31:49.992896+00:00', '2026-10-01T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('fb09fdd7-8666-44fb-85e7-b65c3d760384', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Benjamin Taylor', 'btaylor@acadiasolutions.ca', '+14165552121', 'Acadia Solutions', 'https://api.dicebear.com/7.x/initials/svg?seed=Benjamin%20Taylor', '2026-09-13T03:31:49.992896+00:00', '2026-09-13T03:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('ad63c4ae-3488-4a0e-94c0-f6d2459784fd', 'fb09fdd7-8666-44fb-85e7-b65c3d760384', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-13T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('070f1ec3-04f1-46d6-83a3-aeacafac8167', 'fb09fdd7-8666-44fb-85e7-b65c3d760384', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-13T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('99184fb8-2962-4db8-8291-4e66ed82f288', 'fb09fdd7-8666-44fb-85e7-b65c3d760384', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is IT Director. Company operating in IT Services space.', '2026-09-13T03:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('855ecc6c-8e1f-4b7b-a8ba-ba40481a86d2', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'fb09fdd7-8666-44fb-85e7-b65c3d760384', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-13T03:31:49.992896+00:00', 0, '2026-09-13T03:31:49.992896+00:00', '2026-09-13T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f3f48a86-ba5c-45ac-aa98-f4389c272c66', '855ecc6c-8e1f-4b7b-a8ba-ba40481a86d2', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-13T03:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('de4b6fed-c7f8-487e-965e-3909d38b0b1d', '855ecc6c-8e1f-4b7b-a8ba-ba40481a86d2', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-13T03:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6f0cf1fb-fb84-43f4-9c87-25f4d858cd7c', '855ecc6c-8e1f-4b7b-a8ba-ba40481a86d2', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-13T03:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0b60220d-066d-46ff-bad7-4ae5c719a4bb', '855ecc6c-8e1f-4b7b-a8ba-ba40481a86d2', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-13T04:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('9591c660-e0b2-4a14-97a9-6c483f5ec8c5', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Mia Johansson', 'mia@stockholmfashion.se', '+46812342122', 'Stockholm Fashion House', 'https://api.dicebear.com/7.x/initials/svg?seed=Mia%20Johansson', '2026-09-15T04:31:49.992896+00:00', '2026-09-15T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('badf895e-ef41-425a-b23c-4501cd8ba74d', '9591c660-e0b2-4a14-97a9-6c483f5ec8c5', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-15T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('5be6ef94-0b90-40ce-980c-d3733335fd2d', '9591c660-e0b2-4a14-97a9-6c483f5ec8c5', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Stockholm Fashion House.', '2026-09-15T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('4e77b767-9c30-4425-b6c5-515c8e6552db', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '9591c660-e0b2-4a14-97a9-6c483f5ec8c5', 'closed', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-15T04:31:49.992896+00:00', 0, '2026-09-15T04:31:49.992896+00:00', '2026-09-15T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('5c42279c-a3f7-4c67-86bc-6443e1e88d4e', '4e77b767-9c30-4425-b6c5-515c8e6552db', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-15T04:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('46bc71ee-7433-4128-8602-97fa3ee7d161', '4e77b767-9c30-4425-b6c5-515c8e6552db', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-15T04:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('e21ab3da-824d-489b-a701-4974565aa9a7', '4e77b767-9c30-4425-b6c5-515c8e6552db', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-15T04:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('867e8fc7-b518-4da8-ad04-f1671fd4bd5c', '4e77b767-9c30-4425-b6c5-515c8e6552db', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-15T05:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('422b366d-3a5e-4b52-97de-0fd8b80910c6', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'cf8c23a8-444c-4891-9733-f10ad2f291f5', '9591c660-e0b2-4a14-97a9-6c483f5ec8c5', '4e77b767-9c30-4425-b6c5-515c8e6552db', 'Stockholm Fashion House — Standard Team Onboarding & 1-Year License', 8500, 'USD', 'open', 'Primary contact: Mia Johansson (+46812342122). Target rollout across Fashion operations.', '2026-11-02', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-15T04:31:49.992896+00:00', '2026-09-15T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('2c77e895-cc9d-4728-beb5-07ec90226379', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Vikram Singhania', 'vikram@singhaniatextiles.in', '+919820052123', 'Singhania Textiles', 'https://api.dicebear.com/7.x/initials/svg?seed=Vikram%20Singhania', '2026-09-11T07:31:49.992896+00:00', '2026-09-11T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4480ee18-2e18-43d3-999b-36258477deae', '2c77e895-cc9d-4728-beb5-07ec90226379', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-11T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('2e1a554a-848f-405e-bb81-95e37a081ee6', '2c77e895-cc9d-4728-beb5-07ec90226379', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-11T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('3a20e605-4400-48c3-b044-946a1719e199', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '2c77e895-cc9d-4728-beb5-07ec90226379', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-11T07:31:49.992896+00:00', 0, '2026-09-11T07:31:49.992896+00:00', '2026-09-11T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('bbbbccdf-c773-42e9-9b15-601d2e74cbf1', '3a20e605-4400-48c3-b044-946a1719e199', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-11T07:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1feedca8-581f-4ecc-8827-b5bc34223c9f', '3a20e605-4400-48c3-b044-946a1719e199', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-11T07:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('dd945027-9507-4797-ae67-935180d8422c', '3a20e605-4400-48c3-b044-946a1719e199', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-11T07:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('57ebfc72-b8be-44c7-aa16-2c70e0742bf8', '3a20e605-4400-48c3-b044-946a1719e199', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-11T08:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('9ced3404-b01f-46ef-a744-19107e520641', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'a2215588-0b2d-44c0-92b5-e479b6ce413e', '2c77e895-cc9d-4728-beb5-07ec90226379', '3a20e605-4400-48c3-b044-946a1719e199', 'Singhania Textiles — Enterprise WhatsApp Suite (50 Seats)', 5400, 'USD', 'won', 'Primary contact: Vikram Singhania (+919820052123). Target rollout across Textiles operations.', '2026-12-03', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-11T07:31:49.992896+00:00', '2026-09-11T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('7246376e-5a01-4064-96ca-5040d8bea0b7', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Isabella Rossi', 'i.rossi@milanoapparel.it', '+390212342124', 'Milano Luxury Apparel', 'https://api.dicebear.com/7.x/initials/svg?seed=Isabella%20Rossi', '2026-09-25T09:31:49.992896+00:00', '2026-09-25T09:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('b32cfa5b-1abb-47ae-b856-f1ac3ac30346', '7246376e-5a01-4064-96ca-5040d8bea0b7', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-25T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('851b61f1-2a9f-49d4-9257-34de48647783', '7246376e-5a01-4064-96ca-5040d8bea0b7', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-09-25T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('babe219f-26ac-4225-82a2-e88f1a7a0fbe', '7246376e-5a01-4064-96ca-5040d8bea0b7', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Milano Luxury Apparel.', '2026-09-25T09:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('2b3adc37-0ba4-4f95-8f97-ed3a937d7253', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '3233438d-9b85-4047-b2ab-303dfe27bc63', '7246376e-5a01-4064-96ca-5040d8bea0b7', NULL, 'Milano Luxury Apparel — Standard Team Onboarding & 1-Year License', 3200, 'USD', 'lost', 'Primary contact: Isabella Rossi (+390212342124). Target rollout across Luxury operations.', '2026-10-26', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-25T09:31:49.992896+00:00', '2026-09-25T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('4b6977aa-1e48-43d9-8bdc-4eb91901e894', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Tariq Mahmoud', 'tariq@cairotrade.eg', '+20227952125', 'Cairo Trade Link', 'https://api.dicebear.com/7.x/initials/svg?seed=Tariq%20Mahmoud', '2026-09-16T14:31:49.992896+00:00', '2026-09-16T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('91402e52-34b2-4571-8346-9233db023e66', '4b6977aa-1e48-43d9-8bdc-4eb91901e894', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-16T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('6d0a9325-d3d9-4c8e-a95a-0a07c2faea67', '4b6977aa-1e48-43d9-8bdc-4eb91901e894', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-16T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('cafcda59-e64e-4eda-897a-963898df07a1', '4b6977aa-1e48-43d9-8bdc-4eb91901e894', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-16T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('76fcbb10-d6d2-4239-a540-be25bc1d9299', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4b6977aa-1e48-43d9-8bdc-4eb91901e894', 'closed', 'Great! Let us know if your developers have any questions.', '2026-09-16T14:31:49.992896+00:00', 0, '2026-09-16T14:31:49.992896+00:00', '2026-09-16T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1a6f5205-5470-45a6-ba34-13e175e969db', '76fcbb10-d6d2-4239-a540-be25bc1d9299', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-16T14:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('32735296-010d-470e-b64f-59f0e0dfc7cd', '76fcbb10-d6d2-4239-a540-be25bc1d9299', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-16T14:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('8373d6eb-8336-483f-be01-66d3bb5e19bd', '76fcbb10-d6d2-4239-a540-be25bc1d9299', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-16T14:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('49a807f9-4401-4470-bcb2-e9914bbf39e9', '76fcbb10-d6d2-4239-a540-be25bc1d9299', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-16T15:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('de2f46ab-8f7e-4e9e-af01-42728d3dda1e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Charlotte Evans', 'cevans@sydneymedtech.com.au', '+61298762126', 'Sydney MedTech', 'https://api.dicebear.com/7.x/initials/svg?seed=Charlotte%20Evans', '2026-10-01T08:31:49.992896+00:00', '2026-10-01T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('a452e052-655b-4561-8d9f-7759f8318461', 'de2f46ab-8f7e-4e9e-af01-42728d3dda1e', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-10-01T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('cbdb4333-461e-4cf4-bb17-ccce303bca1d', 'de2f46ab-8f7e-4e9e-af01-42728d3dda1e', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-10-01T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('e7ac2325-5e80-4e87-9a16-a21899114c18', 'de2f46ab-8f7e-4e9e-af01-42728d3dda1e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-10-01T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('fa4ae5b9-abe8-4924-ae16-014fccc7fceb', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'de2f46ab-8f7e-4e9e-af01-42728d3dda1e', 'open', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', '2026-10-01T08:31:49.992896+00:00', 0, '2026-10-01T08:31:49.992896+00:00', '2026-10-01T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b99c5e8d-b0af-4831-9573-51a1b74797b5', 'fa4ae5b9-abe8-4924-ae16-014fccc7fceb', 'customer', 'text', 'Hey! We are migrating from a legacy WhatsApp web wrapper. Will our team lose existing chat history?', 'read', '2026-10-01T08:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0efb2827-eb77-47bb-b450-031f94f5f07b', 'fa4ae5b9-abe8-4924-ae16-014fccc7fceb', 'agent', 'text', 'Hi! Migration is seamless — you can export your contacts via CSV into Selora and connect your WhatsApp Business Account. We also offer automated migration assistance.', 'read', '2026-10-01T08:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('14eb1ff0-5f75-4ef2-9179-e8c5b0dcc38e', 'fa4ae5b9-abe8-4924-ae16-014fccc7fceb', 'customer', 'text', 'That''s a huge relief. Who will be our point of contact?', 'read', '2026-10-01T08:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6ab2ec13-21d3-4161-93ba-b6c1fa778e00', 'fa4ae5b9-abe8-4924-ae16-014fccc7fceb', 'agent', 'text', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', 'read', '2026-10-01T09:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('a87fc076-ce8f-4a86-a88a-8d13901461c3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '2b52db24-fb73-477c-a66c-01e077d0783a', 'de2f46ab-8f7e-4e9e-af01-42728d3dda1e', 'fa4ae5b9-abe8-4924-ae16-014fccc7fceb', 'Sydney MedTech — Enterprise WhatsApp Suite (50 Seats)', 3200, 'USD', 'open', 'Primary contact: Charlotte Evans (+61298762126). Target rollout across MedTech operations.', '2026-11-22', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-01T08:31:49.992896+00:00', '2026-10-01T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('aad6df7c-037d-495f-bc67-815f6b17aea9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Hiroshi Tanaka', 'tanaka@tokyoelectronic.jp', '+81355552127', 'Tokyo Electronics', 'https://api.dicebear.com/7.x/initials/svg?seed=Hiroshi%20Tanaka', '2026-09-09T22:31:49.992896+00:00', '2026-09-09T22:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('85972609-1ce1-4c5b-9672-50001872aebb', 'aad6df7c-037d-495f-bc67-815f6b17aea9', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-09T22:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('ad89e4ae-664d-49bf-b101-a876718a0657', 'aad6df7c-037d-495f-bc67-815f6b17aea9', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-09-09T22:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('58090e0a-d635-4d41-ba20-6b4b559b10e8', 'aad6df7c-037d-495f-bc67-815f6b17aea9', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-09T22:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('8e9a6a9a-6bc1-44e9-9e6d-faeabd906775', 'aad6df7c-037d-495f-bc67-815f6b17aea9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Tokyo Electronics.', '2026-09-09T22:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('0c027545-91ab-4567-b411-00b9c727e8e3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'aad6df7c-037d-495f-bc67-815f6b17aea9', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-09T22:31:49.992896+00:00', 0, '2026-09-09T22:31:49.992896+00:00', '2026-09-09T22:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('4e1f3ed5-e7f1-4cb3-9e0e-322e5df47a10', '0c027545-91ab-4567-b411-00b9c727e8e3', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-09T22:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('91254d90-1b67-4826-8ca2-02e0ec5a82be', '0c027545-91ab-4567-b411-00b9c727e8e3', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-09T22:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6fa7d9a9-887d-4bd8-a35c-bdc3ba6cd01a', '0c027545-91ab-4567-b411-00b9c727e8e3', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-09T22:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b9db25cf-db51-484f-b2ae-b9ddd8b80164', '0c027545-91ab-4567-b411-00b9c727e8e3', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-09T23:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('0bcb007e-80e3-4654-89e6-2b3799ac0597', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'a2215588-0b2d-44c0-92b5-e479b6ce413e', 'aad6df7c-037d-495f-bc67-815f6b17aea9', '0c027545-91ab-4567-b411-00b9c727e8e3', 'Tokyo Electronics — API & Webhook Custom Integration Tier', 39000, 'USD', 'won', 'Primary contact: Hiroshi Tanaka (+81355552127). Target rollout across Electronics operations.', '2026-10-23', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-09T22:31:49.992896+00:00', '2026-09-09T22:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('24cc0f0c-c4c6-4681-b5e1-f3c7e9f05e40', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Amara Okafor', 'amara@lagospayments.ng', '+23412342128', 'Lagos Fintech Hub', 'https://api.dicebear.com/7.x/initials/svg?seed=Amara%20Okafor', '2026-09-24T20:31:49.992896+00:00', '2026-09-24T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e5da4ead-f56a-41f0-92fd-8839d9763c89', '24cc0f0c-c4c6-4681-b5e1-f3c7e9f05e40', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-09-24T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('47e8ae47-8a14-4a32-9853-849f391f0cc1', '24cc0f0c-c4c6-4681-b5e1-f3c7e9f05e40', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-24T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e7b3de78-f531-4b0f-a14a-60dac0b6e54e', '24cc0f0c-c4c6-4681-b5e1-f3c7e9f05e40', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-24T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('377fc3ac-3ad9-4d7b-a39d-a34f493bd3a9', '24cc0f0c-c4c6-4681-b5e1-f3c7e9f05e40', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-24T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('7d80dd43-4804-4c18-9ac5-329fd6a0cf16', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', '24cc0f0c-c4c6-4681-b5e1-f3c7e9f05e40', NULL, 'Lagos Fintech Hub — Global Messaging Expansion Plan', 18000, 'USD', 'open', 'Primary contact: Amara Okafor (+23412342128). Target rollout across FinTech operations.', '2026-10-29', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-24T20:31:49.992896+00:00', '2026-09-24T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('d69f6884-86eb-4505-9cdf-b91f1fc55aa4', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Daniel Weber', 'dweber@alpineworks.ch', '+41223452129', 'Alpine Industrial Works', 'https://api.dicebear.com/7.x/initials/svg?seed=Daniel%20Weber', '2026-09-20T07:31:49.992896+00:00', '2026-09-20T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4cc1c761-64de-475f-8b88-0e6e57d945bc', 'd69f6884-86eb-4505-9cdf-b91f1fc55aa4', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-20T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('be12a96a-e421-4f9f-b973-96701c541a9c', 'd69f6884-86eb-4505-9cdf-b91f1fc55aa4', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-20T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('4a3aee58-7a14-459e-94b9-aa771fd95c92', 'd69f6884-86eb-4505-9cdf-b91f1fc55aa4', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-20T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('719e9e98-5e23-4440-8d3d-c268b59aba31', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'd69f6884-86eb-4505-9cdf-b91f1fc55aa4', 'pending', 'Great! Let us know if your developers have any questions.', '2026-09-20T07:31:49.992896+00:00', 0, '2026-09-20T07:31:49.992896+00:00', '2026-09-20T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('df1fcf79-716f-4bd3-91ec-30ac62b4a4c8', '719e9e98-5e23-4440-8d3d-c268b59aba31', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-20T07:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('10475d55-eff0-491e-86b7-9a2246299b92', '719e9e98-5e23-4440-8d3d-c268b59aba31', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-20T07:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('8c6c05ed-c4f3-4873-937e-7e572ebb8056', '719e9e98-5e23-4440-8d3d-c268b59aba31', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-20T07:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('9a521bef-0945-4fe6-b1f6-5ab574ccb87a', '719e9e98-5e23-4440-8d3d-c268b59aba31', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-20T08:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('7949ab46-9201-4857-b1bc-802dde725ae9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Zoe Kravitz-Lee', 'zoe@pacificevents.com', '+12065552130', 'Pacific Event Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Zoe%20Kravitz-Lee', '2026-10-06T14:31:49.992896+00:00', '2026-10-06T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('8962b589-8c8a-4621-87e3-5584e1e9bf23', '7949ab46-9201-4857-b1bc-802dde725ae9', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-10-06T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('c0cc3e9f-c5f6-4cc8-868c-5365de48fe44', '7949ab46-9201-4857-b1bc-802dde725ae9', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-10-06T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('2eff2118-0246-4996-9c98-6d0ccbcc8894', '7949ab46-9201-4857-b1bc-802dde725ae9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Founder. Company operating in Hospitality space.', '2026-10-06T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('0876138a-8358-4e17-801c-8508f22d353c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '7949ab46-9201-4857-b1bc-802dde725ae9', 'open', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', '2026-10-06T14:31:49.992896+00:00', 0, '2026-10-06T14:31:49.992896+00:00', '2026-10-06T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f81fdd5d-0ab5-413d-9dca-232523c39731', '0876138a-8358-4e17-801c-8508f22d353c', 'customer', 'text', 'Hey! We are migrating from a legacy WhatsApp web wrapper. Will our team lose existing chat history?', 'read', '2026-10-06T14:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d4c6b7bb-7716-42f1-afc8-5dcf05b83aae', '0876138a-8358-4e17-801c-8508f22d353c', 'agent', 'text', 'Hi! Migration is seamless — you can export your contacts via CSV into Selora and connect your WhatsApp Business Account. We also offer automated migration assistance.', 'read', '2026-10-06T14:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('516576e5-cad6-437e-8bd2-8a73d16cad2b', '0876138a-8358-4e17-801c-8508f22d353c', 'customer', 'text', 'That''s a huge relief. Who will be our point of contact?', 'read', '2026-10-06T14:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('61d046c4-67fc-41f3-95b0-0656f98e7fb5', '0876138a-8358-4e17-801c-8508f22d353c', 'agent', 'text', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', 'read', '2026-10-06T15:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('bccc5b03-dff5-4776-9e68-45ec9fda2227', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', '7949ab46-9201-4857-b1bc-802dde725ae9', '0876138a-8358-4e17-801c-8508f22d353c', 'Pacific Event Group — Multi-Branch CRM License Rollout', 8500, 'USD', 'open', 'Primary contact: Zoe Kravitz-Lee (+12065552130). Target rollout across Hospitality operations.', '2026-11-07', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-06T14:31:49.992896+00:00', '2026-10-06T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('dde76c51-c74e-4534-9a36-f152df86cb16', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Karthik Raman', 'karthik@chennaisoftware.in', '+919820052131', 'Chennai Cloud Works', 'https://api.dicebear.com/7.x/initials/svg?seed=Karthik%20Raman', '2026-10-06T07:31:49.992896+00:00', '2026-10-06T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('92ff0113-e899-47be-a182-f3474478fcbb', 'dde76c51-c74e-4534-9a36-f152df86cb16', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-10-06T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('1764be70-7838-41e0-9b2c-d5d53edc86cc', 'dde76c51-c74e-4534-9a36-f152df86cb16', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-10-06T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('4403d6cb-8b0e-4e7c-bb37-8449594274c5', 'dde76c51-c74e-4534-9a36-f152df86cb16', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-10-06T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('c2c5e1ff-126d-49cf-a000-ff42e0c68a69', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'dde76c51-c74e-4534-9a36-f152df86cb16', 'pending', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', '2026-10-06T07:31:49.992896+00:00', 0, '2026-10-06T07:31:49.992896+00:00', '2026-10-06T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f7e9907d-2272-4ecd-8008-8ea5205b1c87', 'c2c5e1ff-126d-49cf-a000-ff42e0c68a69', 'customer', 'text', 'Hey! We are migrating from a legacy WhatsApp web wrapper. Will our team lose existing chat history?', 'read', '2026-10-06T07:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('db192318-6255-4bd8-8fd3-d80eeee0fc5a', 'c2c5e1ff-126d-49cf-a000-ff42e0c68a69', 'agent', 'text', 'Hi! Migration is seamless — you can export your contacts via CSV into Selora and connect your WhatsApp Business Account. We also offer automated migration assistance.', 'read', '2026-10-06T07:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d5654e05-dad3-4161-a26d-e212f846d95f', 'c2c5e1ff-126d-49cf-a000-ff42e0c68a69', 'customer', 'text', 'That''s a huge relief. Who will be our point of contact?', 'read', '2026-10-06T07:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fbbcdf5b-871e-43a7-955a-1a1e79f4031c', 'c2c5e1ff-126d-49cf-a000-ff42e0c68a69', 'agent', 'text', 'Your dedicated account manager is assigned and available via priority WhatsApp support.', 'read', '2026-10-06T08:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('0e2058eb-59c8-453d-ae78-8e1eb3dea8de', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '2b36720d-47ba-45d3-8d07-e652bb20f8f1', 'dde76c51-c74e-4534-9a36-f152df86cb16', 'c2c5e1ff-126d-49cf-a000-ff42e0c68a69', 'Chennai Cloud Works — Multi-Branch CRM License Rollout', 5400, 'USD', 'open', 'Primary contact: Karthik Raman (+919820052131). Target rollout across Software operations.', '2026-10-24', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-06T07:31:49.992896+00:00', '2026-10-06T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('fe6cfdbf-97b2-471b-8495-caa6513a7dba', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Larissa Volkova', 'larissa@amberlogistics.pl', '+48221232132', 'Amber Logistics Warsaw', 'https://api.dicebear.com/7.x/initials/svg?seed=Larissa%20Volkova', '2026-09-24T11:31:49.992896+00:00', '2026-09-24T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('9b8ba7f3-d635-444f-825e-66c776454b11', 'fe6cfdbf-97b2-471b-8495-caa6513a7dba', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-24T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('121d55c5-ffc3-4696-baac-7508d452f10a', 'fe6cfdbf-97b2-471b-8495-caa6513a7dba', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Amber Logistics Warsaw.', '2026-09-24T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('250b5fa0-93c9-4f08-ae11-75de9b47de64', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', 'fe6cfdbf-97b2-471b-8495-caa6513a7dba', NULL, 'Amber Logistics Warsaw — Multi-Branch CRM License Rollout', 95000, 'USD', 'open', 'Primary contact: Larissa Volkova (+48221232132). Target rollout across Logistics operations.', '2026-10-29', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-24T11:31:49.992896+00:00', '2026-09-24T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('124bf74f-817d-4147-bde6-f3ac641dd900', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Samuel Green', 'sgreen@austincleanenergy.com', '+15125552133', 'Austin Clean Energy', 'https://api.dicebear.com/7.x/initials/svg?seed=Samuel%20Green', '2026-09-19T08:31:49.992896+00:00', '2026-09-19T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('9c4bafc9-fcd4-4501-bc42-2cd7a5724d1a', '124bf74f-817d-4147-bde6-f3ac641dd900', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-19T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('3bba405d-8572-4bce-a5ea-c6b66d4e7115', '124bf74f-817d-4147-bde6-f3ac641dd900', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-19T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('3a8a6149-5b73-45f7-b939-bc1565f8bc31', '124bf74f-817d-4147-bde6-f3ac641dd900', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-19T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('aab14dbe-dd99-49cb-ae0c-089209005282', '124bf74f-817d-4147-bde6-f3ac641dd900', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-19T08:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('ebac52cd-c772-4929-91b0-ec35559ff684', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '124bf74f-817d-4147-bde6-f3ac641dd900', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-19T08:31:49.992896+00:00', 0, '2026-09-19T08:31:49.992896+00:00', '2026-09-19T08:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6c0533e5-5cdf-412a-83f4-eb006d5b3a7c', 'ebac52cd-c772-4929-91b0-ec35559ff684', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-19T08:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d361ee72-fe94-42ea-b970-809f9591e4df', 'ebac52cd-c772-4929-91b0-ec35559ff684', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-19T08:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('deb13d2e-42c4-4f45-83b0-afdf39c95f81', 'ebac52cd-c772-4929-91b0-ec35559ff684', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-19T08:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f5920977-c9f7-4589-8410-1a2d71381336', 'ebac52cd-c772-4929-91b0-ec35559ff684', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-19T09:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('a870e074-5d9b-474d-a38e-f41f1e022549', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Freja Nielsen', 'freja@copenhagendesign.dk', '+4533122134', 'Copenhagen Nordic Design', 'https://api.dicebear.com/7.x/initials/svg?seed=Freja%20Nielsen', '2026-09-13T06:31:49.992896+00:00', '2026-09-13T06:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('8b749cae-8f4f-43d9-92b6-86e87707cf80', 'a870e074-5d9b-474d-a38e-f41f1e022549', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-09-13T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('6814edb8-91f0-4d1a-8d9c-b631b062ed3f', 'a870e074-5d9b-474d-a38e-f41f1e022549', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-13T06:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('99b5f1e5-2290-4006-8ee5-af77f66aa073', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'a870e074-5d9b-474d-a38e-f41f1e022549', 'pending', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-13T06:31:49.992896+00:00', 0, '2026-09-13T06:31:49.992896+00:00', '2026-09-13T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('618524ff-37c7-4e01-9856-4766e0ceb31f', '99b5f1e5-2290-4006-8ee5-af77f66aa073', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-13T06:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('36b07dc8-d2c3-4b50-a5fe-d256fbae4ec7', '99b5f1e5-2290-4006-8ee5-af77f66aa073', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-13T06:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('8b7fa212-f37a-48b5-8b39-164f09ec1bcb', '99b5f1e5-2290-4006-8ee5-af77f66aa073', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-13T06:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('55753d7d-bfa9-4dbe-8f3f-af2a524fd68d', '99b5f1e5-2290-4006-8ee5-af77f66aa073', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-13T07:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('a345235d-8bc8-417f-aac2-c9691ed59993', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'cf8c23a8-444c-4891-9733-f10ad2f291f5', 'a870e074-5d9b-474d-a38e-f41f1e022549', '99b5f1e5-2290-4006-8ee5-af77f66aa073', 'Copenhagen Nordic Design — Annual Enterprise Renewal & SLA', 78000, 'USD', 'open', 'Primary contact: Freja Nielsen (+4533122134). Target rollout across Architecture operations.', '2026-11-30', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-13T06:31:49.992896+00:00', '2026-09-13T06:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('0f5b8479-3ae8-4d5b-bcec-026d0d428e9d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Ananya Roy', 'ananya@kolkatadigital.in', '+919820052135', 'Kolkata Digital Arts', 'https://api.dicebear.com/7.x/initials/svg?seed=Ananya%20Roy', '2026-09-12T21:31:49.992896+00:00', '2026-09-12T21:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4944a852-0601-4fc3-a9e4-52ff117be65a', '0f5b8479-3ae8-4d5b-bcec-026d0d428e9d', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-12T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('4a2d5b82-1016-43d0-bad5-3246d74dd770', '0f5b8479-3ae8-4d5b-bcec-026d0d428e9d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Co-Founder. Company operating in Digital Agency space.', '2026-09-12T21:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('8d3fc411-fb31-4452-8502-f8733a8e14a7', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '0f5b8479-3ae8-4d5b-bcec-026d0d428e9d', 'open', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-12T21:31:49.992896+00:00', 0, '2026-09-12T21:31:49.992896+00:00', '2026-09-12T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('736730a2-ec01-44e5-8baa-95696067d72d', '8d3fc411-fb31-4452-8502-f8733a8e14a7', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-12T21:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b94a4337-49c5-45c9-ab47-d7864d8cf7b3', '8d3fc411-fb31-4452-8502-f8733a8e14a7', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-12T21:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('531f8cc0-3559-478d-bcf3-af51e4dda81c', '8d3fc411-fb31-4452-8502-f8733a8e14a7', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-12T21:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d3f0fd4f-4629-4a30-8603-e70006dc8a6f', '8d3fc411-fb31-4452-8502-f8733a8e14a7', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-12T22:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('b5bdb9ee-e8eb-4e52-a068-13d23fcc0c0a', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '3233438d-9b85-4047-b2ab-303dfe27bc63', '0f5b8479-3ae8-4d5b-bcec-026d0d428e9d', '8d3fc411-fb31-4452-8502-f8733a8e14a7', 'Kolkata Digital Arts — Global Messaging Expansion Plan', 95000, 'USD', 'lost', 'Primary contact: Ananya Roy (+919820052135). Target rollout across Digital Agency operations.', '2026-11-20', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-12T21:31:49.992896+00:00', '2026-09-12T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('43aa84fa-a462-44ab-b276-7933625f7de4', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Leo Van Dijk', 'leo@amsterdamfleet.nl', '+31201232136', 'Amsterdam Fleet Services', 'https://api.dicebear.com/7.x/initials/svg?seed=Leo%20Van%20Dijk', '2026-10-01T01:31:49.992896+00:00', '2026-10-01T01:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('5add45cf-ae30-424a-bc49-3ad6650fe946', '43aa84fa-a462-44ab-b276-7933625f7de4', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-10-01T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('80b3a6dc-d711-4e33-869b-1dbbf7f8d931', '43aa84fa-a462-44ab-b276-7933625f7de4', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-10-01T01:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('4755bc02-1698-4713-a608-63a5abd3196b', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '2b52db24-fb73-477c-a66c-01e077d0783a', '43aa84fa-a462-44ab-b276-7933625f7de4', NULL, 'Amsterdam Fleet Services — Enterprise WhatsApp Suite (50 Seats)', 26000, 'USD', 'open', 'Primary contact: Leo Van Dijk (+31201232136). Target rollout across Automotive operations.', '2026-10-29', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-01T01:31:49.992896+00:00', '2026-10-01T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('33421f25-cf84-4c25-a692-724538718a29', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Camila Morales', 'camila@bogotacoffee.co', '+5712342137', 'Bogota Coffee Roasters', 'https://api.dicebear.com/7.x/initials/svg?seed=Camila%20Morales', '2026-09-24T17:31:49.992896+00:00', '2026-09-24T17:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('60069ffe-a6dc-4b6d-ad76-172a2f91649c', '33421f25-cf84-4c25-a692-724538718a29', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-09-24T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('6ba18121-3751-4431-a11a-86e2e9f1da7a', '33421f25-cf84-4c25-a692-724538718a29', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-24T17:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('2cdb4aba-15a8-40bb-a5a6-f82852d4836e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '33421f25-cf84-4c25-a692-724538718a29', 'open', 'Great! Let us know if your developers have any questions.', '2026-09-24T17:31:49.992896+00:00', 0, '2026-09-24T17:31:49.992896+00:00', '2026-09-24T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('31d2fb31-e5af-4291-8905-a7f93684a261', '2cdb4aba-15a8-40bb-a5a6-f82852d4836e', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-24T17:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f1c22557-af16-484a-a555-403603bde4ff', '2cdb4aba-15a8-40bb-a5a6-f82852d4836e', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-24T17:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('82e0f04a-7d1d-4c6e-8cfe-922c61643ca3', '2cdb4aba-15a8-40bb-a5a6-f82852d4836e', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-24T17:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('9c947507-4d63-4b9a-b130-95723ef47a29', '2cdb4aba-15a8-40bb-a5a6-f82852d4836e', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-24T18:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('32495a56-af2c-479a-aec9-ea1aa659d2be', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Ethan Walker', 'ethan@denveroutdoors.com', '+13035552138', 'Denver Outdoor Gear', 'https://api.dicebear.com/7.x/initials/svg?seed=Ethan%20Walker', '2026-09-25T09:31:49.992896+00:00', '2026-09-25T09:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('38d2328a-069b-4f26-b45c-26df7e200b6d', '32495a56-af2c-479a-aec9-ea1aa659d2be', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-25T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('80b663ae-6fa9-446f-919b-a2050463218e', '32495a56-af2c-479a-aec9-ea1aa659d2be', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is VP Marketing. Company operating in Retail space.', '2026-09-25T09:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('cfff47bd-b1a5-4e29-a5c0-0e02839efc92', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '32495a56-af2c-479a-aec9-ea1aa659d2be', 'pending', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-25T09:31:49.992896+00:00', 0, '2026-09-25T09:31:49.992896+00:00', '2026-09-25T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fc3b6021-49bb-4dc4-8147-ee2c896a005d', 'cfff47bd-b1a5-4e29-a5c0-0e02839efc92', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-25T09:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('e0edc47b-f754-4b72-a3e3-ea2852045c34', 'cfff47bd-b1a5-4e29-a5c0-0e02839efc92', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-25T09:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('99404d46-2072-4572-896e-0ca9ba433239', 'cfff47bd-b1a5-4e29-a5c0-0e02839efc92', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-25T09:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d6599b26-5e24-49cc-b023-a848268908cf', 'cfff47bd-b1a5-4e29-a5c0-0e02839efc92', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-25T10:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('e38e4051-a1a5-4c58-bd09-9738cc172acf', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '3233438d-9b85-4047-b2ab-303dfe27bc63', '32495a56-af2c-479a-aec9-ea1aa659d2be', 'cfff47bd-b1a5-4e29-a5c0-0e02839efc92', 'Denver Outdoor Gear — Standard Team Onboarding & 1-Year License', 12500, 'USD', 'lost', 'Primary contact: Ethan Walker (+13035552138). Target rollout across Retail operations.', '2026-11-02', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-25T09:31:49.992896+00:00', '2026-09-25T09:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('37d32dc2-27b2-4405-9b59-9d261a48d874', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Kavita Menon', 'kavita@bangaloredatastack.in', '+919820052139', 'DataStack Analytics', 'https://api.dicebear.com/7.x/initials/svg?seed=Kavita%20Menon', '2026-09-29T16:31:49.992896+00:00', '2026-09-29T16:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('0d275d20-09a9-4ad6-8f3f-4281095cb3c6', '37d32dc2-27b2-4405-9b59-9d261a48d874', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-29T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('07625c04-0250-457e-aee8-142d833f471c', '37d32dc2-27b2-4405-9b59-9d261a48d874', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is VP Engineering. Company operating in Big Data space.', '2026-09-29T16:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('fd619f67-3eaa-41f8-a2f4-75252959f461', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '37d32dc2-27b2-4405-9b59-9d261a48d874', 'open', 'Great! Let us know if your developers have any questions.', '2026-09-29T16:31:49.992896+00:00', 0, '2026-09-29T16:31:49.992896+00:00', '2026-09-29T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1cfdd3db-5d61-4bd5-98d5-b602e0c39adb', 'fd619f67-3eaa-41f8-a2f4-75252959f461', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-29T16:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fe751919-e9dd-4e1d-8f8c-32fbcfecf069', 'fd619f67-3eaa-41f8-a2f4-75252959f461', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-29T16:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('00aad3f1-67a1-4ed9-a002-878f7c125741', 'fd619f67-3eaa-41f8-a2f4-75252959f461', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-29T16:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b51fff98-85de-402c-a1f6-5eea5aa07e0b', 'fd619f67-3eaa-41f8-a2f4-75252959f461', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-29T17:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('ffa39ff9-817c-48c6-9cb9-4682eedc802c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'cf8c23a8-444c-4891-9733-f10ad2f291f5', '37d32dc2-27b2-4405-9b59-9d261a48d874', 'fd619f67-3eaa-41f8-a2f4-75252959f461', 'DataStack Analytics — Annual Enterprise Renewal & SLA', 26000, 'USD', 'open', 'Primary contact: Kavita Menon (+919820052139). Target rollout across Big Data operations.', '2026-11-04', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-29T16:31:49.992896+00:00', '2026-09-29T16:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('e728d93b-c666-4650-bb82-77439fb4b573', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Simon Becker', 'simon@berlinmicro.de', '+493090182140', 'Berlin Micro Systems', 'https://api.dicebear.com/7.x/initials/svg?seed=Simon%20Becker', '2026-09-26T07:31:49.992896+00:00', '2026-09-26T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('a963c47c-8e1b-4228-b063-65599d5dcff2', 'e728d93b-c666-4650-bb82-77439fb4b573', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-26T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('d24c4ff8-b7f7-46d5-b4f1-49962382137e', 'e728d93b-c666-4650-bb82-77439fb4b573', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-09-26T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('b0977fc4-b8d0-4407-82b7-0c8eb03fa6c3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', 'e728d93b-c666-4650-bb82-77439fb4b573', NULL, 'Berlin Micro Systems — Multi-Branch CRM License Rollout', 5400, 'USD', 'open', 'Primary contact: Simon Becker (+493090182140). Target rollout across Hardware operations.', '2026-12-04', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-26T07:31:49.992896+00:00', '2026-09-26T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('c337d088-f7d6-444a-b54f-965cfeacae51', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Elena Petrova', 'elena@viennaadvisory.at', '+4312342141', 'Vienna Financial Advisory', 'https://api.dicebear.com/7.x/initials/svg?seed=Elena%20Petrova', '2026-09-23T03:31:49.992896+00:00', '2026-09-23T03:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('50b17888-979c-41df-b9a9-f39083954343', 'c337d088-f7d6-444a-b54f-965cfeacae51', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-23T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('5d1f34fd-c9d6-4178-bc00-5c32a9c103ec', 'c337d088-f7d6-444a-b54f-965cfeacae51', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-23T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('fef82e75-2ac0-4926-bac2-a9eb2039c9d6', 'c337d088-f7d6-444a-b54f-965cfeacae51', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-09-23T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('e2101fb1-94bd-40dd-9f8b-dc6d441c766f', 'c337d088-f7d6-444a-b54f-965cfeacae51', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Senior Partner. Company operating in Finance space.', '2026-09-23T03:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('764f069b-e30d-4ee1-9e44-285d5017e8c5', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'c337d088-f7d6-444a-b54f-965cfeacae51', 'pending', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-23T03:31:49.992896+00:00', 0, '2026-09-23T03:31:49.992896+00:00', '2026-09-23T03:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('caad111b-8a8f-4a07-97ed-fcb7bb6a5a60', '764f069b-e30d-4ee1-9e44-285d5017e8c5', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-23T03:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b0a51172-5563-45ea-960a-d4e65d1f6f20', '764f069b-e30d-4ee1-9e44-285d5017e8c5', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-23T03:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('1df425a5-94b0-4ac0-82b8-346ce3c3b186', '764f069b-e30d-4ee1-9e44-285d5017e8c5', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-23T03:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f7fa10a0-d06c-4230-9983-bd0823a299f3', '764f069b-e30d-4ee1-9e44-285d5017e8c5', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-23T04:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('778aa669-f139-48c8-99bb-f0e91dc2340d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Jack Thompson', 'jack@aucklandagri.co.nz', '+6491232142', 'Auckland Agri Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Jack%20Thompson', '2026-09-28T20:31:49.992896+00:00', '2026-09-28T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('ef275415-8f49-4a7f-bde9-8aceebf3664f', '778aa669-f139-48c8-99bb-f0e91dc2340d', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-09-28T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e0eab52d-5024-4ca2-b75d-e38c4aad95b5', '778aa669-f139-48c8-99bb-f0e91dc2340d', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-28T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('e705cbb2-307a-4910-9f72-9b33924b2d7b', '778aa669-f139-48c8-99bb-f0e91dc2340d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-28T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('dedc764e-a2eb-40cf-8949-6886cf54074a', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '778aa669-f139-48c8-99bb-f0e91dc2340d', 'pending', 'Great! Let us know if your developers have any questions.', '2026-09-28T20:31:49.992896+00:00', 0, '2026-09-28T20:31:49.992896+00:00', '2026-09-28T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('dee1a6be-7a73-429a-a726-cdbd7569120c', 'dedc764e-a2eb-40cf-8949-6886cf54074a', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-28T20:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('4e2bd795-5048-4afc-802b-74ec276d4ab5', 'dedc764e-a2eb-40cf-8949-6886cf54074a', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-28T20:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('95430d0a-525c-411e-addc-9592d2a0ccea', 'dedc764e-a2eb-40cf-8949-6886cf54074a', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-28T20:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('00020be3-e031-4824-aa58-ea9ef12fbf7a', 'dedc764e-a2eb-40cf-8949-6886cf54074a', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-28T21:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('ca689814-079a-477b-b051-77881ce16149', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'a2215588-0b2d-44c0-92b5-e479b6ce413e', '778aa669-f139-48c8-99bb-f0e91dc2340d', 'dedc764e-a2eb-40cf-8949-6886cf54074a', 'Auckland Agri Group — Global Messaging Expansion Plan', 39000, 'USD', 'won', 'Primary contact: Jack Thompson (+6491232142). Target rollout across Agriculture operations.', '2026-11-23', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-28T20:31:49.992896+00:00', '2026-09-28T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('9b4aae2c-6883-4bf4-95e2-bb67a669e508', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Siddharth Gupta', 'sid@delhiecommercelabs.in', '+919820052143', 'Delhi eCommerce Labs', 'https://api.dicebear.com/7.x/initials/svg?seed=Siddharth%20Gupta', '2026-09-08T11:31:49.992896+00:00', '2026-09-08T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('15ce3f02-2a7f-4f68-9fbe-a3a5abb54164', '9b4aae2c-6883-4bf4-95e2-bb67a669e508', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-09-08T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('cad97f38-6178-4e1a-b67d-c8dddc323b03', '9b4aae2c-6883-4bf4-95e2-bb67a669e508', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-08T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('0b79cd15-9960-4209-90df-6274a3663eaf', '9b4aae2c-6883-4bf4-95e2-bb67a669e508', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-08T11:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('f9575ad9-bc98-426d-aa74-2c6ddce06a73', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '9b4aae2c-6883-4bf4-95e2-bb67a669e508', 'closed', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-08T11:31:49.992896+00:00', 0, '2026-09-08T11:31:49.992896+00:00', '2026-09-08T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fee896b9-12b2-4f2c-8609-b043c328d45f', 'f9575ad9-bc98-426d-aa74-2c6ddce06a73', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-08T11:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('516444b4-a089-4894-87f9-89f059ceb3e3', 'f9575ad9-bc98-426d-aa74-2c6ddce06a73', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-08T11:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('2f7b66a4-1c52-4eef-a4fd-fba1a7d42f01', 'f9575ad9-bc98-426d-aa74-2c6ddce06a73', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-08T11:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('aa763dac-cfff-4184-bc4f-7582fa262558', 'f9575ad9-bc98-426d-aa74-2c6ddce06a73', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-08T12:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('ce80d87b-94b6-4b5b-bbce-b0fc83b0175c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'f1b95c66-4df7-4799-9df8-d83556a7303b', '9b4aae2c-6883-4bf4-95e2-bb67a669e508', 'f9575ad9-bc98-426d-aa74-2c6ddce06a73', 'Delhi eCommerce Labs — API & Webhook Custom Integration Tier', 26000, 'USD', 'open', 'Primary contact: Siddharth Gupta (+919820052143). Target rollout across E-commerce operations.', '2026-11-12', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-08T11:31:49.992896+00:00', '2026-09-08T11:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('e7e2ec3f-3da1-4e0d-8881-53fb0ab7c57e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Lucia Moretti', 'lucia@florenceleather.it', '+390551232144', 'Florence Crafts', 'https://api.dicebear.com/7.x/initials/svg?seed=Lucia%20Moretti', '2026-10-05T17:31:49.992896+00:00', '2026-10-05T17:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('b4f1a763-5ec2-4775-84b9-ed0eea8be775', 'e7e2ec3f-3da1-4e0d-8881-53fb0ab7c57e', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-10-05T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('c6670552-385a-46f7-890b-0130441f55a6', 'e7e2ec3f-3da1-4e0d-8881-53fb0ab7c57e', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-10-05T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('c5add6e1-7f57-41fa-b6d7-ac07b3ac7129', 'e7e2ec3f-3da1-4e0d-8881-53fb0ab7c57e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Global Sales Head. Company operating in Apparel space.', '2026-10-05T17:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('7e46ecbb-88a8-493c-a885-2d55f95f2040', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'a2215588-0b2d-44c0-92b5-e479b6ce413e', 'e7e2ec3f-3da1-4e0d-8881-53fb0ab7c57e', NULL, 'Florence Crafts — Multi-Branch CRM License Rollout', 78000, 'USD', 'won', 'Primary contact: Lucia Moretti (+390551232144). Target rollout across Apparel operations.', '2026-11-04', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-05T17:31:49.992896+00:00', '2026-10-05T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('65daab77-4d6c-45b0-aa08-579c3930955f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Arthur Pendelton', 'arthur@manchestermfg.co.uk', '+441619462145', 'Manchester Mfg Ltd', 'https://api.dicebear.com/7.x/initials/svg?seed=Arthur%20Pendelton', '2026-09-14T04:31:49.992896+00:00', '2026-09-14T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('65e7c1fb-678b-4b9d-b16b-2b1266be1ddc', '65daab77-4d6c-45b0-aa08-579c3930955f', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-14T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('72d2a6ee-4890-426a-ad99-29f89f208f55', '65daab77-4d6c-45b0-aa08-579c3930955f', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-14T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('f38da92f-437b-4a6a-b94b-57fcaf278b7d', '65daab77-4d6c-45b0-aa08-579c3930955f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Manchester Mfg Ltd.', '2026-09-14T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('b9c9fee9-b45a-4f71-b5cb-b85c0287595a', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '65daab77-4d6c-45b0-aa08-579c3930955f', 'closed', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-14T04:31:49.992896+00:00', 0, '2026-09-14T04:31:49.992896+00:00', '2026-09-14T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('694115e4-12bb-4901-be4e-3f977a55fa06', 'b9c9fee9-b45a-4f71-b5cb-b85c0287595a', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-14T04:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0b0878a2-23b9-4fff-b773-f0824ec510ce', 'b9c9fee9-b45a-4f71-b5cb-b85c0287595a', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-14T04:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('3ef1b9f6-c449-4a66-ad71-a34b9e3d5078', 'b9c9fee9-b45a-4f71-b5cb-b85c0287595a', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-14T04:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0564362e-9f71-42c9-bf5d-c7ec648e6fbb', 'b9c9fee9-b45a-4f71-b5cb-b85c0287595a', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-14T05:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('dc01db63-2f8d-44f1-b173-2c0ccd97ff94', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Yuki Sato', 'yuki@osakabiotech.jp', '+81665552146', 'Osaka BioTech Corp', 'https://api.dicebear.com/7.x/initials/svg?seed=Yuki%20Sato', '2026-09-15T17:31:49.992896+00:00', '2026-09-15T17:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('db18d1da-0478-42bf-af75-f38b16f0ff1e', 'dc01db63-2f8d-44f1-b173-2c0ccd97ff94', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-15T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('67ad76dc-160d-4339-be36-a95011fa816a', 'dc01db63-2f8d-44f1-b173-2c0ccd97ff94', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-15T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('c421e0d0-06ac-42a9-a9d3-ececffee8529', 'dc01db63-2f8d-44f1-b173-2c0ccd97ff94', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-15T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('faeb0bea-8e09-41ce-82af-6c578af18b81', 'dc01db63-2f8d-44f1-b173-2c0ccd97ff94', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-15T17:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('13fa6fdc-4f39-45b3-b186-ca3e9ec19735', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'dc01db63-2f8d-44f1-b173-2c0ccd97ff94', 'pending', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-15T17:31:49.992896+00:00', 0, '2026-09-15T17:31:49.992896+00:00', '2026-09-15T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('459a2780-2b81-4e0f-bea4-ce4ee7755161', '13fa6fdc-4f39-45b3-b186-ca3e9ec19735', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-15T17:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('2444c46b-2e27-475b-8af0-0cb2812eb63e', '13fa6fdc-4f39-45b3-b186-ca3e9ec19735', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-15T17:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('bf5071e2-cd6d-4ed0-8ad7-d05e6ae14441', '13fa6fdc-4f39-45b3-b186-ca3e9ec19735', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-15T17:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('08dfadd2-39ea-401b-90e0-19127017b6df', '13fa6fdc-4f39-45b3-b186-ca3e9ec19735', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-15T18:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('74d1ba49-a81f-4ec5-9bdb-0817a52859ec', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '2b52db24-fb73-477c-a66c-01e077d0783a', 'dc01db63-2f8d-44f1-b173-2c0ccd97ff94', '13fa6fdc-4f39-45b3-b186-ca3e9ec19735', 'Osaka BioTech Corp — API & Webhook Custom Integration Tier', 39000, 'USD', 'open', 'Primary contact: Yuki Sato (+81665552146). Target rollout across Biotech operations.', '2026-12-05', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-15T17:31:49.992896+00:00', '2026-09-15T17:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('dbbe513f-8999-4a7e-b1dc-0a5882890df9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Meera Nambiar', 'meera@hyderabadpharma.in', '+919820052147', 'Hyderabad BioPharma', 'https://api.dicebear.com/7.x/initials/svg?seed=Meera%20Nambiar', '2026-09-20T00:31:49.992896+00:00', '2026-09-20T00:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('2e64c777-5190-4c74-917c-647a16057773', 'dbbe513f-8999-4a7e-b1dc-0a5882890df9', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-20T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('708eb8dc-07b7-44b2-b788-8607bb4f9b2e', 'dbbe513f-8999-4a7e-b1dc-0a5882890df9', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-20T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('a7c86819-cd63-455d-b224-9cc58161eafc', 'dbbe513f-8999-4a7e-b1dc-0a5882890df9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Follow-up scheduled next week to review enterprise SLAs and security compliance documentation.', '2026-09-20T00:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('e859db7d-ef22-4e02-83e7-e363985c9f86', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'dbbe513f-8999-4a7e-b1dc-0a5882890df9', 'open', 'Great! Let us know if your developers have any questions.', '2026-09-20T00:31:49.992896+00:00', 0, '2026-09-20T00:31:49.992896+00:00', '2026-09-20T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('545197aa-b89e-42d6-848c-fbdce36bdaf0', 'e859db7d-ef22-4e02-83e7-e363985c9f86', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-20T00:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('7dfe35ee-ea51-49cc-a84a-3c047648e491', 'e859db7d-ef22-4e02-83e7-e363985c9f86', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-20T00:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('c39464b1-1f7e-4609-9ac9-185671396c88', 'e859db7d-ef22-4e02-83e7-e363985c9f86', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-20T00:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('ec3c9926-a45b-4cad-a009-9e98fe732c65', 'e859db7d-ef22-4e02-83e7-e363985c9f86', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-20T01:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('7c07a731-ce90-47e6-bb42-a0d8359337de', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'a2215588-0b2d-44c0-92b5-e479b6ce413e', 'dbbe513f-8999-4a7e-b1dc-0a5882890df9', 'e859db7d-ef22-4e02-83e7-e363985c9f86', 'Hyderabad BioPharma — Growth Multi-Agent Plan', 18000, 'USD', 'won', 'Primary contact: Meera Nambiar (+919820052147). Target rollout across Pharma operations.', '2026-11-17', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-20T00:31:49.992896+00:00', '2026-09-20T00:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('0da2d9d4-f5cf-4f08-aadf-107497fdc583', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Carlos Mendoza', 'carlos@monterreyindustries.mx', '+528181232148', 'Monterrey Heavy Industries', 'https://api.dicebear.com/7.x/initials/svg?seed=Carlos%20Mendoza', '2026-09-19T12:31:49.992896+00:00', '2026-09-19T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('f4771e9e-8e4b-44f2-a2b8-fece0bb9f489', '0da2d9d4-f5cf-4f08-aadf-107497fdc583', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-19T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('01a28806-efa9-4127-ac83-8f75916539e7', '0da2d9d4-f5cf-4f08-aadf-107497fdc583', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Monterrey Heavy Industries.', '2026-09-19T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('88d0cc95-275f-45b7-9d7f-58d4d10f3af3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '3233438d-9b85-4047-b2ab-303dfe27bc63', '0da2d9d4-f5cf-4f08-aadf-107497fdc583', NULL, 'Monterrey Heavy Industries — API & Webhook Custom Integration Tier', 8500, 'USD', 'lost', 'Primary contact: Carlos Mendoza (+528181232148). Target rollout across Heavy Industry operations.', '2026-10-17', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-19T12:31:49.992896+00:00', '2026-09-19T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('c4cb84c6-d473-471a-933f-e9a61d97e6c9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Hannah Abbott', 'hannah@bostonrobotics.io', '+16175552149', 'Boston Robotics Group', 'https://api.dicebear.com/7.x/initials/svg?seed=Hannah%20Abbott', '2026-10-08T07:31:49.992896+00:00', '2026-10-08T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('f36d8635-e2cc-4fe3-8216-d840eb31a7e2', 'c4cb84c6-d473-471a-933f-e9a61d97e6c9', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-10-08T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('c2c97997-8c4a-4bc0-b84a-c0fed9d1d1d8', 'c4cb84c6-d473-471a-933f-e9a61d97e6c9', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-10-08T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('8e052c4c-98e5-49de-8f62-f90243d6c26b', 'c4cb84c6-d473-471a-933f-e9a61d97e6c9', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-10-08T07:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('7148c359-69aa-4371-8dd4-3ce13a949796', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'c4cb84c6-d473-471a-933f-e9a61d97e6c9', 'open', 'Great! Let us know if your developers have any questions.', '2026-10-08T07:31:49.992896+00:00', 0, '2026-10-08T07:31:49.992896+00:00', '2026-10-08T07:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('c8f05c0e-544e-4d3a-b0b5-1b468754dbf4', '7148c359-69aa-4371-8dd4-3ce13a949796', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-10-08T07:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('e3cc0fa8-04da-4dd3-aa2f-27616a7a4974', '7148c359-69aa-4371-8dd4-3ce13a949796', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-10-08T07:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b249ce59-8e10-4695-a3ac-e4fa0a8456d9', '7148c359-69aa-4371-8dd4-3ce13a949796', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-10-08T07:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('90d8e8f8-ea90-46de-b6c3-437fd49ba256', '7148c359-69aa-4371-8dd4-3ce13a949796', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-10-08T08:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('564b0deb-87ea-4426-ae86-23e49a63ddf6', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Rohan Deshmukh', 'rohan@punesoftwarehub.in', '+919820052150', 'Pune Software Hub', 'https://api.dicebear.com/7.x/initials/svg?seed=Rohan%20Deshmukh', '2026-09-15T23:31:49.992896+00:00', '2026-09-15T23:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('40716487-f0a6-4bc5-972c-ec169e9971f9', '564b0deb-87ea-4426-ae86-23e49a63ddf6', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-15T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('2148db8a-bf44-42ab-8cb6-be8b0008d897', '564b0deb-87ea-4426-ae86-23e49a63ddf6', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-15T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('76596133-5485-44be-98ec-b324ac628623', '564b0deb-87ea-4426-ae86-23e49a63ddf6', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is Chief Product Officer. Company operating in SaaS space.', '2026-09-15T23:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('084bfc74-218a-4cf4-90ec-7b0fde24cc6c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '564b0deb-87ea-4426-ae86-23e49a63ddf6', 'closed', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-15T23:31:49.992896+00:00', 0, '2026-09-15T23:31:49.992896+00:00', '2026-09-15T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6821d10a-02b7-4129-9151-8340dadf3336', '084bfc74-218a-4cf4-90ec-7b0fde24cc6c', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-15T23:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('226097eb-ad4c-433f-98db-4f501317f9c4', '084bfc74-218a-4cf4-90ec-7b0fde24cc6c', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-15T23:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('69c0cd11-9f05-4c4f-81b5-efa552b0d7a6', '084bfc74-218a-4cf4-90ec-7b0fde24cc6c', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-15T23:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('859f6859-946e-4819-9229-a84d241f9bb9', '084bfc74-218a-4cf4-90ec-7b0fde24cc6c', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-16T00:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('0cbe66e1-e4b4-442b-8b51-2d7b7766410f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'cf8c23a8-444c-4891-9733-f10ad2f291f5', '564b0deb-87ea-4426-ae86-23e49a63ddf6', '084bfc74-218a-4cf4-90ec-7b0fde24cc6c', 'Pune Software Hub — High-Volume Broadcast & Automation Suite', 78000, 'USD', 'open', 'Primary contact: Rohan Deshmukh (+919820052150). Target rollout across SaaS operations.', '2026-11-14', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-15T23:31:49.992896+00:00', '2026-09-15T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('ad6abe7a-54d8-492f-94bd-da4b9f905f56', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Dmitri Ivanov', 'dmitri@nordicshipping.fi', '+358912342151', 'Nordic Maritime Lines', 'https://api.dicebear.com/7.x/initials/svg?seed=Dmitri%20Ivanov', '2026-10-06T21:31:49.992896+00:00', '2026-10-06T21:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('8c61ffeb-9116-4581-adf2-7600cb3ef87f', 'ad6abe7a-54d8-492f-94bd-da4b9f905f56', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-10-06T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('6c0e4234-5ad6-45b7-ae3e-a329dc57df4c', 'ad6abe7a-54d8-492f-94bd-da4b9f905f56', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-10-06T21:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('b9dff1ef-b937-4353-8673-14f6591a9815', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'ad6abe7a-54d8-492f-94bd-da4b9f905f56', 'closed', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-10-06T21:31:49.992896+00:00', 0, '2026-10-06T21:31:49.992896+00:00', '2026-10-06T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('bade63ae-40b4-4d20-b662-1c6ca711be9e', 'b9dff1ef-b937-4353-8673-14f6591a9815', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-10-06T21:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('729c1f6c-2d8f-48be-be35-9719e6395891', 'b9dff1ef-b937-4353-8673-14f6591a9815', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-10-06T21:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('ace311dc-87dc-4ef7-9640-61548f958f26', 'b9dff1ef-b937-4353-8673-14f6591a9815', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-10-06T21:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('739785b7-c041-45fd-bb52-ab2ba007a0d0', 'b9dff1ef-b937-4353-8673-14f6591a9815', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-10-06T22:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('9f2790e9-ecf8-4754-8d91-6d7441000c56', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '2b52db24-fb73-477c-a66c-01e077d0783a', 'ad6abe7a-54d8-492f-94bd-da4b9f905f56', 'b9dff1ef-b937-4353-8673-14f6591a9815', 'Nordic Maritime Lines — Annual Enterprise Renewal & SLA', 95000, 'USD', 'open', 'Primary contact: Dmitri Ivanov (+358912342151). Target rollout across Maritime operations.', '2026-12-07', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-06T21:31:49.992896+00:00', '2026-10-06T21:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('c2ec222c-2631-4858-8b38-812c0647764d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Selena Gomez-Cruz', 'selena@valenciacitrus.es', '+34963122152', 'Valencia Citrus Co', 'https://api.dicebear.com/7.x/initials/svg?seed=Selena%20Gomez-Cruz', '2026-09-08T01:31:49.992896+00:00', '2026-09-08T01:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('cc58bd0a-0d11-4be8-b2b0-ed08d0033e95', 'c2ec222c-2631-4858-8b38-812c0647764d', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-08T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('f85046d0-88a3-4782-b78a-75bb7c6888e7', 'c2ec222c-2631-4858-8b38-812c0647764d', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-09-08T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('de95d1b7-fdb2-4e27-b8f8-69eaf78cd5d1', 'c2ec222c-2631-4858-8b38-812c0647764d', 'fa319af6-049d-4bac-b2aa-db95924662b8', '2026-09-08T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('cb070106-81a1-4aaf-a011-85744c0f558a', 'c2ec222c-2631-4858-8b38-812c0647764d', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-09-08T01:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('9f1cddd2-02c9-4e6f-8965-1bb95ff90b73', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', 'e41c9bbd-22fe-452e-bab5-7a2213d9d0b3', 'c2ec222c-2631-4858-8b38-812c0647764d', NULL, 'Valencia Citrus Co — API & Webhook Custom Integration Tier', 18000, 'USD', 'open', 'Primary contact: Selena Gomez-Cruz (+34963122152). Target rollout across Agriculture operations.', '2026-12-04', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-08T01:31:49.992896+00:00', '2026-09-08T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('1a4fdc7b-91b5-4756-8ec1-df0597cdf122', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Kwame Mensah', 'kwame@accracacao.gh', '+233302122153', 'Accra Cacao Exporters', 'https://api.dicebear.com/7.x/initials/svg?seed=Kwame%20Mensah', '2026-09-06T23:31:49.992896+00:00', '2026-09-06T23:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('eab81198-0f23-40cc-84b3-764bc370545d', '1a4fdc7b-91b5-4756-8ec1-df0597cdf122', 'f14a45e9-e9aa-431e-8fbd-298bb81b01be', '2026-09-06T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('cc86040f-efa6-4637-88ce-6418b302707c', '1a4fdc7b-91b5-4756-8ec1-df0597cdf122', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-06T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('1dc74df0-25c2-4ca2-9dfc-0348583c2e62', '1a4fdc7b-91b5-4756-8ec1-df0597cdf122', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-06T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('d2feb048-138d-4429-a806-5cdb5642cb25', '1a4fdc7b-91b5-4756-8ec1-df0597cdf122', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Initial discovery meeting completed. Key decision maker is General Manager. Company operating in Commodities space.', '2026-09-06T23:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('31f01a15-612c-4ace-aaef-0a1f389f6871', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '1a4fdc7b-91b5-4756-8ec1-df0597cdf122', 'open', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', '2026-09-06T23:31:49.992896+00:00', 0, '2026-09-06T23:31:49.992896+00:00', '2026-09-06T23:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('892e5150-df64-4677-a058-a9ff211d4ba9', '31f01a15-612c-4ace-aaef-0a1f389f6871', 'customer', 'text', 'Good day, we need to broadcast promotional catalogs to 20,000 opt-in customer numbers next week. What are the rate limits?', 'read', '2026-09-06T23:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6a05e5eb-58b4-473c-802c-d241acde1155', '31f01a15-612c-4ace-aaef-0a1f389f6871', 'agent', 'text', 'Hello! With Meta Cloud API Tier 2 & 3 integrations, Selora easily processes 1,000+ messages per minute with rate limiting and retry queues handled automatically.', 'read', '2026-09-06T23:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('9994b04c-713d-4a25-bdcc-7493a85f2705', '31f01a15-612c-4ace-aaef-0a1f389f6871', 'customer', 'text', 'Understood, that fits our requirements. What templates do we need approved by Meta?', 'read', '2026-09-06T23:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b104a632-4295-4ef4-a09f-25835d28edd2', '31f01a15-612c-4ace-aaef-0a1f389f6871', 'agent', 'text', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', 'read', '2026-09-07T00:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('a5288ae4-293c-485a-93c2-4e4737f30bee', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Tara MacLeod', 'tara@highlandrenewables.scot', '+441314962154', 'Highland Wind Energy', 'https://api.dicebear.com/7.x/initials/svg?seed=Tara%20MacLeod', '2026-09-23T04:31:49.992896+00:00', '2026-09-23T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('66e8c35f-f10e-4a8f-b1ae-d0abcde34971', 'a5288ae4-293c-485a-93c2-4e4737f30bee', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-23T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('ffd1803c-4a2b-498d-9ce1-e3ce269fd7f0', 'a5288ae4-293c-485a-93c2-4e4737f30bee', 'da7d3d0e-2f05-428d-86c0-2ccd30b62912', '2026-09-23T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('b7ca438b-0d15-4f88-9ff0-eafa1eee9f9c', 'a5288ae4-293c-485a-93c2-4e4737f30bee', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Highland Wind Energy.', '2026-09-23T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('6bf0d0b4-4bc1-4448-a8e3-5a7d645166c4', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'a5288ae4-293c-485a-93c2-4e4737f30bee', 'open', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', '2026-09-23T04:31:49.992896+00:00', 0, '2026-09-23T04:31:49.992896+00:00', '2026-09-23T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b4458968-8c2f-4f3b-8077-8a7e52611977', '6bf0d0b4-4bc1-4448-a8e3-5a7d645166c4', 'customer', 'text', 'Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?', 'read', '2026-09-23T04:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fc8af88f-54dd-4888-85b6-b8fb8409b1e0', '6bf0d0b4-4bc1-4448-a8e3-5a7d645166c4', 'agent', 'text', 'Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.', 'read', '2026-09-23T04:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('13ef6bfb-d42f-4f82-9061-8f0a8c24fa12', '6bf0d0b4-4bc1-4448-a8e3-5a7d645166c4', 'customer', 'text', 'That''s exactly what we need for our qualification workflow. Can we test this in a trial?', 'read', '2026-09-23T04:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('261d33d1-1262-4c10-8c83-76d9aeb05fcc', '6bf0d0b4-4bc1-4448-a8e3-5a7d645166c4', 'agent', 'text', 'Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!', 'read', '2026-09-23T05:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('552b87ef-2a5d-4024-9304-0edae284df9c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '831d5cf3-45a1-4b68-ae77-ae984f8edc67', 'a5288ae4-293c-485a-93c2-4e4737f30bee', '6bf0d0b4-4bc1-4448-a8e3-5a7d645166c4', 'Highland Wind Energy — High-Volume Broadcast & Automation Suite', 12500, 'USD', 'open', 'Primary contact: Tara MacLeod (+441314962154). Target rollout across CleanTech operations.', '2026-10-20', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-23T04:31:49.992896+00:00', '2026-09-23T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('2f5b6901-ed0f-493f-aa0f-e77e7e7b683c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Kenji Shimada', 'kenji@kyotoceramics.jp', '+81755552155', 'Kyoto Precision Ceramics', 'https://api.dicebear.com/7.x/initials/svg?seed=Kenji%20Shimada', '2026-09-14T01:31:49.992896+00:00', '2026-09-14T01:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('6ffb5615-af09-4e56-922c-c1076dc2d053', '2f5b6901-ed0f-493f-aa0f-e77e7e7b683c', '7e6acec0-3bc4-4d88-9136-9907381d367e', '2026-09-14T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('1993167e-c26d-47ef-8ff7-6b5b852f8512', '2f5b6901-ed0f-493f-aa0f-e77e7e7b683c', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-14T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('cc7b559e-55ba-4edf-94e1-a3800792a89e', '2f5b6901-ed0f-493f-aa0f-e77e7e7b683c', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'API & custom webhook integration discussion held with their engineering leads.', '2026-09-14T01:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('9ce4d2e2-9913-4b54-bdb9-5c84a135db07', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '2f5b6901-ed0f-493f-aa0f-e77e7e7b683c', 'open', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-09-14T01:31:49.992896+00:00', 0, '2026-09-14T01:31:49.992896+00:00', '2026-09-14T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('d93d2778-eac1-48a2-ad29-2f3f8888398f', '9ce4d2e2-9913-4b54-bdb9-5c84a135db07', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-09-14T01:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('6d2d38e9-835a-447e-b26a-265437926a90', '9ce4d2e2-9913-4b54-bdb9-5c84a135db07', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-09-14T01:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('941d28f2-6cfb-4d18-a36e-826de8af8b3a', '9ce4d2e2-9913-4b54-bdb9-5c84a135db07', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-09-14T01:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0c0ba0ad-6f4e-4c2d-bec3-36a43c6a05ea', '9ce4d2e2-9913-4b54-bdb9-5c84a135db07', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-09-14T02:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('89508023-e192-4945-8c5c-eb6aab3982ee', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '3233438d-9b85-4047-b2ab-303dfe27bc63', '2f5b6901-ed0f-493f-aa0f-e77e7e7b683c', '9ce4d2e2-9913-4b54-bdb9-5c84a135db07', 'Kyoto Precision Ceramics — Standard Team Onboarding & 1-Year License', 39000, 'USD', 'lost', 'Primary contact: Kenji Shimada (+81755552155). Target rollout across Manufacturing operations.', '2026-12-04', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-14T01:31:49.992896+00:00', '2026-09-14T01:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('a9523759-cc71-45aa-adbe-c65ffca13e5e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Beatrice Laurent', 'blaurent@genevabanking.ch', '+41228192156', 'Geneva Private Wealth', 'https://api.dicebear.com/7.x/initials/svg?seed=Beatrice%20Laurent', '2026-10-08T20:31:49.992896+00:00', '2026-10-08T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('16f375c2-f28c-4661-b371-d1d882a214a5', 'a9523759-cc71-45aa-adbe-c65ffca13e5e', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-10-08T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('4825bc6c-19c2-48cc-89dc-01871c8c010d', 'a9523759-cc71-45aa-adbe-c65ffca13e5e', '22bd2bc4-610e-4a12-8df8-b5b9f3e19d4f', '2026-10-08T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('ec036f06-7518-44fd-8b14-d0af8b782698', 'a9523759-cc71-45aa-adbe-c65ffca13e5e', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-10-08T20:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('0758805b-576b-4aec-a784-46f7c980ba33', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', '4afe4e07-8680-4f1e-8742-28902a512d7b', '2b52db24-fb73-477c-a66c-01e077d0783a', 'a9523759-cc71-45aa-adbe-c65ffca13e5e', NULL, 'Geneva Private Wealth — Standard Team Onboarding & 1-Year License', 39000, 'USD', 'open', 'Primary contact: Beatrice Laurent (+41228192156). Target rollout across Private Wealth operations.', '2026-11-19', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-08T20:31:49.992896+00:00', '2026-10-08T20:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('f44acdef-286b-496d-bb93-42a48af14bae', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Suresh Krishnan', 'suresh@chennaiauto.in', '+919840052157', 'Chennai Auto Components', 'https://api.dicebear.com/7.x/initials/svg?seed=Suresh%20Krishnan', '2026-09-05T19:31:49.992896+00:00', '2026-09-05T19:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('e56d2637-c69d-4c67-adf8-293d2ad3486b', 'f44acdef-286b-496d-bb93-42a48af14bae', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-09-05T19:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('a1fae448-4466-4763-9b6c-b435791fcbad', 'f44acdef-286b-496d-bb93-42a48af14bae', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Chennai Auto Components.', '2026-09-05T19:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('e4155e14-9e2e-4e22-8b7a-1a9dbdae3c02', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f44acdef-286b-496d-bb93-42a48af14bae', 'closed', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', '2026-09-05T19:31:49.992896+00:00', 0, '2026-09-05T19:31:49.992896+00:00', '2026-09-05T19:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('8af88387-04fe-4f50-8ada-5f22ce92b149', 'e4155e14-9e2e-4e22-8b7a-1a9dbdae3c02', 'customer', 'text', 'Good day, we need to broadcast promotional catalogs to 20,000 opt-in customer numbers next week. What are the rate limits?', 'read', '2026-09-05T19:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('7f63bb35-7bb4-489a-bb9f-854ea526a860', 'e4155e14-9e2e-4e22-8b7a-1a9dbdae3c02', 'agent', 'text', 'Hello! With Meta Cloud API Tier 2 & 3 integrations, Selora easily processes 1,000+ messages per minute with rate limiting and retry queues handled automatically.', 'read', '2026-09-05T19:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('f4792a7e-773c-4a68-8d73-c4dd8de35a3b', 'e4155e14-9e2e-4e22-8b7a-1a9dbdae3c02', 'customer', 'text', 'Understood, that fits our requirements. What templates do we need approved by Meta?', 'read', '2026-09-05T19:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('a5e89145-6af2-4d84-81ce-cc6b3d773a50', 'e4155e14-9e2e-4e22-8b7a-1a9dbdae3c02', 'agent', 'text', 'You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour.', 'read', '2026-09-05T20:07:49.992896+00:00');
            

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('fe03e59e-393c-4783-b2a9-5d503417bca7', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Nadia Benali', 'nadia@tunistelecom.tn', '+21671232158', 'Tunis Digital Net', 'https://api.dicebear.com/7.x/initials/svg?seed=Nadia%20Benali', '2026-09-09T14:31:49.992896+00:00', '2026-09-09T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('2f74e549-d877-49ef-affb-4ea55c2a17c4', 'fe03e59e-393c-4783-b2a9-5d503417bca7', 'd5376668-4040-418a-b4ba-facd459da7fe', '2026-09-09T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('0ec79c5c-aac9-4ec3-993f-53d1aa37d908', 'fe03e59e-393c-4783-b2a9-5d503417bca7', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-09T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('345d96f6-fcc6-40ce-85e2-1055236ca338', 'fe03e59e-393c-4783-b2a9-5d503417bca7', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for Tunis Digital Net.', '2026-09-09T14:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('ffa8736e-d39a-4302-8184-b80f51764d5f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'fe03e59e-393c-4783-b2a9-5d503417bca7', 'open', 'Great! Let us know if your developers have any questions.', '2026-09-09T14:31:49.992896+00:00', 0, '2026-09-09T14:31:49.992896+00:00', '2026-09-09T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('a56c821b-af5b-46f5-a015-6ce5c50fea59', 'ffa8736e-d39a-4302-8184-b80f51764d5f', 'customer', 'text', 'Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?', 'read', '2026-09-09T14:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('5247a6fa-e658-414d-ae4b-54055a691bec', 'ffa8736e-d39a-4302-8184-b80f51764d5f', 'agent', 'text', 'Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.', 'read', '2026-09-09T14:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('a502ef56-43a7-40ff-bfdd-b6e6ee3c3a29', 'ffa8736e-d39a-4302-8184-b80f51764d5f', 'customer', 'text', 'Excellent. We''ll start testing the API endpoints this afternoon.', 'read', '2026-09-09T14:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('b4459e00-ce4b-4a52-b305-81fa73b39ad0', 'ffa8736e-d39a-4302-8184-b80f51764d5f', 'agent', 'text', 'Great! Let us know if your developers have any questions.', 'read', '2026-09-09T15:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('3aa35dd5-d733-4c03-836a-f095fdfd01b1', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '67182e5d-b9c5-4cce-8153-c779f3104797', 'fe03e59e-393c-4783-b2a9-5d503417bca7', 'ffa8736e-d39a-4302-8184-b80f51764d5f', 'Tunis Digital Net — Enterprise WhatsApp Suite (50 Seats)', 39000, 'USD', 'open', 'Primary contact: Nadia Benali (+21671232158). Target rollout across Telecom operations.', '2026-11-22', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-09T14:31:49.992896+00:00', '2026-09-09T14:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('f3866828-ad00-45d8-9bb8-6a4c1e928daf', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Oliver Sterling', 'oliver@londonproptech.co.uk', '+442079462159', 'London PropTech Labs', 'https://api.dicebear.com/7.x/initials/svg?seed=Oliver%20Sterling', '2026-10-09T12:31:49.992896+00:00', '2026-10-09T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('2717a295-12b9-4d00-a3df-ceed30127dd5', 'f3866828-ad00-45d8-9bb8-6a4c1e928daf', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-10-09T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('126b5175-526f-4273-8fe5-49e8e4019706', 'f3866828-ad00-45d8-9bb8-6a4c1e928daf', '73b9864a-fb5e-4013-81ae-716954e05fa1', '2026-10-09T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('852f9ee5-f71f-4f4e-aea6-af62f6f67e52', 'f3866828-ad00-45d8-9bb8-6a4c1e928daf', 'ad581d2e-a057-4ccb-aeb6-f6f324d52992', '2026-10-09T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('7fd7fe0d-54fa-4d48-8e7c-4b69288ef891', 'f3866828-ad00-45d8-9bb8-6a4c1e928daf', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for London PropTech Labs.', '2026-10-09T12:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('9e4f6c3a-76ac-42c1-b7ea-7a5f8f7dd355', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f3866828-ad00-45d8-9bb8-6a4c1e928daf', 'pending', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', '2026-10-09T12:31:49.992896+00:00', 0, '2026-10-09T12:31:49.992896+00:00', '2026-10-09T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('34aec775-ebe4-461c-80ff-acba7d4500f7', '9e4f6c3a-76ac-42c1-b7ea-7a5f8f7dd355', 'customer', 'text', 'Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?', 'read', '2026-10-09T12:31:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('5b4a75f0-cccc-4b6b-a160-d4fd5f58d4fa', '9e4f6c3a-76ac-42c1-b7ea-7a5f8f7dd355', 'agent', 'text', 'Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I''d love to show you a quick 15-minute demo. Are you free tomorrow?', 'read', '2026-10-09T12:43:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('0c52a5fe-ae98-4523-9dc2-40d2d06cc4b1', '9e4f6c3a-76ac-42c1-b7ea-7a5f8f7dd355', 'customer', 'text', 'Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!', 'read', '2026-10-09T12:55:49.992896+00:00');
            

            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('fa42d998-434d-4a77-a2bf-4d59216911d0', '9e4f6c3a-76ac-42c1-b7ea-7a5f8f7dd355', 'agent', 'text', 'Perfect, invite sent! See you tomorrow at 3:00 PM GMT.', 'read', '2026-10-09T13:07:49.992896+00:00');
            

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('7a8477f6-421d-4592-b618-89278763062f', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '831d5cf3-45a1-4b68-ae77-ae984f8edc67', 'f3866828-ad00-45d8-9bb8-6a4c1e928daf', '9e4f6c3a-76ac-42c1-b7ea-7a5f8f7dd355', 'London PropTech Labs — Global Messaging Expansion Plan', 12500, 'USD', 'open', 'Primary contact: Oliver Sterling (+442079462159). Target rollout across Real Estate operations.', '2026-11-14', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-10-09T12:31:49.992896+00:00', '2026-10-09T12:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('d5878e43-1db7-4cd2-aed4-0fda17ed8de3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Clara Vance', 'clara@montrealai.ca', '+15145552160', 'Montreal Cognitive AI', 'https://api.dicebear.com/7.x/initials/svg?seed=Clara%20Vance', '2026-09-20T04:31:49.992896+00:00', '2026-09-20T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('20623739-9352-4ae7-9194-ea221b55fe11', 'd5878e43-1db7-4cd2-aed4-0fda17ed8de3', 'bffa4ac4-a54f-4103-ac9d-c841869d6b27', '2026-09-20T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('9b945586-dfc3-4e92-b546-8a0ce3c54d18', 'd5878e43-1db7-4cd2-aed4-0fda17ed8de3', 'c14f10a3-f703-4593-87cb-f03b621f3d24', '2026-09-20T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        

    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('c04fa6cd-1f80-4c73-86f3-b9db2d2cb84f', 'd5878e43-1db7-4cd2-aed4-0fda17ed8de3', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.', '2026-09-20T04:31:49.992896+00:00')
    ON CONFLICT DO NOTHING;
    

        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('a8e8638c-a3ed-4008-a923-913292fbdb07', 'f12e3f6d-2986-41a0-bcae-73faef70e41d', '534a5418-feb0-44c0-8eab-ddd22ec07ff1', 'f5a0c73e-d359-40e6-a19b-a589a81c589d', '3233438d-9b85-4047-b2ab-303dfe27bc63', 'd5878e43-1db7-4cd2-aed4-0fda17ed8de3', NULL, 'Montreal Cognitive AI — Growth Multi-Agent Plan', 55000, 'USD', 'lost', 'Primary contact: Clara Vance (+15145552160). Target rollout across AI & ML operations.', '2026-10-17', 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8', '2026-09-20T04:31:49.992896+00:00', '2026-09-20T04:31:49.992896+00:00')
        ON CONFLICT DO NOTHING;
        
COMMIT;
