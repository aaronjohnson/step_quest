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
- **Primary distribution**: Firebase App Distribution (not Google Play Store initially)
- **CI/CD**: Fastlane with GitHub Actions
- **Runner**: Self-hosted GitHub Actions runner available
- **Preferred build flow**: GitHub push -> Fastlane -> Firebase App Distribution

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

## Future Plans
- Google Play Billing integration for tip jar
- Watch-to-phone data synchronization
- Additional Health Connect sensors (heart rate, calories) via GitHub requests
