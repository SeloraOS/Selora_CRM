#!/usr/bin/env bash

# ==============================================================================
# local.sh - Local Development Setup & Runner for wacrm
# ==============================================================================

set -e

# Styling & Colors
BOLD='\033[1m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
RED='\033[0;31m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

echo -e "${BOLD}${CYAN}"
echo "  __      __   _     ___ ___  __  __ "
echo "  \ \    / /  /_\   / __| _ \|  \/  |"
echo "   \ \/\/ /  / _ \ | (__|   /| |\/| |"
echo "    \_/\_/  /_/ \_\ \___|_|_\|_|  |_|"
echo -e "${NC}"
echo -e "${BOLD}Starting wacrm Local Development Environment...${NC}\n"

# 1. Check Node.js and npm version
echo -e "${BLUE}==>${NC} ${BOLD}Checking system prerequisites...${NC}"

if ! command -v node &> /dev/null; then
  echo -e "${RED}[ERROR] Node.js is not installed. Please install Node.js >= 20.0.0.${NC}"
  exit 1
fi

NODE_VERSION=$(node -v | sed 's/^v//')
NODE_MAJOR=$(echo "$NODE_VERSION" | cut -d. -f1)

if [ "$NODE_MAJOR" -lt 20 ]; then
  echo -e "${RED}[ERROR] Node.js version $NODE_VERSION detected. wacrm requires Node.js >= 20.0.0.${NC}"
  exit 1
fi

echo -e "${GREEN}✓${NC} Node.js v$NODE_VERSION detected."
echo -e "${GREEN}✓${NC} npm $(npm -v) detected."

# 2. Environment Configuration (.env.local)
echo -e "\n${BLUE}==>${NC} ${BOLD}Checking environment configuration (.env.local)...${NC}"

if [ ! -f ".env.local" ]; then
  echo -e "${YELLOW}[!] .env.local not found. Creating from .env.local.example...${NC}"
  cp .env.local.example .env.local
fi

# Check and generate ENCRYPTION_KEY if placeholder or empty
CURRENT_ENC_KEY=$(grep -E "^ENCRYPTION_KEY=" .env.local | cut -d'=' -f2- | tr -d ' "' || true)
if [ -z "$CURRENT_ENC_KEY" ] || [ "$CURRENT_ENC_KEY" = "your-64-char-hex-key-here" ]; then
  echo -e "${YELLOW}[!] Generating 32-byte AES-256-GCM ENCRYPTION_KEY...${NC}"
  NEW_ENC_KEY=$(node -e "console.log(require('crypto').randomBytes(32).toString('hex'))")
  
  if grep -q "^ENCRYPTION_KEY=" .env.local; then
    sed -i "s/^ENCRYPTION_KEY=.*/ENCRYPTION_KEY=${NEW_ENC_KEY}/" .env.local
  else
    echo "ENCRYPTION_KEY=${NEW_ENC_KEY}" >> .env.local
  fi
  echo -e "${GREEN}✓${NC} ENCRYPTION_KEY generated and saved to .env.local."
else
  echo -e "${GREEN}✓${NC} ENCRYPTION_KEY is configured."
fi

# Enable dry-run for WhatsApp templates in local dev by default if not set
if ! grep -q "^WHATSAPP_TEMPLATES_DRY_RUN=" .env.local; then
  echo "WHATSAPP_TEMPLATES_DRY_RUN=true" >> .env.local
  echo -e "${GREEN}✓${NC} Enabled WHATSAPP_TEMPLATES_DRY_RUN=true for local testing."
fi

# Check for placeholder Supabase variables
SUPABASE_URL=$(grep -E "^NEXT_PUBLIC_SUPABASE_URL=" .env.local | cut -d'=' -f2- | tr -d ' "' || true)
SUPABASE_ANON_KEY=$(grep -E "^NEXT_PUBLIC_SUPABASE_ANON_KEY=" .env.local | cut -d'=' -f2- | tr -d ' "' || true)
SUPABASE_SERVICE_ROLE=$(grep -E "^SUPABASE_SERVICE_ROLE_KEY=" .env.local | cut -d'=' -f2- | tr -d ' "' || true)

if [ "$SUPABASE_URL" = "https://your-project.supabase.co" ] || [ -z "$SUPABASE_URL" ] || \
   [ "$SUPABASE_ANON_KEY" = "your-anon-key" ] || [ -z "$SUPABASE_ANON_KEY" ] || \
   [ "$SUPABASE_SERVICE_ROLE" = "your-service-role-key" ] || [ -z "$SUPABASE_SERVICE_ROLE" ]; then
  echo -e "\n${YELLOW}----------------------------------------------------------------------${NC}"
  echo -e "${YELLOW}${BOLD}[WARNING] Supabase credentials need to be configured in .env.local:${NC}"
  echo -e "  - NEXT_PUBLIC_SUPABASE_URL"
  echo -e "  - NEXT_PUBLIC_SUPABASE_ANON_KEY"
  echo -e "  - SUPABASE_SERVICE_ROLE_KEY"
  echo -e "\nIf you haven't set up Supabase yet, you can:"
  echo -e "  1. Use hosted Supabase at ${CYAN}https://supabase.com${NC} and copy API keys"
  echo -e "  2. Or run local Supabase with: ${CYAN}npx supabase start${NC}"
  echo -e "${YELLOW}----------------------------------------------------------------------${NC}\n"
fi

# 3. Install Dependencies
echo -e "${BLUE}==>${NC} ${BOLD}Checking dependencies...${NC}"

if [ ! -d "node_modules" ] || [ "package.json" -nt "node_modules" ]; then
  echo -e "${YELLOW}[!] Installing project dependencies via npm...${NC}"
  npm install
  echo -e "${GREEN}✓${NC} Dependencies installed."
else
  echo -e "${GREEN}✓${NC} Dependencies are up to date."
fi

# 4. Starting Dev Server
echo -e "\n${BLUE}==>${NC} ${BOLD}Launching Next.js development server...${NC}"
echo -e "${GREEN}${BOLD}✓ Application will be available at:${NC} ${CYAN}http://localhost:3000${NC}\n"

# Run development server
exec npm run dev
