// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Danish (`da`).
class AppLocalizationsDa extends AppLocalizations {
  AppLocalizationsDa([String locale = 'da']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Forvandl dine skridt til et eventyr!';

  @override
  String levelLabel(int level) {
    return 'Niveau $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count skridt';
  }

  @override
  String todaySteps(int count) {
    return 'I dag: $count';
  }

  @override
  String get streakTitle => 'Serie';

  @override
  String streakDays(int count) {
    return '$count dage';
  }

  @override
  String streakRecord(int count) {
    return 'Rekord: $count dage';
  }

  @override
  String get streakEmpty => 'Begynd at gå og opbyg din serie!';

  @override
  String get logStepsTitle => 'Registrer skridt';

  @override
  String get logStepsHint => 'Indtast skridt';

  @override
  String get logStepsButton => 'Registrer';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Præstationer';

  @override
  String achievementsUnlocked(int count) {
    return '$count låst op';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Forbundet';

  @override
  String get healthConnectNotConnected => 'Ikke forbundet';

  @override
  String get healthConnectUnavailable => 'Ikke tilgængelig';

  @override
  String get healthConnectChecking => 'Kontrollerer...';

  @override
  String get healthConnectSyncMessage =>
      'Skridt synkroniseres automatisk fra Google Fit, Samsung Health, Fitbit og andre Health Connect apps.';

  @override
  String get healthConnectPrompt =>
      'Forbind for at synkronisere skridt fra Google Fit, Samsung Health, Fitbit og andre fitness apps.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect er ikke tilgængelig. Brug manuel skridtregistrering.';

  @override
  String get healthConnectSyncing => 'Synkroniserer...';

  @override
  String get healthConnectSyncNow => 'Synkroniser nu';

  @override
  String get healthConnectConnect => 'Forbind Health';

  @override
  String get healthConnectHowItWorks => 'Hvordan virker synkronisering?';

  @override
  String get healthConnectHideDetails => 'Skjul detaljer';

  @override
  String get healthConnectSyncPathTitle => 'Synkroniseringssti';

  @override
  String get healthConnectSyncPathDescription =>
      'Din fitness app (Samsung Health, Google Fit, Fitbit, osv.) → Health Connect → Step Quest\n\nAktiver Health Connect synkronisering i din fitness apps indstillinger.';

  @override
  String get healthConnectMoreSensors => 'Vil du have flere sensorer?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Puls, kalorier, søvnsporing og andre sensorfunktioner kan efterspørges på GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Støt Step Quest';

  @override
  String get supporterBadge => 'Støtter';

  @override
  String get supportThanks =>
      'Tak for din støtte! Din generøsitet holder fæstningen kørende.';

  @override
  String get supportPrompt =>
      'Step Quest er gratis og open source. Drikkepenge hjælper med udvikling og holder reklamer væk.';

  @override
  String get supportOpenTipJar => 'Åbn drikkepengekrukke';

  @override
  String get supportHideTipJar => 'Skjul drikkepengekrukke';

  @override
  String get supportTipComing =>
      'Drikkepengekrukke kommer snart! Besøg GitHub Sponsors indtil videre.';

  @override
  String get supportSourceCode => 'Se kildekode';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Køb en kaffe';

  @override
  String get tipCoffeeDesc => 'En lille tak!';

  @override
  String get tipSupporter => 'Støt eventyret';

  @override
  String get tipSupporterDesc => 'Hjælp med at holde udviklingen i gang';

  @override
  String get tipLegendary => 'Legendarisk protektor';

  @override
  String get tipLegendaryDesc => 'Du er en legende!';

  @override
  String get supportThankYou => 'Tak for din støtte!';

  @override
  String get supportError => 'Noget gik galt. Prøv igen.';

  @override
  String get supportStoreUnavailable =>
      'Butikken er ikke tilgængelig på denne enhed.';

  @override
  String get watchTapToLog => 'Tryk for at registrere skridt';

  @override
  String get watchStepsLabel => 'skridt';

  @override
  String get watchQuickLogTitle => 'Hurtig registrering';

  @override
  String watchLoggedSteps(int count) {
    return 'Registrerede $count skridt!';
  }

  @override
  String get streakGoalMet => 'Godt klaret! Du har nået dit mål i dag!';

  @override
  String get streakGoalPrompt => 'Nå 10.000 skridt for at fortsætte din serie!';

  @override
  String streakDayStreak(int count) {
    return '$count dages serie';
  }

  @override
  String get logTodayTitle => 'Registrer dagens skridt';

  @override
  String logTodayProgress(String current, String goal) {
    return 'I dag: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count tilbage';
  }

  @override
  String get logEnterSteps => 'Indtast skridt...';

  @override
  String get logAddButton => 'Tilføj';

  @override
  String get logAutoSaved => 'Fremskridt automatisk gemt';

  @override
  String get levelTotalSteps => 'Samlet antal skridt';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Præstationer ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Låst op!';

  @override
  String get achievementLocked => 'Låst';

  @override
  String get closeButton => 'Luk';

  @override
  String get watchAddSteps => 'Tilføj skridt';

  @override
  String get watchBack => '← Tilbage';

  @override
  String get watchStepsAdded => 'skridt tilføjet!';

  @override
  String watchLevelShort(int level) {
    return 'Niv $level';
  }

  @override
  String get easterEggUnlocked => 'Hemmeligt sprog låst op!';

  @override
  String get easterEggTapDescription =>
      'Du trykkede på de gamle runer og vækkede bjergånderne!';

  @override
  String get easterEggKonamiDescription =>
      'Den hellige sekvens er indtastet. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Tryk på sprogknappen for at skifte.';

  @override
  String get easterEggTryNow => 'Prøv det nu';

  @override
  String get easterEggLater => 'Senere';

  @override
  String get languageTitle => 'Sprog';

  @override
  String get languageSecretSection => 'Hemmelige sprog';

  @override
  String get liveTracking => 'LIVE SPORING';

  @override
  String get stepsThisSession => 'skridt denne session';

  @override
  String get liveStarting => 'Starter...';

  @override
  String get pedometerUnavailable => 'Skridttæller ikke tilgængelig';

  @override
  String get enableStepTracking => 'Aktiver skridtsporing';

  @override
  String get enableStepTrackingDesc =>
      'Tillad aktivitetsgenkendelse for at tælle skridt automatisk';

  @override
  String get enableButton => 'Aktiver';

  @override
  String get syncStepsNow => 'Synkroniser skridt nu';

  @override
  String get heroTitleDragonLord => 'Drageherre';

  @override
  String get heroTitleMonarch => 'Monark';

  @override
  String get heroTitleChampion => 'Mester';

  @override
  String get heroTitleKnight => 'Ridder';

  @override
  String get heroTitleWarrior => 'Kriger';

  @override
  String get heroTitleRunner => 'Løber';

  @override
  String get heroTitleWalker => 'Vandrer';

  @override
  String get levelToday => 'I dag';

  @override
  String get streakBadgeLegend => 'Legende';

  @override
  String get streakBadgePro => 'Pro';

  @override
  String get streakBadgeHot => 'Hot';

  @override
  String get celebrationSteps => 'SKRIDT!';
}
