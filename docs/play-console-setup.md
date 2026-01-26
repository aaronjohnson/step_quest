# Google Play Console Setup Guide

This guide documents the complete process for setting up Google Play Console internal testing with Fastlane and GitHub Actions, using Workload Identity Federation (WIF) for secure authentication.

## Overview

The pipeline flow:
1. **Internal Testing** - Upload AAB, limited testers via email invite
2. **Closed Testing (Alpha)** - Wider group, Play Store listing review
3. **Production** - Gradual rollout (10% → 25% → 50% → 100%)

## Prerequisites

### 1. Google Play Developer Account
- One-time $25 registration fee
- Account must be in good standing
- Complete identity verification

### 2. Google Cloud Project
- Firebase project can be reused (already has billing)
- Enable "Google Play Android Developer API"

### 3. Self-Hosted Runner (Mac Mini)
- macOS ARM64 with Xcode, Flutter, Ruby
- Release keystore stored locally (not in repo)
- Homebrew Ruby at `/opt/homebrew/opt/ruby/bin`

## Step 1: Play Console App Setup

1. Go to [Play Console](https://play.google.com/console)
2. Create App → Android App
3. Fill required fields:
   - App name
   - Default language
   - App or game
   - Free or paid
4. Complete the app content questionnaire:
   - Privacy policy URL (required for internal testing)
   - App access (if login required, provide test credentials)
   - Ads declaration
   - Content rating
   - Target audience

## Step 2: Internal Testing Track Setup

1. Go to **Testing → Internal testing**
2. Create a new release (first upload)
3. Upload your signed AAB
4. Add testers:
   - Create a tester list or use email addresses
   - Testers receive invite link (not automatic email on each build)
   - Testers must opt-in via the link to access builds

**Note**: Unlike Firebase App Distribution, Play Store internal testing does NOT email testers on each new build. Testers install via Play Store and get updates automatically.

## Step 3: Workload Identity Federation (WIF)

WIF allows GitHub Actions to authenticate without long-lived secrets.

### Create Workload Identity Pool

```bash
# Variables
PROJECT_ID="your-project-id"
PROJECT_NUMBER="your-project-number"
GITHUB_ORG="your-github-username"
REPO_NAME="your-repo-name"

# Create the pool
gcloud iam workload-identity-pools create "github-actions-pool" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --display-name="GitHub Actions Pool"

# Create the provider
gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --project="${PROJECT_ID}" \
  --location="global" \
  --workload-identity-pool="github-actions-pool" \
  --display-name="GitHub Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com" \
  --attribute-condition="assertion.repository=='${GITHUB_ORG}/${REPO_NAME}'"
```

### Grant Service Account Access

```bash
SERVICE_ACCOUNT="github-actions-firebase@${PROJECT_ID}.iam.gserviceaccount.com"

# Allow GitHub Actions to impersonate the service account
gcloud iam service-accounts add-iam-policy-binding "${SERVICE_ACCOUNT}" \
  --project="${PROJECT_ID}" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/${PROJECT_NUMBER}/locations/global/workloadIdentityPools/github-actions-pool/attribute.repository/${GITHUB_ORG}/${REPO_NAME}"

# Grant Play Console API access
gcloud projects add-iam-policy-binding "${PROJECT_ID}" \
  --role="roles/androidpublisher.releaseAdmin" \
  --member="serviceAccount:${SERVICE_ACCOUNT}"
```

### Link Service Account in Play Console

1. Go to Play Console → Setup → API access
2. Link your Google Cloud project
3. Grant your service account access with "Release manager" permissions

## Step 4: Release Signing

### Generate Release Keystore (one-time)

```bash
keytool -genkey -v \
  -keystore app-release-key.jks \
  -keyalg RSA -keysize 2048 \
  -validity 10000 \
  -alias release

# Store securely on Mac Mini, NOT in git
```

### key.properties File

```properties
storePassword=your-store-password
keyPassword=your-key-password
keyAlias=release
storeFile=app/app-release-key.jks
```

### build.gradle.kts Configuration

```kotlin
import java.util.Properties
import java.io.FileInputStream

// Load signing properties if available
val keystorePropertiesFile = rootProject.file("key.properties")
val keystoreProperties = Properties()
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    signingConfigs {
        if (keystorePropertiesFile.exists()) {
            create("release") {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            signingConfig = if (keystorePropertiesFile.exists()) {
                signingConfigs.getByName("release")
            } else {
                signingConfigs.getByName("debug")
            }
        }
    }
}
```

## Step 5: Fastlane Configuration

### Fastfile Play Store Lanes

```ruby
# Helper to get Play Store credentials (supports WIF via GOOGLE_APPLICATION_CREDENTIALS)
def play_store_json_key
  ENV["GOOGLE_APPLICATION_CREDENTIALS"] || ENV["GOOGLE_PLAY_JSON_KEY"] || "play-store-key.json"
end

desc "Build release App Bundle (AAB) for Play Store"
lane :build_bundle do |options|
  build_number = options[:build_number] || ENV["BUILD_NUMBER"]

  Dir.chdir(FLUTTER_ROOT) do
    args = ["flutter", "build", "appbundle", "--release"]
    args << "--build-number=#{build_number}" if build_number
    sh(*args)
  end

  aab_path = File.join(FLUTTER_ROOT, "build/app/outputs/bundle/release/app-release.aab")
  UI.success("Release AAB built: #{aab_path}")
  aab_path
end

desc "Upload AAB to Play Store internal testing track"
lane :upload_internal do |options|
  aab_path = File.join(FLUTTER_ROOT, "build/app/outputs/bundle/release/app-release.aab")
  unless File.exist?(aab_path)
    aab_path = build_bundle(options)
  end

  upload_to_play_store(
    track: "internal",
    aab: aab_path,
    skip_upload_apk: true,
    skip_upload_metadata: true,
    skip_upload_images: true,
    skip_upload_screenshots: true,
    json_key: play_store_json_key
  )

  UI.success("AAB uploaded to Play Store internal testing track!")
end

desc "Promote internal build to closed testing (alpha)"
lane :promote_to_alpha do
  upload_to_play_store(
    track: "internal",
    track_promote_to: "alpha",
    skip_upload_apk: true,
    skip_upload_aab: true,
    skip_upload_metadata: true,
    skip_upload_images: true,
    skip_upload_screenshots: true,
    json_key: play_store_json_key
  )

  UI.success("Promoted to alpha (closed testing)!")
end

desc "Promote to production"
lane :promote_to_production do |options|
  rollout = options[:rollout] || 1.0

  upload_to_play_store(
    track: "alpha",
    track_promote_to: "production",
    rollout: rollout.to_s,
    skip_upload_apk: true,
    skip_upload_aab: true,
    skip_upload_metadata: true,
    skip_upload_images: true,
    skip_upload_screenshots: true,
    json_key: play_store_json_key
  )

  UI.success("Promoted to production with #{(rollout * 100).to_i}% rollout!")
end
```

## Step 6: GitHub Actions Workflow

```yaml
name: Play Store Release

on:
  workflow_dispatch:
    inputs:
      track:
        description: 'Release track'
        required: true
        default: 'internal'
        type: choice
        options:
          - internal
          - alpha
          - production
      rollout:
        description: 'Production rollout percentage'
        required: false
        default: '100'
        type: choice
        options:
          - '10'
          - '25'
          - '50'
          - '100'

permissions:
  contents: read
  id-token: write

jobs:
  play-store-release:
    runs-on: [self-hosted, macOS, ARM64]

    defaults:
      run:
        working-directory: android

    steps:
      - name: Checkout code
        uses: actions/checkout@v4

      - name: Authenticate to Google Cloud (WIF)
        id: auth
        uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: 'projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions-pool/providers/github-provider'
          service_account: 'github-actions-firebase@PROJECT_ID.iam.gserviceaccount.com'

      - name: Get Flutter dependencies
        run: flutter pub get
        working-directory: .

      - name: Copy signing config
        working-directory: .
        run: |
          cp ~/projects/APP_NAME/android/key.properties android/key.properties
          cp ~/projects/APP_NAME/android/app/app-release-key.jks android/app/app-release-key.jks

      - name: Install Fastlane
        run: |
          export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
          bundle config set --local path 'vendor/bundle'
          bundle install

      # IMPORTANT: Split build and upload into separate steps!
      # The first upload to Play Console MUST be manual. By splitting steps
      # and using continue-on-error, the AAB artifact is saved even when
      # upload fails, allowing manual download and upload to Play Console.

      - name: Build AAB
        if: ${{ github.event.inputs.track == 'internal' }}
        env:
          BUILD_NUMBER: ${{ github.run_number }}
        run: |
          export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
          bundle exec fastlane android build_bundle build_number:$BUILD_NUMBER

      - name: Upload AAB artifact
        if: ${{ github.event.inputs.track == 'internal' }}
        uses: actions/upload-artifact@v4
        with:
          name: release-aab-v${{ github.run_number }}
          path: build/app/outputs/bundle/release/*.aab
          retention-days: 30

      - name: Upload to Play Store
        if: ${{ github.event.inputs.track == 'internal' }}
        continue-on-error: true  # First upload must be manual, this will fail
        run: |
          export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
          bundle exec fastlane android upload_internal

      - name: Promote to Alpha
        if: ${{ github.event.inputs.track == 'alpha' }}
        run: |
          export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
          bundle exec fastlane android promote_to_alpha

      - name: Promote to Production
        if: ${{ github.event.inputs.track == 'production' }}
        run: |
          export PATH="/opt/homebrew/opt/ruby/bin:$PATH"
          ROLLOUT=$(echo "${{ github.event.inputs.rollout }}" | awk '{print $1/100}')
          bundle exec fastlane android promote_to_production rollout:$ROLLOUT
```

## Step 7: App Transfer (Future)

When ready to transfer an app to a different developer account:

1. **Source account**: Setup → Advanced settings → App transfers → Transfer app
2. **Target account**: Must be in good standing, fully verified
3. **What transfers**: Listing, ratings, reviews, users, subscriptions
4. **What doesn't transfer**: Earnings history, detailed financials

**Package name stays the same** - users see a seamless transition.

## Checklist

### Play Console Setup
- [ ] Create Play Console developer account ($25)
- [ ] Create app in Play Console
- [ ] Complete app content questionnaire
- [ ] Set privacy policy URL
- [ ] Enable Google Play Android Developer API in Cloud Console

### Authentication
- [ ] Create Workload Identity Pool and Provider
- [ ] Grant service account `androidpublisher.releaseAdmin` role
- [ ] Link service account in Play Console API access

### Signing
- [ ] Generate release keystore
- [ ] Store keystore on Mac Mini securely
- [ ] Create key.properties file
- [ ] Update build.gradle.kts with signing config

### Fastlane
- [ ] Add `build_bundle` lane
- [ ] Add `upload_internal` lane
- [ ] Add `promote_to_alpha` lane
- [ ] Add `promote_to_production` lane

### GitHub Actions
- [ ] Create play-store.yml workflow
- [ ] Configure WIF authentication
- [ ] Add signing config copy step

### Internal Testing
- [ ] Run workflow to build AAB (upload step will fail - this is expected)
- [ ] Download AAB artifact from workflow run
- [ ] Upload first AAB manually via Play Console (required by Google)
- [ ] Create tester list
- [ ] Share opt-in link with testers
- [ ] Testers install via Play Store
- [ ] Subsequent workflow runs will upload automatically
