import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// Animated hero avatar that evolves based on level.
class HeroAvatar extends StatefulWidget {
  final int level;
  final double size;
  final bool showGlow;

  const HeroAvatar({
    super.key,
    required this.level,
    this.size = 80,
    this.showGlow = true,
  });

  @override
  State<HeroAvatar> createState() => _HeroAvatarState();
}

class _HeroAvatarState extends State<HeroAvatar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _floatAnimation;
  late Animation<double> _glowAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);

    _floatAnimation = Tween<double>(begin: 0, end: 8).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );

    _glowAnimation = Tween<double>(begin: 0.5, end: 1.0).animate(
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
    final heroData = _getHeroData(widget.level);

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform.translate(
          offset: Offset(0, -_floatAnimation.value),
          child: Stack(
            alignment: Alignment.center,
            children: [
              // Glow effect
              if (widget.showGlow)
                Container(
                  width: widget.size * 1.4,
                  height: widget.size * 1.4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: heroData.glowColor
                            .withValues(alpha: 0.4 * _glowAnimation.value),
                        blurRadius: 20 * _glowAnimation.value,
                        spreadRadius: 5 * _glowAnimation.value,
                      ),
                    ],
                  ),
                ),
              // Avatar container
              Container(
                width: widget.size,
                height: widget.size,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: heroData.gradientColors,
                  ),
                  border: Border.all(
                    color: heroData.borderColor,
                    width: 3,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.3),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Center(
                  child: Text(
                    heroData.emoji,
                    style: TextStyle(fontSize: widget.size * 0.5),
                  ),
                ),
              ),
              // Level badge
              Positioned(
                bottom: 0,
                right: 0,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: heroData.borderColor,
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.3),
                        blurRadius: 4,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: Text(
                    '${widget.level}',
                    style: const TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _HeroData _getHeroData(int level) {
    // Hero evolves every 5 levels
    if (level >= 50) {
      return _HeroData(
        emoji: '🐉',
        glowColor: AppColors.accentGold,
        borderColor: AppColors.accentGold,
        gradientColors: [const Color(0xFFFFD700), const Color(0xFFFF8C00)],
        title: 'Dragon Lord',
      );
    } else if (level >= 40) {
      return _HeroData(
        emoji: '👑',
        glowColor: const Color(0xFFE040FB),
        borderColor: const Color(0xFFE040FB),
        gradientColors: [const Color(0xFF9C27B0), const Color(0xFF7B1FA2)],
        title: 'Monarch',
      );
    } else if (level >= 30) {
      return _HeroData(
        emoji: '⚔️',
        glowColor: const Color(0xFFFF5722),
        borderColor: const Color(0xFFFF5722),
        gradientColors: [const Color(0xFFE65100), const Color(0xFFBF360C)],
        title: 'Champion',
      );
    } else if (level >= 20) {
      return _HeroData(
        emoji: '🛡️',
        glowColor: const Color(0xFF2196F3),
        borderColor: const Color(0xFF2196F3),
        gradientColors: [const Color(0xFF1976D2), const Color(0xFF0D47A1)],
        title: 'Knight',
      );
    } else if (level >= 10) {
      return _HeroData(
        emoji: '⚡',
        glowColor: AppColors.accentGreen,
        borderColor: AppColors.accentGreen,
        gradientColors: [const Color(0xFF4CAF50), const Color(0xFF2E7D32)],
        title: 'Warrior',
      );
    } else if (level >= 5) {
      return _HeroData(
        emoji: '🏃',
        glowColor: const Color(0xFF00BCD4),
        borderColor: const Color(0xFF00BCD4),
        gradientColors: [const Color(0xFF00ACC1), const Color(0xFF00838F)],
        title: 'Runner',
      );
    } else {
      return _HeroData(
        emoji: '🚶',
        glowColor: AppColors.primaryGradientStart,
        borderColor: AppColors.primaryGradientStart,
        gradientColors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
        title: 'Walker',
      );
    }
  }
}

class _HeroData {
  final String emoji;
  final Color glowColor;
  final Color borderColor;
  final List<Color> gradientColors;
  final String title;

  _HeroData({
    required this.emoji,
    required this.glowColor,
    required this.borderColor,
    required this.gradientColors,
    required this.title,
  });
}
