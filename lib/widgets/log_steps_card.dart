import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import '../models/step_quest_data.dart';
import '../theme/app_theme.dart';
import 'game_card.dart';
import 'progress_bar.dart';

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
    widget.onLogSteps(steps);
  }

  void _handleCustomAdd() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;

    final steps = int.tryParse(text);
    if (steps != null && steps > 0) {
      widget.onLogSteps(steps);
      _controller.clear();
      _focusNode.unfocus();
    }
  }

  @override
  Widget build(BuildContext context) {
    final numberFormat = NumberFormat('#,###');
    final progress = widget.data.todaySteps / StepQuestData.dailyGoal;

    return GameCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Text('🎯', style: TextStyle(fontSize: 24)),
              SizedBox(width: 8),
              Text(
                "Log Today's Steps",
                style: TextStyle(
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
                'Today: ${numberFormat.format(widget.data.todaySteps)} / ${numberFormat.format(StepQuestData.dailyGoal)}',
                style: const TextStyle(
                  fontSize: 16,
                  color: AppColors.textPrimary,
                ),
              ),
              if (widget.data.stepsToGoal > 0)
                Text(
                  '${numberFormat.format(widget.data.stepsToGoal)} to go',
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
              _QuickAddButton(
                  label: '+2.5k', onTap: () => _handleQuickAdd(2500)),
              const SizedBox(width: 8),
              _QuickAddButton(label: '+5k', onTap: () => _handleQuickAdd(5000)),
              const SizedBox(width: 8),
              _QuickAddButton(
                  label: '+10k', onTap: () => _handleQuickAdd(10000)),
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
                  inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                  style: const TextStyle(color: AppColors.textPrimary),
                  decoration: const InputDecoration(
                    hintText: 'Enter steps...',
                    contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  ),
                  onSubmitted: (_) => _handleCustomAdd(),
                ),
              ),
              const SizedBox(width: 12),
              ElevatedButton(
                onPressed: _handleCustomAdd,
                child: const Text('Add'),
              ),
            ],
          ),
          const SizedBox(height: 12),
          const Row(
            children: [
              Icon(Icons.check, size: 16, color: AppColors.textSecondary),
              SizedBox(width: 4),
              Text(
                'Progress auto-saved',
                style: TextStyle(
                  fontSize: 12,
                  color: AppColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;

  const _QuickAddButton({required this.label, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Material(
        color: AppColors.cardOverlay,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(8),
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            alignment: Alignment.center,
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
