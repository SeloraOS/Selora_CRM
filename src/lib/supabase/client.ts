import { createBrowserClient } from '@supabase/ssr'
import type { SupabaseClient } from '@supabase/supabase-js'

// Singleton instance — one client shared across the whole browser session.
// Creating multiple clients causes auth-lock contention ("Lock was released
// because another request stole it") and intermittent fetch failures.
let browserClient: SupabaseClient | undefined

export function createClient() {
  if (browserClient) return browserClient

  browserClient = createBrowserClient(
    process.env.NEXT_PUBLIC_SUPABASE_URL!,
    process.env.NEXT_PUBLIC_SUPABASE_ANON_KEY!,
    {
      global: {
        // Never serve API data from the browser's HTTP cache. Some responses (e.g. a 300
        // "Multiple Choices" from PostgREST when an embed is ambiguous) are cacheable by
        // default, and a replayed stale error shows up as an empty page long after the
        // underlying problem is fixed. CRM data must always come from the server.
        fetch: (input, init) => fetch(input, { ...init, cache: 'no-store' }),
      },
    }
  )

  return browserClient
}
