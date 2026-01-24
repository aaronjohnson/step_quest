# Step Quest: Lightweight Technical Spec

**Purpose:** Port a React PWA step-tracking game to Flutter/Dart for phone + Wear OS watch.

**Target Platforms:**
- Android phone (primary)
- iOS phone (secondary)  
- Wear OS / Samsung Galaxy Watch (companion app)

---

## Data Model

```dart
class StepQuestData {
  int totalSteps;
  int level;
  int currentXP;
  int streak;
  String? lastLogDate;        // ISO date string: "2025-01-24"
  int todaySteps;
  List<String> achievements;  // IDs of unlocked achievements
  
  // Computed
  int get xpToNextLevel => 5000;
  double get levelProgress => currentXP / xpToNextLevel;
}

class Achievement {
  final String id;
  final String name;
  final String description;
  final String emoji;
  final bool Function(StepQuestData) condition;
}
```

---

## Achievement Definitions

| ID | Name | Condition | Emoji |
|----|------|-----------|-------|
| `first_steps` | First Steps | totalSteps > 0 | 👟 |
| `goal_crusher` | Goal Crusher | todaySteps >= 10000 | 🎯 |
| `marathon_walker` | Marathon Walker | todaySteps >= 20000 | 🏃 |
| `week_warrior` | Week Warrior | streak >= 7 | 🔥 |
| `level_5_hero` | Level 5 Hero | level >= 5 | ⭐ |
| `century_club` | Century Club | totalSteps >= 100000 | 💯 |

---

## Core Game Rules

**XP System:**
- 1 step = 1 XP
- 5,000 XP = 1 level up
- XP carries over (e.g., 7,000 steps → Level 2 with 2,000 XP)

**Streak Logic:**
```
on_steps_logged(steps, date):
  if date == lastLogDate:
    todaySteps += steps
  else:
    if date == lastLogDate + 1 day AND todaySteps >= 10000:
      streak += 1
    else if date != lastLogDate + 1 day:
      streak = 0
    todaySteps = steps
    lastLogDate = date
  
  totalSteps += steps
  currentXP += steps
  while currentXP >= 5000:
    level += 1
    currentXP -= 5000
  
  check_achievements()
```

---

## Persistence

**Phone:** `shared_preferences` package
- Key: `step_quest_data`
- Value: JSON-encoded `StepQuestData`
- Auto-save on every step log

**Watch:** Same approach, but data syncs via Wear Data Layer API (v2)

---

## UI Components (Phone)

```
┌─────────────────────────────────┐
│ 🏆 Step Quest                   │
│ "Turn your steps into adventure"│
├─────────────────────────────────┤
│ ☆ Level {n}      Total: {steps} │
│ ████████░░░░░ {xp}/5000 XP      │
├─────────────────────────────────┤
│ ⚡ {n} Day Streak               │
│ "Hit 10,000 to continue!"       │
├─────────────────────────────────┤
│ 🎯 Log Today's Steps            │
│ Today: {n}/10,000               │
│ ████████████░░░░ {remaining}    │
│                                 │
│ [+1k] [+2.5k] [+5k] [+10k]     │
│ ┌─────────────────┐ [  Add  ]   │
│ │ Custom amount   │             │
│ └─────────────────┘             │
├─────────────────────────────────┤
│ 🏅 Achievements ({n}/6)         │
│ ┌─────┐ ┌─────┐ ┌─────┐        │
│ │ 👟  │ │ 🎯  │ │ 🏃  │        │
│ │unlkd│ │lockd│ │lockd│        │
│ └─────┘ └─────┘ └─────┘        │
└─────────────────────────────────┘
```

---

## UI Components (Watch - Wear OS)

Simplified for 1.4" round display:

**Screen 1: Dashboard (default)**
```
      ┌───────────┐
    ╱             ╲
   │   Level 3     │
   │   ⭐⭐⭐      │
   │               │
   │  12,450 steps │
   │   🔥 5 days   │
    ╲             ╱
      └───────────┘
```

**Screen 2: Quick Log (swipe up)**
```
      ┌───────────┐
    ╱    +1000     ╲
   │               │
   │    [TAP]      │
   │               │
    ╲    +5000    ╱
      └───────────┘
```

**Watch-specific considerations:**
- Use `WatchShape` to detect round vs square
- Implement `AmbientMode` for always-on display
- Support rotary bezel input for scrolling
- Dark theme default (OLED battery savings)

---

## Project Structure

```
step_quest/
├── lib/
│   ├── main.dart
│   ├── models/
│   │   ├── step_quest_data.dart
│   │   └── achievement.dart
│   ├── services/
│   │   ├── persistence_service.dart
│   │   └── game_logic_service.dart
│   ├── screens/
│   │   ├── phone/
│   │   │   └── home_screen.dart
│   │   └── watch/
│   │       ├── dashboard_screen.dart
│   │       └── quick_log_screen.dart
│   ├── widgets/
│   │   ├── level_card.dart
│   │   ├── streak_card.dart
│   │   ├── log_steps_card.dart
│   │   ├── achievements_grid.dart
│   │   └── quick_add_buttons.dart
│   └── theme/
│       └── app_theme.dart
├── android/
│   └── app/
│       └── src/
│           └── main/
│               └── AndroidManifest.xml  # Wear OS flags
└── pubspec.yaml
```

---

## Key Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.0
  wear: ^1.1.0                    # Wear OS support
  wearable_rotary: ^1.0.0         # Bezel input
  intl: ^0.18.0                   # Date formatting
  
dev_dependencies:
  flutter_test:
    sdk: flutter
```

---

## Phase 1 Deliverables (MVP)

1. Phone app with full feature parity to React version
2. Local persistence working
3. All 6 achievements functional
4. Quick-add buttons working

## Phase 2 Deliverables

1. Wear OS companion app (dashboard + quick log)
2. Watch-to-phone data sync
3. Ambient mode support

## Phase 3 (Future)

1. Samsung Health API integration (auto-import steps)
2. Apple HealthKit integration
3. Notifications/reminders
4. Historical charts

---

## Visual Design Notes

**Color Palette (from screenshots):**
- Primary gradient: `#667EEA` → `#764BA2` (purple-blue)
- Secondary gradient: `#06B6D4` → `#3B82F6` (cyan-blue)
- Accent (buttons): `#22C55E` (green)
- Text: White on gradients
- Cards: Semi-transparent white overlay

**Typography:**
- Use system fonts for performance
- Bold weights for headers
- Monospace for numbers (step counts)

**Watch adaptations:**
- Darker gradients for OLED
- Larger touch targets (min 48dp)
- Reduced information density
