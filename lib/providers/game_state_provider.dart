import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/step_quest_data.dart';
import '../services/persistence_service.dart';
import '../services/game_engine.dart';

/// Provider for the persistence service.
final persistenceServiceProvider = Provider<PersistenceService>((ref) {
  throw UnimplementedError('Must be overridden in ProviderScope');
});

/// Provider for the game state with persistence.
final gameStateProvider =
    StateNotifierProvider<GameStateNotifier, StepQuestData>((ref) {
  final persistence = ref.watch(persistenceServiceProvider);
  return GameStateNotifier(persistence);
});

/// Manages game state and persists changes.
class GameStateNotifier extends StateNotifier<StepQuestData> {
  final PersistenceService _persistence;

  GameStateNotifier(this._persistence) : super(StepQuestData.empty()) {
    _loadState();
  }

  void _loadState() {
    final saved = _persistence.load();
    if (saved != null) {
      // Check if lastLogDate is today, if not we may need to handle day change
      state = saved;
    }
  }

  /// Logs steps and updates game state.
  Future<void> logSteps(int steps) async {
    if (steps <= 0) return;

    final newState = GameEngine.processSteps(state, steps, DateTime.now());
    state = newState;
    await _persistence.save(newState);
  }

  /// Resets all game data.
  Future<void> reset() async {
    state = StepQuestData.empty();
    await _persistence.clear();
  }
}

/// Provider for newly unlocked achievements (for showing notifications).
final newlyUnlockedAchievementsProvider = Provider<List<String>>((ref) {
  // This could be enhanced to track which achievements were just unlocked
  // For now, just return the full list
  return ref.watch(gameStateProvider).unlockedAchievements;
});
