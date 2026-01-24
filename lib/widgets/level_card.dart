import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/step_quest_data.dart';
import '../theme/app_theme.dart';
import 'game_card.dart';
import 'progress_bar.dart';

/// Displays current level, total steps, and XP progress.
class LevelCard extends StatelessWidget {
  final StepQuestData data;

  const LevelCard({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');

    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  const Text(
                    '☆ ',
                    style: TextStyle(fontSize: 24),
                  ),
                  Text(
                    'Level ${data.level}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const Text(
                    'Total Steps',
                    style: TextStyle(
                      fontSize: 12,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Text(
                    numberFormat.format(data.totalSteps),
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 16),
          ProgressBar(
            progress: data.levelProgress,
            backgroundColor: AppColors.cardOverlay,
            foregroundColor: AppColors.accentGold,
          ),
          const SizedBox(height: 8),
          Text(
            '${numberFormat.format(data.currentXP)} / ${numberFormat.format(StepQuestData.xpPerLevel)} XP',
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
          ),
        ],
      ),
    );
  }
}
