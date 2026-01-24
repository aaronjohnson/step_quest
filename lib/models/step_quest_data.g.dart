// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'step_quest_data.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StepQuestData _$StepQuestDataFromJson(Map<String, dynamic> json) =>
    StepQuestData(
      totalSteps: (json['totalSteps'] as num).toInt(),
      level: (json['level'] as num).toInt(),
      currentXP: (json['currentXP'] as num).toInt(),
      streak: (json['streak'] as num).toInt(),
      lastLogDate: json['lastLogDate'] as String?,
      todaySteps: (json['todaySteps'] as num).toInt(),
      unlockedAchievements: (json['unlockedAchievements'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      lastModified: DateTime.parse(json['lastModified'] as String),
    );

Map<String, dynamic> _$StepQuestDataToJson(StepQuestData instance) =>
    <String, dynamic>{
      'totalSteps': instance.totalSteps,
      'level': instance.level,
      'currentXP': instance.currentXP,
      'streak': instance.streak,
      'lastLogDate': instance.lastLogDate,
      'todaySteps': instance.todaySteps,
      'unlockedAchievements': instance.unlockedAchievements,
      'lastModified': instance.lastModified.toIso8601String(),
    };
