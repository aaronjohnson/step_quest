import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/step_quest_data.dart';

/// Service for persisting game state to local storage.
class PersistenceService {
  static const String _storageKey = 'step_quest_data_v1';

  final SharedPreferences _prefs;

  PersistenceService(this._prefs);

  /// Creates a PersistenceService instance.
  static Future<PersistenceService> create() async {
    final prefs = await SharedPreferences.getInstance();
    return PersistenceService(prefs);
  }

  /// Loads the saved game state, or returns null if none exists.
  StepQuestData? load() {
    final jsonString = _prefs.getString(_storageKey);
    if (jsonString == null) return null;

    try {
      final json = jsonDecode(jsonString) as Map<String, dynamic>;
      return StepQuestData.fromJson(json);
    } catch (e) {
      // If data is corrupted, return null to start fresh
      return null;
    }
  }

  /// Saves the game state to local storage.
  Future<bool> save(StepQuestData data) async {
    final jsonString = jsonEncode(data.toJson());
    return _prefs.setString(_storageKey, jsonString);
  }

  /// Clears all saved game data (for testing or reset).
  Future<bool> clear() async {
    return _prefs.remove(_storageKey);
  }
}
