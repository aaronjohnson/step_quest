// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Turn your steps into an adventure!';

  @override
  String levelLabel(int level) {
    return 'Level $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count steps';
  }

  @override
  String todaySteps(int count) {
    return 'Today: $count';
  }

  @override
  String get streakTitle => 'Streak';

  @override
  String streakDays(int count) {
    return '$count days';
  }

  @override
  String streakRecord(int count) {
    return 'Record: $count days';
  }

  @override
  String get streakEmpty => 'Start walking to build your streak!';

  @override
  String get logStepsTitle => 'Log Steps';

  @override
  String get logStepsHint => 'Enter steps';

  @override
  String get logStepsButton => 'Log';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Achievements';

  @override
  String achievementsUnlocked(int count) {
    return '$count unlocked';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Connected';

  @override
  String get healthConnectNotConnected => 'Not Connected';

  @override
  String get healthConnectUnavailable => 'Unavailable';

  @override
  String get healthConnectChecking => 'Checking...';

  @override
  String get healthConnectSyncMessage =>
      'Steps sync automatically from Google Fit, Samsung Health, Fitbit, and other Health Connect apps.';

  @override
  String get healthConnectPrompt =>
      'Connect to sync steps from Google Fit, Samsung Health, Fitbit, and other fitness apps.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect is not available. Use manual step logging.';

  @override
  String get healthConnectSyncing => 'Syncing...';

  @override
  String get healthConnectSyncNow => 'Sync Now';

  @override
  String get healthConnectConnect => 'Connect Health';

  @override
  String get healthConnectHowItWorks => 'How does sync work?';

  @override
  String get healthConnectHideDetails => 'Hide details';

  @override
  String get healthConnectSyncPathTitle => 'Sync Path';

  @override
  String get healthConnectSyncPathDescription =>
      'Your fitness app (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nEnable Health Connect sync in your fitness app\'s settings to share step data.';

  @override
  String get healthConnectMoreSensors => 'Want more sensors?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Heart rate, calories, sleep tracking, and other sensor features can be requested on our GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Support Step Quest';

  @override
  String get supporterBadge => 'Supporter';

  @override
  String get supportThanks =>
      'Thank you for supporting the quest! Your generosity keeps the fortress running.';

  @override
  String get supportPrompt =>
      'Step Quest is free and open source. Tips help fund development and keep ads away.';

  @override
  String get supportOpenTipJar => 'Open Tip Jar';

  @override
  String get supportHideTipJar => 'Hide Tip Jar';

  @override
  String get supportTipComing =>
      'Tip jar coming soon! For now, visit GitHub Sponsors.';

  @override
  String get supportSourceCode => 'View Source Code';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Buy a Coffee';

  @override
  String get tipCoffeeDesc => 'A small thanks!';

  @override
  String get tipSupporter => 'Support the Quest';

  @override
  String get tipSupporterDesc => 'Help keep development going';

  @override
  String get tipLegendary => 'Legendary Patron';

  @override
  String get tipLegendaryDesc => 'You are a legend!';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

  @override
  String get watchTapToLog => 'Tap to log steps';

  @override
  String get watchStepsLabel => 'steps';

  @override
  String get watchQuickLogTitle => 'Quick Log';

  @override
  String watchLoggedSteps(int count) {
    return 'Logged $count steps!';
  }

  @override
  String get streakGoalMet => 'Great job! You\'ve hit your goal today!';

  @override
  String get streakGoalPrompt => 'Hit 10,000 steps to continue your streak!';

  @override
  String streakDayStreak(int count) {
    return '$count Day Streak';
  }

  @override
  String get logTodayTitle => 'Log Today\'s Steps';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Today: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count to go';
  }

  @override
  String get logEnterSteps => 'Enter steps...';

  @override
  String get logAddButton => 'Add';

  @override
  String get logAutoSaved => 'Progress auto-saved';

  @override
  String get levelTotalSteps => 'Total Steps';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Achievements ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Unlocked!';

  @override
  String get achievementLocked => 'Locked';

  @override
  String get closeButton => 'Close';

  @override
  String get watchAddSteps => 'Add Steps';

  @override
  String get watchBack => '← Back';

  @override
  String get watchStepsAdded => 'steps added!';

  @override
  String watchLevelShort(int level) {
    return 'Lv $level';
  }

  @override
  String get easterEggUnlocked => 'Secret Language Unlocked!';

  @override
  String get easterEggTapDescription =>
      'You tapped the ancient runes and awoke the mountain spirits!';

  @override
  String get easterEggKonamiDescription =>
      'The sacred sequence has been entered. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Tap the language button to switch.';

  @override
  String get easterEggTryNow => 'Try It Now';

  @override
  String get easterEggLater => 'Later';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageSecretSection => 'Secret Languages';

  @override
  String get liveTracking => 'LIVE TRACKING';

  @override
  String get stepsThisSession => 'steps this session';

  @override
  String get liveStarting => 'Starting...';

  @override
  String get pedometerUnavailable => 'Pedometer unavailable';

  @override
  String get enableStepTracking => 'Enable Step Tracking';

  @override
  String get enableStepTrackingDesc =>
      'Allow activity recognition to count steps automatically';

  @override
  String get enableButton => 'Enable';

  @override
  String get syncStepsNow => 'Sync steps now';

  @override
  String get heroTitleDragonLord => 'Dragon Lord';

  @override
  String get heroTitleMonarch => 'Monarch';

  @override
  String get heroTitleChampion => 'Champion';

  @override
  String get heroTitleKnight => 'Knight';

  @override
  String get heroTitleWarrior => 'Warrior';

  @override
  String get heroTitleRunner => 'Runner';

  @override
  String get heroTitleWalker => 'Walker';

  @override
  String get levelToday => 'Today';

  @override
  String get streakBadgeLegend => 'Legend';

  @override
  String get streakBadgePro => 'Pro';

  @override
  String get streakBadgeHot => 'Hot';

  @override
  String get celebrationSteps => 'STEPS!';
}
