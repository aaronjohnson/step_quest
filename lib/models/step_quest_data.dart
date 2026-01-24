import 'dart:math';
import 'package:json_annotation/json_annotation.dart';

part 'step_quest_data.g.dart';

/// Core game state persisted to local storage.
@JsonSerializable()
class StepQuestData {
  /// Lifetime accumulated steps across all sessions.
  final int totalSteps;

  /// Current player level (1-based, no maximum).
  final int level;

  /// XP accumulated toward next level (0-4999).
  final int currentXP;

  /// Consecutive days with >= 10,000 steps.
  final int streak;

  /// ISO-8601 date of last log entry (YYYY-MM-DD).
  final String? lastLogDate;

  /// Steps logged for current calendar day.
  final int todaySteps;

  /// List of achievement IDs that have been unlocked.
  final List<String> unlockedAchievements;

  /// Timestamp of last save (for sync conflict resolution).
  final DateTime lastModified;

  // Constants
  static const int xpPerLevel = 5000;
  static const int dailyGoal = 10000;

  const StepQuestData({
    required this.totalSteps,
    required this.level,
    required this.currentXP,
    required this.streak,
    this.lastLogDate,
    required this.todaySteps,
    required this.unlockedAchievements,
    required this.lastModified,
  });

  /// Creates an empty/initial game state.
  factory StepQuestData.empty() => StepQuestData(
        totalSteps: 0,
        level: 1,
        currentXP: 0,
        streak: 0,
        lastLogDate: null,
        todaySteps: 0,
        unlockedAchievements: const [],
        lastModified: DateTime.now(),
      );

  /// Progress toward next level (0.0 to 1.0).
  double get levelProgress => currentXP / xpPerLevel;

  /// XP remaining to reach next level.
  int get xpToNextLevel => xpPerLevel - currentXP;

  /// Whether today's step goal has been met.
  bool get goalMetToday => todaySteps >= dailyGoal;

  /// Steps remaining to reach daily goal.
  int get stepsToGoal => max(0, dailyGoal - todaySteps);

  /// Creates a copy with updated fields.
  StepQuestData copyWith({
    int? totalSteps,
    int? level,
    int? currentXP,
    int? streak,
    String? lastLogDate,
    int? todaySteps,
    List<String>? unlockedAchievements,
    DateTime? lastModified,
  }) {
    return StepQuestData(
      totalSteps: totalSteps ?? this.totalSteps,
      level: level ?? this.level,
      currentXP: currentXP ?? this.currentXP,
      streak: streak ?? this.streak,
      lastLogDate: lastLogDate ?? this.lastLogDate,
      todaySteps: todaySteps ?? this.todaySteps,
      unlockedAchievements: unlockedAchievements ?? this.unlockedAchievements,
      lastModified: lastModified ?? this.lastModified,
    );
  }

  factory StepQuestData.fromJson(Map<String, dynamic> json) =>
      _$StepQuestDataFromJson(json);

  Map<String, dynamic> toJson() => _$StepQuestDataToJson(this);

  @override
  String toString() {
    return 'StepQuestData(level: $level, xp: $currentXP, totalSteps: $totalSteps, '
        'streak: $streak, todaySteps: $todaySteps)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is StepQuestData &&
        other.totalSteps == totalSteps &&
        other.level == level &&
        other.currentXP == currentXP &&
        other.streak == streak &&
        other.lastLogDate == lastLogDate &&
        other.todaySteps == todaySteps &&
        _listEquals(other.unlockedAchievements, unlockedAchievements);
  }

  @override
  int get hashCode {
    return Object.hash(
      totalSteps,
      level,
      currentXP,
      streak,
      lastLogDate,
      todaySteps,
      Object.hashAll(unlockedAchievements),
    );
  }
}

bool _listEquals<T>(List<T> a, List<T> b) {
  if (a.length != b.length) return false;
  for (int i = 0; i < a.length; i++) {
    if (a[i] != b[i]) return false;
  }
  return true;
}
