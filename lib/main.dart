import 'dart:io' show Platform;
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'providers/game_state_provider.dart';
import 'screens/phone/home_screen.dart';
import 'screens/watch/watch_home.dart';
import 'services/persistence_service.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize persistence service
  final persistenceService = await PersistenceService.create();

  runApp(
    ProviderScope(
      overrides: [
        persistenceServiceProvider.overrideWithValue(persistenceService),
      ],
      child: const StepQuestApp(),
    ),
  );
}

class StepQuestApp extends StatelessWidget {
  const StepQuestApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Step Quest',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.theme,
      home: const _DeviceAdaptiveHome(),
    );
  }
}

/// Detects device type and shows appropriate UI.
class _DeviceAdaptiveHome extends StatelessWidget {
  const _DeviceAdaptiveHome();

  bool get _isMobilePlatform {
    if (kIsWeb) return false;
    return Platform.isAndroid || Platform.isIOS;
  }

  @override
  Widget build(BuildContext context) {
    // Only check for watch on mobile platforms (wear package is Android-only)
    if (!_isMobilePlatform) {
      return const HomeScreen();
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        // Wear OS watches typically have screens <= 450px in the smallest dimension
        // and are roughly square (aspect ratio close to 1)
        final shortestSide = constraints.maxWidth < constraints.maxHeight
            ? constraints.maxWidth
            : constraints.maxHeight;
        final aspectRatio = constraints.maxWidth / constraints.maxHeight;

        // Detect watch: small screen (< 300dp) and roughly square
        final isWatch = shortestSide < 300 && aspectRatio > 0.8 && aspectRatio < 1.25;

        if (isWatch) {
          return const WatchHome();
        } else {
          return const HomeScreen();
        }
      },
    );
  }
}
