# "Your API Key is Leaked!" - Why Firebase Keys Are Different

*A tale of security scanners, false positives, and understanding what API keys actually protect*

---

## The Alert

It started with an email from Google Cloud Trust & Safety:

> We have detected a publicly accessible Google API key associated with your project...
> The key was found at: https://github.com/yourrepo/web/public/index.html

My heart sank. A leaked API key. The cardinal sin of cloud security. Time to rotate credentials, audit logs, and figure out how this happened.

Except... I put it there on purpose.

## The "Leak"

Here's the offending code:

```javascript
const firebaseConfig = {
    apiKey: "AIzaSy...", // THE LEAKED KEY
    authDomain: "myproject.firebaseapp.com",
    projectId: "myproject",
};

const app = initializeApp(firebaseConfig);
```

This is standard Firebase Web SDK initialization. It's in every Firebase web tutorial. It's *supposed* to be in your client-side code.

So what's going on?

## API Keys Are Not All Created Equal

Here's the mental model most developers have:

> API Key = Password = Must Be Secret

This is true for many APIs. Your Stripe secret key, your AWS credentials, your database passwords - these must never be exposed. They grant full access to perform actions *as you*.

But Firebase web API keys are different. They're more like a **phone number** than a password:

| Traditional API Key | Firebase Web API Key |
|---------------------|----------------------|
| Grants access to perform actions | Identifies which project to talk to |
| Must be kept secret | Designed to be public |
| Anyone with it can act as you | Anyone with it can only do what your rules allow |
| Security = keep it hidden | Security = Firebase Security Rules |

## How Firebase Security Actually Works

When someone calls your Firebase project with your API key, here's what happens:

```
Client (with API key) → Firebase → Security Rules → ✓ or ✗
```

The API key gets them to the door. **Security Rules decide if they get in.**

For example, my Firestore rules:

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    // iOS waitlist - anyone can add their email
    match /ios-waitlist/{document} {
      allow create: if request.resource.data.keys().hasOnly(['email', 'timestamp']);
      allow read, update, delete: if false;
    }
    // Everything else - locked down
    match /{document=**} {
      allow read, write: if false;
    }
  }
}
```

With these rules, even if an attacker has my API key, they can:
- ✓ Add an email to the waitlist
- ✗ Read the waitlist
- ✗ Delete entries
- ✗ Access any other collection
- ✗ Do literally anything else

The API key is public. The *rules* are the security.

## But Wait, Shouldn't We Still Protect It?

Yes! But not by hiding it. By **restricting it**.

### 1. HTTP Referrer Restrictions

In Google Cloud Console → Credentials → Edit your API key:

```
Application restrictions: HTTP referrers
Allowed referrers:
  - yourdomain.com/*
  - yourproject.web.app/*
  - localhost:* (for development)
```

Now the key only works from your domains. Someone can't copy it to their malicious site.

### 2. API Restrictions

Same page, restrict which Google APIs the key can call:

```
API restrictions: Restrict key
Allowed APIs:
  - Cloud Firestore API
  - Firebase Installations API
```

Now even if someone bypasses referrer checks, they can only call Firestore (which your rules protect anyway).

### 3. Firestore Security Rules

This is the real security layer:

```javascript
// Only allow specific, validated operations
match /ios-waitlist/{doc} {
  allow create: if
    request.resource.data.keys().hasOnly(['email', 'timestamp']) &&
    request.resource.data.email is string &&
    request.resource.data.email.size() < 255;
}
```

## The gcloud Commands

Here's how to apply these restrictions via CLI (this is exactly what I did):

```bash
# 1. Enable API Keys management
gcloud services enable apikeys.googleapis.com --project=step-quest-485403

# 2. List your keys to find the key ID
gcloud services api-keys list --project=step-quest-485403
# Look for "Browser key (auto created by Firebase)"

# 3. Apply HTTP referrer restrictions
gcloud services api-keys update ee562fb1-7d94-411d-bd7b-42fb04831b05 \
  --project=step-quest-485403 \
  --allowed-referrers="step.quest.mqqn.net/*,step-quest-485403.web.app/*,step-quest-485403.firebaseapp.com/*,localhost:*"
```

The key now only works from my domains. An attacker copying the API key to their site will get a `403 Forbidden`.

## Why Security Scanners Get This Wrong

Automated scanners like GitHub's secret scanning and Google's own detection:

1. Pattern match for API key formats
2. Flag anything that looks like a credential
3. Don't understand the context

They can't know that:
- This is a Firebase web key (designed to be public)
- Your security rules are properly configured
- The key has referrer restrictions

So they alert. And that's actually fine - it's better to have false positives than miss real leaks.

## The Right Response

When you get this alert:

1. **Don't panic** - Firebase web keys are public by design
2. **Do verify** - Check that your Security Rules are correct
3. **Do restrict** - Add referrer and API restrictions
4. **Do document** - Mark the alert as "false positive" with explanation
5. **Don't rotate** - Unless you have evidence of actual abuse

## What Would Actually Be Bad

Real Firebase security issues:

- ❌ Firestore rules that allow `read, write: if true`
- ❌ Admin SDK credentials (service account keys) in client code
- ❌ Firebase Auth without proper validation
- ❌ Cloud Functions with no authentication
- ❌ API key without any restrictions

## Conclusion

Firebase web API keys are **identifiers**, not **secrets**. They tell Firebase which project you're talking to, not what you're allowed to do.

Security comes from:
1. **Firebase Security Rules** - The real access control
2. **API Key Restrictions** - Defense in depth
3. **Understanding your architecture** - Know what each credential does

So the next time a scanner screams about your Firebase API key, take a breath. Check your rules. Add restrictions. And maybe write a blog post explaining why you're not actually on fire.

---

*Published: January 25, 2026*
*Project: [Step Quest](https://step.quest.mqqn.net) - A gamified step counter*

**Update:** After writing this post, I applied the referrer restrictions via `gcloud` CLI. The key is now properly secured, the landing page still works, and Google's security scanner should be satisfied. Total time to fix: 5 minutes. Time spent understanding the problem: much longer (but now you don't have to).

## Further Reading

- [Firebase Security Rules documentation](https://firebase.google.com/docs/rules)
- [API Key Best Practices](https://cloud.google.com/docs/authentication/api-keys)
- [Learn more about securing Firebase](https://firebase.google.com/docs/projects/learn-more#config-files-objects)
