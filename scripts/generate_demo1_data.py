#!/usr/bin/env python3
"""
scripts/generate_demo1_data.py
Generates a comprehensive SQL seed script for demo1@seloraos.online
Account: 534a5418-feb0-44c0-8eab-ddd22ec07ff1
User: f12e3f6d-2986-41a0-bcae-73faef70e41d
Profile: bcd70fd9-c3cc-4af3-b375-cd135df0b6a8
"""

import json
import random
import datetime
import uuid

user_id = 'f12e3f6d-2986-41a0-bcae-73faef70e41d'
profile_id = 'bcd70fd9-c3cc-4af3-b375-cd135df0b6a8'
account_id = '534a5418-feb0-44c0-8eab-ddd22ec07ff1'

random.seed(42)

leads_data = [
    ("Alexander Wright", "alex.wright@apexgroup.io", "+14155552101", "Apex Group", "CEO", "FinTech"),
    ("Sophia Martinez", "smartinez@nexoratech.com", "+14155552102", "Nexora Tech", "CTO", "SaaS"),
    ("Liam O'Connor", "liam@vanguardlogistics.co", "+442079462103", "Vanguard Logistics", "Operations Director", "Logistics"),
    ("Elena Rostova", "elena@quantumdynamic.de", "+493090182104", "Quantum Dynamics", "Head of Procurement", "Manufacturing"),
    ("Rahul Sharma", "rahul.sharma@luminahealth.in", "+919820052105", "Lumina Health", "Managing Director", "Healthcare"),
    ("Chloe Dupont", "c.dupont@bluepeakcap.fr", "+33140052106", "BluePeak Capital", "Partner", "Venture Capital"),
    ("Marcus Vance", "marcus@starlightmedia.com", "+12125552107", "Starlight Media", "VP Marketing", "Media"),
    ("Olivia Chen", "olivia@horizonretail.sg", "+6567892108", "Horizon Retail", "E-commerce Lead", "Retail"),
    ("Lucas Silva", "lucas@solarisenergy.br", "+551198762109", "Solaris Energy", "Chief Commercial Officer", "Energy"),
    ("Aisha Al-Mansoor", "aisha@gulfventures.ae", "+97143122110", "Gulf Ventures", "Investment Manager", "Finance"),
    ("David Kim", "dkim@seoulautomations.kr", "+8225552111", "Seoul Automations", "General Manager", "Robotics"),
    ("Emma Watson-Bell", "emma@crestviewconsulting.co.uk", "+442079462112", "Crestview Consulting", "Senior Consultant", "Consulting"),
    ("Mateo Fernandez", "mateo@iberiapharma.es", "+34912342113", "Iberia Pharma", "Sales Director", "Pharmaceuticals"),
    ("Fatima Zahra", "fzahra@casablancagroup.ma", "+212522552114", "Casablanca Exports", "Supply Chain Head", "Import/Export"),
    ("Noah Lindqvist", "noah@nordiccloud.se", "+46812342115", "Nordic Cloud Labs", "Founder", "Cloud & DevOps"),
    ("Grace Hopperly", "grace@aerotechsys.com", "+16505552116", "AeroTech Systems", "Product Director", "Aerospace"),
    ("Ravi Patel", "ravi.patel@zenithenterprises.in", "+919820052117", "Zenith Enterprises", "President", "Textiles"),
    ("Hanna Schmidt", "h.schmidt@bavariagoods.de", "+498912342118", "Bavaria Goods", "Purchasing Manager", "Manufacturing"),
    ("Gabriel Santos", "gabriel@paulistalog.com.br", "+551198762119", "Paulista Logistics", "COO", "Supply Chain"),
    ("Priya Nair", "priya@keralaspicesglobal.com", "+919820052120", "Kerala Global Spices", "Export Manager", "Food & Beverage"),
    ("Benjamin Taylor", "btaylor@acadiasolutions.ca", "+14165552121", "Acadia Solutions", "IT Director", "IT Services"),
    ("Mia Johansson", "mia@stockholmfashion.se", "+46812342122", "Stockholm Fashion House", "Brand Lead", "Fashion"),
    ("Vikram Singhania", "vikram@singhaniatextiles.in", "+919820052123", "Singhania Textiles", "Managing Director", "Textiles"),
    ("Isabella Rossi", "i.rossi@milanoapparel.it", "+390212342124", "Milano Luxury Apparel", "Merchandising Lead", "Luxury"),
    ("Tariq Mahmoud", "tariq@cairotrade.eg", "+20227952125", "Cairo Trade Link", "Regional Manager", "Trading"),
    ("Charlotte Evans", "cevans@sydneymedtech.com.au", "+61298762126", "Sydney MedTech", "Head of Growth", "MedTech"),
    ("Hiroshi Tanaka", "tanaka@tokyoelectronic.jp", "+81355552127", "Tokyo Electronics", "Procurement Lead", "Electronics"),
    ("Amara Okafor", "amara@lagospayments.ng", "+23412342128", "Lagos Fintech Hub", "CEO", "FinTech"),
    ("Daniel Weber", "dweber@alpineworks.ch", "+41223452129", "Alpine Industrial Works", "VP Operations", "Engineering"),
    ("Zoe Kravitz-Lee", "zoe@pacificevents.com", "+12065552130", "Pacific Event Group", "Founder", "Hospitality"),
    ("Karthik Raman", "karthik@chennaisoftware.in", "+919820052131", "Chennai Cloud Works", "Chief Architect", "Software"),
    ("Larissa Volkova", "larissa@amberlogistics.pl", "+48221232132", "Amber Logistics Warsaw", "Business Dev Lead", "Logistics"),
    ("Samuel Green", "sgreen@austincleanenergy.com", "+15125552133", "Austin Clean Energy", "Project Director", "Renewables"),
    ("Freja Nielsen", "freja@copenhagendesign.dk", "+4533122134", "Copenhagen Nordic Design", "Creative Director", "Architecture"),
    ("Ananya Roy", "ananya@kolkatadigital.in", "+919820052135", "Kolkata Digital Arts", "Co-Founder", "Digital Agency"),
    ("Leo Van Dijk", "leo@amsterdamfleet.nl", "+31201232136", "Amsterdam Fleet Services", "Fleet Manager", "Automotive"),
    ("Camila Morales", "camila@bogotacoffee.co", "+5712342137", "Bogota Coffee Roasters", "Commercial Director", "Food & Beverage"),
    ("Ethan Walker", "ethan@denveroutdoors.com", "+13035552138", "Denver Outdoor Gear", "VP Marketing", "Retail"),
    ("Kavita Menon", "kavita@bangaloredatastack.in", "+919820052139", "DataStack Analytics", "VP Engineering", "Big Data"),
    ("Simon Becker", "simon@berlinmicro.de", "+493090182140", "Berlin Micro Systems", "Managing Partner", "Hardware"),
    ("Elena Petrova", "elena@viennaadvisory.at", "+4312342141", "Vienna Financial Advisory", "Senior Partner", "Finance"),
    ("Jack Thompson", "jack@aucklandagri.co.nz", "+6491232142", "Auckland Agri Group", "Managing Director", "Agriculture"),
    ("Siddharth Gupta", "sid@delhiecommercelabs.in", "+919820052143", "Delhi eCommerce Labs", "CEO", "E-commerce"),
    ("Lucia Moretti", "lucia@florenceleather.it", "+390551232144", "Florence Crafts", "Global Sales Head", "Apparel"),
    ("Arthur Pendelton", "arthur@manchestermfg.co.uk", "+441619462145", "Manchester Mfg Ltd", "Plant Director", "Manufacturing"),
    ("Yuki Sato", "yuki@osakabiotech.jp", "+81665552146", "Osaka BioTech Corp", "R&D Director", "Biotech"),
    ("Meera Nambiar", "meera@hyderabadpharma.in", "+919820052147", "Hyderabad BioPharma", "Head of Clinical Supply", "Pharma"),
    ("Carlos Mendoza", "carlos@monterreyindustries.mx", "+528181232148", "Monterrey Heavy Industries", "Purchasing Director", "Heavy Industry"),
    ("Hannah Abbott", "hannah@bostonrobotics.io", "+16175552149", "Boston Robotics Group", "VP Strategy", "Robotics"),
    ("Rohan Deshmukh", "rohan@punesoftwarehub.in", "+919820052150", "Pune Software Hub", "Chief Product Officer", "SaaS"),
    ("Dmitri Ivanov", "dmitri@nordicshipping.fi", "+358912342151", "Nordic Maritime Lines", "Fleet Director", "Maritime"),
    ("Selena Gomez-Cruz", "selena@valenciacitrus.es", "+34963122152", "Valencia Citrus Co", "Export Director", "Agriculture"),
    ("Kwame Mensah", "kwame@accracacao.gh", "+233302122153", "Accra Cacao Exporters", "General Manager", "Commodities"),
    ("Tara MacLeod", "tara@highlandrenewables.scot", "+441314962154", "Highland Wind Energy", "Commercial Lead", "CleanTech"),
    ("Kenji Shimada", "kenji@kyotoceramics.jp", "+81755552155", "Kyoto Precision Ceramics", "Export Manager", "Manufacturing"),
    ("Beatrice Laurent", "blaurent@genevabanking.ch", "+41228192156", "Geneva Private Wealth", "VP Client Relations", "Private Wealth"),
    ("Suresh Krishnan", "suresh@chennaiauto.in", "+919840052157", "Chennai Auto Components", "MD & CEO", "Automotive"),
    ("Nadia Benali", "nadia@tunistelecom.tn", "+21671232158", "Tunis Digital Net", "Procurement VP", "Telecom"),
    ("Oliver Sterling", "oliver@londonproptech.co.uk", "+442079462159", "London PropTech Labs", "Co-Founder", "Real Estate"),
    ("Clara Vance", "clara@montrealai.ca", "+15145552160", "Montreal Cognitive AI", "Head of Alliances", "AI & ML")
]

tags_data = [
    ("VIP", "#ef4444"),
    ("Hot Lead", "#f97316"),
    ("Enterprise", "#8b5cf6"),
    ("Wholesale", "#06b6d4"),
    ("Follow Up", "#eab308"),
    ("Inbound", "#10b981"),
    ("Demo Requested", "#3b82f6"),
    ("Pricing Inquiry", "#ec4899"),
    ("High Intent", "#6366f1"),
    ("Decision Maker", "#14b8a6")
]

pipeline_stages_1 = [
    ("New Lead", 0, "#64748b"),
    ("Qualified", 1, "#3b82f6"),
    ("Demo / Meeting", 2, "#8b5cf6"),
    ("Proposal Sent", 3, "#f59e0b"),
    ("Negotiation", 4, "#06b6d4"),
    ("Closed Won", 5, "#22c55e"),
    ("Closed Lost", 6, "#ef4444")
]

pipeline_stages_2 = [
    ("Prospect", 0, "#64748b"),
    ("Initial Call", 1, "#3b82f6"),
    ("Agreement Review", 2, "#f59e0b"),
    ("Signed Partner", 3, "#22c55e")
]

deal_titles = [
    "Enterprise WhatsApp Suite (50 Seats)",
    "Growth Multi-Agent Plan",
    "High-Volume Broadcast & Automation Suite",
    "API & Webhook Custom Integration Tier",
    "Multi-Branch CRM License Rollout",
    "Global Messaging Expansion Plan",
    "Standard Team Onboarding & 1-Year License",
    "Annual Enterprise Renewal & SLA"
]

conversation_dialogues = [
    (
        "Hi! We are currently evaluating Selora CRM for our 35-person sales team. Can you share enterprise pricing and onboarding timeline?",
        "Hello! Thanks for reaching out. Yes, absolutely! We offer unlimited seats, multi-agent WhatsApp inboxes, and dedicated onboarding support within 48 hours. I'd love to show you a quick 15-minute demo. Are you free tomorrow?",
        "Tomorrow at 3:00 PM GMT works great for our team. Looking forward to it!",
        "Perfect, invite sent! See you tomorrow at 3:00 PM GMT."
    ),
    (
        "Hello, does Selora CRM support automated trigger flows when a lead changes pipeline stage?",
        "Hi there! Yes, our visual workflow automation builder allows you to trigger automated WhatsApp messages, assign agents, and dispatch webhooks on any stage change.",
        "That's exactly what we need for our qualification workflow. Can we test this in a trial?",
        "Absolutely, your demo account has full access to the workflow engine. Let us know if you need assistance setting up your first flow!"
    ),
    (
        "Good day, we need to broadcast promotional catalogs to 20,000 opt-in customer numbers next week. What are the rate limits?",
        "Hello! With Meta Cloud API Tier 2 & 3 integrations, Selora easily processes 1,000+ messages per minute with rate limiting and retry queues handled automatically.",
        "Understood, that fits our requirements. What templates do we need approved by Meta?",
        "You can draft and submit WhatsApp templates directly in your Selora settings — approvals typically take less than 1 hour."
    ),
    (
        "Hi team, can we connect our existing custom ERP to sync contacts and deals via REST API?",
        "Hello! Yes, Selora provides full REST API endpoints with API key authentication, plus bidirectional incoming & outgoing webhooks for real-time contact and deal sync.",
        "Excellent. We'll start testing the API endpoints this afternoon.",
        "Great! Let us know if your developers have any questions."
    ),
    (
        "Hey! We are migrating from a legacy WhatsApp web wrapper. Will our team lose existing chat history?",
        "Hi! Migration is seamless — you can export your contacts via CSV into Selora and connect your WhatsApp Business Account. We also offer automated migration assistance.",
        "That's a huge relief. Who will be our point of contact?",
        "Your dedicated account manager is assigned and available via priority WhatsApp support."
    )
]

quick_replies_data = [
    ("Welcome Greeting", "text", "Hello! Thanks for reaching out to Selora. How can our sales or technical support team assist you today?"),
    ("Schedule Live Demo", "text", "We'd love to show you a live walkthrough! You can pick a convenient time on our calendar here: https://seloraos.online/demo"),
    ("Enterprise Pricing Overview", "text", "Our Enterprise tier includes unlimited agents, priority Cloud API throughput, custom webhook automations, and a dedicated SLA. Would you like a custom quote?"),
    ("Meta Cloud API Setup", "text", "To link your official WhatsApp Business number, navigate to Settings > WhatsApp Config and follow our 3-step Meta embedded signup wizard."),
    ("API Documentation", "text", "You can explore our developer API documentation and webhook specifications at https://docs.seloraos.online/api"),
    ("After Hours Response", "text", "Thank you for contacting us! Our team is currently offline, but we have logged your inquiry and will reply promptly first thing tomorrow morning.")
]

templates_data = [
    ("welcome_enterprise", "Marketing", "text", "Welcome to Selora, {{1}}! We're thrilled to have {{2}} onboard. Let us know if you have any questions.", "APPROVED"),
    ("meeting_confirmation", "Utility", "text", "Hi {{1}}, this is a confirmation for our scheduled meeting on {{2}} at {{3}}. Reply YES to confirm.", "APPROVED"),
    ("deal_proposal_update", "Marketing", "text", "Hello {{1}}, your customized proposal for {{2}} is ready for review. Access your quote here: {{3}}", "APPROVED"),
    ("renewal_reminder", "Utility", "text", "Hi {{1}}, your Selora CRM subscription for {{2}} will renew on {{3}}. Please verify your billing details.", "APPROVED")
]

now = datetime.datetime.now(datetime.timezone.utc)
sql = []

sql.append("-- ===========================================================================")
sql.append(f"-- SEED SCRIPT FOR demo1@seloraos.online")
sql.append(f"-- Account: {account_id} | User: {user_id}")
sql.append("-- ===========================================================================")
sql.append("BEGIN;")
sql.append("")

# Update profile name
sql.append(f"""
UPDATE public.profiles
SET full_name = 'Demo Admin', avatar_url = 'https://api.dicebear.com/7.x/initials/svg?seed=Demo%20Admin', updated_at = NOW()
WHERE id = '{profile_id}' AND (full_name IS NULL OR full_name = '');
""")

# 1. Pipelines
pipe1_id = str(uuid.uuid4())
pipe2_id = str(uuid.uuid4())

sql.append(f"""
INSERT INTO public.pipelines (id, user_id, account_id, name, created_at)
VALUES 
  ('{pipe1_id}', '{user_id}', '{account_id}', 'Enterprise Sales Pipeline', NOW() - INTERVAL '40 days'),
  ('{pipe2_id}', '{user_id}', '{account_id}', 'Strategic Partnerships', NOW() - INTERVAL '35 days')
ON CONFLICT DO NOTHING;
""")

# 2. Pipeline Stages
stages1_map = {}
for name, pos, color in pipeline_stages_1:
    s_id = str(uuid.uuid4())
    stages1_map[name] = s_id
    sql.append(f"""
    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('{s_id}', '{pipe1_id}', '{name}', {pos}, '{color}', NOW() - INTERVAL '40 days');
    """)

stages2_map = {}
for name, pos, color in pipeline_stages_2:
    s_id = str(uuid.uuid4())
    stages2_map[name] = s_id
    sql.append(f"""
    INSERT INTO public.pipeline_stages (id, pipeline_id, name, position, color, created_at)
    VALUES ('{s_id}', '{pipe2_id}', '{name}', {pos}, '{color}', NOW() - INTERVAL '35 days');
    """)

# 3. Tags
tag_ids = {}
for name, color in tags_data:
    t_id = str(uuid.uuid4())
    tag_ids[name] = t_id
    sql.append(f"""
    INSERT INTO public.tags (id, user_id, account_id, name, color, created_at)
    VALUES ('{t_id}', '{user_id}', '{account_id}', '{name}', '{color}', NOW() - INTERVAL '40 days')
    ON CONFLICT DO NOTHING;
    """)

# 4. Quick Replies
for title, kind, content in quick_replies_data:
    qr_id = str(uuid.uuid4())
    clean_content = content.replace("'", "''")
    clean_title = title.replace("'", "''")
    sql.append(f"""
    INSERT INTO public.quick_replies (id, account_id, user_id, title, kind, content_text, created_at, updated_at)
    VALUES ('{qr_id}', '{account_id}', '{user_id}', '{clean_title}', '{kind}', '{clean_content}', NOW() - INTERVAL '30 days', NOW() - INTERVAL '30 days')
    ON CONFLICT DO NOTHING;
    """)

# 5. Message Templates
for name, category, h_type, body, status in templates_data:
    mt_id = str(uuid.uuid4())
    clean_body = body.replace("'", "''")
    sql.append(f"""
    INSERT INTO public.message_templates (id, user_id, account_id, name, category, language, header_type, body_text, status, created_at, updated_at)
    VALUES ('{mt_id}', '{user_id}', '{account_id}', '{name}', '{category}', 'en_US', '{h_type}', '{clean_body}', '{status}', NOW() - INTERVAL '25 days', NOW() - INTERVAL '25 days')
    ON CONFLICT DO NOTHING;
    """)

# 6. Contacts, Tags, Notes, Conversations, Messages, Deals
contact_ids = []
deals_count = 0
conversations_count = 0

for idx, (name, email, phone, company, role, industry) in enumerate(leads_data):
    days_ago = random.randint(1, 35)
    hours_ago = random.randint(1, 23)
    created_at = (now - datetime.timedelta(days=days_ago, hours=hours_ago)).isoformat()
    clean_name = name.replace("'", "''")
    clean_company = company.replace("'", "''")
    safe_seed = name.replace(" ", "%20").replace("'", "%27")
    avatar_url = f"https://api.dicebear.com/7.x/initials/svg?seed={safe_seed}"
    c_id = str(uuid.uuid4())
    contact_ids.append((c_id, name, email, phone, company, role, industry, created_at))

    # Insert Contact
    sql.append(f"""
    INSERT INTO public.contacts (id, user_id, account_id, name, email, phone, company, avatar_url, created_at, updated_at)
    VALUES ('{c_id}', '{user_id}', '{account_id}', '{clean_name}', '{email}', '{phone}', '{clean_company}', '{avatar_url}', '{created_at}', '{created_at}')
    ON CONFLICT DO NOTHING;
    """)

    # Assign 1 to 3 Tags
    assigned_tags = random.sample(tags_data, k=random.randint(1, 3))
    for t_name, _ in assigned_tags:
        ct_id = str(uuid.uuid4())
        sql.append(f"""
        INSERT INTO public.contact_tags (id, contact_id, tag_id, created_at)
        VALUES ('{ct_id}', '{c_id}', '{tag_ids[t_name]}', '{created_at}')
        ON CONFLICT DO NOTHING;
        """)

    # Contact Note
    notes_templates = [
        f"Initial discovery meeting completed. Key decision maker is {role}. Company operating in {industry} space.",
        f"Expressed high interest in multi-agent WhatsApp inbox and broadcast campaigns for {company}.",
        f"Evaluating Selora CRM against legacy tools. Budget approved for Q4 rollout; requested pricing breakdown.",
        f"API & custom webhook integration discussion held with their engineering leads.",
        f"Follow-up scheduled next week to review enterprise SLAs and security compliance documentation."
    ]
    note_text = random.choice(notes_templates).replace("'", "''")
    cn_id = str(uuid.uuid4())
    sql.append(f"""
    INSERT INTO public.contact_notes (id, contact_id, user_id, account_id, note_text, created_at)
    VALUES ('{cn_id}', '{c_id}', '{user_id}', '{account_id}', '{note_text}', '{created_at}')
    ON CONFLICT DO NOTHING;
    """)

    # Conversations & Messages (for ~75% of leads, i.e. 45 leads)
    conv_id = None
    if idx % 4 != 3:
        conversations_count += 1
        conv_id = str(uuid.uuid4())
        dialogue = random.choice(conversation_dialogues)
        
        # Recent contacts (index < 6) have very recent messages and 1-2 unread
        is_very_recent = (idx < 6)
        if is_very_recent:
            conv_created = (now - datetime.timedelta(hours=random.randint(2, 14))).isoformat()
            unread_count = random.choice([1, 2])
            status = 'open'
        else:
            conv_created = created_at
            unread_count = 0
            status = random.choice(['open', 'open', 'pending', 'closed'])

        last_msg = dialogue[-1].replace("'", "''")
        last_msg_at = conv_created

        sql.append(f"""
        INSERT INTO public.conversations (id, user_id, account_id, contact_id, status, last_message_text, last_message_at, unread_count, created_at, updated_at)
        VALUES ('{conv_id}', '{user_id}', '{account_id}', '{c_id}', '{status}', '{last_msg}', '{last_msg_at}', {unread_count}, '{conv_created}', '{conv_created}')
        ON CONFLICT DO NOTHING;
        """)

        # Insert Dialogue Messages
        t0 = datetime.datetime.fromisoformat(conv_created)
        for m_idx, msg_text in enumerate(dialogue):
            m_id = str(uuid.uuid4())
            sender_type = 'customer' if m_idx % 2 == 0 else 'agent'
            m_status = 'read' if (not is_very_recent or m_idx < len(dialogue) - 1) else 'delivered'
            m_time = (t0 + datetime.timedelta(minutes=m_idx * 12)).isoformat()
            clean_m_text = msg_text.replace("'", "''")
            sql.append(f"""
            INSERT INTO public.messages (id, conversation_id, sender_type, content_type, content_text, status, created_at)
            VALUES ('{m_id}', '{conv_id}', '{sender_type}', 'text', '{clean_m_text}', '{m_status}', '{m_time}');
            """)

    # Deals (for ~75% of leads, across both pipelines)
    if idx % 4 != 0:
        deals_count += 1
        deal_id = str(uuid.uuid4())
        
        # Choose pipeline: 80% pipeline 1, 20% pipeline 2
        if idx % 5 != 0:
            p_id = pipe1_id
            stage_name, _, _ = random.choice(pipeline_stages_1)
            stage_id = stages1_map[stage_name]
            deal_status = "won" if stage_name == "Closed Won" else ("lost" if stage_name == "Closed Lost" else "open")
        else:
            p_id = pipe2_id
            stage_name, _, _ = random.choice(pipeline_stages_2)
            stage_id = stages2_map[stage_name]
            deal_status = "won" if stage_name == "Signed Partner" else "open"

        deal_title = f"{company} — {random.choice(deal_titles)}".replace("'", "''")
        deal_value = random.choice([3200, 5400, 8500, 12500, 18000, 26000, 39000, 55000, 78000, 95000])
        future_days = random.randint(5, 60)
        expected_close = (now + datetime.timedelta(days=future_days)).strftime("%Y-%m-%d")
        deal_note = f"Primary contact: {name} ({phone}). Target rollout across {industry} operations.".replace("'", "''")
        conv_fk_clause = f"'{conv_id}'" if conv_id else "NULL"

        sql.append(f"""
        INSERT INTO public.deals (id, user_id, account_id, pipeline_id, stage_id, contact_id, conversation_id, title, value, currency, status, notes, expected_close_date, assigned_to, created_at, updated_at)
        VALUES ('{deal_id}', '{user_id}', '{account_id}', '{p_id}', '{stage_id}', '{c_id}', {conv_fk_clause}, '{deal_title}', {deal_value}, 'USD', '{deal_status}', '{deal_note}', '{expected_close}', '{profile_id}', '{created_at}', '{created_at}')
        ON CONFLICT DO NOTHING;
        """)

sql.append("COMMIT;")
sql.append("")

output_file = 'scripts/seed_demo1_data.sql'
with open(output_file, 'w') as f:
    f.write('\n'.join(sql))

print(f"Generated {output_file} successfully!")
print(f"Contacts: {len(leads_data)}")
print(f"Conversations: {conversations_count}")
print(f"Deals: {deals_count}")
print(f"Pipelines: 2 (Enterprise Sales + Strategic Partnerships)")
print(f"Quick Replies: {len(quick_replies_data)}")
print(f"Message Templates: {len(templates_data)}")
