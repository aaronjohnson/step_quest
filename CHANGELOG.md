# Step Quest Changelog

*In the tradition of Dwarf Fortress patch notes*

---

## v0.7.0 - "The Quest for a Proper Address" (2026-01-25)

### The Mason's Work
- **Custom Domain** — The fortress finally has a proper address
  - `step.quest.mqqn.net` now points to the landing page
  - Cloud DNS zone created for `quest.mqqn.net` namespace
  - Subdomain delegation from Gandi preserves email safety
  - Future quest apps can live at `*.quest.mqqn.net`

### The Scribes' Archives
- Added `docs/DNS_SETUP.md` — A map for future domain expeditions
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
- **Firebase Crashlytics** — The fortress now reports when walls crumble
  - Three-layer error handling: Flutter errors, platform errors, zone errors
  - Crashes appear in Firebase Console automatically
  - The mountain spirits will know when something goes wrong

### The Translator's Guild
- **Nordic Expansion** — The northern realms join the quest
  - Danish (da) — For the Danes who march through wind and rain
  - Norwegian Bokmål (nb) — For the fjord-dwellers
  - Swedish (sv) — For those who brave the midnight sun
  - Finnish (fi) — For the sauna warriors
  - Catalan (ca) — For the builders of Sagrada Família
- Total: 13 languages + 2 secret (Klingon, Dwarven)

### The Scribes' Archives
- **Privacy Policy Updated** — The scribes have documented the watchtower's new eyes
  - Crashlytics data collection disclosed
  - Link to Firebase privacy practices added
- **SECURITY.md Updated** — The fortress ledger now records crash reports

---

## v0.5.0 - "The Grand Opening" (2026-01-25)

### New Chambers
- **Google Play Store Release** — The fortress gates open to the public
  - Mobile app available on internal testing track
  - Wear OS app on dedicated form factor track
  - Automated CI/CD via GitHub Actions and Fastlane

- **Tip Jar Implementation** — Real Google Play Billing integration
  - Three tiers: Coffee ($2), Supporter ($3), Legendary ($7)
  - Prime number pricing preserved
  - Consumable products (can tip multiple times)
  - Purchase status tracked locally

- **Landing Page** — Firebase Hosting at step-quest-485403.web.app
  - Beta testing links for Phone and Wear OS
  - Privacy policy for Play Store compliance
  - iOS waitlist form with Firestore backend

### The Scribes' Archives
- SECURITY.md for vulnerability reporting via GitHub
- README updated with Free and Open Source section

### Secrets of the Deep
- Product flavors for mobile/wear separation
- Version codes: mobile uses even numbers, wear uses odd numbers
- Workload Identity Federation for keyless CI authentication
- BILLING permission added to AndroidManifest

---

## v0.4.0 - "The Tower of Babel Falls" (2026-01-24)

### The Translator's Guild
- **Full Internationalization Infrastructure** — The fortress now speaks many tongues
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
- All widget strings migrated to use `AppLocalizations.of(context)`

---

## v0.3.0 - "The Supporter's Guild" (2026-01-24)

### New Chambers
- **Supporter System** — A tip jar for those who wish to fund the fortress
  - Three tiers with prime number pricing: Coffee ☕ (~$2), Supporter ⭐ (~$3), Legendary 👑 (~$7)
  - Supporter badge displayed proudly in-app
  - Google Play IAP integration pending (prices will be localized per country)

- **Health Connect Info Panel** — Expanded sync documentation
  - Explains the data flow: Fitness App → Health Connect → Step Quest
  - Lists compatible apps (Samsung Health, Google Fit, Fitbit, etc.)
  - Directs adventurers to GitHub for sensor feature requests

### Trade Routes
- GitHub Sponsors for the developer community
- Patreon for general audience supporters
- Source code link for the curious and brave
- SUPPORTERS.md added for public recognition of patrons

### The Architect's Wisdom
- **Prime number pricing** — Because $2, $3, and $7 are more elegant than $1.99
- **Localized pricing** — Sensible round numbers per country (configured in Play Console)
- In-app purchases follow Google Play policies
- Both GitHub Sponsors AND Patreon for different audiences
- Open source remains free; tips fund development and keep ads at bay

---

## v0.2.0 - "The Health Connection" (2026-01-24)

### New Chambers
- **Health Connect Integration** — The fortress now receives tribute from the realm's fitness trackers
  - Automatic step syncing from Health Connect-compatible apps
  - Manual sync button for the impatient adventurer
  - Graceful fallback to manual logging when Health Connect is unavailable

### The Great Upheaval
- Raised minimum Android SDK to 26 (Android 8.0 Oreo)
  - The ancient devices of API 23-25 can no longer receive the blessings of Health Connect
  - Their inhabitants must seek adventure through other means

### Menaces Vanquished
- **Corrected the sacred color references in the Health Connect card**
  - The `xpGold` color, though noble in intent, did not exist in the theme scrolls
  - Replaced with `accentGold`, which had been there all along, waiting patiently

---

## v0.1.0 - "The Great Awakening" (2026-01-24)

### New Chambers
- Initial project creation with phone and watch support
- Step logging gamification with levels, XP, and streaks
- Wear OS companion app for quick step entry
- Ambient mode support for low-power watch display

### Menaces Vanquished

**Fixed Android Virtual Device refusing to materialize on the host plane**
- The emulator, summoned via Flatpak's sandboxed realm, crashed repeatedly
- Hardware acceleration proved incompatible with the astral projection required
- Decided to use physical devices instead of wrestling with ethereal constructs

**Prevented the build system from starving due to missing Java sustenance**
- The Gradle daemon searched in vain for JAVA_HOME
- Flatpak had imprisoned the JetBrains Runtime in a sandbox dimension
- Installed OpenJDK 21 in the Distrobox container, restoring the daemon's vitality

**Stopped the wear plugin from speaking in an ancient dialect (package attribute)**
- The venerable `wear` package (vintage 2021) used deprecated manifest incantations
- Android Gradle Plugin 8+ no longer understood these archaic runes
- Migrated to `wear_plus`, a living fork that speaks the modern tongue

**Removed discontinued wearable_rotary dependency**
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
