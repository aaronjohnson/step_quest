# Step Quest: Claude Code Session Kickoff

## Context

I'm porting a step-tracking gamification app from a React artifact to Flutter/Dart. The goal is to support Android phone, iOS phone, and Wear OS (Samsung Galaxy Watch).

## Reference Materials

I have two specification documents:
1. **Lightweight Spec** (`step_quest_lightweight_spec.md`) - Quick reference for data model, game rules, and project structure
2. **Formal PRD** (`step_quest_formal_prd.md`) - Comprehensive requirements with user stories, edge cases, and acceptance criteria

## What I Need

Let's build this incrementally:

### Session 1: Foundation
1. Create Flutter project with proper structure
2. Implement `StepQuestData` model with JSON serialization
3. Implement `PersistenceService` using shared_preferences
4. Implement `GameEngine` with XP/level/streak calculations
5. Write unit tests for the game engine

### Session 2: Phone UI
1. Build the phone app UI (single scrollable screen)
2. Implement the gradient theme from the spec
3. Wire up state management (Riverpod preferred)
4. Add achievement checking

### Session 3: Wear OS
1. Configure project for Wear OS
2. Build watch dashboard screen
3. Build quick-log screen
4. Add ambient mode support

## Technical Preferences

- **State management:** Riverpod (prefer over Provider for testability)
- **Avoid:** Excessive third-party packages; keep it lean
- **Testing:** Unit tests for business logic are important
- **Style:** Clean Dart with documentation comments on public APIs

## Screenshots

[The original React artifact looked like the attached screenshots - purple/blue gradient background, card-based layout, achievement grid with emoji icons]

---

**Let's start with Session 1.** Can you set up the Flutter project and implement the data model + persistence layer?
