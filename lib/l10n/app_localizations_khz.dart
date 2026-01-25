// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Keapara (`khz`).
class AppLocalizationsKhz extends AppLocalizations {
  AppLocalizationsKhz([String locale = 'khz']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Forge thy steps into legend, stone-kin!';

  @override
  String levelLabel(int level) {
    return 'Rank $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count strides';
  }

  @override
  String todaySteps(int count) {
    return 'This day: $count';
  }

  @override
  String get streakTitle => 'Endurance';

  @override
  String streakDays(int count) {
    return '$count suns';
  }

  @override
  String streakRecord(int count) {
    return 'Greatest: $count suns';
  }

  @override
  String get streakEmpty => 'March forth and forge thy endurance!';

  @override
  String get logStepsTitle => 'Record strides';

  @override
  String get logStepsHint => 'Enter strides';

  @override
  String get logStepsButton => 'Record';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Deeds of Valor';

  @override
  String achievementsUnlocked(int count) {
    return '$count earned';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Bound';

  @override
  String get healthConnectNotConnected => 'Unbound';

  @override
  String get healthConnectUnavailable => 'Unreachable';

  @override
  String get healthConnectChecking => 'Seeking...';

  @override
  String get healthConnectSyncMessage =>
      'Strides flow from Google Fit, Samsung Health, Fitbit, and other halls through Health Connect.';

  @override
  String get healthConnectPrompt =>
      'Bind to sync strides from the great fitness halls.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect lies beyond reach. Record strides by thine own hand.';

  @override
  String get healthConnectSyncing => 'Binding...';

  @override
  String get healthConnectSyncNow => 'Bind now';

  @override
  String get healthConnectConnect => 'Bind Health';

  @override
  String get healthConnectHowItWorks => 'How does binding work?';

  @override
  String get healthConnectHideDetails => 'Hide the runes';

  @override
  String get healthConnectSyncPathTitle => 'The Binding Path';

  @override
  String get healthConnectSyncPathDescription =>
      'Thy fitness hall (Samsung Health, Google Fit, Fitbit) → Health Connect → Step Quest\n\nEnable Health Connect in thy fitness hall\'s deep settings.';

  @override
  String get healthConnectMoreSensors => 'Desire more sensors?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Heart-stone rate, forge-calories, sleep-watch, and other craft-works may be requested at the GitHub mine:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Support the Quest';

  @override
  String get supporterBadge => 'Patron of the Hall';

  @override
  String get supportThanks =>
      'The Mountain thanks thee! Thy gold keeps the forges burning.';

  @override
  String get supportPrompt =>
      'Step Quest is free as mountain air. Tips fuel the forge and keep the halls ad-free.';

  @override
  String get supportOpenTipJar => 'Open the coffers';

  @override
  String get supportHideTipJar => 'Seal the coffers';

  @override
  String get supportTipComing =>
      'Coffers coming soon! Visit GitHub Sponsors meanwhile.';

  @override
  String get supportSourceCode => 'View the runes';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'A Mug of Ale';

  @override
  String get tipCoffeeDesc => 'A small thanks!';

  @override
  String get tipSupporter => 'Support the Forge';

  @override
  String get tipSupporterDesc => 'Keep the hammers ringing';

  @override
  String get tipLegendary => 'Lord of the Deep';

  @override
  String get tipLegendaryDesc => 'Thy name echoes in the halls!';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

  @override
  String get watchTapToLog => 'Tap to record';

  @override
  String get watchStepsLabel => 'strides';

  @override
  String get watchQuickLogTitle => 'Swift Record';

  @override
  String watchLoggedSteps(int count) {
    return '$count strides marked!';
  }

  @override
  String get streakGoalMet => 'By Durin\'s beard! Thy daily quota is met!';

  @override
  String get streakGoalPrompt =>
      'March 10,000 strides to maintain thine endurance!';

  @override
  String streakDayStreak(int count) {
    return '$count Sun Endurance';
  }

  @override
  String get logTodayTitle => 'Record This Day\'s Strides';

  @override
  String logTodayProgress(String current, String goal) {
    return 'This day: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count remain';
  }

  @override
  String get logEnterSteps => 'Enter strides...';

  @override
  String get logAddButton => 'Add';

  @override
  String get logAutoSaved => 'Progress carved in stone';

  @override
  String get levelTotalSteps => 'Total Strides';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Deeds ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Earned!';

  @override
  String get achievementLocked => 'Sealed';

  @override
  String get closeButton => 'Close';

  @override
  String get watchAddSteps => 'Add strides';

  @override
  String get watchBack => '← Return';

  @override
  String get watchStepsAdded => 'strides added!';

  @override
  String watchLevelShort(int level) {
    return 'Rk $level';
  }

  @override
  String get easterEggUnlocked => 'Secret Tongue Unearthed!';

  @override
  String get easterEggTapDescription =>
      'Thou hast struck the ancient runes and roused the spirits of the deep!';

  @override
  String get easterEggKonamiDescription =>
      'The sacred sequence hath been entered. Victory!';

  @override
  String get easterEggTapLanguageHint =>
      'Tap the tongue-stone to change thy speech.';

  @override
  String get easterEggTryNow => 'Speak It Now';

  @override
  String get easterEggLater => 'Later';

  @override
  String get languageTitle => 'Tongue';

  @override
  String get languageSecretSection => 'Hidden Tongues';

  @override
  String get liveTracking => 'LIVE WATCH';

  @override
  String get stepsThisSession => 'strides this shift';

  @override
  String get liveStarting => 'Awakening...';

  @override
  String get pedometerUnavailable => 'Stride-counter sleeps';

  @override
  String get enableStepTracking => 'Awaken Stride Tracking';

  @override
  String get enableStepTrackingDesc =>
      'Grant the mountain spirits permission to count thy strides';

  @override
  String get enableButton => 'Awaken';

  @override
  String get syncStepsNow => 'Bind strides now';

  @override
  String get heroTitleDragonLord => 'Dragon Slayer';

  @override
  String get heroTitleMonarch => 'Mountain King';

  @override
  String get heroTitleChampion => 'Champion of the Deep';

  @override
  String get heroTitleKnight => 'Tunnel Knight';

  @override
  String get heroTitleWarrior => 'Stone Warrior';

  @override
  String get heroTitleRunner => 'Swift-foot';

  @override
  String get heroTitleWalker => 'Tunnel Walker';

  @override
  String get levelToday => 'This Day';

  @override
  String get streakBadgeLegend => 'Legend';

  @override
  String get streakBadgePro => 'Veteran';

  @override
  String get streakBadgeHot => 'Burning';

  @override
  String get celebrationSteps => 'STRIDES!';
}
