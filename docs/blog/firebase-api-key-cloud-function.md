# The Alternative: No Client-Side API Key At All

*A follow-up to "Your API Key is Leaked!" - sometimes the best defense is not having one*

---

## The Simpler Solution

In the [previous post](/docs/blog/firebase-api-key-security.md), I explained why Firebase web API keys aren't really "leaked" and how to properly secure them. But there's an even simpler approach:

**Don't put the key in client code at all.**

## Before: Direct Firestore Access

```javascript
// Client-side - API key visible in source
const firebaseConfig = {
    apiKey: "AIzaSy...",  // Scanner bait
    projectId: "myproject",
};

const app = initializeApp(firebaseConfig);
const db = getFirestore(app);

await addDoc(collection(db, 'ios-waitlist'), {
    email: email,
    timestamp: serverTimestamp()
});
```

## After: Cloud Function Proxy

```javascript
// Client-side - no API key, no Firebase SDK
await fetch('https://us-central1-myproject.cloudfunctions.net/addToWaitlist', {
    method: 'POST',
    headers: { 'Content-Type': 'application/json' },
    body: JSON.stringify({ email: email })
});
```

The API key lives only in the Cloud Function, which runs on Google's servers.

## The Cloud Function

```typescript
// functions/src/index.ts
import * as functions from 'firebase-functions';
import * as admin from 'firebase-admin';

admin.initializeApp();
const db = admin.firestore();

export const addToWaitlist = functions.https.onRequest(async (req, res) => {
    // CORS for your domains only
    const allowedOrigins = [
        'https://step.quest.mqqn.net',
        'https://step-quest-485403.web.app',
        'http://localhost:5000'
    ];

    const origin = req.headers.origin;
    if (origin && allowedOrigins.includes(origin)) {
        res.set('Access-Control-Allow-Origin', origin);
    }

    // Handle preflight
    if (req.method === 'OPTIONS') {
        res.set('Access-Control-Allow-Methods', 'POST');
        res.set('Access-Control-Allow-Headers', 'Content-Type');
        res.status(204).send('');
        return;
    }

    // Only POST
    if (req.method !== 'POST') {
        res.status(405).send('Method not allowed');
        return;
    }

    // Validate input
    const { email } = req.body;
    if (!email || typeof email !== 'string' || email.length > 254) {
        res.status(400).json({ error: 'Invalid email' });
        return;
    }

    // Basic email format check
    if (!email.includes('@') || !email.includes('.')) {
        res.status(400).json({ error: 'Invalid email format' });
        return;
    }

    try {
        await db.collection('ios-waitlist').add({
            email: email.toLowerCase().trim(),
            timestamp: admin.firestore.FieldValue.serverTimestamp(),
            source: origin || 'unknown'
        });

        res.status(200).json({ success: true });
    } catch (error) {
        console.error('Waitlist error:', error);
        res.status(500).json({ error: 'Failed to add to waitlist' });
    }
});
```

## Updated Client Code

```html
<script>
document.getElementById('ios-notify-form').addEventListener('submit', async (e) => {
    e.preventDefault();
    const email = document.getElementById('ios-email').value;
    const status = document.getElementById('ios-notify-status');
    const form = document.getElementById('ios-notify-form');

    try {
        const response = await fetch(
            'https://us-central1-step-quest-485403.cloudfunctions.net/addToWaitlist',
            {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ email })
            }
        );

        if (!response.ok) throw new Error('Request failed');

        form.style.display = 'none';
        status.style.display = 'block';
        status.textContent = "You're on the list!";
    } catch (error) {
        status.style.display = 'block';
        status.style.color = '#ef4444';
        status.textContent = 'Something went wrong. Please try again.';
    }
});
</script>
```

## Comparison

| Aspect | Client-Side Firebase | Cloud Function |
|--------|---------------------|----------------|
| API key in source | Yes (restricted) | No |
| Security scanner alerts | Yes (false positives) | No |
| Need to explain/defend | Yes | No |
| Firebase SDK size | ~50KB | 0KB |
| Cold start latency | None | ~200-500ms first call |
| Cost | Free tier generous | Free tier generous |
| Complexity | Lower | Slightly higher |

## When to Use Each

**Keep client-side Firebase when:**
- You need real-time listeners (Firestore onSnapshot)
- You have complex queries
- You're already using Firebase Auth
- You understand and can explain the security model

**Use Cloud Functions when:**
- Simple write-only operations (forms, logs)
- You want zero security scanner noise
- You want server-side validation/sanitization
- You don't want to explain Firebase key security to auditors

## Deployment

```bash
# Install Firebase CLI
npm install -g firebase-tools

# Initialize functions
firebase init functions

# Deploy
firebase deploy --only functions
```

## The Trade-off

Cloud Functions add:
- A build step (TypeScript compilation)
- Cold start latency on first request
- Another thing to monitor

But they eliminate:
- Security scanner alerts
- Explaining Firebase key security
- Client-side Firebase SDK bundle size

For a simple waitlist form, the Cloud Function approach is arguably cleaner.

## Conclusion

Both approaches are secure when done right:
- **Client-side**: API key restrictions + Firestore rules
- **Cloud Function**: No client-side credentials at all

Choose based on your needs. For Step Quest, I kept the client-side approach with proper restrictions because the landing page is simple and I wanted to document the "leaked key" situation. But for enterprise projects with security audits, the Cloud Function approach avoids the conversation entirely.

---

*Published: January 2026*
*Part 2 of the Firebase API Key Security series*

## See Also

- [Part 1: "Your API Key is Leaked!"](/docs/blog/firebase-api-key-security.md)
- [Firebase Cloud Functions documentation](https://firebase.google.com/docs/functions)
