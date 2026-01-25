import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../l10n/app_localizations.dart';
import '../theme/app_theme.dart';

/// Shows a celebration animation when steps are logged.
class StepCelebration extends StatefulWidget {
  final int steps;
  final VoidCallback? onComplete;

  const StepCelebration({
    super.key,
    required this.steps,
    this.onComplete,
  });

  @override
  State<StepCelebration> createState() => _StepCelebrationState();
}

class _StepCelebrationState extends State<StepCelebration>
    with TickerProviderStateMixin {
  late AnimationController _mainController;
  late AnimationController _particleController;
  late Animation<double> _scaleAnimation;
  late Animation<double> _fadeAnimation;
  late List<_Particle> _particles;

  @override
  void initState() {
    super.initState();

    _mainController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _particleController = AnimationController(
      duration: const Duration(milliseconds: 2000),
      vsync: this,
    );

    _scaleAnimation = TweenSequence<double>([
      TweenSequenceItem(
        tween: Tween(begin: 0.0, end: 1.2).chain(CurveTween(curve: Curves.easeOut)),
        weight: 40,
      ),
      TweenSequenceItem(
        tween: Tween(begin: 1.2, end: 1.0).chain(CurveTween(curve: Curves.elasticOut)),
        weight: 60,
      ),
    ]).animate(_mainController);

    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _mainController,
        curve: const Interval(0.7, 1.0, curve: Curves.easeOut),
      ),
    );

    // Generate particles
    final random = math.Random();
    _particles = List.generate(20, (index) {
      return _Particle(
        angle: (index / 20) * 2 * math.pi + random.nextDouble() * 0.5,
        speed: 100 + random.nextDouble() * 150,
        size: 8 + random.nextDouble() * 12,
        color: [
          AppColors.accentGold,
          AppColors.accentGreen,
          AppColors.accentOrange,
          Colors.white,
        ][random.nextInt(4)],
      );
    });

    _mainController.forward();
    _particleController.forward();

    _mainController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        widget.onComplete?.call();
      }
    });
  }

  @override
  void dispose() {
    _mainController.dispose();
    _particleController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return AnimatedBuilder(
      animation: Listenable.merge([_mainController, _particleController]),
      builder: (context, child) {
        return Stack(
          alignment: Alignment.center,
          children: [
            // Particles
            ..._particles.map((particle) {
              final progress = _particleController.value;
              final distance = particle.speed * progress;
              final dx = math.cos(particle.angle) * distance;
              final dy = math.sin(particle.angle) * distance - (progress * 50); // gravity
              final opacity = (1 - progress).clamp(0.0, 1.0);

              return Positioned(
                left: MediaQuery.of(context).size.width / 2 + dx - particle.size / 2,
                top: MediaQuery.of(context).size.height / 2 + dy - particle.size / 2,
                child: Opacity(
                  opacity: opacity,
                  child: Container(
                    width: particle.size,
                    height: particle.size,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: particle.color,
                      boxShadow: [
                        BoxShadow(
                          color: particle.color.withValues(alpha: 0.5),
                          blurRadius: 8,
                        ),
                      ],
                    ),
                  ),
                ),
              );
            }),
            // Main celebration text
            Opacity(
              opacity: _fadeAnimation.value,
              child: Transform.scale(
                scale: _scaleAnimation.value,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 20),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [AppColors.accentGreen, Color(0xFF059669)],
                    ),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppColors.accentGreen.withValues(alpha: 0.5),
                        blurRadius: 20,
                        spreadRadius: 5,
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text(
                        '🎉',
                        style: TextStyle(fontSize: 40),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        '+${_formatNumber(widget.steps)}',
                        style: const TextStyle(
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                      Text(
                        l10n.celebrationSteps,
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: Colors.white70,
                          letterSpacing: 2,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  String _formatNumber(int number) {
    if (number >= 1000) {
      return '${(number / 1000).toStringAsFixed(number % 1000 == 0 ? 0 : 1)}k';
    }
    return number.toString();
  }
}

class _Particle {
  final double angle;
  final double speed;
  final double size;
  final Color color;

  _Particle({
    required this.angle,
    required this.speed,
    required this.size,
    required this.color,
  });
}

/// Overlay entry helper for showing celebrations
class CelebrationOverlay {
  static OverlayEntry? _currentEntry;

  static void show(BuildContext context, int steps) {
    _currentEntry?.remove();

    _currentEntry = OverlayEntry(
      builder: (context) => Material(
        color: Colors.black38,
        child: StepCelebration(
          steps: steps,
          onComplete: () {
            _currentEntry?.remove();
            _currentEntry = null;
          },
        ),
      ),
    );

    Overlay.of(context).insert(_currentEntry!);
  }
}
