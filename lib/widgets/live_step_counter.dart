import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:permission_handler/permission_handler.dart';
import '../l10n/app_localizations.dart';
import '../providers/game_state_provider.dart';
import '../theme/app_theme.dart';

/// Widget showing live step count from pedometer with auto-sync.
class LiveStepCounter extends ConsumerStatefulWidget {
  const LiveStepCounter({super.key});

  @override
  ConsumerState<LiveStepCounter> createState() => _LiveStepCounterState();
}

class _LiveStepCounterState extends ConsumerState<LiveStepCounter>
    with SingleTickerProviderStateMixin {
  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;
  Timer? _syncTimer;
  int _lastSyncedSteps = 0;
  bool _hasPermission = false;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      duration: const Duration(milliseconds: 1000),
      vsync: this,
    )..repeat(reverse: true);

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.15).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    _checkPermissionAndStart();
  }

  Future<void> _checkPermissionAndStart() async {
    final status = await Permission.activityRecognition.request();
    if (status.isGranted) {
      setState(() => _hasPermission = true);
      _startPedometer();
    }
  }

  void _startPedometer() {
    final pedometer = ref.read(pedometerServiceProvider);
    pedometer.start();
    ref.read(pedometerActiveProvider.notifier).state = true;

    // Sync to game state every 10 steps or every 30 seconds
    _syncTimer = Timer.periodic(const Duration(seconds: 30), (_) {
      _syncStepsToGame();
    });
  }

  void _syncStepsToGame() {
    final pedometer = ref.read(pedometerServiceProvider);
    final currentSteps = pedometer.sessionSteps;

    if (currentSteps > _lastSyncedSteps) {
      final newSteps = currentSteps - _lastSyncedSteps;
      _lastSyncedSteps = currentSteps;
      ref.read(gameStateProvider.notifier).addPedometerSteps(newSteps);
    }
  }

  @override
  void dispose() {
    _syncStepsToGame(); // Final sync before disposing
    _pulseController.dispose();
    _syncTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final liveSteps = ref.watch(liveStepCountProvider);
    final status = ref.watch(pedestrianStatusProvider);
    final isActive = ref.watch(pedometerActiveProvider);

    if (!_hasPermission) {
      return _buildPermissionRequest(l10n);
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.accentGreen.withValues(alpha: 0.2),
            AppColors.accentGreen.withValues(alpha: 0.1),
          ],
        ),
        border: Border.all(
          color: AppColors.accentGreen.withValues(alpha: 0.3),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          // Animated walking indicator
          AnimatedBuilder(
            animation: _pulseAnimation,
            builder: (context, child) {
              final isWalking = status.valueOrNull == 'walking';
              return Transform.scale(
                scale: isWalking ? _pulseAnimation.value : 1.0,
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: isWalking
                        ? AppColors.accentGreen.withValues(alpha: 0.3)
                        : Colors.white.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    isWalking ? '🚶' : '🧍',
                    style: const TextStyle(fontSize: 24),
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 8,
                      height: 8,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: isActive ? AppColors.accentGreen : Colors.grey,
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color: AppColors.accentGreen.withValues(alpha: 0.5),
                                  blurRadius: 6,
                                ),
                              ]
                            : null,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      l10n.liveTracking,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                        color: AppColors.accentGreen,
                        letterSpacing: 1,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                liveSteps.when(
                  data: (steps) => Row(
                    children: [
                      Text(
                        '+$steps',
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        l10n.stepsThisSession,
                        style: const TextStyle(
                          fontSize: 12,
                          color: AppColors.textSecondary,
                        ),
                      ),
                    ],
                  ),
                  loading: () => Text(
                    l10n.liveStarting,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                  error: (e, _) => Text(
                    l10n.pedometerUnavailable,
                    style: const TextStyle(color: AppColors.textSecondary),
                  ),
                ),
              ],
            ),
          ),
          // Sync button
          IconButton(
            onPressed: _syncStepsToGame,
            icon: const Icon(Icons.sync, color: AppColors.accentGreen),
            tooltip: l10n.syncStepsNow,
          ),
        ],
      ),
    );
  }

  Widget _buildPermissionRequest(AppLocalizations l10n) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Colors.white.withValues(alpha: 0.1),
        border: Border.all(
          color: Colors.white.withValues(alpha: 0.1),
          width: 1,
        ),
      ),
      child: Row(
        children: [
          const Text('🚶', style: TextStyle(fontSize: 24)),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.enableStepTracking,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: AppColors.textPrimary,
                  ),
                ),
                Text(
                  l10n.enableStepTrackingDesc,
                  style: const TextStyle(
                    fontSize: 12,
                    color: AppColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: _checkPermissionAndStart,
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.accentGreen,
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            ),
            child: Text(l10n.enableButton),
          ),
        ],
      ),
    );
  }
}
