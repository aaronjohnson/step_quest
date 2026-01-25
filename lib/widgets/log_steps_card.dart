import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../l10n/app_localizations.dart';
import '../models/step_quest_data.dart';
import '../theme/app_theme.dart';
import 'progress_bar.dart';
import 'step_celebration.dart';

/// Card for logging daily steps with quick-add buttons and custom input.
class LogStepsCard extends StatefulWidget {
  final StepQuestData data;
  final void Function(int steps) onLogSteps;

  const LogStepsCard({
    super.key,
    required this.data,
    required this.onLogSteps,
  });

  @override
  State<LogStepsCard> createState() => _LogStepsCardState();
}

class _LogStepsCardState extends State<LogStepsCard> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _handleQuickAdd(int steps) {
    HapticFeedback.mediumImpact();
    widget.onLogSteps(steps);
    CelebrationOverlay.show(context, steps);
  }

  // Max steps per single entry (100k is generous for any reasonable use)
  static const int _maxStepsPerEntry = 100000;

  void _handleCustomAdd() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final steps = int.tryParse(text);
    if (steps == null || steps <= 0) return;

    // Clamp to reasonable max
    final clampedSteps = steps > _maxStepsPerEntry ? _maxStepsPerEntry : steps;

    HapticFeedback.mediumImpact();
    widget.onLogSteps(clampedSteps);
    CelebrationOverlay.show(context, clampedSteps);
    _controller.clear();
    _focusNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final numberFormat = NumberFormat('#,###');
    final progress = widget.data.todaySteps / StepQuestData.dailyGoal;

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Colors.white.withValues(alpha: 0.12),
            Colors.white.withValues(alpha: 0.05),
          ],
        ),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.15),
          width: 1,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: AppColors.accentGreen.withValues(alpha: 0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: const Text('🎯', style: TextStyle(fontSize: 24)),
                ),
                const SizedBox(width: 12),
                Text(
                  l10n.logTodayTitle,
                  style: const TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
              ],
            ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                l10n.logTodayProgress(
                  numberFormat.format(widget.data.todaySteps),
                  numberFormat.format(StepQuestData.dailyGoal),
                ),
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              if (widget.data.stepsToGoal > 0)
                Text(
                  l10n.logStepsToGo(numberFormat.format(widget.data.stepsToGoal)),
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
            ],
          ),
          const SizedBox(height: 8),
          ProgressBar(
            progress: progress,
            backgroundColor: AppColors.cardOverlay,
            foregroundColor: AppColors.accentGreen,
          ),
          const SizedBox(height: 20),
          // Quick-add buttons
          Row(
            children: [
              _QuickAddButton(label: '+1k', onTap: () => _handleQuickAdd(1000)),
              const SizedBox(width: 8),
              _QuickAddButton(label: '+2.5k', onTap: () => _handleQuickAdd(2500)),
              const SizedBox(width: 8),
              _QuickAddButton(label: '+5k', onTap: () => _handleQuickAdd(5000), isPrimary: true),
              const SizedBox(width: 8),
              _QuickAddButton(label: '+10k', onTap: () => _handleQuickAdd(10000)),
            ],
          ),
          const SizedBox(height: 16),
          // Custom input
          Row(
            children: [
              Expanded(
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  keyboardType: TextInputType.number,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(6), // Max 999,999
                  ],
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: InputDecoration(
                    hintText: l10n.logEnterSteps,
                    contentPadding:
                        const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSubmitted: (_) => _handleCustomAdd(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _handleCustomAdd,
                child: Text(l10n.logAddButton),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Icon(Icons.cloud_done_outlined, size: 14, color: AppColors.accentGreen.withValues(alpha: 0.7)),
              const SizedBox(width: 4),
              Text(
                l10n.logAutoSaved,
                style: TextStyle(
                  fontSize: 11,
                  color: AppColors.textSecondary.withValues(alpha: 0.8),
                ),
              ),
            ],
          ),
        ],
        ),
      ),
    );
  }
}

class _QuickAddButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QuickAddButton({
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  State<_QuickAddButton> createState() => _QuickAddButtonState();
}

class _QuickAddButtonState extends State<_QuickAddButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
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
    final color = widget.isPrimary ? AppColors.accentGreen : AppColors.cardOverlay;

    return Expanded(
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onTap();
        },
        onTapCancel: () => _controller.reverse(),
        child: AnimatedBuilder(
          animation: _scaleAnimation,
          builder: (context, child) {
            return Transform.scale(
              scale: _scaleAnimation.value,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 14),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: widget.isPrimary
                        ? [
                            AppColors.accentGreen,
                            AppColors.accentGreen.withValues(alpha: 0.8),
                          ]
                        : [
                            Colors.white.withValues(alpha: 0.15),
                            Colors.white.withValues(alpha: 0.08),
                          ],
                  ),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: widget.isPrimary
                        ? AppColors.accentGreen.withValues(alpha: 0.5)
                        : Colors.white.withValues(alpha: 0.1),
                    width: 1,
                  ),
                  boxShadow: widget.isPrimary
                      ? [
                          BoxShadow(
                            color: AppColors.accentGreen.withValues(alpha: 0.3),
                            blurRadius: 8,
                            offset: const Offset(0, 2),
                          ),
                        ]
                      : null,
                ),
                alignment: Alignment.center,
                child: Text(
                  widget.label,
                  style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: widget.isPrimary ? Colors.white : AppColors.textPrimary,
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
