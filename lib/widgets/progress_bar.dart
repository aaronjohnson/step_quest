import 'package:flutter/material.dart';

/// A customizable progress bar widget.
class ProgressBar extends StatelessWidget {
  final double progress;
  final Color backgroundColor;
  final Color foregroundColor;
  final double height;

  const ProgressBar({
    super.key,
    required this.progress,
    required this.backgroundColor,
    required this.foregroundColor,
    this.height = 12,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(height / 2),
      ),
      child: FractionallySizedBox(
        alignment: Alignment.centerLeft,
        widthFactor: progress.clamp(0.0, 1.0),
        child: Container(
          decoration: BoxDecoration(
            color: foregroundColor,
            borderRadius: BorderRadius.circular(height / 2),
          ),
        ),
      ),
    );
  }
}
