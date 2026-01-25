# Workload Identity Federation for GitHub Actions

Set up keyless CI authentication from GitHub Actions to Google Cloud.

## When to Use

When someone says "set up WIF", "keyless CI", or "GitHub Actions to GCP auth".

## Steps

### 1. Create Workload Identity Pool

```bash
gcloud iam workload-identity-pools create "github-actions-pool" \
  --project="PROJECT_ID" \
  --location="global" \
  --display-name="GitHub Actions Pool"
```

### 2. Add GitHub as Provider

```bash
gcloud iam workload-identity-pools providers create-oidc "github-provider" \
  --project="PROJECT_ID" \
  --location="global" \
  --workload-identity-pool="github-actions-pool" \
  --display-name="GitHub Provider" \
  --attribute-mapping="google.subject=assertion.sub,attribute.actor=assertion.actor,attribute.repository=assertion.repository" \
  --issuer-uri="https://token.actions.githubusercontent.com"
```

### 3. Create Service Account

```bash
gcloud iam service-accounts create "github-actions-deploy" \
  --project="PROJECT_ID" \
  --display-name="GitHub Actions Deploy"
```

### 4. Grant Impersonation

```bash
gcloud iam service-accounts add-iam-policy-binding \
  "github-actions-deploy@PROJECT_ID.iam.gserviceaccount.com" \
  --project="PROJECT_ID" \
  --role="roles/iam.workloadIdentityUser" \
  --member="principalSet://iam.googleapis.com/projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions-pool/attribute.repository/OWNER/REPO"
```

### 5. GitHub Actions Workflow

```yaml
permissions:
  contents: read
  id-token: write  # Required!

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: google-github-actions/auth@v2
        with:
          workload_identity_provider: 'projects/PROJECT_NUMBER/locations/global/workloadIdentityPools/github-actions-pool/providers/github-provider'
          service_account: 'github-actions-deploy@PROJECT_ID.iam.gserviceaccount.com'
```

## Variables to Replace

| Placeholder | Where to Find |
|-------------|---------------|
| `PROJECT_ID` | `gcloud config get-value project` |
| `PROJECT_NUMBER` | `gcloud projects describe PROJECT_ID --format='value(projectNumber)'` |
| `OWNER/REPO` | GitHub repo (e.g., `aaronjohnson/step_quest`) |

## Gotchas

- **`id-token: write`** — Must be in permissions or auth silently fails
- **Project number vs ID** — Provider path uses the *number*
- **Repository binding** — Locks auth to specific repo (security feature)

## Grant Additional Roles

After setup, grant the service account roles it needs:

```bash
gcloud projects add-iam-policy-binding PROJECT_ID \
  --member="serviceAccount:github-actions-deploy@PROJECT_ID.iam.gserviceaccount.com" \
  --role="roles/firebase.admin"  # or whatever roles needed
```
