import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wear_plus/wear_plus.dart';
import '../../providers/game_state_provider.dart';
import '../../theme/app_theme.dart';
import 'watch_quick_log.dart';

/// Main dashboard screen for Wear OS watch.
class WatchHome extends ConsumerWidget {
  const WatchHome({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return WatchShape(
      builder: (context, shape, child) {
        return AmbientMode(
          builder: (context, mode, child) {
            return mode == WearMode.active
                ? const _ActiveWatchHome()
                : const _AmbientWatchHome();
          },
        );
      },
    );
  }
}

/// Active mode watch dashboard with full UI.
class _ActiveWatchHome extends ConsumerWidget {
  const _ActiveWatchHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.primaryGradientEnd,
      body: GestureDetector(
        onVerticalDragEnd: (details) {
          // Swipe up to open quick log
          if (details.primaryVelocity != null && details.primaryVelocity! < -200) {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const WatchQuickLog()),
            );
          }
        },
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const WatchQuickLog()),
          );
        },
        child: Container(
          width: screenSize.width,
          height: screenSize.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                AppColors.primaryGradientStart,
                AppColors.primaryGradientEnd,
              ],
            ),
          ),
          child: SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Level display
                Text(
                  'Level ${gameState.level}',
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                const SizedBox(height: 4),
                // Stars for level (up to 5)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    (gameState.level).clamp(1, 5),
                    (_) => const Text('⭐', style: TextStyle(fontSize: 16)),
                  ),
                ),
                const SizedBox(height: 16),
                // Total steps (large)
                Text(
                  _formatSteps(gameState.totalSteps),
                  style: const TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                    fontFeatures: [FontFeature.tabularFigures()],
                  ),
                ),
                const Text(
                  'steps',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 12),
                // Streak
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text('🔥', style: TextStyle(fontSize: 18)),
                    const SizedBox(width: 4),
                    Text(
                      '${gameState.streak} days',
                      style: const TextStyle(
                        fontSize: 14,
                        color: AppColors.textPrimary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                // Hint to tap
                const Text(
                  'Tap to log steps',
                  style: TextStyle(
                    fontSize: 10,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  String _formatSteps(int steps) {
    if (steps >= 1000) {
      return '${(steps / 1000).toStringAsFixed(steps % 1000 == 0 ? 0 : 1)}k';
    }
    return steps.toString();
  }
}

/// Ambient mode watch display (low power).
class _AmbientWatchHome extends ConsumerWidget {
  const _AmbientWatchHome();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final gameState = ref.watch(gameStateProvider);
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.black,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Level (minimal)
            Text(
              'Lv ${gameState.level}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w300,
                color: Colors.white70,
              ),
            ),
            const SizedBox(height: 8),
            // Steps
            Text(
              '${gameState.totalSteps}',
              style: const TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.w300,
                color: Colors.white,
                fontFeatures: [FontFeature.tabularFigures()],
              ),
            ),
            const SizedBox(height: 8),
            // Streak (if any)
            if (gameState.streak > 0)
              Text(
                '🔥 ${gameState.streak}',
                style: const TextStyle(
                  fontSize: 14,
                  color: Colors.white54,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
