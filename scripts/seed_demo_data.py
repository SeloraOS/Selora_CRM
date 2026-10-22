import json
import random
import datetime

user_id = '89e3156b-6316-43e1-b8dc-220d5586d31e'
profile_id = 'bffb4ab7-48e1-4e02-b674-d2b27c9bacdf'
account_id = '9cfe3f3f-1161-4d81-806b-c97fbe0a1aef'

leads_data = [
    ("Alexander Wright", "alex.wright@apexgroup.io", "+14155552001", "Apex Group", "CEO"),
    ("Sophia Martinez", "smartinez@nexoratech.com", "+14155552002", "Nexora Tech", "CTO"),
    ("Liam O'Connor", "liam@vanguardlogistics.co", "+442079460001", "Vanguard Logistics", "Operations Director"),
    ("Elena Rostova", "elena@quantumdynamic.de", "+493090182001", "Quantum Dynamics", "Head of Procurement"),
    ("Rahul Sharma", "rahul.sharma@luminahealth.in", "+919820055001", "Lumina Health", "Managing Director"),
    ("Chloe Dupont", "c.dupont@bluepeakcap.fr", "+33140052001", "BluePeak Capital", "Partner"),
    ("Marcus Vance", "marcus@starlightmedia.com", "+12125552003", "Starlight Media", "VP Marketing"),
    ("Olivia Chen", "olivia@horizonretail.sg", "+6567892001", "Horizon Retail", "E-commerce Lead"),
    ("Lucas Silva", "lucas@solarisenergy.br", "+551198762001", "Solaris Energy", "Chief Commercial Officer"),
    ("Aisha Al-Mansoor", "aisha@gulfventures.ae", "+97143122001", "Gulf Ventures", "Investment Manager"),
    ("David Kim", "dkim@seoulautomations.kr", "+8225552001", "Seoul Automations", "General Manager"),
    ("Emma Watson-Bell", "emma@crestviewconsulting.co.uk", "+442079460002", "Crestview Consulting", "Senior Consultant"),
    ("Mateo Fernandez", "mateo@iberiapharma.es", "+34912342001", "Iberia Pharma", "Sales Director"),
    ("Fatima Zahra", "fzahra@casablancagroup.ma", "+212522552001", "Casablanca Exports", "Supply Chain Head"),
    ("Noah Lindqvist", "noah@nordiccloud.se", "+46812342001", "Nordic Cloud Labs", "Founder"),
    ("Grace Hopperly", "grace@aerotechsys.com", "+16505552004", "AeroTech Systems", "Product Director"),
    ("Ravi Patel", "ravi.patel@zenithenterprises.in", "+919820055002", "Zenith Enterprises", "President"),
    ("Hanna Schmidt", "h.schmidt@bavariagoods.de", "+498912342001", "Bavaria Goods", "Purchasing Manager"),
    ("Gabriel Santos", "gabriel@paulistalog.com.br", "+551198762002", "Paulista Logistics", "COO"),
    ("Priya Nair", "priya@keralaspicesglobal.com", "+919820055003", "Kerala Global Spices", "Export Manager"),
    ("Benjamin Taylor", "btaylor@acadiasolutions.ca", "+14165552005", "Acadia Solutions", "IT Director"),
    ("Mia Johansson", "mia@stockholmfashion.se", "+46812342002", "Stockholm Fashion House", "Brand Lead"),
    ("Vikram Singhania", "vikram@singhaniatextiles.in", "+919820055004", "Singhania Textiles", "Managing Director"),
    ("Isabella Rossi", "i.rossi@milanoapparel.it", "+390212342001", "Milano Luxury Apparel", "Merchandising Lead"),
    ("Tariq Mahmoud", "tariq@cairotrade.eg", "+20227952001", "Cairo Trade Link", "Regional Manager"),
    ("Charlotte Evans", "cevans@sydneymedtech.com.au", "+61298762001", "Sydney MedTech", "Head of Growth"),
    ("Hiroshi Tanaka", "tanaka@tokyoelectronic.jp", "+81355552001", "Tokyo Electronics", "Procurement Lead"),
    ("Amara Okafor", "amara@lagospayments.ng", "+23412342001", "Lagos Fintech Hub", "CEO"),
    ("Daniel Weber", "dweber@alpineworks.ch", "+41223452001", "Alpine Industrial Works", "VP Operations"),
    ("Zoe Kravitz-Lee", "zoe@pacificevents.com", "+12065552006", "Pacific Event Group", "Founder"),
    ("Karthik Raman", "karthik@chennaisoftware.in", "+919820055005", "Chennai Cloud Works", "Chief Architect"),
    ("Larissa Volkova", "larissa@amberlogistics.pl", "+48221232001", "Amber Logistics Warsaw", "Business Dev Lead"),
    ("Samuel Green", "sgreen@austincleanenergy.com", "+15125552007", "Austin Clean Energy", "Project Director"),
    ("Freja Nielsen", "freja@copenhagendesign.dk", "+4533122001", "Copenhagen Nordic Design", "Creative Director"),
    ("Ananya Roy", "ananya@kolkatadigital.in", "+919820055006", "Kolkata Digital Arts", "Co-Founder"),
    ("Leo Van Dijk", "leo@amsterdamfleet.nl", "+31201232001", "Amsterdam Fleet Services", "Fleet Manager"),
    ("Camila Morales", "camila@bogotacoffee.co", "+5712342001", "Bogota Coffee Roasters", "Commercial Director"),
    ("Ethan Walker", "ethan@denveroutdoors.com", "+13035552008", "Denver Outdoor Gear", "VP Marketing"),
    ("Kavita Menon", "kavita@bangaloredatastack.in", "+919820055007", "DataStack Analytics", "VP Engineering"),
    ("Simon Becker", "simon@berlinmicro.de", "+493090182002", "Berlin Micro Systems", "Managing Partner"),
    ("Elena Petrova", "elena@viennaadvisory.at", "+4312342001", "Vienna Financial Advisory", "Senior Partner"),
    ("Jack Thompson", "jack@aucklandagri.co.nz", "+6491232001", "Auckland Agri Group", "Managing Director"),
    ("Siddharth Gupta", "sid@delhiecommercelabs.in", "+919820055008", "Delhi eCommerce Labs", "CEO"),
    ("Lucia Moretti", "lucia@florenceleather.it", "+390551232001", "Florence Crafts", "Global Sales Head"),
    ("Arthur Pendelton", "arthur@manchestermfg.co.uk", "+441619462001", "Manchester Mfg Ltd", "Plant Director"),
    ("Yuki Sato", "yuki@osakabiotech.jp", "+81665552001", "Osaka BioTech Corp", "R&D Director"),
    ("Meera Nambiar", "meera@hyderabadpharma.in", "+919820055009", "Hyderabad BioPharma", "Head of Clinical Supply"),
    ("Carlos Mendoza", "carlos@monterreyindustries.mx", "+528181232001", "Monterrey Heavy Industries", "Purchasing Director"),
    ("Hannah Abbott", "hannah@bostonrobotics.io", "+16175552009", "Boston Robotics Group", "VP Strategy"),
    ("Rohan Deshmukh", "rohan@punesoftwarehub.in", "+919820055010", "Pune Software Hub", "Chief Product Officer")
]

tags_data = [
    ("VIP", "#ef4444"),
    ("Hot Lead", "#f97316"),
    ("Enterprise", "#8b5cf6"),
    ("Wholesale", "#06b6d4"),
    ("Follow Up", "#eab308"),
    ("Inbound", "#10b981"),
    ("Demo Requested", "#3b82f6"),
    ("Pricing Inquiry", "#ec4899")
]

stages_data = [
    ("New Lead", 0, "#64748b"),
    ("Qualified", 1, "#3b82f6"),
    ("Demo / Meeting", 2, "#8b5cf6"),
    ("Proposal Sent", 3, "#f59e0b"),
    ("Negotiation", 4, "#06b6d4"),
    ("Closed Won", 5, "#22c55e"),
    ("Closed Lost", 6, "#ef4444")
]

sql_statements = []

# 1. Pipeline
sql_statements.append(f"""
INSERT INTO public.pipelines (id, user_id, account_id, name, created_at)
VALUES (uuid_generate_v4(), '{user_id}', '{account_id}', 'Enterprise Sales Pipeline', NOW() - INTERVAL '30 days')
ON CONFLICT DO NOTHING;
""")

# 2. Pipeline Stages
for name, pos, color in stages_data:
    sql_statements.append(f"""
    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    SELECT uuid_generate_v4(), p.id, '{name}', {pos}, '{color}', NOW() - INTERVAL '30 days'
    FROM public.pipelines p WHERE p.account_id = '{account_id}' AND p.name = 'Enterprise Sales Pipeline'
    AND NOT EXISTS (
        SELECT 1 FROM public.pipeline_stages s WHERE s.pipeline_id = p.id AND s.name = '{name}'
    );
    """)

# 3. Tags
for name, color in tags_data:
    sql_statements.append(f"""
    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES (uuid_generate_v4(), '{user_id}', '{account_id}', '{name}', '{color}', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    """)

# 4. Contacts & linked records
now = datetime.datetime.now(datetime.timezone.utc)

sample_messages_inbound = [
    "Hi there! We are interested in integrating WhatsApp CRM for our sales team. Can you share pricing?",
    "Hello! I saw your platform demo. We have about 50 agents who need WhatsApp broadcast and automation.",
    "Good day, we are evaluating multichannel CRM tools. Does your API support webhook triggers and automated flow routing?",
    "Hi, we want to set up automated reminders and order updates via WhatsApp Cloud API. Is onboarding support included?",
    "Hey! Looking to migrate our team from our legacy WhatsApp tool. What is the timeline for onboarding?",
    "Hello Selora team, we need an enterprise plan with team roles and custom webhook dispatching."
]

sample_messages_outbound = [
    "Hi! Thanks for reaching out. Yes, absolutely! We support multi-agent inboxes, automated flows, and native WhatsApp broadcasts.",
    "Hello! Great to hear from you. I would love to walk you through a 15-minute product walkthrough. When are you available?",
    "Hi! Yes, our API supports bidirectional webhooks, message template sync, and interactive message buttons.",
    "Hello! We can have your team up and running within 24 hours. Let me share our enterprise feature breakdown.",
    "Hi! Migration is seamless — you can import your existing contact lists via CSV and hook up your WhatsApp Business Account."
]

deal_titles = [
    "Annual Enterprise Subscription",
    "Growth Plan (20 Agents)",
    "WhatsApp Broadcast & Automation Suite",
    "API & Webhook Custom Integration",
    "Multi-Branch CRM Rollout",
    "High-Volume Messaging Tier",
    "Standard Onboarding & Team License",
    "Quarterly Expansion License"
]

for idx, (name, email, phone, company, role) in enumerate(leads_data):
    days_ago = random.randint(1, 28)
    created_at = (now - datetime.timedelta(days=days_ago, hours=random.randint(0, 23))).isoformat()
    avatar_seed = name.replace(" ", "%20").replace("'", "%27")
    clean_name = name.replace("'", "''")
    
    # Insert contact
    sql_statements.append(f"""
    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES (uuid_generate_v4(), '{user_id}', '{account_id}', '{clean_name}', '{email}', '{phone}', '{company}', 'https://api.dicebear.com/7.x/initials/svg?seed={avatar_seed}', '{created_at}', '{created_at}')
    ON CONFLICT (account_id, phone_normalized) WHERE phone_normalized <> '' DO UPDATE
    SET name = EXCLUDED.name, email = EXCLUDED.email, company = EXCLUDED.company;
    """)
    
    # Assign 1-2 random tags
    selected_tags = random.sample(tags_data, k=random.randint(1, 2))
    for t_name, _ in selected_tags:
        sql_statements.append(f"""
        INSERT INTO public.contact_tags (contact_id, tag_id, created_at)
        SELECT c.id, t.id, '{created_at}'
        FROM public.contacts c, public.tags t
        WHERE c.account_id = '{account_id}' AND c.phone = '{phone}'
          AND t.account_id = '{account_id}' AND t.name = '{t_name}'
        ON CONFLICT DO NOTHING;
        """)

    # Note
    sql_statements.append(f"""
    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    SELECT uuid_generate_v4(), c.id, '{user_id}', '{account_id}', 'Lead identified as {role} at {company}. Key interest in automated workflows and WhatsApp marketing.', '{created_at}'
    FROM public.contacts c
    WHERE c.account_id = '{account_id}' AND c.phone = '{phone}'
    ON CONFLICT DO NOTHING;
    """)

    # Conversations & Messages for ~75% of leads
    if idx % 4 != 0:
        inbound_msg = random.choice(sample_messages_inbound).replace("'", "''")
        outbound_msg = random.choice(sample_messages_outbound).replace("'", "''")
        unread = random.choice([0, 0, 1, 2])
        status = random.choice(['open', 'open', 'open', 'pending', 'closed'])
        
        sql_statements.append(f"""
        DO $$
        DECLARE
          v_contact_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '{account_id}' AND phone = '{phone}';
          IF v_contact_id IS NOT NULL THEN
            INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
            VALUES (uuid_generate_v4(), '{user_id}', '{account_id}', v_contact_id, '{status}', '{outbound_msg}', '{created_at}', {unread}, '{created_at}', '{created_at}')
            ON CONFLICT (account_id, contact_id) DO UPDATE
            SET last_message_text = EXCLUDED.last_message_text, last_message_at = EXCLUDED.last_message_at
            RETURNING id INTO v_conv_id;

            IF v_conv_id IS NOT NULL THEN
              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'customer', 'text', '{inbound_msg}', 'read', ('{created_at}'::timestamptz - INTERVAL '10 minutes'));

              INSERT INTO public.messages (conversation_id, sender_type, content_type, content_text, status, created_at)
              VALUES (v_conv_id, 'agent', 'text', '{outbound_msg}', 'delivered', '{created_at}'::timestamptz);
            END IF;
          END IF;
        END $$;
        """)

    # Deals for ~60% of leads
    if idx % 5 in (0, 1, 2):
        deal_title = f"{company} - {random.choice(deal_titles)}".replace("'", "''")
        deal_value = random.choice([2500, 4800, 7500, 12000, 18500, 24000, 36000, 50000])
        stage_name = random.choice(["New Lead", "Qualified", "Demo / Meeting", "Proposal Sent", "Negotiation", "Closed Won", "Closed Lost"])
        deal_status = "won" if stage_name == "Closed Won" else ("lost" if stage_name == "Closed Lost" else "open")
        
        sql_statements.append(f"""
        DO $$
        DECLARE
          v_contact_id UUID;
          v_pipeline_id UUID;
          v_stage_id UUID;
          v_conv_id UUID;
        BEGIN
          SELECT id INTO v_contact_id FROM public.contacts WHERE account_id = '{account_id}' AND phone = '{phone}';
          SELECT id INTO v_pipeline_id FROM public.pipelines WHERE account_id = '{account_id}' AND name = 'Enterprise Sales Pipeline';
          SELECT id INTO v_stage_id FROM public.pipeline_stages WHERE pipeline_id = v_pipeline_id AND name = '{stage_name}';
          SELECT id INTO v_conv_id FROM public.conversations WHERE account_id = '{account_id}' AND contact_id = v_contact_id;
          
          IF v_contact_id IS NOT NULL AND v_pipeline_id IS NOT NULL AND v_stage_id IS NOT NULL THEN
            INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, assigned_to, created_at, updated_at)
            VALUES (uuid_generate_v4(), '{user_id}', '{account_id}', v_pipeline_id, v_stage_id, v_contact_id, v_conv_id, '{deal_title}', {deal_value}, 'USD', '{deal_status}', '{profile_id}', '{created_at}', '{created_at}')
            ON CONFLICT DO NOTHING;
          END IF;
        END $$;
        """)

output_file = 'scripts/seed_demo_data.sql'
with open(output_file, 'w') as f:
    f.write('\n'.join(sql_statements))

print(f"Generated {output_file} successfully with {len(leads_data)} leads!")
