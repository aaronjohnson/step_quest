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
  String get watchTapToLog => 'Tap to log steps';

  @override
  String get watchStepsLabel => 'steps';

  @override
  String get watchQuickLogTitle => 'Quick Log';

  @override
  String watchLoggedSteps(int count) {
    return 'Logged $count steps!';
  }
}
