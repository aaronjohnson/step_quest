import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../models/step_quest_data.dart';
import '../theme/app_theme.dart';

/// Displays the current streak and goal status with animated fire.
class StreakCard extends StatefulWidget {
  final StepQuestData data;

  const StreakCard({super.key, required this.data});

  @override
  State<StreakCard> createState() => _StreakCardState();
}

class _StreakCardState extends State<StreakCard>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _flameAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    )..repeat(reverse: true);

    _flameAnimation = Tween<double>(begin: 0.9, end: 1.1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final hasStreak = widget.data.streak > 0;
    final goalMet = widget.data.goalMetToday;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: hasStreak
              ? [
                  const Color(0xFFFF6B35).withValues(alpha: 0.3),
                  const Color(0xFFFF4500).withValues(alpha: 0.1),
                ]
              : [
                  Colors.white.withValues(alpha: 0.1),
                  Colors.white.withValues(alpha: 0.05),
                ],
        ),
        border: Border.all(
          color: hasStreak
              ? const Color(0xFFFF6B35).withValues(alpha: 0.5)
              : Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            // Animated flame
            AnimatedBuilder(
              animation: _flameAnimation,
              builder: (context, child) {
                return Transform.scale(
                  scale: hasStreak ? _flameAnimation.value : 1.0,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      if (hasStreak)
                        Container(
                          width: 50,
                          height: 50,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: const Color(0xFFFF6B35)
                                    .withValues(alpha: 0.5 * _flameAnimation.value),
                                blurRadius: 20,
                                spreadRadius: 5,
                              ),
                            ],
                          ),
                        ),
                      Text(
                        '🔥',
                        style: TextStyle(
                          fontSize: 36,
                          color: hasStreak ? null : AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Wrap(
                    crossAxisAlignment: WrapCrossAlignment.center,
                    spacing: 8,
                    runSpacing: 4,
                    children: [
                      Text(
                        l10n.streakDayStreak(widget.data.streak),
                        style: const TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      if (widget.data.streak >= 7)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 8,
                            vertical: 2,
                          ),
                          decoration: BoxDecoration(
                            color: AppColors.accentGold.withValues(alpha: 0.2),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Text(
                            widget.data.streak >= 30
                                ? '🏆 ${l10n.streakBadgeLegend}'
                                : widget.data.streak >= 14
                                    ? '⭐ ${l10n.streakBadgePro}'
                                    : '✨ ${l10n.streakBadgeHot}',
                            style: const TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                              color: AppColors.accentGold,
                            ),
                          ),
                        ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  Row(
                    children: [
                      Icon(
                        goalMet ? Icons.check_circle : Icons.timer_outlined,
                        size: 16,
                        color: goalMet ? AppColors.accentGreen : AppColors.textSecondary,
                      ),
                      const SizedBox(width: 6),
                      Expanded(
                        child: Text(
                          goalMet ? l10n.streakGoalMet : l10n.streakGoalPrompt,
                          style: TextStyle(
                            fontSize: 13,
                            color: goalMet ? AppColors.accentGreen : AppColors.textSecondary,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
