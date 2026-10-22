#!/usr/bin/env bash
# Deploy on the VPS: pull the latest main, build, and restart the pm2 process.
#   ssh oracle "cd ~/Selora_CRM && ./scripts/deploy.sh"
# The app runs under pm2 as "wacrm" (npm start -p 3000) behind Caddy.
# Needs .env.local with the Supabase / Meta keys (never committed).
set -euo pipefail
cd "$(dirname "$0")/.."

[ -f .env.local ] || { echo "missing .env.local" >&2; exit 1; }

# Generated files that the build rewrites on the server
git checkout -- next-env.d.ts package-lock.json 2>/dev/null || true

git fetch --quiet origin main
git merge --ff-only origin/main

npm ci --no-audit --no-fund
npm test --silent
npm run build

if pm2 describe wacrm >/dev/null 2>&1; then
  pm2 restart wacrm --update-env
else
  pm2 start npm --name wacrm -- start -- -p 3000
fi
pm2 save >/dev/null
echo "deployed $(git rev-parse --short HEAD) as pm2 app wacrm"
