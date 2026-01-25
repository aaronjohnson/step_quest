// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Norwegian Bokmål (`nb`).
class AppLocalizationsNb extends AppLocalizations {
  AppLocalizationsNb([String locale = 'nb']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Gjør skritt til et eventyr!';

  @override
  String levelLabel(int level) {
    return 'Nivå $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count skritt';
  }

  @override
  String todaySteps(int count) {
    return 'I dag: $count';
  }

  @override
  String get streakTitle => 'Serie';

  @override
  String streakDays(int count) {
    return '$count dager';
  }

  @override
  String streakRecord(int count) {
    return 'Rekord: $count dager';
  }

  @override
  String get streakEmpty => 'Begynn å gå og bygg opp serien din!';

  @override
  String get logStepsTitle => 'Registrer skritt';

  @override
  String get logStepsHint => 'Skriv inn skritt';

  @override
  String get logStepsButton => 'Registrer';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Prestasjoner';

  @override
  String achievementsUnlocked(int count) {
    return '$count låst opp';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Tilkoblet';

  @override
  String get healthConnectNotConnected => 'Ikke tilkoblet';

  @override
  String get healthConnectUnavailable => 'Utilgjengelig';

  @override
  String get healthConnectChecking => 'Sjekker...';

  @override
  String get healthConnectSyncMessage =>
      'Skritt synkroniseres automatisk fra Google Fit, Samsung Health, Fitbit og andre Health Connect-apper.';

  @override
  String get healthConnectPrompt =>
      'Koble til for å synkronisere skritt fra Google Fit, Samsung Health, Fitbit og andre treningsapper.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect er ikke tilgjengelig. Bruk manuell skritt-registrering.';

  @override
  String get healthConnectSyncing => 'Synkroniserer...';

  @override
  String get healthConnectSyncNow => 'Synkroniser nå';

  @override
  String get healthConnectConnect => 'Koble til Health';

  @override
  String get healthConnectHowItWorks => 'Hvordan fungerer synkronisering?';

  @override
  String get healthConnectHideDetails => 'Skjul detaljer';

  @override
  String get healthConnectSyncPathTitle => 'Synkroniseringssti';

  @override
  String get healthConnectSyncPathDescription =>
      'Din treningsapp (Samsung Health, Google Fit, Fitbit, osv.) → Health Connect → Step Quest\n\nAktiver Health Connect-synkronisering i treningsappens innstillinger.';

  @override
  String get healthConnectMoreSensors => 'Vil du ha flere sensorer?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Puls, kalorier, søvnsporing og andre sensorfunksjoner kan etterspørres på GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Støtt Step Quest';

  @override
  String get supporterBadge => 'Støttespiller';

  @override
  String get supportThanks =>
      'Takk for støtten! Din sjenerøsitet holder festningen i gang.';

  @override
  String get supportPrompt =>
      'Step Quest er gratis og åpen kildekode. Tips hjelper med utvikling og holder reklamer borte.';

  @override
  String get supportOpenTipJar => 'Åpne tipskrukke';

  @override
  String get supportHideTipJar => 'Skjul tipskrukke';

  @override
  String get supportTipComing =>
      'Tipskrukke kommer snart! Besøk GitHub Sponsors inntil videre.';

  @override
  String get supportSourceCode => 'Se kildekode';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Kjøp en kaffe';

  @override
  String get tipCoffeeDesc => 'Drivstoff til reisen';

  @override
  String get tipGuild => 'Bli med i gildet';

  @override
  String get tipGuildDesc => 'Stå sammen med andre eventyrere';

  @override
  String get tipDragon => 'Dragedreper';

  @override
  String get tipDragonDesc => 'En helt av legendarisk sjenerøsitet';

  @override
  String get supportThankYou => 'Takk for støtten!';

  @override
  String get supportError => 'Noe gikk galt. Prøv igjen.';

  @override
  String get supportStoreUnavailable =>
      'Butikken er ikke tilgjengelig på denne enheten.';

  @override
  String get watchTapToLog => 'Trykk for å registrere skritt';

  @override
  String get watchStepsLabel => 'skritt';

  @override
  String get watchQuickLogTitle => 'Rask registrering';

  @override
  String watchLoggedSteps(int count) {
    return 'Registrerte $count skritt!';
  }

  @override
  String get streakGoalMet => 'Bra jobbet! Du har nådd målet ditt i dag!';

  @override
  String get streakGoalPrompt => 'Nå 10 000 skritt for å fortsette serien!';

  @override
  String streakDayStreak(int count) {
    return '$count dagers serie';
  }

  @override
  String get logTodayTitle => 'Registrer dagens skritt';

  @override
  String logTodayProgress(String current, String goal) {
    return 'I dag: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count igjen';
  }

  @override
  String get logEnterSteps => 'Skriv inn skritt...';

  @override
  String get logAddButton => 'Legg til';

  @override
  String get logAutoSaved => 'Fremgang automatisk lagret';

  @override
  String get levelTotalSteps => 'Totalt antall skritt';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Prestasjoner ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Låst opp!';

  @override
  String get achievementLocked => 'Låst';

  @override
  String get closeButton => 'Lukk';

  @override
  String get watchAddSteps => 'Legg til skritt';

  @override
  String get watchBack => '← Tilbake';

  @override
  String get watchStepsAdded => 'skritt lagt til!';

  @override
  String watchLevelShort(int level) {
    return 'Niv $level';
  }

  @override
  String get easterEggUnlocked => 'Hemmelig språk låst opp!';

  @override
  String get easterEggTapDescription =>
      'Du trykket på de gamle runene og vekket fjellåndene!';

  @override
  String get easterEggKonamiDescription =>
      'Den hellige sekvensen er tastet inn. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Trykk på språkknappen for å bytte.';

  @override
  String get easterEggTryNow => 'Prøv det nå';

  @override
  String get easterEggLater => 'Senere';

  @override
  String get languageTitle => 'Språk';

  @override
  String get languageSecretSection => 'Hemmelige språk';

  @override
  String get liveTracking => 'LIVE SPORING';

  @override
  String get stepsThisSession => 'skritt denne økten';

  @override
  String get liveStarting => 'Starter...';

  @override
  String get pedometerUnavailable => 'Skritteller utilgjengelig';

  @override
  String get enableStepTracking => 'Aktiver skrittsporing';

  @override
  String get enableStepTrackingDesc =>
      'Tillat aktivitetsgjenkjenning for å telle skritt automatisk';

  @override
  String get enableButton => 'Aktiver';

  @override
  String get syncStepsNow => 'Synkroniser skritt nå';

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
  String get heroTitleRunner => 'Løper';

  @override
  String get heroTitleWalker => 'Vandrer';

  @override
  String get levelToday => 'I dag';

  @override
  String get streakBadgeLegend => 'Legende';

  @override
  String get streakBadgePro => 'Proff';

  @override
  String get streakBadgeHot => 'Het';

  @override
  String get celebrationSteps => 'SKRITT!';
}
