import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/game_state_provider.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/level_card.dart';
import '../../widgets/streak_card.dart';
import '../../widgets/log_steps_card.dart';
import '../../widgets/achievements_card.dart';
import '../../widgets/health_connect_card.dart';
import '../../widgets/supporter_card.dart';

/// Main home screen for the phone app.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSyncing = false;

  @override
  void initState() {
    super.initState();
    _checkHealthConnect();
  }

  Future<void> _checkHealthConnect() async {
    final notifier = ref.read(gameStateProvider.notifier);
    final available = await notifier.isHealthConnectAvailable();

    if (!mounted) return;

    if (!available) {
      ref.read(healthConnectStatusProvider.notifier).state =
          HealthConnectStatus.unavailable;
      return;
    }

    // Check if already authorized
    final healthService = ref.read(healthServiceProvider);
    final authorized = await healthService.hasAuthorization();

    if (!mounted) return;

    ref.read(healthConnectStatusProvider.notifier).state =
        authorized ? HealthConnectStatus.authorized : HealthConnectStatus.notAuthorized;

    // If authorized, do initial sync
    if (authorized) {
      _syncSteps();
    }
  }

  Future<void> _connectHealthConnect() async {
    final notifier = ref.read(gameStateProvider.notifier);
    final authorized = await notifier.authorizeHealthConnect();

    if (!mounted) return;

    ref.read(healthConnectStatusProvider.notifier).state =
        authorized ? HealthConnectStatus.authorized : HealthConnectStatus.notAuthorized;

    if (authorized) {
      _syncSteps();
    }
  }

  Future<void> _syncSteps() async {
    if (_isSyncing) return;

    setState(() => _isSyncing = true);

    try {
      await ref.read(gameStateProvider.notifier).syncFromHealthConnect();
    } finally {
      if (mounted) {
        setState(() => _isSyncing = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final gameState = ref.watch(gameStateProvider);
    final healthStatus = ref.watch(healthConnectStatusProvider);

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
                // Health Connect card
                HealthConnectCard(
                  status: healthStatus,
                  onConnect: _connectHealthConnect,
                  onSync: _syncSteps,
                  isSyncing: _isSyncing,
                ),
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
                const SizedBox(height: 16),
                // Supporter card
                const SupporterCard(),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
