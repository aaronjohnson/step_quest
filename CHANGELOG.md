# Step Quest Changelog

*In the tradition of Dwarf Fortress patch notes*

---

## v0.2.0 - "The Health Connection" (2026-01-24)

### Major Features
- **Health Connect Integration** — The fortress now receives tribute from the realm's fitness trackers
  - Automatic step syncing from Health Connect-compatible apps
  - Manual sync button for the impatient adventurer
  - Graceful fallback to manual logging when Health Connect is unavailable

### Changes
- Raised minimum Android SDK to 26 (Android 8.0 Oreo)
  - The ancient devices of API 23-25 can no longer receive the blessings of Health Connect
  - Their inhabitants must seek adventure through other means

### Bug Fixes
- **Corrected the sacred color references in the Health Connect card**
  - The `xpGold` color, though noble in intent, did not exist in the theme scrolls
  - Replaced with `accentGold`, which had been there all along, waiting patiently

---

## v0.1.0 - "The Great Awakening" (2026-01-24)

### Major Features
- Initial project creation with phone and watch support
- Step logging gamification with levels, XP, and streaks
- Wear OS companion app for quick step entry
- Ambient mode support for low-power watch display

### Bug Fixes & Technical Debt

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

### Known Issues
- Step count must be entered manually (health API integration pending)
- Watch app requires physical Wear OS device for testing
- The AVD remains hostile to Flatpak containment

### Technical Notes
- Flutter 3.38.7 stable
- Targeting Android SDK 35 / minSdk 23
- Using Riverpod for state management
- Persistence via SharedPreferences

---

*"Losing is fun!" - Dwarf Fortress wisdom*
