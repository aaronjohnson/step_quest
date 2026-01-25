import { onRequest } from 'firebase-functions/v2/https';
import { logger } from 'firebase-functions';
import { initializeApp } from 'firebase-admin/app';
import { getFirestore, FieldValue } from 'firebase-admin/firestore';

initializeApp();
const db = getFirestore();

const ALLOWED_ORIGINS = [
    'https://step.quest.mqqn.net',
    'https://step-quest-485403.web.app',
    'https://step-quest-485403.firebaseapp.com',
    'http://localhost:5000',
    'http://localhost:3000',
];

/**
 * Add email to iOS waitlist
 * POST /addToWaitlist
 * Body: { email: string }
 */
export const addToWaitlist = onRequest(
    {
        region: 'us-west1',
        cors: ALLOWED_ORIGINS,
        // Rate limiting: max 100 requests per 100 seconds per IP
        rateLimits: {
            maxConcurrentDispatches: 10,
        },
    },
    async (req, res) => {
    // CORS handling
    const origin = req.headers.origin as string | undefined;
    if (origin && ALLOWED_ORIGINS.includes(origin)) {
        res.set('Access-Control-Allow-Origin', origin);
    }
    res.set('Access-Control-Allow-Methods', 'POST, OPTIONS');
    res.set('Access-Control-Allow-Headers', 'Content-Type');

    // Handle preflight request
    if (req.method === 'OPTIONS') {
        res.status(204).send('');
        return;
    }

    // Only allow POST
    if (req.method !== 'POST') {
        res.status(405).json({ error: 'Method not allowed' });
        return;
    }

    // Parse and validate email
    const { email } = req.body;

    if (!email || typeof email !== 'string') {
        res.status(400).json({ error: 'Email is required' });
        return;
    }

    const trimmedEmail = email.toLowerCase().trim();

    // Basic email validation
    if (trimmedEmail.length < 5 || trimmedEmail.length > 254) {
        res.status(400).json({ error: 'Invalid email length' });
        return;
    }

    if (!trimmedEmail.includes('@') || !trimmedEmail.includes('.')) {
        res.status(400).json({ error: 'Invalid email format' });
        return;
    }

    // Simple regex for basic email format
    const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
    if (!emailRegex.test(trimmedEmail)) {
        res.status(400).json({ error: 'Invalid email format' });
        return;
    }

    try {
        // Add to Firestore
        await db.collection('ios-waitlist').add({
            email: trimmedEmail,
            timestamp: FieldValue.serverTimestamp(),
            source: origin || 'unknown',
        });

        logger.info('Added to iOS waitlist', { email: trimmedEmail });
        res.status(200).json({ success: true });
    } catch (error) {
        logger.error('Failed to add to waitlist', error);
        res.status(500).json({ error: 'Failed to add to waitlist' });
    }
});
