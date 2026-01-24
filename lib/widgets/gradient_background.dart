import 'package:flutter/material.dart';
import '../theme/app_theme.dart';

/// A gradient background container for the app.
class GradientBackground extends StatelessWidget {
  final Widget child;

  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: AppGradients.primaryBackground,
      ),
      child: child,
    );
  }
}
