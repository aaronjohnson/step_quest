import 'package:flutter/material.dart';
import '../models/step_quest_data.dart';
import '../theme/app_theme.dart';
import 'game_card.dart';

/// Displays the current streak and goal status.
class StreakCard extends StatelessWidget {
  final StepQuestData data;

  const StreakCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final streakText = data.streak == 1 ? 'Day' : 'Day';

    return GameCard(
      child: Row(
        children: [
          Text(
            '🔥',
            style: TextStyle(
              fontSize: 32,
              color: data.streak > 0 ? null : AppColors.textSecondary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '${data.streak} $streakText Streak',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  data.goalMetToday
                      ? "Great job! You've hit your goal today!"
                      : 'Hit 10,000 steps to continue your streak!',
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
