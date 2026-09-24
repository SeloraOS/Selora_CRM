/**
 * scripts/seed-leads.js
 * Generates 30 realistic, scattered sample leads with contacts, tags, deals,
 * notes, and conversations across pipeline stages for wacrm.
 */

const fs = require('fs');
const path = require('path');
const { createClient } = require('@supabase/supabase-js');

// 1. Load environment variables from .env.local
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

// Random helpers
function randomChoice(arr) {
  return arr[Math.floor(Math.random() * arr.length)];
}

function randomInt(min, max) {
  return Math.floor(Math.random() * (max - min + 1)) + min;
}

function randomDateInPast(days = 30) {
  const date = new Date();
  date.setDate(date.getDate() - randomInt(0, days));
  date.setHours(randomInt(9, 18), randomInt(0, 59), randomInt(0, 59));
  return date.toISOString();
}

function randomFutureDate(days = 45) {
  const date = new Date();
  date.setDate(date.getDate() + randomInt(3, days));
  return date.toISOString().split('T')[0];
}

const LEAD_DATA = [
  { name: 'Sarah Jenkins', company: 'Apex Cloud Solutions', email: 'sarah.jenkins@apexcloud.io', phone: '+14155552001', industry: 'SaaS' },
  { name: 'Alexander Wright', company: 'Vanguard Logistics', email: 'a.wright@vanguardlog.com', phone: '+14155552002', industry: 'Logistics' },
  { name: 'Priya Sharma', company: 'Nova Healthtech', email: 'priya.sharma@novahealth.org', phone: '+919876543201', industry: 'Healthcare' },
  { name: 'Marcus Vance', company: 'Titan Real Estate', email: 'mvance@titanestates.com', phone: '+14155552004', industry: 'Real Estate' },
  { name: 'Elena Rostova', company: 'CyberFlow Security', email: 'elena@cyberflow.tech', phone: '+442079460911', industry: 'Cybersecurity' },
  { name: 'David Miller', company: 'BlueWave eCommerce', email: 'david.m@bluewave.shop', phone: '+14155552006', industry: 'E-commerce' },
  { name: 'Fatima Al-Mansoor', company: 'Gulf Trade Connect', email: 'fatima@gulftrade.ae', phone: '+971501234507', industry: 'Import/Export' },
  { name: 'Lucas Silva', company: 'Solaria Solar Energy', email: 'lucas.silva@solariaenergy.com', phone: '+551198765408', industry: 'CleanTech' },
  { name: 'Chloe Dubois', company: 'Lumiere Digital Agency', email: 'chloe@lumieredigital.fr', phone: '+33142685509', industry: 'Marketing' },
  { name: 'Kenji Takahashi', company: 'OmniRobotics Japan', email: 'kenji.t@omnirobotics.jp', phone: '+81355550110', industry: 'Robotics' },
  { name: 'Carlos Mendez', company: 'Andes Supply Chain', email: 'carlos@andessupply.co', phone: '+525512345611', industry: 'Supply Chain' },
  { name: 'Amina Diallo', company: 'Sahel Agro Foods', email: 'amina.d@sahelagro.com', phone: '+221771234512', industry: 'Agriculture' },
  { name: 'Julian Mercer', company: 'Zenith Wealth Advisors', email: 'jmercer@zenithwealth.com', phone: '+14155552013', industry: 'Financial Services' },
  { name: 'Mei-Ling Chen', company: 'Quantum Biotech', email: 'ml.chen@quantumbiotech.tw', phone: '+886223456714', industry: 'Biotech' },
  { name: 'Liam O’Connor', company: 'Emerald Fleet Hire', email: 'liam@emeraldfleet.ie', phone: '+35314960115', industry: 'Automotive' },
  { name: 'Rohan Kapoor', company: 'InstaCart Retailers', email: 'rohan.k@instacartretail.in', phone: '+919811223316', industry: 'Retail' },
  { name: 'Sophia Kowalski', company: 'Polonia Construction', email: 'sophia@poloniaconstruct.pl', phone: '+48221234517', industry: 'Construction' },
  { name: 'Gabriel Santos', company: 'Rio Tech Accelerator', email: 'gabriel@riotech.br', phone: '+552199887718', industry: 'Venture Capital' },
  { name: 'Hannah Schmidt', company: 'Bavaria Automation', email: 'h.schmidt@bavariaauto.de', phone: '+498912345619', industry: 'Manufacturing' },
  { name: 'Tariq Hassan', company: 'Oasis Hospitality Group', email: 'tariq@oasishotels.qa', phone: '+97444123420', industry: 'Hospitality' },
  { name: 'Emma Watson', company: 'Oxford Tutoring Hub', email: 'emma@oxfordhub.co.uk', phone: '+442079460921', industry: 'EdTech' },
  { name: 'Vikram Mehta', company: 'Matrix FinServe', email: 'vikram.m@matrixfin.in', phone: '+919820011222', industry: 'Fintech' },
  { name: 'Isabella Rossi', company: 'Milano Fashion Direct', email: 'isabella@milanofashion.it', phone: '+390212345623', industry: 'Apparel' },
  { name: 'Nathaniel Drake', company: 'Uncharted Logistics', email: 'nate@unchartedlog.com', phone: '+14155552024', industry: 'Freight' },
  { name: 'Zainab Qureshi', company: 'Indus Organic Tea', email: 'zainab@industea.pk', phone: '+922134567825', industry: 'FMCG' },
  { name: 'Oliver Hansen', company: 'Nordic Clean Power', email: 'oliver@nordicclean.dk', phone: '+4532123426', industry: 'Energy' },
  { name: 'Jessica Taylor', company: 'PrimeCare Insurance', email: 'jtaylor@primecareins.com', phone: '+14155552027', industry: 'Insurance' },
  { name: 'Daniel Kim', company: 'Seoul AI Labs', email: 'daniel.kim@seoulailabs.kr', phone: '+8225550128', industry: 'AI & Data' },
  { name: 'Larissa Gomez', company: 'Sol Tropical Resorts', email: 'larissa@solresorts.es', phone: '+34911234529', industry: 'Travel' },
  { name: 'Benjamin Hayes', company: 'Keystone Legal Partners', email: 'bhayes@keystonelegal.com', phone: '+14155552030', industry: 'Legal' }
];

const SAMPLE_NOTES = [
  'Customer contacted via WhatsApp asking for volume discount pricing.',
  'Had a 20-minute intro call. Very interested in WhatsApp shared inbox + automations.',
  'Requires SOC2 compliance info and multi-agent access for a 25-person support team.',
  'Sent product one-pager and demo recording. Decision maker reviewing this week.',
  'Requested a customized pricing proposal with annual billing.',
  'Follow-up scheduled for next Tuesday to finalize the onboarding schedule.'
];

const SAMPLE_MESSAGES = [
  {
    inbound: "Hi! We're looking for a WhatsApp CRM solution for our sales team. Can you share pricing?",
    outbound: "Hello! Thanks for reaching out. We have flexible plans tailored to your team size. Are you looking to connect 1 number or multiple agents?"
  },
  {
    inbound: "Hey team, saw your broadcast demo. Can we schedule a quick walkthrough tomorrow?",
    outbound: "Hi! Absolutely, we would love to show you around. Does 2:00 PM EST work for you?"
  },
  {
    inbound: "Quick question: does your WhatsApp integration support automated drip campaigns?",
    outbound: "Yes! Our visual automation builder lets you trigger custom sequences with conditional logic and delays."
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
  { name: 'Demo Scheduled', color: '#6366f1' }
];

async function seedAccount(account, profile, pipeline) {
  console.log(`\n🌱 Seeding for Account: "${account.name}" (${account.id})`);
  const userId = profile.user_id;
  const accountId = account.id;

  // 1. Seed or fetch Tags
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
      const { data: created, error } = await supabase
        .from('tags')
        .insert({
          user_id: userId,
          account_id: accountId,
          name: tag.name,
          color: tag.color
        })
        .select()
        .single();

      if (!error && created) {
        tagMap[created.name] = created.id;
      }
    }
  }

  const stages = pipeline.pipeline_stages || [];
  if (stages.length === 0) {
    console.error('  ✕ No pipeline stages found for pipeline:', pipeline.id);
    return;
  }

  // Sort stages by position
  stages.sort((a, b) => a.position - b.position);

  console.log(`  → Found ${stages.length} pipeline stages:`, stages.map(s => s.name).join(' → '));

  // 2. Insert 30 scattered leads
  let createdCount = 0;
  for (let i = 0; i < LEAD_DATA.length; i++) {
    const item = LEAD_DATA[i];
    const createdAt = randomDateInPast(25);

    // Create Contact
    const { data: contact, error: contactError } = await supabase
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

    if (contactError || !contact) {
      console.warn(`  ⚠ Warning creating contact ${item.name}:`, contactError?.message);
      continue;
    }

    // Attach 1-3 random tags
    const numTags = randomInt(1, 3);
    const tagKeys = Object.keys(tagMap);
    const selectedTags = [];
    while (selectedTags.length < numTags && tagKeys.length > 0) {
      const randomTag = randomChoice(tagKeys);
      if (!selectedTags.includes(randomTag)) {
        selectedTags.push(randomTag);
      }
    }

    for (const tagName of selectedTags) {
      const tagId = tagMap[tagName];
      if (tagId) {
        await supabase.from('contact_tags').insert({
          contact_id: contact.id,
          tag_id: tagId,
          created_at: createdAt
        });
      }
    }

    // Add a random contact note for some contacts
    if (Math.random() > 0.3) {
      await supabase.from('contact_notes').insert({
        contact_id: contact.id,
        user_id: userId,
        account_id: accountId,
        note_text: randomChoice(SAMPLE_NOTES),
        created_at: createdAt
      });
    }

    // Pick stage (scattered distribution: slightly more in early/mid stages, some won)
    // Stage weights: 0: 35%, 1: 25%, 2: 20%, 3: 12%, 4: 8%
    const stageIdx = i % stages.length; // ensures even scattering across all stages
    const stage = stages[stageIdx];
    const dealValue = randomChoice([1500, 2400, 4800, 7500, 12000, 18500, 25000, 36000, 45000, 60000]);
    const isWon = stage.name.toLowerCase().includes('won');

    // Create Conversation & sample messages for ~60% of leads
    let conversationId = null;
    if (Math.random() > 0.35) {
      const msgSample = randomChoice(SAMPLE_MESSAGES);
      const { data: conv } = await supabase
        .from('conversations')
        .insert({
          user_id: userId,
          account_id: accountId,
          contact_id: contact.id,
          status: isWon ? 'closed' : randomChoice(['open', 'open', 'pending']),
          last_message_text: msgSample.outbound,
          last_message_at: createdAt,
          unread_count: 0,
          created_at: createdAt,
          updated_at: createdAt
        })
        .select()
        .single();

      if (conv) {
        conversationId = conv.id;
        // Inbound message
        await supabase.from('messages').insert({
          conversation_id: conv.id,
          sender_type: 'customer',
          content_type: 'text',
          content_text: msgSample.inbound,
          status: 'delivered',
          created_at: createdAt
        });

        // Outbound agent reply
        const replyTime = new Date(new Date(createdAt).getTime() + 12 * 60000).toISOString();
        await supabase.from('messages').insert({
          conversation_id: conv.id,
          sender_type: 'agent',
          content_type: 'text',
          content_text: msgSample.outbound,
          status: 'read',
          created_at: replyTime
        });
      }
    }

    // Create Deal linked to contact, stage, and conversation
    const dealTitles = [
      `${item.company} — WhatsApp CRM License`,
      `${item.company} — Team Enterprise Onboarding`,
      `${item.company} — Broadcast & Automation Suite`,
      `${item.company} — Custom Sales Pipeline Setup`,
      `${item.company} — Annual Multi-Agent Support`
    ];

    const { error: dealError } = await supabase
      .from('deals')
      .insert({
        user_id: userId,
        account_id: accountId,
        pipeline_id: pipeline.id,
        stage_id: stage.id,
        contact_id: contact.id,
        conversation_id: conversationId,
        title: randomChoice(dealTitles),
        value: dealValue,
        currency: 'USD',
        status: isWon ? 'won' : 'open',
        expected_close_date: randomFutureDate(60),
        notes: `Lead from ${item.industry} sector. Primary contact: ${item.name} (${item.phone}).`,
        created_at: createdAt,
        updated_at: createdAt
      });

    if (!dealError) {
      createdCount++;
    }
  }

  console.log(`  ✓ Successfully created ${createdCount} scattered leads with deals and contacts!`);
}

async function main() {
  console.log('🚀 Seeding 30 Scattered Sample Leads into Supabase...');

  // Fetch accounts and profiles
  const { data: accounts, error: accError } = await supabase.from('accounts').select('*');
  const { data: profiles, error: profError } = await supabase.from('profiles').select('*');
  const { data: pipelines, error: pipeError } = await supabase.from('pipelines').select('*, pipeline_stages(*)');

  if (accError || !accounts || accounts.length === 0) {
    console.error('✕ Failed to fetch accounts:', accError?.message || 'No accounts found.');
    return;
  }

  for (const account of accounts) {
    const profile = profiles.find(p => p.account_id === account.id || p.user_id === account.owner_user_id) || profiles[0];
    let pipeline = pipelines.find(p => p.account_id === account.id || p.user_id === profile.user_id);

    if (!pipeline) {
      console.log(`  → Creating default Sales Pipeline for account ${account.name}...`);
      const { data: newPipe } = await supabase
        .from('pipelines')
        .insert({
          user_id: profile.user_id,
          account_id: account.id,
          name: 'Sales Pipeline'
        })
        .select()
        .single();

      if (newPipe) {
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
    }

    if (pipeline) {
      await seedAccount(account, profile, pipeline);
    }
  }

  console.log('\n🎉 Seeding complete! Check your CRM contacts and pipeline boards.');
}

main().catch(err => {
  console.error('Fatal error during seed:', err);
  process.exit(1);
});
