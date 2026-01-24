# Step Quest: Android Auto & CarPlay Technical Assessment

## Executive Summary

**Can Step Quest run on Android Auto?** Sort of, but not as a traditional app.

**Why?** Android Auto restricts apps to specific categories (media, messaging, navigation, parking). A step tracker doesn't fit. However, there are viable alternatives that achieve the same UX goal: **motivation during the drive-to-walk transition.**

---

## The Constraint

<cite>Android Auto supports a small set of app categories: media, messaging, navigation, and parking/EV charging where applicable.</cite>

Google enforces these restrictions for driver safety. You cannot render arbitrary Flutter UI on the car display. Even within allowed categories, you must use their template system, not custom widgets.

---

## Viable Approaches (Ranked by Feasibility)

### 1. Rich Notifications (Recommended - Phase 2)
**Effort:** Low | **Impact:** High | **Risk:** Low

Standard Android notifications appear on Android Auto. Step Quest can send contextual notifications that show on the car display:

```dart
// Triggered by geofencing or time-of-day
NotificationService.show(
  title: "Step Quest",
  body: "Your 7-day streak needs 4,500 more steps. Let's do this!",
  priority: NotificationPriority.high,
);
```

**Implementation:**
- `flutter_local_notifications` package
- Geofencing via `geolocator` + `geofence_service`
- Trigger on: arrival at known parks/trails, departure from home, time of day

**Pros:**
- Works today, no special approval
- Shows on Android Auto AND Wear OS
- Simple to implement

**Cons:**
- Passive (user doesn't initiate)
- Limited to notification format

---

### 2. Google Assistant Actions (Recommended - Phase 3)
**Effort:** Medium | **Impact:** High | **Risk:** Low

Build an Assistant Action so users can say:
- "Hey Google, how's my Step Quest?"
- "Hey Google, check my walking streak"
- "Hey Google, how many steps to level up?"

Assistant works on Android Auto, so this gives voice-activated access.

**Implementation:**
- Actions on Google / Dialogflow
- App exposes data via Assistant App Link or Conversational Action
- Returns TTS response with current stats

**Response Examples:**
```
"You're Level 4 with a 7-day streak. You need 2,340 steps to hit today's goal 
and 1,560 XP to reach Level 5. Go get 'em!"

"Your streak is safe! You hit 12,450 steps today. That's 2,450 bonus XP. 
Nice work!"
```

**Pros:**
- Natural interaction while driving
- Works on Auto, phones, smart speakers
- Voice-first is safe for driving

**Cons:**
- Requires Actions on Google setup
- Needs backend or local broadcast receiver
- Review process for Assistant Actions

---

### 3. Media Service "Audio Motivation" (Phase 4+)
**Effort:** High | **Impact:** Medium | **Risk:** Medium

Step Quest registers as a media app that "plays" short motivational audio clips:

```
[Phone connects to Android Auto]
[User opens Step Quest from media apps]
[Plays: "Level 4. 7-day streak. 4,500 steps to goal. The trail awaits."]
```

**Implementation:**
- `audio_service` package with `MediaBrowserService`
- Pre-recorded or TTS-generated clips
- Clips organized as "playlist" of motivational messages

**Pros:**
- Full presence in Android Auto
- Can include longer motivational content
- User-initiated

**Cons:**
- Feels hacky (it's not really "media")
- May face Play Store review pushback
- More complex implementation
- <cite>Flutter doesn't provide direct support for Android Auto</cite>—requires native Kotlin bridging

---

### 4. Companion Widget on Phone (Alternative)
**Effort:** Low | **Impact:** Medium | **Risk:** None

Skip Android Auto entirely. Build a phone home screen widget that's visible when the user glances at their phone in the car mount:

- Large, glanceable stats
- Updates automatically
- No interaction required while driving

**Implementation:**
- `home_widget` package for Flutter
- Simple display: Level, Streak, Today's Progress

---

## Recommended Phased Approach

| Phase | Feature | Effort | Dependencies |
|-------|---------|--------|--------------|
| **2** | Rich notifications with geofencing | 2-3 days | Phone app working |
| **2** | Phone home screen widget | 1-2 days | Phone app working |
| **3** | Google Assistant integration | 1 week | Stats API or broadcast |
| **4+** | Audio motivation media service | 2+ weeks | Significant native code |

---

## Geofencing Implementation Sketch

```dart
// services/location_service.dart

class LocationService {
  final List<GeofenceRegion> favoriteSpots = [];
  
  // User can mark parks/trails as "walking spots"
  void addWalkingSpot(String name, double lat, double lng) {
    favoriteSpots.add(GeofenceRegion(
      id: name,
      latitude: lat,
      longitude: lng,
      radius: 200, // meters
      triggers: [GeofenceTrigger.enter, GeofenceTrigger.exit],
    ));
  }
  
  void onGeofenceEvent(GeofenceEvent event) {
    if (event.trigger == GeofenceTrigger.enter) {
      // Arriving at walking spot
      NotificationService.showMotivation(
        context: MessageContext.arrivingAtTrail,
        data: gameState,
      );
    } else if (event.trigger == GeofenceTrigger.exit) {
      // Leaving walking spot
      NotificationService.showMotivation(
        context: MessageContext.leavingTrail,
        data: gameState,
      );
    }
  }
}
```

---

## Apple CarPlay Notes

The `flutter_carplay` package exists and recently added Android Auto support. However:

- CarPlay has similar category restrictions
- Navigation apps get more flexibility
- Step Quest would face same limitations

The notification + Assistant approach works equally well on iOS with Siri Shortcuts.

---

## Blog Angle: "The Road Not Rendered"

This is great content for the blog series:

**Chapter title:** "Why My Step Counter Can't Talk to My Car (And What I Did Instead)"

Key narrative beats:
1. The excitement: "Android Auto support! Motivation while driving!"
2. The research: "Wait, there are only 4 allowed app types?"
3. The creative workaround: Geofenced notifications, voice assistant
4. The lesson: Platform constraints force creative solutions
5. The Dwarf Fortress energy: "Removed Android Auto support. Added yelling at user via notification instead. Fixed bug where 'arriving at park' triggered while parked at Wendy's."

---

## Recommendation

For the MVP and near-term phases:

1. **Phase 2:** Implement rich notifications with basic time-of-day triggers
2. **Phase 2:** Add phone home screen widget
3. **Phase 3:** Add geofencing for walking spot detection
4. **Phase 3:** Build Google Assistant Action

This gives 90% of the "motivation while driving" UX without the complexity of a full Android Auto media service. The user experience is:

**Morning, leaving for work:**
> *Notification:* "Level 4, Day 8 of your streak. You need 10,000 steps to keep it alive. Make today count!"

**Arriving at park:**
> *Notification:* "You're here! 4,230 steps to goal. This walk could get you to Level 5. Let's go."

**Leaving park:**
> *Notification:* "6,500 steps logged! Goal crushed. Level 5 achieved! 🎉 Enjoy the drive home."

**In car, via voice:**
> "Hey Google, how's my Step Quest?"
> *"You're Level 5 with an 8-day streak! Nice work on that walk—you're 1,500 XP into Level 5."*

That's a pretty great driving experience without fighting the Android Auto restrictions.

---

*End of Technical Assessment*
