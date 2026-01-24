import 'step_quest_data.dart';

/// Represents an unlockable achievement in the game.
class Achievement {
  /// Unique identifier for persistence.
  final String id;

  /// Display name shown to user.
  final String name;

  /// Description of how to unlock.
  final String description;

  /// Emoji icon for the achievement.
  final String emoji;

  /// Function that checks if achievement condition is met.
  final bool Function(StepQuestData) condition;

  const Achievement({
    required this.id,
    required this.name,
    required this.description,
    required this.emoji,
    required this.condition,
  });
}

/// All available achievements in the game.
final List<Achievement> allAchievements = [
  Achievement(
    id: 'first_steps',
    name: 'First Steps',
    description: 'Log your first steps',
    emoji: '👟',
    condition: (data) => data.totalSteps > 0,
  ),
  Achievement(
    id: 'goal_crusher',
    name: 'Goal Crusher',
    description: 'Hit 10,000 steps in a single day',
    emoji: '🎯',
    condition: (data) => data.todaySteps >= 10000,
  ),
  Achievement(
    id: 'marathon_walker',
    name: 'Marathon Walker',
    description: 'Walk 20,000 steps in a single day',
    emoji: '🏃',
    condition: (data) => data.todaySteps >= 20000,
  ),
  Achievement(
    id: 'week_warrior',
    name: 'Week Warrior',
    description: 'Maintain a 7-day streak',
    emoji: '🔥',
    condition: (data) => data.streak >= 7,
  ),
  Achievement(
    id: 'level_5_hero',
    name: 'Level 5 Hero',
    description: 'Reach level 5',
    emoji: '⭐',
    condition: (data) => data.level >= 5,
  ),
  Achievement(
    id: 'century_club',
    name: 'Century Club',
    description: 'Accumulate 100,000 total steps',
    emoji: '💯',
    condition: (data) => data.totalSteps >= 100000,
  ),
];

/// Map for quick lookup by ID.
final Map<String, Achievement> achievementById = {
  for (final a in allAchievements) a.id: a,
};
