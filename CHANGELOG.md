# Step Quest Changelog

*In the tradition of Dwarf Fortress patch notes*

---

## v0.8.0 - "A Strange Game" (2026-01-25)

### The Diplomat's Retreat
- **The Watchers Cry Wolf** (Security Scanners) — GitHub and Google Cloud sound the alarm
  - The Firebase API key, visible in the landing page, triggered automated guardians
  - "Your credentials have been compromised!" they warned
  - The key was never a secret — it's an identifier, not a password
  - But the watchers do not understand nuance

### The Engineer's Folly
- **A Cloud Function Rises** (functions/) — An elaborate tunnel is dug
  - A Node.js function to proxy waitlist submissions
  - IAM permissions granted: logging, storage, artifact registry
  - The build succeeds, the function deploys
  - "403 Forbidden" — the organization policy blocks public access
  - The tunnel collapses before reaching the surface

### The Sage's Wisdom
- **The Waitlist Falls Silent** (Landing Page) — The feature is removed entirely
  - No form, no Firebase SDK, no API key exposure
  - "🍎 iOS - Coming Soon" remains as a simple promise
  - The `functions/` directory preserved as a monument to hubris

### The Purge
- **The Key Returns to the Void** (API Key Deleted) — The exposed key is revoked
  - Web API key deleted from GCP, not just removed from code
  - Git history spelunkers will find only a useless relic
  - Android key was never in the repo (lives only in the local forge)

### The Patron's Hall Opens
- **A Place for Supporters** (Patreon) — The fortress welcomes benefactors
  - patreon.com/mqqn established
  - First post tells the origin story: from React screenshot to running app in a day
  - "Building with AI for human benefit. Sharing how it's done."
- **The Roads Connect** (Cross-linking) — All paths lead to the fortress
  - Patreon link added to landing page footer
  - Origin story linked from README
  - Beta invite email: apps+stepquest@mqqn.net

### Secrets of the Deep
- The only winning move is not to play
- Sometimes the simplest solution is no solution
- The Cloud Function sleeps in `functions/`, awaiting a future where org policies relent

---

## v0.7.0 - "The Quest for a Proper Address" (2026-01-25)

### The Mason's Work
- **A Proper Address at Last** (Custom Domain) — The fortress claims its place on the map
  - `step.quest.mqqn.net` now points to the landing page
  - Cloud DNS zone created for `quest.mqqn.net` namespace
  - Subdomain delegation from Gandi preserves email safety
  - Future quest apps can live at `*.quest.mqqn.net`

### The Scribes' Archives
- **A Map for Future Expeditions** (docs/DNS_SETUP.md) — The cartographers document their journey
  - Cloud DNS setup with subdomain delegation
  - Firebase Hosting custom domain configuration
  - Fourth-level domain considerations
  - Useful gcloud commands for DNS management

### Secrets of the Deep
- Firebase Hosting requires A records, not CNAME, for custom domains
- Default domains (`*.web.app`, `*.firebaseapp.com`) remain active alongside custom domain
- SSL certificate auto-provisioned by Firebase (minting takes 15-30 min)

---

## v0.6.0 - "The Watchtower Speaks Many Tongues" (2026-01-25)

### The Watchtower
- **Eyes on the Walls** (Firebase Crashlytics) — The fortress now reports when walls crumble
  - Three-layer error handling: Flutter errors, platform errors, zone errors
  - Crashes appear in Firebase Console automatically
  - The mountain spirits will know when something goes wrong

### The Translator's Guild
- **The Nordic Expansion** (da, nb, sv, fi, ca) — The northern realms join the quest
  - Danish (da) — For the Danes who march through wind and rain
  - Norwegian Bokmål (nb) — For the fjord-dwellers
  - Swedish (sv) — For those who brave the midnight sun
  - Finnish (fi) — For the sauna warriors
  - Catalan (ca) — For the builders of Sagrada Família
- Total: 13 languages + 2 secret (Klingon, Dwarven)

### The Scribes' Archives
- **The Watchtower Disclosed** (Privacy Policy) — The scribes document the new eyes
  - Crashlytics data collection disclosed
  - Link to Firebase privacy practices added
- **The Ledger Updated** (SECURITY.md) — Crash reports now recorded in fortress records

---

## v0.5.0 - "The Grand Opening" (2026-01-25)

### New Chambers
- **The Gates Open** (Google Play Store) — The fortress welcomes adventurers
  - Mobile app available on internal testing track
  - Wear OS app on dedicated form factor track
  - Automated CI/CD via GitHub Actions and Fastlane

- **The Patron's Coffer** (Tip Jar) — Real Google Play Billing integration
  - Three tiers: Coffee ($2), Supporter ($3), Legendary ($7)
  - Prime number pricing preserved
  - Consumable products (can tip multiple times)
  - Purchase status tracked locally

- **The Welcome Hall** (Landing Page) — Firebase Hosting at step-quest-485403.web.app
  - Beta testing links for Phone and Wear OS
  - Privacy policy for Play Store compliance

### The Scribes' Archives
- **The Guard's Codex** (SECURITY.md) — Vulnerability reporting via GitHub
- **The Free Banner** (README) — Updated with Free and Open Source section

### Secrets of the Deep
- Product flavors for mobile/wear separation
- Version codes: mobile uses even numbers, wear uses odd numbers
- Workload Identity Federation for keyless CI authentication
- BILLING permission added to AndroidManifest

---

## v0.4.0 - "The Tower of Babel Falls" (2026-01-24)

### The Translator's Guild
- **Many Tongues** (i18n Infrastructure) — The fortress learns to speak
  - English (en) - Base language
  - German (de) - For our European allies (EUR)
  - Spanish (es) - Para nuestros amigos hispanohablantes
  - Hindi (hi) - भारतीय साहसियों के लिए (INR)
  - Japanese (ja) - 日本の冒険者のために (JPY)
  - Portuguese (pt) - Para nossos amigos brasileiros (BRL)

### Secrets of the Deep
- ARB files for all 6 locales with 50+ translatable strings
- Flutter localization delegates configured
- XP remains universal (gaming lingua franca)

### Quests Fulfilled
- **The Words Migrate** (AppLocalizations) — All widget strings now speak the local tongue

---

## v0.3.0 - "The Supporter's Guild" (2026-01-24)

### New Chambers
- **The Patron's Guild** (Supporter System) — A tip jar for those who wish to fund the fortress
  - Three tiers with prime number pricing: Coffee ☕ ($2), Supporter ⭐ ($3), Legendary 👑 ($7)
  - Supporter badge displayed proudly in-app
  - Google Play IAP integration pending (prices will be localized per country)

- **The Oracle Speaks** (Health Connect Info Panel) — Expanded sync documentation
  - Explains the data flow: Fitness App → Health Connect → Step Quest
  - Lists compatible apps (Samsung Health, Google Fit, Fitbit, etc.)
  - Directs adventurers to GitHub for sensor feature requests

### Trade Routes
- **The Sponsor's Path** (GitHub Sponsors) — For the developer community
- **The Patron's Road** (Patreon) — For general audience supporters
- **The Open Scrolls** (Source Code) — Link for the curious and brave
- **The Hall of Patrons** (SUPPORTERS.md) — Public recognition of those who give

### The Architect's Wisdom
- **Prime Numbers** (Pricing) — Because $2, $3, and $7 are more elegant than $1.99
- **The Price of Coffee Worldwide** (PPP Auto-Pricing) — A tip should feel the same everywhere
  - Google's auto-pricing uses Purchasing Power Parity, not just exchange rates
  - A $2 coffee in San Francisco ≠ ₹166 in Mumbai — that's a fancy dinner
  - Play Console suggests ₹79, R$4.90, ¥200 — prices that feel like a coffee
  - 173 countries, zero manual spreadsheets, one fair gesture of support
- In-app purchases follow Google Play policies
- Both GitHub Sponsors AND Patreon for different audiences
- Open source remains free; tips fund development and keep ads at bay

---

## v0.2.0 - "The Health Connection" (2026-01-24)

### New Chambers
- **Tribute from the Realm** (Health Connect) — The fortress receives steps from fitness trackers
  - Automatic step syncing from Health Connect-compatible apps
  - Manual sync button for the impatient adventurer
  - Graceful fallback to manual logging when Health Connect is unavailable

### The Great Upheaval
- **The Ancient Devices Left Behind** (minSdk 26) — Android 8.0 Oreo becomes the threshold
  - The ancient devices of API 23-25 can no longer receive the blessings of Health Connect
  - Their inhabitants must seek adventure through other means

### Menaces Vanquished
- **The Sacred Colors Corrected** (Theme Fix) — The Health Connect card finds its true hue
  - The `xpGold` color, though noble in intent, did not exist in the theme scrolls
  - Replaced with `accentGold`, which had been there all along, waiting patiently

---

## v0.1.0 - "The Great Awakening" (2026-01-24)

### New Chambers
- **The Fortress Rises** (Initial Release) — Phone and watch support established
- **The Gamification Engine** (Core Features) — Levels, XP, and streaks begin tracking
- **The Wrist Companion** (Wear OS) — Quick step entry from the watch
- **The Low-Power Vigil** (Ambient Mode) — Watch display persists in darkness

### Menaces Vanquished

**The Emulator Refuses to Materialize** (AVD + Flatpak)
- The emulator, summoned via Flatpak's sandboxed realm, crashed repeatedly
- Hardware acceleration proved incompatible with the astral projection required
- Decided to use physical devices instead of wrestling with ethereal constructs

**The Build System Starves** (JAVA_HOME)
- The Gradle daemon searched in vain for JAVA_HOME
- Flatpak had imprisoned the JetBrains Runtime in a sandbox dimension
- Installed OpenJDK 21 in the Distrobox container, restoring the daemon's vitality

**The Ancient Dialect** (wear → wear_plus)
- The venerable `wear` package (vintage 2021) used deprecated manifest incantations
- Android Gradle Plugin 8+ no longer understood these archaic runes
- Migrated to `wear_plus`, a living fork that speaks the modern tongue

**The Discontinued Dependency** (wearable_rotary)
- The package had passed into the void (marked discontinued)
- Its functionality was mourned but not required for initial operation

### Challenges Ahead
- Step count must be entered manually (health API integration pending)
- Watch app requires physical Wear OS device for testing
- The AVD remains hostile to Flatpak containment

### Secrets of the Deep
- Flutter 3.38.7 stable
- Targeting Android SDK 35 / minSdk 23
- Using Riverpod for state management
- Persistence via SharedPreferences

---

*"Losing is fun!" - [Dwarf Fortress](https://www.bay12games.com/dwarves/) wisdom*
