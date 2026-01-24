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

## Future Plans
- Health Connect API integration for automatic step tracking
- Samsung APIs for data sync exploration
- Watch-to-phone data synchronization
