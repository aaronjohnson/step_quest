import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/step_quest_data.dart';
import '../services/persistence_service.dart';
import '../services/game_engine.dart';
import '../services/health_service.dart';
import '../services/pedometer_service.dart';

/// Provider for the persistence service.
final persistenceServiceProvider = Provider<PersistenceService>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

/// Provider for the health service.
final healthServiceProvider = Provider<HealthService>((ref) {
  return HealthService();
});

/// Provider for Health Connect status.
final healthConnectStatusProvider = StateProvider<HealthConnectStatus>((ref) {
  return HealthConnectStatus.unknown;
});

/// Health Connect connection status.
enum HealthConnectStatus {
  unknown,
  unavailable,
  notAuthorized,
  authorized,
}

/// Provider for the pedometer service.
final pedometerServiceProvider = Provider<PedometerService>((ref) {
  final service = PedometerService();
  ref.onDispose(() => service.dispose());
  return service;
});

/// Provider for live step count from pedometer.
final liveStepCountProvider = StreamProvider<int>((ref) {
  final pedometer = ref.watch(pedometerServiceProvider);
  return pedometer.stepStream;
});

/// Provider for pedestrian status (walking/stopped).
final pedestrianStatusProvider = StreamProvider<String>((ref) {
  final pedometer = ref.watch(pedometerServiceProvider);
  return pedometer.statusStream;
});

/// Provider for whether pedometer is active.
final pedometerActiveProvider = StateProvider<bool>((ref) => false);

/// Provider for the game state with persistence.
final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, StepQuestData>((ref) {
  final persistence = ref.watch(persistenceServiceProvider);
  return GameStateNotifier(persistence);
});

/// Manages game state and persists changes.
class GameStateNotifier extends StateNotifier<StepQuestData> {
  final PersistenceService _persistence;
  final HealthService _healthService = HealthService();

  /// Tracks the last synced step count from Health Connect to avoid double-counting
  int _lastSyncedSteps = 0;

  GameStateNotifier(this._persistence) : super(StepQuestData.empty()) {
    _loadState();
  }

  void _loadState() {
    final saved = _persistence.load();
    if (saved != null) {
      state = saved;
      // Initialize synced steps to current total to avoid re-adding on restart
      _lastSyncedSteps = saved.todaySteps;
    }
  }

  /// Logs steps manually and updates game state.
  Future<void> logSteps(int steps) async {
    if (steps <= 0) return;

    final newState = GameEngine.processSteps(state, steps, DateTime.now());
    state = newState;
    await _persistence.save(newState);
  }

  /// Syncs steps from Health Connect.
  /// Only adds the difference since last sync to avoid double-counting.
  Future<void> syncFromHealthConnect() async {
    try {
      final healthSteps = await _healthService.getTodaySteps();

      if (healthSteps > _lastSyncedSteps) {
        final newSteps = healthSteps - _lastSyncedSteps;
        _lastSyncedSteps = healthSteps;

        if (newSteps > 0) {
          final newState = GameEngine.processSteps(state, newSteps, DateTime.now());
          state = newState;
          await _persistence.save(newState);
        }
      }
    } catch (e) {
      // Silently fail - manual entry is always available
    }
  }

  /// Checks and requests Health Connect authorization.
  Future<bool> authorizeHealthConnect() async {
    return await _healthService.requestAuthorization();
  }

  /// Checks if Health Connect is available.
  Future<bool> isHealthConnectAvailable() async {
    return await _healthService.isHealthConnectAvailable();
  }

  /// Resets all game data.
  Future<void> reset() async {
    state = StepQuestData.empty();
    _lastSyncedSteps = 0;
    await _persistence.clear();
  }

  /// Adds steps from pedometer (called periodically to sync live steps).
  Future<void> addPedometerSteps(int steps) async {
    if (steps <= 0) return;

    final newState = GameEngine.processSteps(state, steps, DateTime.now());
    state = newState;
    await _persistence.save(newState);
  }
}

/// Provider for newly unlocked achievements (for showing notifications).
final newlyUnlockedAchievementsProvider = Provider<List<String>>((ref) {
  // This could be enhanced to track which achievements were just unlocked
  // For now, just return the full list
  return ref.watch(gameStateProvider).unlockedAchievements;
});
