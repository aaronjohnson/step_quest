import 'package:flutter/material.dart';

/// App color palette from the design spec.
class AppColors {
  // Primary gradient (purple-blue)
  static const primaryGradientStart = Color(0xFF667EEA);
  static const primaryGradientEnd = Color(0xFF764BA2);

  // Secondary gradient (cyan-blue)
  static const secondaryGradientStart = Color(0xFF06B6D4);
  static const secondaryGradientEnd = Color(0xFF3B82F6);

  // Accent colors
  static const accentGreen = Color(0xFF22C55E);
  static const accentOrange = Color(0xFFF97316);
  static const accentGold = Color(0xFFEAB308);

  // Neutral
  static const cardOverlay = Color(0x33FFFFFF); // 20% white
  static const textPrimary = Color(0xFFFFFFFF);
  static const textSecondary = Color(0xCCFFFFFF); // 80% white

  // Locked achievement overlay
  static const lockedOverlay = Color(0x66000000); // 40% black
}

/// Common gradients used throughout the app.
class AppGradients {
  static const primaryBackground = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.primaryGradientStart, AppColors.primaryGradientEnd],
  );

  static const secondaryCard = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [AppColors.secondaryGradientStart, AppColors.secondaryGradientEnd],
  );
}

/// App theme configuration.
class AppTheme {
  static ThemeData get theme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: ColorScheme.fromSeed(
        seedColor: AppColors.primaryGradientStart,
        brightness: Brightness.dark,
      ),
      fontFamily: null, // Use system fonts for performance
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 28,
          fontWeight: FontWeight.bold,
          color: AppColors.textPrimary,
        ),
        headlineMedium: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: AppColors.textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 16,
          color: AppColors.textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 14,
          color: AppColors.textSecondary,
        ),
        labelLarge: TextStyle(
          fontSize: 16,
          fontWeight: FontWeight.w500,
          color: AppColors.textPrimary,
        ),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentGreen,
          foregroundColor: AppColors.textPrimary,
          minimumSize: const Size(48, 48),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.cardOverlay,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        hintStyle: const TextStyle(color: AppColors.textSecondary),
      ),
    );
  }
}
