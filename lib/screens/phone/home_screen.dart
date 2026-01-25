import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../l10n/app_localizations.dart';
import '../../providers/game_state_provider.dart';
import '../../providers/locale_provider.dart';
import '../../services/easter_egg_service.dart';
import '../../theme/app_theme.dart';
import '../../widgets/gradient_background.dart';
import '../../widgets/language_selector_dialog.dart';
import '../../widgets/level_card.dart';
import '../../widgets/streak_card.dart';
import '../../widgets/log_steps_card.dart';
import '../../widgets/achievements_card.dart';
import '../../widgets/health_connect_card.dart';
import '../../widgets/live_step_counter.dart';
import '../../widgets/supporter_card.dart';

/// Main home screen for the phone app.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  bool _isSyncing = false;
  bool _showManualEntry = false;
  Timer? _tapResetTimer;

  @override
  void initState() {
    super.initState();
    _checkHealthConnect();
    _initializeLocale();
  }

  Future<void> _initializeLocale() async {
    await ref.read(localeNotifierProvider).initialize();
  }

  void _handleTitleTap() async {
    // Reset the timer on each tap - give 3 seconds between taps
    _tapResetTimer?.cancel();
    _tapResetTimer = Timer(const Duration(seconds: 3), () {
      ref.read(localeNotifierProvider).resetTapCounter();
    });

    debugPrint('Title tapped! Current count: ${ref.read(easterEggTapCountProvider)}');
    final result = await ref.read(localeNotifierProvider).handleEasterEggTap();
    debugPrint('Easter egg result: unlocked=${result.unlocked}, type=${result.type}');

    if (result.unlocked && mounted) {
      _showEasterEggUnlockedDialog(result);
    }
  }

  /// Handle swipe gestures for Konami code
  void _handleSwipe(KonamiInput direction) async {
    // Reset timer on each input
    _tapResetTimer?.cancel();
    _tapResetTimer = Timer(const Duration(seconds: 3), () {
      ref.read(localeNotifierProvider).resetKonamiSequence();
    });

    final result = await ref.read(localeNotifierProvider).handleKonamiInput(direction);

    if (result.unlocked && mounted) {
      _showEasterEggUnlockedDialog(result);
    }
  }

  /// Handle double-tap for Konami code (B, A buttons)
  void _handleKonamiTap() async {
    _tapResetTimer?.cancel();
    _tapResetTimer = Timer(const Duration(seconds: 3), () {
      ref.read(localeNotifierProvider).resetKonamiSequence();
    });

    final result = await ref.read(localeNotifierProvider).handleKonamiInput(KonamiInput.tap);

    if (result.unlocked && mounted) {
      _showEasterEggUnlockedDialog(result);
    }
  }

  void _showEasterEggUnlockedDialog(EasterEggResult result) {
    final l10n = AppLocalizations.of(context)!;
    final description = result.type == EasterEggType.konamiCode
        ? l10n.easterEggKonamiDescription
        : l10n.easterEggTapDescription;

    // Show different title if already unlocked
    final title = result.wasNewUnlock
        ? l10n.easterEggUnlocked
        : '${result.languageName} already unlocked!';

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.primaryGradientEnd,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Row(
          children: [
            Text(result.languageFlag ?? '🔓', style: const TextStyle(fontSize: 28)),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(color: AppColors.textPrimary, fontSize: 18),
              ),
            ),
          ],
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              description,
              style: const TextStyle(color: AppColors.textSecondary),
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppColors.cardOverlay,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Text(result.languageFlag ?? '🌐', style: const TextStyle(fontSize: 24)),
                  const SizedBox(width: 12),
                  Text(
                    result.languageName ?? 'Unknown',
                    style: const TextStyle(
                      color: AppColors.textPrimary,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.easterEggTapLanguageHint,
              style: const TextStyle(color: AppColors.textSecondary, fontSize: 12),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
              _showLanguageSelector();
            },
            child: Text(l10n.easterEggTryNow),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: Text(l10n.easterEggLater),
          ),
        ],
      ),
    );
  }

  void _showLanguageSelector() {
    showDialog(
      context: context,
      builder: (context) => const LanguageSelectorDialog(),
    );
  }

  @override
  void dispose() {
    _tapResetTimer?.cancel();
    super.dispose();
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
    debugPrint('Health Connect: Connect button pressed');
    final notifier = ref.read(gameStateProvider.notifier);

    debugPrint('Health Connect: Requesting authorization...');
    final authorized = await notifier.authorizeHealthConnect();
    debugPrint('Health Connect: Authorization result = $authorized');

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
    final l10n = AppLocalizations.of(context)!;
    final gameState = ref.watch(gameStateProvider);
    final healthStatus = ref.watch(healthConnectStatusProvider);

    return Scaffold(
      body: _KonamiDetector(
        onKonamiInput: _handleSwipe,
        onDoubleTap: _handleKonamiTap,
        child: GradientBackground(
          child: SafeArea(
            child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 8),
                // App header (tappable for easter egg)
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: _handleTitleTap,
                      child: Text(
                        '🏆 ${l10n.appTitle}',
                        style: const TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ),
                    // Language button (always visible but subtle)
                    const SizedBox(width: 8),
                    _LanguageButton(onTap: _showLanguageSelector),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  l10n.appTagline,
                  style: const TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 24),
                // Level card
                LevelCard(data: gameState),
                const SizedBox(height: 16),
                // Live step counter
                const LiveStepCounter(),
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
                // Manual entry toggle (hidden by default since pedometer works)
                _ManualEntrySection(
                  isExpanded: _showManualEntry,
                  onToggle: () => setState(() => _showManualEntry = !_showManualEntry),
                  child: LogStepsCard(
                    data: gameState,
                    onLogSteps: (steps) {
                      ref.read(gameStateProvider.notifier).logSteps(steps);
                    },
                  ),
                ),
                const SizedBox(height: 16),
                // Achievements card
                AchievementsCard(data: gameState),
                const SizedBox(height: 16),
                // Supporter card
                const SupporterCard(),
                // Debug panel (only in debug mode)
                if (kDebugMode) ...[
                  const SizedBox(height: 16),
                  _DebugPanel(
                    onResetGame: () => ref.read(gameStateProvider.notifier).reset(),
                    onResetEasterEggs: () => ref.read(localeNotifierProvider).resetEasterEggs(),
                    onUnlockKlingon: () => ref.read(localeNotifierProvider).unlockKlingon(),
                    onUnlockDwarvish: () => ref.read(localeNotifierProvider).unlockDwarvish(),
                  ),
                ],
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
        ),
      ),
    );
  }
}

/// Konami code gesture detector
/// Detects swipe gestures (up/down/left/right) and double-taps for the Konami sequence
class _KonamiDetector extends StatefulWidget {
  final Widget child;
  final void Function(KonamiInput) onKonamiInput;
  final VoidCallback onDoubleTap;

  const _KonamiDetector({
    required this.child,
    required this.onKonamiInput,
    required this.onDoubleTap,
  });

  @override
  State<_KonamiDetector> createState() => _KonamiDetectorState();
}

class _KonamiDetectorState extends State<_KonamiDetector> {
  Offset? _startPosition;
  static const double _swipeThreshold = 50.0;

  void _onPanStart(DragStartDetails details) {
    _startPosition = details.globalPosition;
  }

  void _onPanEnd(DragEndDetails details) {
    if (_startPosition == null) return;

    final velocity = details.velocity.pixelsPerSecond;
    final dx = velocity.dx;
    final dy = velocity.dy;

    // Determine swipe direction based on velocity
    if (dx.abs() > dy.abs() && dx.abs() > _swipeThreshold) {
      // Horizontal swipe
      if (dx > 0) {
        widget.onKonamiInput(KonamiInput.right);
      } else {
        widget.onKonamiInput(KonamiInput.left);
      }
    } else if (dy.abs() > dx.abs() && dy.abs() > _swipeThreshold) {
      // Vertical swipe
      if (dy > 0) {
        widget.onKonamiInput(KonamiInput.down);
      } else {
        widget.onKonamiInput(KonamiInput.up);
      }
    }

    _startPosition = null;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onPanStart: _onPanStart,
      onPanEnd: _onPanEnd,
      onDoubleTap: widget.onDoubleTap,
      behavior: HitTestBehavior.translucent,
      child: widget.child,
    );
  }
}

/// Small language selector button
class _LanguageButton extends ConsumerWidget {
  final VoidCallback onTap;

  const _LanguageButton({required this.onTap});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: AppColors.cardOverlay,
          borderRadius: BorderRadius.circular(8),
        ),
        child: const Icon(
          Icons.language,
          size: 20,
          color: AppColors.textSecondary,
        ),
      ),
    );
  }
}

/// Collapsible section for manual step entry
class _ManualEntrySection extends StatelessWidget {
  final bool isExpanded;
  final VoidCallback onToggle;
  final Widget child;

  const _ManualEntrySection({
    required this.isExpanded,
    required this.onToggle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Toggle button
        GestureDetector(
          onTap: onToggle,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: AppColors.cardOverlay,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
                const SizedBox(width: 8),
                Text(
                  isExpanded ? 'Hide manual entry' : 'Add steps manually',
                  style: const TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                Icon(
                  isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                  size: 18,
                  color: AppColors.textSecondary,
                ),
              ],
            ),
          ),
        ),
        // Expandable content
        AnimatedCrossFade(
          firstChild: const SizedBox.shrink(),
          secondChild: Padding(
            padding: const EdgeInsets.only(top: 12),
            child: child,
          ),
          crossFadeState: isExpanded
              ? CrossFadeState.showSecond
              : CrossFadeState.showFirst,
          duration: const Duration(milliseconds: 200),
        ),
      ],
    );
  }
}

/// Debug panel with reset options (only shown in debug mode)
class _DebugPanel extends StatelessWidget {
  final VoidCallback onResetGame;
  final VoidCallback onResetEasterEggs;
  final VoidCallback onUnlockKlingon;
  final VoidCallback onUnlockDwarvish;

  const _DebugPanel({
    required this.onResetGame,
    required this.onResetEasterEggs,
    required this.onUnlockKlingon,
    required this.onUnlockDwarvish,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.red.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Row(
            children: [
              Icon(Icons.bug_report, color: Colors.red, size: 20),
              SizedBox(width: 8),
              Text(
                'Debug Mode',
                style: TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _DebugButton(
                label: 'Reset Game',
                icon: Icons.refresh,
                onTap: onResetGame,
              ),
              _DebugButton(
                label: 'Reset Easter Eggs',
                icon: Icons.egg_alt,
                onTap: onResetEasterEggs,
              ),
              _DebugButton(
                label: '🖖 Klingon',
                icon: Icons.lock_open,
                onTap: onUnlockKlingon,
              ),
              _DebugButton(
                label: '⛏️ Dwarvish',
                icon: Icons.lock_open,
                onTap: onUnlockDwarvish,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _DebugButton extends StatelessWidget {
  final String label;
  final IconData icon;
  final VoidCallback onTap;

  const _DebugButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: Colors.red.withValues(alpha: 0.2),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: Colors.red, size: 16),
            const SizedBox(width: 6),
            Text(
              label,
              style: const TextStyle(color: Colors.red, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}
