/**
 * scripts/seed-50-leads-param.js
 * Seeds 50 realistic, scattered sample leads for parammavani21@gmail.com
 */

const fs = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

// Load environment variables from .env.local
const envPath = path.resolve(__dirname, '../.env.local');
if (fs.existsSync(envPath)) {
  const envContent = fs.readFileSync(envPath, 'utf8');
  envContent.split('\n').forEach(line => {
    const trimmed = line.trim();
    if (trimmed && !trimmed.startsWith('#')) {
      const idx = trimmed.indexOf('=');
      if (idx !== -1) {
        const key = trimmed.slice(0, idx).trim();
        const value = trimmed.slice(idx + 1).trim().replace(/^["']|["']$/g, '');
        if (!process.env[key]) {
          process.env[key] = value;
        }
      }
    }
  });
}

const supabaseUrl = process.env.NEXT_PUBLIC_SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('Error: NEXT_PUBLIC_SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY are required in .env.local');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey);

function randomChoice(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomDateInPast(days = 40) {
  const date = new Date();
  date.setDate(date.getDate() - randomInt(0, days));
  date.setHours(randomInt(9, 19), randomInt(0, 59), randomInt(0, 59));
  return date.toISOString();
}

function randomFutureDate(days = 60) {
  const date = new Date();
  date.setDate(date.getDate() + randomInt(4, days));
  return date.toISOString().split('T')[0];
}

const LEADS_50 = [
  { name: 'Arjun Patel', company: 'Zenith Logistics Hub', email: 'arjun.p@zenithlogistics.in', phone: '+919820123401', industry: 'Logistics' },
  { name: 'Sarah Jenkins', company: 'Apex Cloud Solutions', email: 'sarah.j@apexcloud.io', phone: '+14155553002', industry: 'SaaS' },
  { name: 'Rohan Sharma', company: 'Nova Healthtech Global', email: 'rohan.s@novahealth.org', phone: '+919876543203', industry: 'Healthcare' },
  { name: 'Marcus Vance', company: 'Titan Realty Group', email: 'mvance@titanrealty.com', phone: '+14155553004', industry: 'Real Estate' },
  { name: 'Elena Rostova', company: 'CyberFlow Security', email: 'elena@cyberflow.tech', phone: '+442079460905', industry: 'Cybersecurity' },
  { name: 'David Miller', company: 'BlueWave E-Commerce', email: 'david.m@bluewaveshop.com', phone: '+14155553006', industry: 'E-commerce' },
  { name: 'Fatima Al-Mansoor', company: 'Gulf Trade Connect', email: 'fatima@gulftrade.ae', phone: '+971501234507', industry: 'Import/Export' },
  { name: 'Lucas Silva', company: 'Solaria Energy Brasil', email: 'lucas.silva@solariaenergy.com', phone: '+551198765408', industry: 'CleanTech' },
  { name: 'Chloe Dubois', company: 'Lumiere Digital Agency', email: 'chloe@lumieredigital.fr', phone: '+33142685509', industry: 'Marketing' },
  { name: 'Kenji Takahashi', company: 'OmniRobotics Japan', email: 'kenji.t@omnirobotics.jp', phone: '+81355550110', industry: 'Robotics' },
  { name: 'Carlos Mendez', company: 'Andes Supply Chains', email: 'carlos@andessupply.co', phone: '+525512345611', industry: 'Supply Chain' },
  { name: 'Amina Diallo', company: 'Sahel Agro Commodities', email: 'amina.d@sahelagro.com', phone: '+221771234512', industry: 'Agriculture' },
  { name: 'Julian Mercer', company: 'Zenith Wealth Advisors', email: 'jmercer@zenithwealth.com', phone: '+14155553013', industry: 'Financial Services' },
  { name: 'Mei-Ling Chen', company: 'Quantum Biotech Lab', email: 'ml.chen@quantumbiotech.tw', phone: '+886223456714', industry: 'Biotech' },
  { name: 'Liam O’Connor', company: 'Emerald Fleet Solutions', email: 'liam@emeraldfleet.ie', phone: '+35314960115', industry: 'Automotive' },
  { name: 'Ananya Desai', company: 'Matrix FinServe India', email: 'ananya.d@matrixfin.in', phone: '+919811223316', industry: 'Fintech' },
  { name: 'Sophia Kowalski', company: 'Polonia Industrial Build', email: 'sophia@poloniaconstruct.pl', phone: '+48221234517', industry: 'Construction' },
  { name: 'Gabriel Santos', company: 'Rio Tech Ventures', email: 'gabriel@riotech.br', phone: '+552199887718', industry: 'Venture Capital' },
  { name: 'Hannah Schmidt', company: 'Bavaria Industrial Auto', email: 'h.schmidt@bavariaauto.de', phone: '+498912345619', industry: 'Manufacturing' },
  { name: 'Tariq Hassan', company: 'Oasis Luxury Resorts', email: 'tariq@oasishotels.qa', phone: '+97444123420', industry: 'Hospitality' },
  { name: 'Emma Watson', company: 'Oxford EduBridge', email: 'emma@oxfordedubridge.co.uk', phone: '+442079460921', industry: 'EdTech' },
  { name: 'Vikram Mehta', company: 'Kavach Insurance Tech', email: 'vikram.m@kavachinsure.in', phone: '+919820011222', industry: 'InsurTech' },
  { name: 'Isabella Rossi', company: 'Milano Haute Couture', email: 'isabella@milanocouture.it', phone: '+390212345623', industry: 'Apparel' },
  { name: 'Nathaniel Drake', company: 'Uncharted Air Freight', email: 'nate@unchartedlog.com', phone: '+14155553024', industry: 'Freight' },
  { name: 'Zainab Qureshi', company: 'Indus Pure Tea Traders', email: 'zainab@industea.pk', phone: '+922134567825', industry: 'FMCG' },
  { name: 'Oliver Hansen', company: 'Nordic Clean Grids', email: 'oliver@nordicclean.dk', phone: '+4532123426', industry: 'Renewable Energy' },
  { name: 'Jessica Taylor', company: 'PrimeCare Clinics', email: 'jtaylor@primecareclinics.com', phone: '+14155553027', industry: 'Healthcare' },
  { name: 'Daniel Kim', company: 'Seoul Machine Intelligence', email: 'daniel.kim@seoulai.kr', phone: '+8225550128', industry: 'AI & Analytics' },
  { name: 'Larissa Gomez', company: 'Costa Brava Hospitality', email: 'larissa@costabravahotels.es', phone: '+34911234529', industry: 'Travel' },
  { name: 'Benjamin Hayes', company: 'Keystone Legal Corporate', email: 'bhayes@keystonelegal.com', phone: '+14155553030', industry: 'Legal' },
  { name: 'Aarav Singhania', company: 'Singhania Steel Works', email: 'aarav@singhaniasteel.com', phone: '+919830112231', industry: 'Manufacturing' },
  { name: 'Maya Lin', company: 'Verdant Architecture', email: 'maya.lin@verdantarch.sg', phone: '+6567890132', industry: 'Architecture' },
  { name: 'Dmitri Volkov', company: 'Aurora Cyber Defense', email: 'dmitri@auroradefense.ee', phone: '+3725123433', industry: 'Cybersecurity' },
  { name: 'Nia Adebayo', company: 'Lagos FinTech Direct', email: 'nia.a@lagosfintech.ng', phone: '+234801234534', industry: 'Fintech' },
  { name: 'Ethan Hunt', company: 'Apex Media Productions', email: 'ethan@apexmediapro.com', phone: '+14155553035', industry: 'Media & Entertainment' },
  { name: 'Leila Karim', company: 'Casablanca Trading Co.', email: 'leila@casablancatrade.ma', phone: '+212522123436', industry: 'Trading' },
  { name: 'Mateo Hernandez', company: 'Bogota Organic Coffee', email: 'mateo@bogotacoffee.co', phone: '+5712345637', industry: 'Food & Beverage' },
  { name: 'Freja Lindqvist', company: 'Stockholm Green Tech', email: 'freja@stockholmtech.se', phone: '+46812345638', industry: 'Sustainability' },
  { name: 'Siddharth Rao', company: 'Bangalore Cloud Labs', email: 'sid.rao@bangalorecloud.io', phone: '+919845012339', industry: 'Cloud & DevOps' },
  { name: 'Clara Oswald', company: 'London Retail Brands', email: 'clara@londonbrands.co.uk', phone: '+442079460940', industry: 'Retail' },
  { name: 'Zane Gallagher', company: 'Sydney Horizon Marine', email: 'zane@horizonmarine.com.au', phone: '+61298765441', industry: 'Maritime' },
  { name: 'Hassan Mansouri', company: 'Cairo Textile Mills', email: 'hassan@cairotextiles.eg', phone: '+20223456742', industry: 'Textiles' },
  { name: 'Yuki Tanaka', company: 'Kyoto Artisan Teas', email: 'yuki@kyototeas.jp', phone: '+81755550143', industry: 'Hospitality' },
  { name: 'Beatriz Costa', company: 'Lisbon Urban Mobility', email: 'beatriz@lisbonmobility.pt', phone: '+351213456744', industry: 'Transportation' },
  { name: 'Kavita Verma', company: 'Pulse Pharma Solutions', email: 'kavita@pulsepharma.in', phone: '+919867012345', industry: 'Pharmaceuticals' },
  { name: 'Alexander Brandt', company: 'Zurich Precision Tools', email: 'a.brandt@zurichtools.ch', phone: '+41441234546', industry: 'Engineering' },
  { name: 'Noor Al-Zahrani', company: 'Riyadh Smart Solutions', email: 'noor@riyadhsmart.sa', phone: '+966112345647', industry: 'Smart Cities' },
  { name: 'George Papadopoulos', company: 'Aegean Yacht Charters', email: 'george@aegeanyachts.gr', phone: '+302101234548', industry: 'Tourism' },
  { name: 'Tara Campbell', company: 'Vancouver BioAgri', email: 'tara@vancouverbioagri.ca', phone: '+16045550149', industry: 'AgriTech' },
  { name: 'Devendra Joshi', company: 'Apex Edutech Platform', email: 'dev.joshi@apexedutech.in', phone: '+919819012350', industry: 'EdTech' }
];

const SAMPLE_NOTES = [
  'Inquired via WhatsApp for multi-agent support (20+ seats). Sent enterprise brochure.',
  'Lead requested API documentation for integrating with their custom internal ERP.',
  'Had a positive 30-min discovery call. Decision maker requested pricing proposal.',
  'Interested in automated WhatsApp Broadcast campaigns & interactive templates.',
  'Budget approved for Q3 rollout. Follow-up meeting scheduled next week.',
  'High priority lead. Reached out after viewing the product demo on YouTube.'
];

const SAMPLE_MESSAGES = [
  {
    inbound: "Hello! We are looking for an official WhatsApp Business CRM for our 15-person sales team. Can you share plan details?",
    outbound: "Hi! Thanks for getting in touch. Our CRM provides multi-agent shared inbox, automated pipelines, and broadcast messaging. Are you looking to connect 1 number or multiple?"
  },
  {
    inbound: "Hey! Does your CRM allow triggering automated WhatsApp follow-ups when deals move stages?",
    outbound: "Yes! Our visual automation builder allows automatic message triggers on stage changes, new contacts, keywords, and webhook events."
  },
  {
    inbound: "Hi team, we'd like to schedule an onboarding demo for our team leaders tomorrow.",
    outbound: "Hello! We'd be glad to host a live demo for your team. Would 3:00 PM work for everyone?"
  }
];

const DEFAULT_TAGS = [
  { name: 'Hot Lead', color: '#ef4444' },
  { name: 'Enterprise', color: '#8b5cf6' },
  { name: 'Inbound', color: '#3b82f6' },
  { name: 'Qualified', color: '#f59e0b' },
  { name: 'SMB', color: '#06b6d4' },
  { name: 'Referral', color: '#10b981' },
  { name: 'Follow-up', color: '#f97316' },
  { name: 'Demo Scheduled', color: '#6366f1' },
  { name: 'High Priority', color: '#dc2626' },
  { name: 'VIP Client', color: '#ec4899' }
];

async function seedUser50() {
  const targetEmail = 'parammavani21@gmail.com';
  console.log(`🚀 Seeding 50 Scattered Leads for "${targetEmail}"...`);

  // 1. Fetch user & account
  const { data: profiles } = await supabase.from('profiles').select('*').eq('email', targetEmail);
  const profile = profiles?.[0];
  if (!profile) {
    console.error(`✕ Profile not found for ${targetEmail}`);
    return;
  }

  const userId = profile.user_id;
  const accountId = profile.account_id;

  // 2. Fetch or create pipeline
  const { data: pipelines } = await supabase
    .from('pipelines')
    .select('*, pipeline_stages(*)')
    .eq('account_id', accountId);

  let pipeline = pipelines?.[0];
  if (!pipeline || !pipeline.pipeline_stages || pipeline.pipeline_stages.length === 0) {
    console.log('  → Creating default Sales Pipeline with 5 stages...');
    const { data: newPipe } = await supabase
      .from('pipelines')
      .insert({
        user_id: userId,
        account_id: accountId,
        name: 'Sales Pipeline'
      })
      .select()
      .single();

    const stageNames = [
      { name: 'New Lead', color: '#3b82f6', pos: 0 },
      { name: 'Qualified', color: '#eab308', pos: 1 },
      { name: 'Proposal Sent', color: '#f97316', pos: 2 },
      { name: 'Negotiation', color: '#8b5cf6', pos: 3 },
      { name: 'Won', color: '#22c55e', pos: 4 }
    ];

    const createdStages = [];
    for (const s of stageNames) {
      const { data: stage } = await supabase
        .from('pipeline_stages')
        .insert({
          pipeline_id: newPipe.id,
          name: s.name,
          color: s.color,
          position: s.pos
        })
        .select()
        .single();
      if (stage) createdStages.push(stage);
    }
    newPipe.pipeline_stages = createdStages;
    pipeline = newPipe;
  }

  const stages = pipeline.pipeline_stages.sort((a, b) => a.position - b.position);
  console.log(`  → Found ${stages.length} stages:`, stages.map(s => s.name).join(' → '));

  // 3. Ensure Tags exist
  console.log('  → Ensuring tags exist...');
  const tagMap = {};
  for (const tag of DEFAULT_TAGS) {
    const { data: existing } = await supabase
      .from('tags')
      .select('id, name')
      .eq('account_id', accountId)
      .eq('name', tag.name)
      .maybeSingle();

    if (existing) {
      tagMap[existing.name] = existing.id;
    } else {
      const { data: created } = await supabase
        .from('tags')
        .insert({
          user_id: userId,
          account_id: accountId,
          name: tag.name,
          color: tag.color
        })
        .select()
        .single();

      if (created) {
        tagMap[created.name] = created.id;
      }
    }
  }

  // 4. Clean old records for this account if any
  await supabase.from('deals').delete().eq('account_id', accountId);
  await supabase.from('contacts').delete().eq('account_id', accountId);

  // 5. Insert 50 contacts
  console.log('  → Inserting 50 realistic scattered contacts...');
  const createdContacts = [];
  for (let i = 0; i < LEADS_50.length; i++) {
    const item = LEADS_50[i];
    const createdAt = randomDateInPast(35);

    const { data: contact, error } = await supabase
      .from('contacts')
      .insert({
        user_id: userId,
        account_id: accountId,
        name: item.name,
        email: item.email,
        phone: item.phone,
        company: item.company,
        created_at: createdAt,
        updated_at: createdAt
      })
      .select()
      .single();

    if (contact) {
      createdContacts.push({ ...contact, industry: item.industry });

      // Attach 1-3 tags
      const numTags = randomInt(1, 3);
      const tagKeys = Object.keys(tagMap);
      const chosenTags = [];
      while (chosenTags.length < numTags && tagKeys.length > 0) {
        const t = randomChoice(tagKeys);
        if (!chosenTags.includes(t)) chosenTags.push(t);
      }

      for (const tName of chosenTags) {
        if (tagMap[tName]) {
          await supabase.from('contact_tags').insert({
            contact_id: contact.id,
            tag_id: tagMap[tName],
            created_at: createdAt
          });
        }
      }

      // Add contact note for ~70% of leads
      if (Math.random() > 0.3) {
        await supabase.from('contact_notes').insert({
          contact_id: contact.id,
          user_id: userId,
          account_id: accountId,
          note_text: randomChoice(SAMPLE_NOTES),
          created_at: createdAt
        });
      }

      // Add conversations & messages for ~65% of leads
      if (Math.random() > 0.35) {
        const msg = randomChoice(SAMPLE_MESSAGES);
        const { data: conv } = await supabase
          .from('conversations')
          .insert({
            user_id: userId,
            account_id: accountId,
            contact_id: contact.id,
            status: randomChoice(['open', 'open', 'pending']),
            last_message_text: msg.outbound,
            last_message_at: createdAt,
            unread_count: 0,
            created_at: createdAt,
            updated_at: createdAt
          })
          .select()
          .single();

        if (conv) {
          await supabase.from('messages').insert({
            conversation_id: conv.id,
            sender_type: 'customer',
            content_type: 'text',
            content_text: msg.inbound,
            status: 'delivered',
            created_at: createdAt
          });

          const replyTime = new Date(new Date(createdAt).getTime() + 15 * 60000).toISOString();
          await supabase.from('messages').insert({
            conversation_id: conv.id,
            sender_type: 'agent',
            content_type: 'text',
            content_text: msg.outbound,
            status: 'read',
            created_at: replyTime
          });
        }
      }
    }
  }

  console.log(`  ✓ Inserted ${createdContacts.length} contacts.`);

  // 6. Insert 50 Deals evenly scattered across 5 stages (10 per stage)
  console.log('  → Inserting 50 scattered deals across pipeline stages...');
  const dealsToInsert = createdContacts.map((contact, i) => {
    const stage = stages[i % stages.length]; // 10 per stage
    const isWon = stage.name === 'Won';
    const dealTitles = [
      `${contact.company || contact.name} — Enterprise WhatsApp Suite`,
      `${contact.company || contact.name} — Team Growth CRM Plan`,
      `${contact.company || contact.name} — Broadcast & Campaigns License`,
      `${contact.company || contact.name} — Custom Sales Pipeline Setup`,
      `${contact.company || contact.name} — Multi-Agent CRM Onboarding`
    ];

    const dealValue = randomChoice([2500, 3800, 6200, 9500, 14000, 22500, 38000, 54000, 72000]);
    const closeDate = new Date();
    closeDate.setDate(closeDate.getDate() + randomInt(5, 60));

    return {
      user_id: userId,
      account_id: accountId,
      pipeline_id: pipeline.id,
      stage_id: stage.id,
      contact_id: contact.id,
      title: dealTitles[i % dealTitles.length],
      value: dealValue,
      currency: 'USD',
      status: isWon ? 'won' : 'open',
      expected_close_date: closeDate.toISOString().split('T')[0],
      notes: `Lead in ${contact.industry} sector. Primary contact: ${contact.name} (${contact.phone}).`,
      created_at: contact.created_at,
      updated_at: contact.created_at
    };
  });

  const { data: insertedDeals, error: dealErr } = await supabase
    .from('deals')
    .insert(dealsToInsert)
    .select();

  if (dealErr) {
    console.error('✕ Error inserting deals:', dealErr);
  } else {
    console.log(`  ✓ Successfully inserted ${insertedDeals.length} deals across stages.`);
  }

  console.log(`\n🎉 50 Scattered Leads Successfully Seeded for "${targetEmail}"!`);
}

seedUser50().catch(err => {
  console.error('Fatal error:', err);
  process.exit(1);
});
