import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../services/easter_egg_service.dart';

/// Provider for the easter egg service
final easterEggServiceProvider = Provider<EasterEggService>((ref) {
  return EasterEggService();
});

/// Provider for tracking if hidden languages are unlocked
final hiddenLanguagesUnlockedProvider = StateProvider<bool>((ref) => false);

/// Provider for the currently selected locale
/// null means use system default
final localeProvider = StateProvider<Locale?>((ref) => null);

/// Provider for the easter egg tap counter
final easterEggTapCountProvider = StateProvider<int>((ref) => 0);

/// Provider for Konami code input sequence
final konamiSequenceProvider = StateProvider<List<KonamiInput>>((ref) => []);

/// Number of taps required to unlock easter egg
const int easterEggTapThreshold = 7;

/// Konami code inputs
enum KonamiInput { up, down, left, right, tap }

/// The sacred Konami sequence: ↑↑↓↓←→←→ then two taps (for B, A)
const List<KonamiInput> konamiCode = [
  KonamiInput.up,
  KonamiInput.up,
  KonamiInput.down,
  KonamiInput.down,
  KonamiInput.left,
  KonamiInput.right,
  KonamiInput.left,
  KonamiInput.right,
  KonamiInput.tap,
  KonamiInput.tap,
];

/// Result of an easter egg attempt
class EasterEggResult {
  final bool unlocked;
  final bool wasNewUnlock; // true if this was a fresh unlock, false if already unlocked
  final EasterEggType? type;
  final String? languageCode;
  final String? languageName;
  final String? languageFlag;
  final String? description;

  EasterEggResult({
    required this.unlocked,
    this.wasNewUnlock = true,
    this.type,
    this.languageCode,
    this.languageName,
    this.languageFlag,
    this.description,
  });

  static EasterEggResult none() => EasterEggResult(unlocked: false);
}

/// Helper class for managing locale and easter eggs
class LocaleNotifier {
  final Ref ref;
  final EasterEggService _service;

  LocaleNotifier(this.ref) : _service = ref.read(easterEggServiceProvider);

  /// Initialize - load saved preferences
  Future<void> initialize() async {
    // Check if hidden languages are already unlocked
    final hasUnlocked = await _service.hasUnlockedHiddenLanguages();
    ref.read(hiddenLanguagesUnlockedProvider.notifier).state = hasUnlocked;

    // Load saved locale preference
    final savedCode = await _service.getSelectedLanguage();
    if (savedCode != null) {
      ref.read(localeProvider.notifier).state = Locale(savedCode);
    }
  }

  /// Handle tap on app title for easter egg (unlocks Dwarvish)
  /// Returns result with unlock info
  Future<EasterEggResult> handleEasterEggTap() async {
    final currentCount = ref.read(easterEggTapCountProvider);
    final newCount = currentCount + 1;
    ref.read(easterEggTapCountProvider.notifier).state = newCount;

    if (newCount >= easterEggTapThreshold) {
      // Reset counter
      ref.read(easterEggTapCountProvider.notifier).state = 0;

      // Try to unlock Dwarvish
      final (langCode, wasNew) = await _service.unlockEasterEgg(EasterEggType.tapTitle);
      if (langCode != null) {
        ref.read(hiddenLanguagesUnlockedProvider.notifier).state = true;
        return EasterEggResult(
          unlocked: true,
          wasNewUnlock: wasNew,
          type: EasterEggType.tapTitle,
          languageCode: langCode,
          languageName: EasterEggService.languageNames[langCode],
          languageFlag: EasterEggService.languageFlags[langCode],
          description: EasterEggService.unlockDescriptions[EasterEggType.tapTitle],
        );
      }
    }

    return EasterEggResult.none();
  }

  /// Handle Konami code input (unlocks Klingon)
  /// Returns result with unlock info
  Future<EasterEggResult> handleKonamiInput(KonamiInput input) async {
    final currentSequence = List<KonamiInput>.from(ref.read(konamiSequenceProvider));
    currentSequence.add(input);

    // Check if sequence matches so far
    bool matchesSoFar = true;
    for (int i = 0; i < currentSequence.length && i < konamiCode.length; i++) {
      if (currentSequence[i] != konamiCode[i]) {
        matchesSoFar = false;
        break;
      }
    }

    if (!matchesSoFar) {
      // Reset on wrong input
      ref.read(konamiSequenceProvider.notifier).state = [];
      return EasterEggResult.none();
    }

    // Update sequence
    ref.read(konamiSequenceProvider.notifier).state = currentSequence;

    // Check if complete
    if (currentSequence.length == konamiCode.length) {
      // Reset sequence
      ref.read(konamiSequenceProvider.notifier).state = [];

      // Try to unlock Klingon
      final (langCode, wasNew) = await _service.unlockEasterEgg(EasterEggType.konamiCode);
      if (langCode != null) {
        ref.read(hiddenLanguagesUnlockedProvider.notifier).state = true;
        return EasterEggResult(
          unlocked: true,
          wasNewUnlock: wasNew,
          type: EasterEggType.konamiCode,
          languageCode: langCode,
          languageName: EasterEggService.languageNames[langCode],
          languageFlag: EasterEggService.languageFlags[langCode],
          description: EasterEggService.unlockDescriptions[EasterEggType.konamiCode],
        );
      }
    }

    return EasterEggResult.none();
  }

  /// Reset tap counter (call on timeout or other interaction)
  void resetTapCounter() {
    ref.read(easterEggTapCountProvider.notifier).state = 0;
  }

  /// Reset Konami sequence (call on timeout)
  void resetKonamiSequence() {
    ref.read(konamiSequenceProvider.notifier).state = [];
  }

  /// Get current Konami progress (for visual feedback)
  int getKonamiProgress() {
    return ref.read(konamiSequenceProvider).length;
  }

  /// Change the app locale
  Future<void> setLocale(String code) async {
    await _service.setSelectedLanguage(code);
    ref.read(localeProvider.notifier).state = Locale(code);
  }

  /// Get list of available language codes
  Future<List<String>> getAvailableLanguages() async {
    return _service.getAvailableLanguages();
  }

  /// Get language display name
  String getLanguageName(String code) {
    return EasterEggService.languageNames[code] ?? code;
  }

  /// Get language flag/emoji
  String getLanguageFlag(String code) {
    return EasterEggService.languageFlags[code] ?? '🌐';
  }

  /// Reset easter eggs (for re-experiencing the unlocks)
  Future<void> resetEasterEggs() async {
    await _service.resetEasterEggs();
    ref.read(hiddenLanguagesUnlockedProvider.notifier).state = false;
  }

  /// Force unlock Klingon (debug)
  Future<void> unlockKlingon() async {
    await _service.forceUnlockLanguage('tlh');
    ref.read(hiddenLanguagesUnlockedProvider.notifier).state = true;
  }

  /// Force unlock Dwarvish (debug)
  Future<void> unlockDwarvish() async {
    await _service.forceUnlockLanguage('khz');
    ref.read(hiddenLanguagesUnlockedProvider.notifier).state = true;
  }
}

/// Provider for the locale notifier
final localeNotifierProvider = Provider<LocaleNotifier>((ref) {
  return LocaleNotifier(ref);
});
