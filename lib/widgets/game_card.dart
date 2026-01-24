import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A styled card container used throughout the app.
class GameCard extends StatelessWidget {
  final Widget child;
  final EdgeInsetsGeometry? padding;

  const GameCard({
    super.key,
    required this.child,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: padding ?? const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: AppColors.cardOverlay,
        borderRadius: BorderRadius.circular(16),
      ),
      child: child,
    );
  }
}
