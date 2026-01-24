import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/game_state_provider.dart';
import '../../theme/app_theme.dart';

/// Quick log screen for adding steps on watch.
class WatchQuickLog extends ConsumerStatefulWidget {
  const WatchQuickLog({super.key});

  @override
  ConsumerState<WatchQuickLog> createState() => _WatchQuickLogState();
}

class _WatchQuickLogState extends ConsumerState<WatchQuickLog> {
  bool _showConfirmation = false;
  int _lastAddedSteps = 0;

  void _logSteps(int steps) {
    ref.read(gameStateProvider.notifier).logSteps(steps);

    // Haptic feedback
    HapticFeedback.mediumImpact();

    // Show confirmation
    setState(() {
      _showConfirmation = true;
      _lastAddedSteps = steps;
    });

    // Auto-return to dashboard after delay
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted && _showConfirmation) {
        Navigator.pop(context);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    if (_showConfirmation) {
      return _ConfirmationScreen(steps: _lastAddedSteps);
    }

    return Scaffold(
      backgroundColor: AppColors.primaryGradientEnd,
      body: Container(
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
              const Text(
                'Add Steps',
                style: TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(height: 16),
              // Quick add buttons in a circular layout
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QuickAddButton(
                    label: '+1k',
                    onTap: () => _logSteps(1000),
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QuickAddButton(
                    label: '+5k',
                    onTap: () => _logSteps(5000),
                    isPrimary: true,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _QuickAddButton(
                    label: '+10k',
                    onTap: () => _logSteps(10000),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Back button
              GestureDetector(
                onTap: () => Navigator.pop(context),
                child: const Text(
                  '← Back',
                  style: TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _QuickAddButton extends StatelessWidget {
  final String label;
  final VoidCallback onTap;
  final bool isPrimary;

  const _QuickAddButton({
    required this.label,
    required this.onTap,
    this.isPrimary = false,
  });

  @override
  Widget build(BuildContext context) {
    final size = isPrimary ? 72.0 : 56.0;
    final fontSize = isPrimary ? 18.0 : 14.0;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isPrimary ? AppColors.accentGreen : AppColors.cardOverlay,
          boxShadow: isPrimary
              ? [
                  BoxShadow(
                    color: AppColors.accentGreen.withValues(alpha: 0.4),
                    blurRadius: 12,
                    spreadRadius: 2,
                  ),
                ]
              : null,
        ),
        child: Center(
          child: Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.bold,
              color: AppColors.textPrimary,
            ),
          ),
        ),
      ),
    );
  }
}

class _ConfirmationScreen extends StatelessWidget {
  final int steps;

  const _ConfirmationScreen({required this.steps});

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: AppColors.accentGreen,
      body: SizedBox(
        width: screenSize.width,
        height: screenSize.height,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(
              Icons.check_circle,
              size: 48,
              color: Colors.white,
            ),
            const SizedBox(height: 12),
            Text(
              '+${_formatSteps(steps)}',
              style: const TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            const SizedBox(height: 4),
            const Text(
              'steps added!',
              style: TextStyle(
                fontSize: 14,
                color: Colors.white70,
              ),
            ),
          ],
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
