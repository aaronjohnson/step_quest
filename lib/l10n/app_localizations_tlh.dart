// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Klingon tlhIngan Hol (`tlh`).
class AppLocalizationsTlh extends AppLocalizations {
  AppLocalizationsTlh([String locale = 'tlh']) : super(locale);

  @override
  String get appTitle => 'yIt Quest';

  @override
  String get appTagline => 'yItmeylIj yIngu\'moH!';

  @override
  String levelLabel(int level) {
    return 'patlh $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count yItmey';
  }

  @override
  String todaySteps(int count) {
    return 'DaHjaj: $count';
  }

  @override
  String get streakTitle => 'taHghach';

  @override
  String streakDays(int count) {
    return '$count jajmey';
  }

  @override
  String streakRecord(int count) {
    return 'qun: $count jajmey';
  }

  @override
  String get streakEmpty => 'yIt \'ej taHghachlIj chenmoH!';

  @override
  String get logStepsTitle => 'yItmey qon';

  @override
  String get logStepsHint => 'yItmey \'el';

  @override
  String get logStepsButton => 'qon';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Qapla\'mey';

  @override
  String achievementsUnlocked(int count) {
    return '$count poSmoHlu\'';
  }

  @override
  String get healthConnectTitle => 'pIvghor Connect';

  @override
  String get healthConnectConnected => 'rarlu\'';

  @override
  String get healthConnectNotConnected => 'rarlu\'be\'';

  @override
  String get healthConnectUnavailable => 'Qapbe\'';

  @override
  String get healthConnectChecking => '\'ol...';

  @override
  String get healthConnectSyncMessage =>
      'yItmey Google Fit, Samsung Health, Fitbit je Health Connect apps vo\' автоматически синхронизируются.';

  @override
  String get healthConnectPrompt =>
      'Google Fit, Samsung Health, Fitbit je fitness apps vo\' yItmey rar.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect Qapbe\'. yItmey qon manually.';

  @override
  String get healthConnectSyncing => 'rar...';

  @override
  String get healthConnectSyncNow => 'DaH rar';

  @override
  String get healthConnectConnect => 'Health rar';

  @override
  String get healthConnectHowItWorks => 'chay\' rar Qap?';

  @override
  String get healthConnectHideDetails => 'De\' So\'';

  @override
  String get healthConnectSyncPathTitle => 'rar He';

  @override
  String get healthConnectSyncPathDescription =>
      'fitness app\'a\'lIj (Samsung Health, Google Fit, Fitbit, joq) → Health Connect → yIt Quest\n\nfitness app settings-Daq Health Connect rar yIchu\'.';

  @override
  String get healthConnectMoreSensors => 'latlh sensors DaneH\'a\'?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'tIq rate, calories, Qong tracking, latlh sensor features GitHub-Daq tlhoblu\'laH:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'yIt Quest yIQaH';

  @override
  String get supporterBadge => 'QaHwI\'';

  @override
  String get supportThanks =>
      'QaHmo\' qatlho\'! nobmeylIj tlhIngan ta\' luQaH.';

  @override
  String get supportPrompt =>
      'yIt Quest pung je open source. Tips development QaH \'ej ads lunobHa\'.';

  @override
  String get supportOpenTipJar => 'tip jar yIpoS';

  @override
  String get supportHideTipJar => 'tip jar yISo\'';

  @override
  String get supportTipComing => 'tip jar tugh! DaH GitHub Sponsors yISuch.';

  @override
  String get supportSourceCode => 'source code yIlegh';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'qa\'vIn yInob';

  @override
  String get tipCoffeeDesc => 'lengvaD nIQ';

  @override
  String get tipGuild => 'DIvI\' yImuv';

  @override
  String get tipGuildDesc => 'latlh SuvwI\'pu\' tlhej yIQam';

  @override
  String get tipDragon => 'lungqIy HoHwI\'';

  @override
  String get tipDragonDesc => 'qun nobwI\' \'oH SuvwI\'\'e\'';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

  @override
  String get watchTapToLog => 'yItmey qonmeH yI\'uy';

  @override
  String get watchStepsLabel => 'yItmey';

  @override
  String get watchQuickLogTitle => 'nom qon';

  @override
  String watchLoggedSteps(int count) {
    return '$count yItmey qonlu\'!';
  }

  @override
  String get streakGoalMet => 'Qapla\'! DaHjaj Dochmaj DaQap!';

  @override
  String get streakGoalPrompt => 'taHghachlIj DataHmoHmeH 10,000 yItmey yIQap!';

  @override
  String streakDayStreak(int count) {
    return '$count jaj taHghach';
  }

  @override
  String get logTodayTitle => 'DaHjaj yItmey qon';

  @override
  String logTodayProgress(String current, String goal) {
    return 'DaHjaj: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count rat';
  }

  @override
  String get logEnterSteps => 'yItmey \'el...';

  @override
  String get logAddButton => 'chel';

  @override
  String get logAutoSaved => 'automatically pollu\'';

  @override
  String get levelTotalSteps => 'Hoch yItmey';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Qapla\'mey ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'poSmoHlu\'!';

  @override
  String get achievementLocked => 'So\'lu\'';

  @override
  String get closeButton => 'SoQmoH';

  @override
  String get watchAddSteps => 'yItmey chel';

  @override
  String get watchBack => '← chap';

  @override
  String get watchStepsAdded => 'yItmey chellu\'!';

  @override
  String watchLevelShort(int level) {
    return 'patlh $level';
  }

  @override
  String get easterEggUnlocked => 'pegh Hol poSmoHlu\'!';

  @override
  String get easterEggTapDescription =>
      'tIqDu\' DaHotpu\' \'ej HuD qa\'mey DavemmoHpu\'!';

  @override
  String get easterEggKonamiDescription => 'mIw quv \'ellu\'. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Hol choHmeH Hol button yI\'uy.';

  @override
  String get easterEggTryNow => 'DaH yInID';

  @override
  String get easterEggLater => 'ghIq';

  @override
  String get languageTitle => 'Hol';

  @override
  String get languageSecretSection => 'pegh Holmey';

  @override
  String get liveTracking => 'YIN TRACKING';

  @override
  String get stepsThisSession => 'yItmey poH';

  @override
  String get liveStarting => 'taghlu\'...';

  @override
  String get pedometerUnavailable => 'yIt counter Qapbe\'';

  @override
  String get enableStepTracking => 'yIt tracking yIchu\'';

  @override
  String get enableStepTrackingDesc =>
      'yItmey toghmeH activity recognition yIchaw\'';

  @override
  String get enableButton => 'yIchu\'';

  @override
  String get syncStepsNow => 'DaH yItmey yIrar';

  @override
  String get heroTitleDragonLord => 'lungHa\' joH';

  @override
  String get heroTitleMonarch => 'ta\'';

  @override
  String get heroTitleChampion => 'ghobwI\' qorghwI\'';

  @override
  String get heroTitleKnight => 'SuvwI\' quv';

  @override
  String get heroTitleWarrior => 'SuvwI\'';

  @override
  String get heroTitleRunner => 'qetwI\'';

  @override
  String get heroTitleWalker => 'yItwI\'';

  @override
  String get levelToday => 'DaHjaj';

  @override
  String get streakBadgeLegend => 'qun';

  @override
  String get streakBadgePro => 'po\'wI\'';

  @override
  String get streakBadgeHot => 'tuj';

  @override
  String get celebrationSteps => 'YITMEY!';
}
