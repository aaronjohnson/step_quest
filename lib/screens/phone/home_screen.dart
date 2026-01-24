import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/game_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/level_card.dart';
import '../../widgets/streak_card.dart';
import '../../widgets/log_steps_card.dart';
import '../../widgets/achievements_card.dart';

/// Main home screen for the phone app.
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);

    return Scaffold(
      body: GradientBackground(
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                // App header
                const Text(
                  '🏆 Step Quest',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                const Text(
                  'Turn your steps into an adventure!',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                // Level card
                LevelCard(data: gameState),
                const SizedBox(height: 16),
                // Streak card
                StreakCard(data: gameState),
                const SizedBox(height: 16),
                // Log steps card
                LogStepsCard(
                  data: gameState,
                  onLogSteps: (steps) {
                    ref.read(gameStateProvider.notifier).logSteps(steps);
                  },
                ),
                const SizedBox(height: 16),
                // Achievements card
                AchievementsCard(data: gameState),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
