import '../models/step_quest_data.dart';
import '../models/achievement.dart';

/// Core game logic for processing steps, XP, levels, and streaks.
class GameEngine {
  /// Processes a step log entry and returns the updated game state.
  ///
  /// [currentState] - The current game state
  /// [steps] - Number of steps to add (must be positive)
  /// [logDate] - The date when steps were logged
  static StepQuestData processSteps(
    StepQuestData currentState,
    int steps,
    DateTime logDate,
  ) {
    if (steps <= 0) return currentState;

    final logDateString = _formatDate(logDate);
    final lastDate = currentState.lastLogDate;

    int newTodaySteps;
    int newStreak;

    if (logDateString == lastDate) {
      // Same day: accumulate steps
      newTodaySteps = currentState.todaySteps + steps;
      newStreak = currentState.streak;
    } else {
      // New day
      if (lastDate != null && _isNextDay(lastDate, logDateString)) {
        // Consecutive day
        if (currentState.todaySteps >= StepQuestData.dailyGoal) {
          // Previous day met goal, increment streak
          newStreak = currentState.streak + 1;
        } else {
          // Previous day didn't meet goal, reset streak
          newStreak = 0;
        }
      } else {
        // Not consecutive (either first log or gap in days)
        newStreak = lastDate == null ? 0 : 0; // Reset streak on gap
      }
      newTodaySteps = steps;
    }

    // Calculate new XP and level
    int newTotalXP = currentState.currentXP + steps;
    int newLevel = currentState.level;

    while (newTotalXP >= StepQuestData.xpPerLevel) {
      newLevel++;
      newTotalXP -= StepQuestData.xpPerLevel;
    }

    // Check for new achievements
    final tempState = StepQuestData(
      totalSteps: currentState.totalSteps + steps,
      level: newLevel,
      currentXP: newTotalXP,
      streak: newStreak,
      lastLogDate: logDateString,
      todaySteps: newTodaySteps,
      unlockedAchievements: currentState.unlockedAchievements,
      lastModified: DateTime.now(),
    );

    final newAchievements = checkAchievements(tempState);

    return tempState.copyWith(
      unlockedAchievements: newAchievements,
    );
  }

  /// Checks all achievements and returns the updated list of unlocked achievement IDs.
  static List<String> checkAchievements(StepQuestData state) {
    final unlocked = List<String>.from(state.unlockedAchievements);

    for (final achievement in allAchievements) {
      if (!unlocked.contains(achievement.id) && achievement.condition(state)) {
        unlocked.add(achievement.id);
      }
    }

    return unlocked;
  }

  /// Formats a DateTime as an ISO date string (YYYY-MM-DD).
  static String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-'
        '${date.month.toString().padLeft(2, '0')}-'
        '${date.day.toString().padLeft(2, '0')}';
  }

  /// Checks if date2 is exactly one day after date1.
  static bool _isNextDay(String date1, String date2) {
    final d1 = DateTime.parse(date1);
    final d2 = DateTime.parse(date2);
    final nextDay = d1.add(const Duration(days: 1));
    return nextDay.year == d2.year &&
        nextDay.month == d2.month &&
        nextDay.day == d2.day;
  }

  /// Checks if the given date string matches today's date.
  static bool isToday(String? dateString) {
    if (dateString == null) return false;
    return dateString == _formatDate(DateTime.now());
  }

  /// Gets today's date as an ISO string.
  static String getTodayString() {
    return _formatDate(DateTime.now());
  }
}
