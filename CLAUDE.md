# Step Quest - Project Context for Claude

## Owner
Aaron Johnson (aaronjohnson on GitHub)

## Package Naming
- Use `net.mqqn.*` as the package prefix for all Flutter/Dart projects
- Android applicationId: `net.mqqn.<project_name>`
- Example: `net.mqqn.step_quest`

## Git Configuration
- Email: `4023+aaronjohnson@users.noreply.github.com`
- Always use GitHub's noreply email to protect privacy
- Branch naming: descriptive lowercase with hyphens

## Changelog Style
- **Dwarf Fortress style** - narrative, detailed, sometimes humorous
- Document bugs/fixes as if describing events in a simulation
- Example: "Fixed the build system from starving due to missing Java sustenance"
- Include technical notes but make them engaging
- See CHANGELOG.md for reference

## Build & Distribution Pipeline

### Overview
- **Primary distribution**: Firebase App Distribution (not Google Play Store initially)
- **CI/CD**: Fastlane with GitHub Actions (self-hosted runner)
- **Auth**: Google Cloud Workload Identity Federation (no long-lived secrets)

### Firebase Project
- **Project ID**: `step-quest-485403`
- **Project Number**: `203689137716`
- **Android App ID**: `1:203689137716:android:b879b8f67ee0caa1ea1c61`
- **Package name**: `net.mqqn.step_quest`

### GitHub Actions Setup
- **Runner**: Self-hosted macOS ARM64 (Mac Mini)
- **Workflow**: `.github/workflows/fastlane-android.yml`
- **Triggers**: Manual dispatch or tag push (`v*`)

### Workload Identity Federation
- **Pool**: `github-actions-pool`
- **Provider**: `github-provider` (OIDC, restricted to `aaronjohnson/step_quest`)
- **Service Account**: `github-actions-firebase@step-quest-485403.iam.gserviceaccount.com`
- **Role**: Firebase App Distribution Admin

### Fastlane Lanes
- `build_debug` / `build_release` - Build APK
- `build_bundle` - Build AAB for Play Store
- `distribute_debug` / `distribute_release` - Build and push to Firebase App Distribution
- `test` / `analyze` - Run Flutter tests and analyzer
- `deploy` - Full pipeline (test, analyze, build, distribute)
- `install` - Install APK on connected device

### Local Signing (Release Builds)
Signing keys stored on Mac Mini at `~/projects/step_quest/android/`:
- `key.properties` - Keystore configuration
- `app/step-quest-release-key.jks` - Release keystore

### Distribution Flow
1. Push tag `v1.x.x` or trigger manual workflow
2. GitHub Actions authenticates via WIF
3. Fastlane builds Flutter APK
4. Firebase App Distribution receives build
5. Testers notified automatically

## Development Environment
- **Host OS**: Fedora Aurora (immutable, rpm-ostree)
- **Dev container**: Distrobox with Debian Trixie
- **Flutter**: Installed in ~/flutter (outside distrobox, accessible via path)
- **Android SDK**: ~/Android/Sdk
- **Java**: OpenJDK 21 in distrobox (`/usr/lib/jvm/java-21-openjdk-amd64`)
- **JAVA_HOME**: Must be set for Gradle builds

## Android/Flutter Notes
- AVD emulator has issues with Flatpak Android Studio on Fedora Aurora
- Prefer physical device testing via wireless ADB
- Use `wear_plus` package (not deprecated `wear`) for Wear OS support
- AGP 8+ requires namespace in build.gradle, not AndroidManifest.xml

## Testing Devices
- Pixel 8 Pro (Android 16 API 36) - primary phone
- Wear OS watch available for testing

## Monetization Strategy
- **Google Play IAP** for in-app tip jar (follows Play Store policies)
- **GitHub Sponsors** for developer community recurring support
- **Patreon** for general audience recurring support
- **No ads** — funded by voluntary tips
- Supporters get in-app badge and recognition in SUPPORTERS.md
- Tip tiers (prime numbers): Coffee (~$2), Supporter (~$3), Legendary (~$7)

### Manual Price Tiers (Google Play Console)
Set these manually in Play Console → Monetization → Products for sensible round numbers:

| Tier      | USD | EUR | GBP | JPY  | INR  | BRL  |
|-----------|-----|-----|-----|------|------|------|
| Coffee    | $2  | €2  | £2  | ¥200 | ₹150 | R$10 |
| Supporter | $3  | €3  | £3  | ¥300 | ₹250 | R$15 |
| Legendary | $7  | €7  | £6  | ¥700 | ₹500 | R$35 |

Product IDs:
- `tip_coffee`
- `tip_supporter`
- `tip_legendary`

## Internationalization (i18n)
- **Supported locales**: en, de, es, hi, ja, pt
- **Easter egg languages**: tlh (Klingon), khz (Dwarvish/Khuzdul)
  - Klingon: Unlocked via Konami code (↑↑↓↓←→←→ + double-tap twice)
  - Dwarvish: Unlocked by tapping app title 7 times
- ARB files in `lib/l10n/`
- Generated classes in `lib/l10n/app_localizations*.dart`
- Usage: `AppLocalizations.of(context)!.stringKey`
- XP is universal (not translated)
- TODO: Migrate remaining widget hardcoded strings

## Mac Mini Troubleshooting

### gh: No such file or directory
If git operations fail with `/usr/local/bin/gh: No such file or directory`:

Homebrew on Apple Silicon installs to `/opt/homebrew`, not `/usr/local`.
```bash
gh auth setup-git
```

### bundle install: system gems error
If `bundle install` tries to install to system gems or throws permission errors:
```bash
bundle config set --local path 'vendor/bundle'
bundle install
```

## Future Plans
- Google Play Billing integration for tip jar
- Watch-to-phone data synchronization
- Additional Health Connect sensors (heart rate, calories) via GitHub requests
- Complete i18n migration of all widget strings
