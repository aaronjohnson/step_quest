import 'package:flutter_test/flutter_test.dart';
import 'package:step_quest/models/step_quest_data.dart';
import 'package:step_quest/services/game_engine.dart';

void main() {
  group('GameEngine.processSteps', () {
    late StepQuestData emptyState;
    late DateTime today;
    late DateTime yesterday;
    late DateTime twoDaysAgo;

    setUp(() {
      emptyState = StepQuestData.empty();
      today = DateTime(2025, 1, 24);
      yesterday = DateTime(2025, 1, 23);
      twoDaysAgo = DateTime(2025, 1, 22);
    });

    group('XP and Level calculations', () {
      test('adds steps to totalSteps', () {
        final result = GameEngine.processSteps(emptyState, 1000, today);
        expect(result.totalSteps, 1000);
      });

      test('converts steps to XP at 1:1 ratio', () {
        final result = GameEngine.processSteps(emptyState, 3000, today);
        expect(result.currentXP, 3000);
      });

      test('levels up at exactly 5000 XP', () {
        final result = GameEngine.processSteps(emptyState, 5000, today);
        expect(result.level, 2);
        expect(result.currentXP, 0);
      });

      test('carries over XP after level up', () {
        final result = GameEngine.processSteps(emptyState, 7000, today);
        expect(result.level, 2);
        expect(result.currentXP, 2000);
      });

      test('handles multiple level ups from single entry', () {
        final result = GameEngine.processSteps(emptyState, 12500, today);
        expect(result.level, 3);
        expect(result.currentXP, 2500);
      });

      test('accumulates XP across multiple logs', () {
        var state = GameEngine.processSteps(emptyState, 3000, today);
        state = GameEngine.processSteps(state, 3000, today);
        expect(state.level, 2);
        expect(state.currentXP, 1000);
        expect(state.totalSteps, 6000);
      });

      test('rejects negative step values', () {
        final result = GameEngine.processSteps(emptyState, -100, today);
        expect(result.totalSteps, 0);
      });

      test('rejects zero step values', () {
        final result = GameEngine.processSteps(emptyState, 0, today);
        expect(result.totalSteps, 0);
      });
    });

    group('Today steps tracking', () {
      test('sets todaySteps on first log', () {
        final result = GameEngine.processSteps(emptyState, 5000, today);
        expect(result.todaySteps, 5000);
      });

      test('accumulates multiple logs on same day', () {
        var state = GameEngine.processSteps(emptyState, 3000, today);
        state = GameEngine.processSteps(state, 2000, today);
        expect(state.todaySteps, 5000);
      });

      test('resets todaySteps on new day', () {
        var state = GameEngine.processSteps(emptyState, 5000, yesterday);
        state = GameEngine.processSteps(state, 3000, today);
        expect(state.todaySteps, 3000);
      });

      test('sets lastLogDate correctly', () {
        final result = GameEngine.processSteps(emptyState, 1000, today);
        expect(result.lastLogDate, '2025-01-24');
      });
    });

    group('Streak calculations', () {
      test('streak starts at 0', () {
        final result = GameEngine.processSteps(emptyState, 10000, today);
        expect(result.streak, 0);
      });

      test('streak increments when consecutive day meets goal', () {
        // Day 1: Log 10000 steps
        var state = GameEngine.processSteps(emptyState, 10000, yesterday);
        expect(state.streak, 0);

        // Day 2: Log more steps (consecutive day)
        state = GameEngine.processSteps(state, 5000, today);
        expect(state.streak, 1);
      });

      test('streak does not increment if previous day missed goal', () {
        // Day 1: Log only 5000 steps (under goal)
        var state = GameEngine.processSteps(emptyState, 5000, yesterday);

        // Day 2: Log steps
        state = GameEngine.processSteps(state, 10000, today);
        expect(state.streak, 0);
      });

      test('streak resets when day is skipped', () {
        // Day 1: Log 10000 steps
        var state = GameEngine.processSteps(emptyState, 10000, twoDaysAgo);
        // Skip a day, log on day 3
        state = GameEngine.processSteps(state, 10000, today);
        expect(state.streak, 0);
      });

      test('streak continues across multiple days', () {
        // Day 1
        var state = GameEngine.processSteps(emptyState, 10000, twoDaysAgo);
        expect(state.streak, 0);

        // Day 2 (consecutive)
        state = GameEngine.processSteps(state, 10000, yesterday);
        expect(state.streak, 1);

        // Day 3 (consecutive)
        state = GameEngine.processSteps(state, 10000, today);
        expect(state.streak, 2);
      });

      test('multiple logs same day do not affect streak', () {
        var state = GameEngine.processSteps(emptyState, 10000, yesterday);
        state = GameEngine.processSteps(state, 5000, today);
        expect(state.streak, 1);

        // Log more on same day
        state = GameEngine.processSteps(state, 5000, today);
        expect(state.streak, 1); // Still 1, not incremented again
      });
    });

    group('Achievement unlocking', () {
      test('unlocks first_steps on first log', () {
        final result = GameEngine.processSteps(emptyState, 100, today);
        expect(result.unlockedAchievements, contains('first_steps'));
      });

      test('unlocks goal_crusher at 10000 today steps', () {
        final result = GameEngine.processSteps(emptyState, 10000, today);
        expect(result.unlockedAchievements, contains('goal_crusher'));
      });

      test('unlocks marathon_walker at 20000 today steps', () {
        final result = GameEngine.processSteps(emptyState, 20000, today);
        expect(result.unlockedAchievements, contains('marathon_walker'));
      });

      test('unlocks level_5_hero at level 5', () {
        final result = GameEngine.processSteps(emptyState, 20000, today);
        expect(result.level, 5);
        expect(result.unlockedAchievements, contains('level_5_hero'));
      });

      test('unlocks century_club at 100000 total steps', () {
        final result = GameEngine.processSteps(emptyState, 100000, today);
        expect(result.unlockedAchievements, contains('century_club'));
      });

      test('unlocks week_warrior at 7-day streak', () {
        var state = emptyState;
        final startDate = DateTime(2025, 1, 17);

        // Log 10000 steps for 8 consecutive days (need 8 to get streak of 7)
        for (int i = 0; i < 8; i++) {
          final date = startDate.add(Duration(days: i));
          state = GameEngine.processSteps(state, 10000, date);
        }

        expect(state.streak, 7);
        expect(state.unlockedAchievements, contains('week_warrior'));
      });

      test('achievements persist once unlocked', () {
        var state = GameEngine.processSteps(emptyState, 10000, yesterday);
        expect(state.unlockedAchievements, contains('goal_crusher'));

        // New day with fewer steps
        state = GameEngine.processSteps(state, 1000, today);
        expect(state.unlockedAchievements, contains('goal_crusher'));
      });

      test('does not duplicate achievements', () {
        var state = GameEngine.processSteps(emptyState, 5000, today);
        state = GameEngine.processSteps(state, 5000, today);

        final firstStepsCount = state.unlockedAchievements
            .where((id) => id == 'first_steps')
            .length;
        expect(firstStepsCount, 1);
      });
    });
  });

  group('GameEngine date utilities', () {
    test('formatDate produces ISO format', () {
      // Test via processSteps which uses _formatDate internally
      final state = StepQuestData.empty();
      final result = GameEngine.processSteps(state, 100, DateTime(2025, 1, 5));
      expect(result.lastLogDate, '2025-01-05');
    });

    test('handles month boundaries', () {
      final state = StepQuestData.empty();
      var result = GameEngine.processSteps(state, 10000, DateTime(2025, 1, 31));
      result = GameEngine.processSteps(result, 5000, DateTime(2025, 2, 1));
      expect(result.streak, 1); // Should recognize consecutive days
    });

    test('handles year boundaries', () {
      final state = StepQuestData.empty();
      var result = GameEngine.processSteps(state, 10000, DateTime(2024, 12, 31));
      result = GameEngine.processSteps(result, 5000, DateTime(2025, 1, 1));
      expect(result.streak, 1);
    });
  });

  group('StepQuestData computed properties', () {
    test('levelProgress calculates correctly', () {
      final state = StepQuestData(
        totalSteps: 2500,
        level: 1,
        currentXP: 2500,
        streak: 0,
        todaySteps: 2500,
        unlockedAchievements: [],
        lastModified: DateTime.now(),
      );
      expect(state.levelProgress, 0.5);
    });

    test('xpToNextLevel calculates correctly', () {
      final state = StepQuestData(
        totalSteps: 3000,
        level: 1,
        currentXP: 3000,
        streak: 0,
        todaySteps: 3000,
        unlockedAchievements: [],
        lastModified: DateTime.now(),
      );
      expect(state.xpToNextLevel, 2000);
    });

    test('goalMetToday is true at 10000 steps', () {
      final state = StepQuestData(
        totalSteps: 10000,
        level: 2,
        currentXP: 0,
        streak: 0,
        todaySteps: 10000,
        unlockedAchievements: [],
        lastModified: DateTime.now(),
      );
      expect(state.goalMetToday, true);
    });

    test('goalMetToday is false below 10000 steps', () {
      final state = StepQuestData(
        totalSteps: 9999,
        level: 1,
        currentXP: 4999,
        streak: 0,
        todaySteps: 9999,
        unlockedAchievements: [],
        lastModified: DateTime.now(),
      );
      expect(state.goalMetToday, false);
    });

    test('stepsToGoal calculates remaining steps', () {
      final state = StepQuestData(
        totalSteps: 7500,
        level: 2,
        currentXP: 2500,
        streak: 0,
        todaySteps: 7500,
        unlockedAchievements: [],
        lastModified: DateTime.now(),
      );
      expect(state.stepsToGoal, 2500);
    });

    test('stepsToGoal is 0 when goal exceeded', () {
      final state = StepQuestData(
        totalSteps: 15000,
        level: 3,
        currentXP: 0,
        streak: 1,
        todaySteps: 15000,
        unlockedAchievements: [],
        lastModified: DateTime.now(),
      );
      expect(state.stepsToGoal, 0);
    });
  });
}
