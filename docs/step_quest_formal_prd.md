# Step Quest: Product Requirements Document

**Document Version:** 1.0  
**Date:** January 24, 2026  
**Status:** Draft for Implementation  
**Author:** [Your Name] + Claude  

---

## 1. Executive Summary

### 1.1 Product Vision

Step Quest transforms mundane step counting into an engaging RPG-style progression game. Users manually log their daily steps (from Samsung Health or any fitness tracker) and watch their character level up, maintain streaks, and unlock achievements.

### 1.2 Origin

This application began as a React/JSX artifact generated through conversational AI in Claude.ai. This PRD documents the requirements for porting to Flutter/Dart to enable cross-platform deployment including Wear OS smartwatches.

### 1.3 Target Platforms

| Platform | Priority | Status |
|----------|----------|--------|
| Android Phone | P0 | Phase 1 |
| iOS Phone | P0 | Phase 1 |
| Wear OS (Samsung Galaxy Watch 4+) | P1 | Phase 2 |
| Apple Watch | P2 | Future |

### 1.4 Success Metrics

- User opens app daily for 7+ consecutive days
- User maintains streak for 14+ days
- User unlocks 4+ achievements within first month
- App launches in < 2 seconds on target devices

---

## 2. User Stories

### 2.1 Core User Stories

**US-001: Log Daily Steps**
> As a fitness-conscious user, I want to quickly log my step count from Samsung Health so that I can track my progress in the game.

*Acceptance Criteria:*
- [ ] User can enter a numeric step value via text input
- [ ] User can tap quick-add buttons (+1k, +2.5k, +5k, +10k)
- [ ] Multiple entries on the same day accumulate
- [ ] Invalid inputs (negative, non-numeric) are rejected gracefully
- [ ] Entry is persisted immediately

**US-002: View Progress**
> As a user, I want to see my current level, XP progress, and total steps so that I feel a sense of accomplishment.

*Acceptance Criteria:*
- [ ] Current level displayed prominently
- [ ] XP progress bar shows progress toward next level
- [ ] Numeric XP shown (e.g., "3,200 / 5,000 XP")
- [ ] Total lifetime steps displayed
- [ ] Level-up triggers a celebratory UI feedback

**US-003: Maintain Streaks**
> As a user, I want to see how many consecutive days I've hit my 10,000 step goal so that I stay motivated.

*Acceptance Criteria:*
- [ ] Current streak count displayed
- [ ] Streak increments when daily goal met on consecutive days
- [ ] Streak resets to 0 if a day is missed
- [ ] Clear messaging about what's needed to continue streak

**US-004: Unlock Achievements**
> As a user, I want to unlock achievements for hitting milestones so that I have additional goals to pursue.

*Acceptance Criteria:*
- [ ] All 6 achievements visible (locked state shows grayed)
- [ ] Achievement unlocks trigger notification/celebration
- [ ] Unlocked achievements persist across sessions
- [ ] Achievement progress visible where applicable

**US-005: Quick Entry on Watch**
> As a watch user, I want to log steps directly from my wrist without pulling out my phone.

*Acceptance Criteria:*
- [ ] Watch app launches in < 1 second
- [ ] Dashboard shows current level and streak at a glance
- [ ] Quick-tap buttons for common step amounts
- [ ] Haptic feedback on successful entry
- [ ] Data syncs to phone app

---

## 3. Functional Requirements

### 3.1 Game Mechanics

#### 3.1.1 Experience Points (XP)

| Rule | Specification |
|------|---------------|
| XP per step | 1:1 ratio (1 step = 1 XP) |
| XP to level up | 5,000 XP per level |
| XP overflow | Carries to next level (7,000 XP → Level 2 + 2,000 XP) |
| Maximum level | No cap (theoretically infinite) |

#### 3.1.2 Streak System

```
STREAK RULES:

1. Daily Goal: 10,000 steps
2. Day boundary: Local midnight (user's timezone)
3. Streak increment: User logs ≥10,000 steps AND it's the day after their last qualifying day
4. Streak reset: User misses a calendar day entirely OR logs <10,000 steps for a day
5. Same-day logging: Multiple entries accumulate; streak evaluated at end of day or next login

EDGE CASES:
- User logs 5,000 steps Monday, 5,000 more Monday evening → counts as 10,000 for Monday
- User logs 10,000 steps Monday, nothing Tuesday, 10,000 Wednesday → streak resets
- User crosses midnight while logging → uses device's current date
- Timezone change → honor device's local time
```

#### 3.1.3 Achievement System

| ID | Name | Emoji | Trigger Condition | Category |
|----|------|-------|-------------------|----------|
| `first_steps` | First Steps | 👟 | totalSteps > 0 | Onboarding |
| `goal_crusher` | Goal Crusher | 🎯 | todaySteps ≥ 10,000 (any single day) | Daily |
| `marathon_walker` | Marathon Walker | 🏃 | todaySteps ≥ 20,000 (any single day) | Daily |
| `week_warrior` | Week Warrior | 🔥 | streak ≥ 7 | Streak |
| `level_5_hero` | Level 5 Hero | ⭐ | level ≥ 5 | Progression |
| `century_club` | Century Club | 💯 | totalSteps ≥ 100,000 | Milestone |

**Achievement unlock behavior:**
- Check conditions after every step log
- Once unlocked, achievement is permanent
- Display toast/snackbar notification on unlock
- Play subtle haptic feedback

### 3.2 Data Model

```dart
/// Core game state persisted to local storage
@JsonSerializable()
class StepQuestData {
  /// Lifetime accumulated steps across all sessions
  final int totalSteps;
  
  /// Current player level (1-based, no maximum)
  final int level;
  
  /// XP accumulated toward next level (0-4999)
  final int currentXP;
  
  /// Consecutive days with ≥10,000 steps
  final int streak;
  
  /// ISO-8601 date of last log entry (YYYY-MM-DD)
  final String? lastLogDate;
  
  /// Steps logged for current calendar day
  final int todaySteps;
  
  /// List of achievement IDs that have been unlocked
  final List<String> unlockedAchievements;
  
  /// Timestamp of last save (for sync conflict resolution)
  final DateTime lastModified;
  
  // Constants
  static const int xpPerLevel = 5000;
  static const int dailyGoal = 10000;
  
  // Computed properties
  double get levelProgress => currentXP / xpPerLevel;
  int get xpToNextLevel => xpPerLevel - currentXP;
  bool get goalMetToday => todaySteps >= dailyGoal;
  int get stepsToGoal => max(0, dailyGoal - todaySteps);
}
```

### 3.3 Persistence

#### 3.3.1 Phone Storage

| Aspect | Specification |
|--------|---------------|
| Package | `shared_preferences` |
| Key | `step_quest_data_v1` |
| Format | JSON string |
| Trigger | Immediate save after any state change |
| Migration | Version key in data; migrate on load if needed |

#### 3.3.2 Watch Storage (Phase 2)

| Aspect | Specification |
|--------|---------------|
| Package | `shared_preferences` (local) + Wear Data Layer (sync) |
| Sync direction | Bidirectional with conflict resolution |
| Conflict rule | Most recent `lastModified` wins |
| Offline behavior | Local changes queue until sync available |

### 3.4 User Interface

#### 3.4.1 Phone App Screens

**Home Screen (Single scrollable screen)**

```
┌────────────────────────────────────────┐
│ [Status Bar]                           │
├────────────────────────────────────────┤
│                                        │
│   🏆 STEP QUEST                        │
│   Turn your steps into an adventure!   │
│                                        │
├────────────────────────────────────────┤
│ ┌────────────────────────────────────┐ │
│ │ ☆ Level 3           Total Steps   │ │
│ │                            12,450  │ │
│ │ ████████████░░░░░░░               │ │
│ │ 2,450 / 5,000 XP                  │ │
│ └────────────────────────────────────┘ │
├────────────────────────────────────────┤
│ ┌────────────────────────────────────┐ │
│ │ ⚡ 5 Day Streak                    │ │
│ │ Hit 10,000 steps to continue!     │ │
│ └────────────────────────────────────┘ │
├────────────────────────────────────────┤
│ ┌────────────────────────────────────┐ │
│ │ 🎯 Log Today's Steps              │ │
│ │                                    │ │
│ │ Today: 7,500 / 10,000             │ │
│ │ ████████████████░░░░░░  2,500 to go│ │
│ │                                    │ │
│ │ [+1k] [+2.5k] [+5k] [+10k]        │ │
│ │                                    │ │
│ │ ┌──────────────────┐  ┌────────┐  │ │
│ │ │ Enter steps...   │  │  Add   │  │ │
│ │ └──────────────────┘  └────────┘  │ │
│ │                                    │ │
│ │ ✓ Progress auto-saved             │ │
│ └────────────────────────────────────┘ │
├────────────────────────────────────────┤
│ ┌────────────────────────────────────┐ │
│ │ 🏅 Achievements (3/6)             │ │
│ │                                    │ │
│ │ ┌──────┐ ┌──────┐ ┌──────┐       │ │
│ │ │  👟  │ │  🎯  │ │  🏃  │       │ │
│ │ │First │ │ Goal │ │Marath│       │ │
│ │ │Steps │ │Crush │ │Walker│       │ │
│ │ │  ✓   │ │  ✓   │ │  🔒  │       │ │
│ │ └──────┘ └──────┘ └──────┘       │ │
│ │ ┌──────┐ ┌──────┐ ┌──────┐       │ │
│ │ │  🔥  │ │  ⭐  │ │  💯  │       │ │
│ │ │ Week │ │Lvl 5 │ │Century│      │ │
│ │ │Warrior│ │ Hero │ │ Club │       │ │
│ │ │  🔒  │ │  🔒  │ │  ✓   │       │ │
│ │ └──────┘ └──────┘ └──────┘       │ │
│ └────────────────────────────────────┘ │
│                                        │
└────────────────────────────────────────┘
```

#### 3.4.2 Watch App Screens

**Dashboard (Default view)**

Round display optimized:
- Center: Level number with stars
- Middle ring: Total steps (large font)
- Bottom: Streak indicator
- Background: Gradient matching phone theme

**Quick Log (Swipe up or tap)**

- Large tap targets for quick-add
- Minimalist: only +1k, +5k, +10k
- Confirmation haptic on tap
- Auto-return to dashboard after 3s

**Ambient Mode**

- Reduce to: Level number + streak only
- Monochrome or minimal color
- No animations
- Update every minute (not realtime)

### 3.5 Visual Design Specifications

#### 3.5.1 Color System

```dart
// Primary palette (from original artifact)
static const primaryGradientStart = Color(0xFF667EEA);  // Purple-blue
static const primaryGradientEnd = Color(0xFF764BA2);    // Deep purple

// Secondary palette
static const secondaryGradientStart = Color(0xFF06B6D4); // Cyan
static const secondaryGradientEnd = Color(0xFF3B82F6);   // Blue

// Accent colors
static const accentGreen = Color(0xFF22C55E);  // Success/Add button
static const accentOrange = Color(0xFFF97316); // Streak fire
static const accentGold = Color(0xFFEAB308);   // Level star

// Neutral
static const cardOverlay = Color(0x33FFFFFF);  // 20% white
static const textPrimary = Color(0xFFFFFFFF);
static const textSecondary = Color(0xCCFFFFFF); // 80% white
```

#### 3.5.2 Typography

| Element | Font | Weight | Size (phone) | Size (watch) |
|---------|------|--------|--------------|--------------|
| App title | System | Bold | 28sp | 18sp |
| Card headers | System | SemiBold | 20sp | 14sp |
| Body text | System | Regular | 16sp | 12sp |
| Step numbers | Monospace | Bold | 32sp | 24sp |
| Buttons | System | Medium | 16sp | 12sp |

#### 3.5.3 Spacing & Layout

| Element | Phone | Watch |
|---------|-------|-------|
| Screen padding | 16dp | 8dp |
| Card padding | 20dp | 12dp |
| Card corner radius | 16dp | 12dp |
| Card spacing | 16dp | 8dp |
| Button height | 48dp | 40dp |
| Touch target minimum | 44dp | 48dp |

---

## 4. Non-Functional Requirements

### 4.1 Performance

| Metric | Target | Measurement |
|--------|--------|-------------|
| Cold start (phone) | < 2s | Time to interactive |
| Cold start (watch) | < 1s | Time to interactive |
| Step log response | < 100ms | UI feedback latency |
| Memory usage (phone) | < 50MB | Peak RAM |
| Memory usage (watch) | < 30MB | Peak RAM |
| APK size | < 15MB | Release build |

### 4.2 Reliability

- Data must persist across app restarts
- No data loss on crash during save
- Graceful degradation if storage unavailable
- Watch app functional without phone connection

### 4.3 Accessibility

- Minimum contrast ratio: 4.5:1
- Support for system font scaling
- Screen reader compatibility (semantic labels)
- Touch targets ≥ 44dp

### 4.4 Localization (Future)

- UI strings externalized
- Number formatting locale-aware
- Date formatting locale-aware
- RTL layout support

---

## 5. Technical Architecture

### 5.1 Project Structure

```
step_quest/
├── lib/
│   ├── main.dart                    # App entry point
│   ├── app.dart                     # MaterialApp configuration
│   │
│   ├── core/
│   │   ├── constants.dart           # Game constants
│   │   ├── theme.dart               # ThemeData & colors
│   │   └── utils/
│   │       ├── date_utils.dart      # Date comparison helpers
│   │       └── number_format.dart   # Step formatting
│   │
│   ├── models/
│   │   ├── step_quest_data.dart     # Core data model
│   │   ├── step_quest_data.g.dart   # JSON serialization (generated)
│   │   └── achievement.dart         # Achievement definitions
│   │
│   ├── services/
│   │   ├── persistence_service.dart # shared_preferences wrapper
│   │   ├── game_engine.dart         # XP/level/streak calculations
│   │   └── achievement_service.dart # Achievement checking
│   │
│   ├── providers/                   # State management (Riverpod or Provider)
│   │   └── game_state_provider.dart
│   │
│   ├── screens/
│   │   ├── phone/
│   │   │   └── home_screen.dart
│   │   └── watch/
│   │       ├── watch_home.dart
│   │       └── watch_quick_log.dart
│   │
│   └── widgets/
│       ├── cards/
│       │   ├── level_card.dart
│       │   ├── streak_card.dart
│       │   ├── log_steps_card.dart
│       │   └── achievements_card.dart
│       ├── common/
│       │   ├── gradient_background.dart
│       │   ├── progress_bar.dart
│       │   └── quick_add_button.dart
│       └── watch/
│           └── ambient_display.dart
│
├── android/
│   └── app/src/main/
│       ├── AndroidManifest.xml      # Wear OS declarations
│       └── kotlin/.../MainActivity.kt # Rotary input handler
│
├── ios/
│   └── Runner/
│       └── Info.plist
│
├── test/
│   ├── models/
│   │   └── step_quest_data_test.dart
│   ├── services/
│   │   ├── game_engine_test.dart
│   │   └── achievement_service_test.dart
│   └── widget_test.dart
│
└── pubspec.yaml
```

### 5.2 Dependencies

```yaml
name: step_quest
description: Turn your steps into an adventure!
version: 1.0.0+1

environment:
  sdk: '>=3.0.0 <4.0.0'

dependencies:
  flutter:
    sdk: flutter
  
  # Persistence
  shared_preferences: ^2.2.2
  
  # State management (choose one)
  flutter_riverpod: ^2.4.0
  # OR provider: ^6.1.1
  
  # JSON serialization
  json_annotation: ^4.8.1
  
  # Wear OS support
  wear: ^1.1.0
  wearable_rotary: ^1.0.0
  
  # Utilities
  intl: ^0.18.1              # Date/number formatting
  collection: ^1.18.0        # List utilities
  
dev_dependencies:
  flutter_test:
    sdk: flutter
  flutter_lints: ^3.0.1
  build_runner: ^2.4.7
  json_serializable: ^6.7.1
  mockito: ^5.4.4

flutter:
  uses-material-design: true
```

### 5.3 State Management Approach

Using Riverpod (recommended for testability):

```dart
// providers/game_state_provider.dart

final gameStateProvider = StateNotifierProvider<GameStateNotifier, StepQuestData>((ref) {
  return GameStateNotifier(ref.read(persistenceServiceProvider));
});

class GameStateNotifier extends StateNotifier<StepQuestData> {
  final PersistenceService _persistence;
  
  GameStateNotifier(this._persistence) : super(StepQuestData.empty()) {
    _loadState();
  }
  
  Future<void> _loadState() async {
    state = await _persistence.load() ?? StepQuestData.empty();
  }
  
  Future<void> logSteps(int steps) async {
    state = GameEngine.processSteps(state, steps, DateTime.now());
    await _persistence.save(state);
  }
}
```

---

## 6. Testing Strategy

### 6.1 Unit Tests

| Component | Test Cases |
|-----------|------------|
| `GameEngine.processSteps` | XP calculation, level-up, overflow |
| `GameEngine.calculateStreak` | Same day, consecutive, gap, edge cases |
| `AchievementService.check` | Each achievement trigger condition |
| `StepQuestData.fromJson/toJson` | Serialization round-trip |
| `DateUtils` | Same day check, next day check, timezone |

### 6.2 Widget Tests

- Level card renders correctly for various states
- Quick-add buttons trigger correct values
- Achievement grid shows locked/unlocked states
- Progress bars display accurate percentages

### 6.3 Integration Tests

- Full flow: log steps → see XP change → level up → achievement unlock
- Persistence: log steps → kill app → relaunch → data persists
- Watch: log on watch → verify on phone (Phase 2)

### 6.4 Edge Case Tests

```dart
// Streak edge cases
test('streak continues across month boundary', () { ... });
test('streak handles daylight saving time', () { ... });
test('streak resets when day is skipped', () { ... });
test('multiple logs same day accumulate', () { ... });

// XP edge cases  
test('level up on exact 5000 XP', () { ... });
test('multiple level ups from single large entry', () { ... });
test('XP never goes negative', () { ... });

// Input validation
test('rejects negative step values', () { ... });
test('rejects non-integer values', () { ... });
test('handles maximum integer gracefully', () { ... });
```

---

## 7. Rollout Plan

### Phase 1: Phone MVP (Weeks 1-2)

- [ ] Project setup and architecture
- [ ] Data model and persistence
- [ ] Game engine (XP, levels, streaks)
- [ ] Phone UI implementation
- [ ] Achievement system
- [ ] Unit and widget tests
- [ ] Internal testing

### Phase 2: Wear OS (Weeks 3-4)

- [ ] Wear OS project configuration
- [ ] Watch UI (dashboard + quick log)
- [ ] Ambient mode support
- [ ] Rotary bezel input
- [ ] Phone-watch data sync
- [ ] Watch-specific testing

### Phase 3: Polish & Release (Week 5)

- [ ] Performance optimization
- [ ] Accessibility audit
- [ ] Play Store / Galaxy Store assets
- [ ] Release build configuration
- [ ] Beta testing
- [ ] Store submission

### Future Phases

- Health API integration (Samsung Health, Apple HealthKit)
- Historical data visualization
- Social features (leaderboards)
- Custom daily goals
- Additional achievements
- Widgets (phone home screen, watch complications)

---

## 8. Open Questions

1. **Daily goal customization:** Should users be able to change the 10k goal?
   - *Recommendation:* Not for v1. Keep it simple.

2. **Historical data:** Should we track daily history for charts?
   - *Recommendation:* Track in data model but don't build UI for v1.

3. **Notifications:** Remind users who haven't logged?
   - *Recommendation:* Phase 3. Requires notification permissions.

4. **Data export:** Allow users to export their history?
   - *Recommendation:* Future feature. Nice for power users.

5. **Watch standalone vs companion:**
   - *Recommendation:* Start as companion (requires phone), evaluate standalone for v2.

---

## 9. Appendix

### A. Original React Artifact Reference

The original implementation was a React/JSX artifact with:
- Single component with useState hooks
- localStorage for persistence
- Inline Tailwind-style CSS
- ~400 lines of code

Key behavioral reference from original:
- Gradient backgrounds (purple-to-blue)
- Card-based layout
- Quick-add buttons appeared in final iteration
- Achievement grid with emoji icons

### B. Competitor Analysis

| App | Gamification | Watch Support | Differentiator |
|-----|--------------|---------------|----------------|
| Samsung Health | Basic challenges | Native | Health ecosystem |
| Strava | Segments, kudos | Yes | Social/competitive |
| Zombies, Run! | Narrative | Limited | Story immersion |
| **Step Quest** | RPG progression | Yes (Flutter) | Simple, satisfying leveling |

### C. Glossary

| Term | Definition |
|------|------------|
| XP | Experience points earned from steps |
| Level | Player progression tier (1 level = 5000 XP) |
| Streak | Consecutive days meeting 10k goal |
| Achievement | One-time unlock for reaching milestone |
| Companion app | Watch app that syncs with phone |
| Standalone app | Watch app that works independently |
| Ambient mode | Low-power always-on watch display |

---

*End of Document*
