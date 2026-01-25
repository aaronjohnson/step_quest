# DNS and Domain Setup

Documentation for setting up custom domains with Firebase Hosting using Google Cloud DNS.

## Architecture

```
Registrar (Gandi)
    └── mqqn.net (NS → Gandi nameservers)
            └── quest (NS → Cloud DNS)  ← Subdomain delegation
                    └── step.quest.mqqn.net (A → Firebase Hosting)
```

## Why Subdomain Delegation?

Instead of migrating all of mqqn.net to Cloud DNS, we delegate only `quest.mqqn.net`:

- **Safer**: Email (MX records) stays in original DNS
- **Isolated**: Changes to quest.* don't affect main domain
- **Scriptable**: Cloud DNS allows CLI management via `gcloud`

## Setup Steps

### 1. Enable Cloud DNS (requires billing)

```bash
# Link billing account
gcloud billing projects link PROJECT_ID --billing-account=BILLING_ACCOUNT_ID

# Enable API
gcloud services enable dns.googleapis.com --project PROJECT_ID
```

### 2. Create Managed Zone for Subdomain

```bash
gcloud dns managed-zones create quest-mqqn-net \
  --description="Subdomain for quest apps" \
  --dns-name="quest.mqqn.net." \
  --project PROJECT_ID
```

### 3. Get NS Records for Delegation

```bash
gcloud dns managed-zones describe quest-mqqn-net \
  --project PROJECT_ID \
  --format="value(nameServers)"
```

Returns something like:
```
ns-cloud-c1.googledomains.com
ns-cloud-c2.googledomains.com
ns-cloud-c3.googledomains.com
ns-cloud-c4.googledomains.com
```

### 4. Add NS Records at Registrar (Gandi)

In Gandi DNS for mqqn.net, add:

```
quest 10800 IN NS ns-cloud-c1.googledomains.com
quest 10800 IN NS ns-cloud-c2.googledomains.com
quest 10800 IN NS ns-cloud-c3.googledomains.com
quest 10800 IN NS ns-cloud-c4.googledomains.com
```

### 5. Add A Records for Firebase Hosting

Firebase Hosting requires A records (not CNAME) for custom domains:

```bash
gcloud dns record-sets create step.quest.mqqn.net. \
  --type=A \
  --ttl=300 \
  --rrdatas="151.101.1.195,151.101.65.195" \
  --zone=quest-mqqn-net \
  --project PROJECT_ID
```

**Note**: CNAME records don't work well with Firebase Hosting custom domains. Use A records pointing to Firebase's IPs:
- 151.101.1.195
- 151.101.65.195

### 6. Add Custom Domain in Firebase Console

1. Go to Firebase Console → Hosting → Your site
2. Click "Add custom domain"
3. Enter the domain (e.g., `step.quest.mqqn.net`)
4. Firebase will verify DNS and mint SSL certificate (usually 15-30 min, up to 24h)

## Useful Commands

```bash
# List all records in a zone
gcloud dns record-sets list --zone=quest-mqqn-net --project PROJECT_ID

# Delete a record
gcloud dns record-sets delete RECORD_NAME. --type=TYPE --zone=ZONE_NAME --project PROJECT_ID

# Verify DNS propagation
dig A step.quest.mqqn.net +short
dig NS quest.mqqn.net +short

# Query authoritative nameserver directly (bypasses cache)
dig A step.quest.mqqn.net @ns-cloud-c1.googledomains.com +short
```

## Firebase Hosting Domains

Firebase Hosting provides three domain types:

| Domain | Purpose | Removable? |
|--------|---------|------------|
| `PROJECT.web.app` | Default Firebase domain | No |
| `PROJECT.firebaseapp.com` | Legacy Firebase domain | No |
| Custom domain | Your domain | Yes |

All three remain active. To force users to custom domain, add redirects in `firebase.json`:

```json
{
  "hosting": {
    "redirects": [
      {
        "source": "**",
        "destination": "https://step.quest.mqqn.net/:splat",
        "type": 301,
        "regex": false
      }
    ]
  }
}
```

## Fourth-Level Domains

Fourth-level domains (e.g., `step.quest.mqqn.net`) work fine with:
- Cloud DNS ✅
- Firebase Hosting ✅
- SSL certificates ✅

Useful for namespace organization:
- `*.quest.mqqn.net` → Gamification apps
- `*.tools.mqqn.net` → Utilities
- `*.lab.mqqn.net` → Experiments

## Costs

- Cloud DNS: ~$0.20/month per zone + $0.40/million queries
- Firebase Hosting: Free tier covers most personal projects
- SSL certificates: Free (Firebase provisions automatically)

---

*Documentation created 2026-01-25*
