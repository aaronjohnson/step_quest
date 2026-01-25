import 'package:shared_preferences/shared_preferences.dart';

/// Easter egg unlock methods
enum EasterEggType {
  tapTitle,   // Tap title 7 times → Dwarvish
  konamiCode, // Konami code → Klingon
}

/// Service for managing easter egg unlocks (hidden languages, etc.)
class EasterEggService {
  static const String _unlockedLanguagesKey = 'unlocked_easter_languages';
  static const String _selectedLanguageKey = 'selected_language';

  /// Hidden language codes that can be unlocked
  static const List<String> hiddenLanguages = ['tlh', 'khz'];

  /// Which easter egg unlocks which language
  static const Map<EasterEggType, String> easterEggLanguages = {
    EasterEggType.tapTitle: 'khz',   // Tap 7x → Dwarvish
    EasterEggType.konamiCode: 'tlh', // Konami → Klingon
  };

  /// Language display names
  static const Map<String, String> languageNames = {
    'en': 'English',
    'de': 'Deutsch',
    'es': 'Español',
    'hi': 'हिन्दी',
    'ja': '日本語',
    'pt': 'Português',
    'tlh': 'tlhIngan Hol', // Klingon
    'khz': 'Khuzdul', // Dwarvish
  };

  /// Language flags/emojis
  static const Map<String, String> languageFlags = {
    'en': '🇺🇸',
    'de': '🇩🇪',
    'es': '🇪🇸',
    'hi': '🇮🇳',
    'ja': '🇯🇵',
    'pt': '🇧🇷',
    'tlh': '🖖', // Vulcan salute for Klingon
    'khz': '⛏️', // Pickaxe for Dwarf
  };

  /// Unlock descriptions
  static const Map<EasterEggType, String> unlockDescriptions = {
    EasterEggType.tapTitle: 'You tapped the ancient runes and awoke the mountain spirits!',
    EasterEggType.konamiCode: 'The sacred sequence has been entered. Qapla\'!',
  };

  SharedPreferences? _prefs;

  Future<void> _ensurePrefs() async {
    _prefs ??= await SharedPreferences.getInstance();
  }

  /// Get list of unlocked hidden languages
  Future<List<String>> getUnlockedLanguages() async {
    await _ensurePrefs();
    return _prefs!.getStringList(_unlockedLanguagesKey) ?? [];
  }

  /// Check if a specific language is unlocked
  Future<bool> isLanguageUnlocked(String code) async {
    if (!hiddenLanguages.contains(code)) return true; // Standard languages always available
    final unlocked = await getUnlockedLanguages();
    return unlocked.contains(code);
  }

  /// Unlock a hidden language
  Future<void> unlockLanguage(String code) async {
    if (!hiddenLanguages.contains(code)) return;
    await _ensurePrefs();
    final unlocked = await getUnlockedLanguages();
    if (!unlocked.contains(code)) {
      unlocked.add(code);
      await _prefs!.setStringList(_unlockedLanguagesKey, unlocked);
    }
  }

  /// Unlock language for a specific easter egg type
  /// Returns (languageCode, wasNewUnlock) - languageCode is always returned,
  /// wasNewUnlock indicates if this was a fresh unlock vs already unlocked
  Future<(String?, bool)> unlockEasterEgg(EasterEggType type) async {
    final langCode = easterEggLanguages[type];
    if (langCode == null) return (null, false);

    final alreadyUnlocked = await isLanguageUnlocked(langCode);
    if (alreadyUnlocked) {
      // Already unlocked - return the code but indicate not new
      return (langCode, false);
    }

    await unlockLanguage(langCode);
    return (langCode, true);
  }

  /// Unlock all hidden languages (called when easter egg triggered)
  Future<void> unlockAllHiddenLanguages() async {
    await _ensurePrefs();
    await _prefs!.setStringList(_unlockedLanguagesKey, hiddenLanguages);
  }

  /// Check if any hidden languages are unlocked
  Future<bool> hasUnlockedHiddenLanguages() async {
    final unlocked = await getUnlockedLanguages();
    return unlocked.isNotEmpty;
  }

  /// Get the currently selected language code
  Future<String?> getSelectedLanguage() async {
    await _ensurePrefs();
    return _prefs!.getString(_selectedLanguageKey);
  }

  /// Set the selected language
  Future<void> setSelectedLanguage(String code) async {
    await _ensurePrefs();
    await _prefs!.setString(_selectedLanguageKey, code);
  }

  /// Get all available languages (standard + unlocked)
  Future<List<String>> getAvailableLanguages() async {
    final standard = ['en', 'de', 'es', 'hi', 'ja', 'pt'];
    final unlocked = await getUnlockedLanguages();
    return [...standard, ...unlocked];
  }

  /// Reset all easter egg unlocks (for testing/re-experiencing)
  Future<void> resetEasterEggs() async {
    await _ensurePrefs();
    await _prefs!.remove(_unlockedLanguagesKey);
  }

  /// Force unlock a specific language (for debugging)
  Future<void> forceUnlockLanguage(String code) async {
    await unlockLanguage(code);
  }
}
