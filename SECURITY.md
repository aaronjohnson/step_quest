# Security Policy

## Reporting a Vulnerability

If you discover a security vulnerability in Step Quest, please report it privately using GitHub's vulnerability reporting:

1. Go to the **Security** tab of this repository
2. Click **Report a vulnerability**
3. Provide details about the issue

**Do not open a public GitHub issue for security vulnerabilities.**

### What to Include

- Description of the vulnerability
- Steps to reproduce
- Potential impact
- Any suggested fixes (optional)

### Response Timeline

| Stage | Timeframe |
|-------|-----------|
| Initial acknowledgment | 48 hours |
| Triage and assessment | 7 days |
| Fix development | Varies by severity |
| Public disclosure | After fix is released |

## Scope

### In Scope

- Step Quest Android app (mobile and Wear OS)
- Firebase Hosting content (step-quest-485403.web.app)
- Firestore security rules
- GitHub Actions workflows
- Dependencies with known vulnerabilities

### Out of Scope

- Google Play Store infrastructure
- Health Connect / Google Health Services
- Third-party fitness apps (Samsung Health, Fitbit, etc.)
- Google Play Billing infrastructure
- Social engineering attacks
- Attacks requiring physical device access

## Data Handling

Step Quest handles the following data:

| Data Type | Storage | Sensitivity |
|-----------|---------|-------------|
| Step counts | Local device (SharedPreferences) | Low |
| XP / Level progress | Local device | Low |
| Achievement status | Local device | Low |
| Health Connect data | Read-only from Health Connect | Medium |
| Purchase receipts | Google Play (not stored locally) | Medium |
| iOS waitlist emails | Firestore (write-only collection) | Medium |

### What We Don't Collect

- Personal identification information
- Location data
- Contacts or phone data
- Analytics or tracking data
- Advertising identifiers

## Security Practices

### App Security

- No sensitive data transmitted to external servers
- Health Connect permissions follow least-privilege principle
- In-app purchases verified through Google Play Billing
- No custom authentication (stateless local app)

### Build Security

- Signed release builds with private keystore
- GitHub Actions with Workload Identity Federation (no long-lived keys)
- Dependencies locked via `pubspec.lock`
- Self-hosted runners for release builds

### Code Security

- Open source for community review
- No obfuscation of security-relevant code
- Minimal permission requests

## Supported Versions

| Version | Supported |
|---------|-----------|
| Latest release | Yes |
| Previous release | Security fixes only |
| Older versions | No |

We recommend always updating to the latest version from Google Play.

## Acknowledgments

We appreciate responsible disclosure and will acknowledge security researchers who report valid vulnerabilities (with permission) in our release notes.

---

*The fortress stands strong through vigilance.*
