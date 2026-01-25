// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Catalan Valencian (`ca`).
class AppLocalizationsCa extends AppLocalizations {
  AppLocalizationsCa([String locale = 'ca']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Converteix els teus passos en una aventura!';

  @override
  String levelLabel(int level) {
    return 'Nivell $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count passos';
  }

  @override
  String todaySteps(int count) {
    return 'Avui: $count';
  }

  @override
  String get streakTitle => 'Ratxa';

  @override
  String streakDays(int count) {
    return '$count dies';
  }

  @override
  String streakRecord(int count) {
    return 'Rècord: $count dies';
  }

  @override
  String get streakEmpty => 'Comença a caminar per crear la teva ratxa!';

  @override
  String get logStepsTitle => 'Registrar passos';

  @override
  String get logStepsHint => 'Introdueix passos';

  @override
  String get logStepsButton => 'Registrar';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Assoliments';

  @override
  String achievementsUnlocked(int count) {
    return '$count desbloquejats';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Connectat';

  @override
  String get healthConnectNotConnected => 'No connectat';

  @override
  String get healthConnectUnavailable => 'No disponible';

  @override
  String get healthConnectChecking => 'Comprovant...';

  @override
  String get healthConnectSyncMessage =>
      'Els passos es sincronitzen automàticament des de Google Fit, Samsung Health, Fitbit i altres apps de Health Connect.';

  @override
  String get healthConnectPrompt =>
      'Connecta\'t per sincronitzar passos des de Google Fit, Samsung Health, Fitbit i altres apps de fitness.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect no està disponible. Utilitza el registre manual de passos.';

  @override
  String get healthConnectSyncing => 'Sincronitzant...';

  @override
  String get healthConnectSyncNow => 'Sincronitzar ara';

  @override
  String get healthConnectConnect => 'Connectar Health';

  @override
  String get healthConnectHowItWorks => 'Com funciona la sincronització?';

  @override
  String get healthConnectHideDetails => 'Amagar detalls';

  @override
  String get healthConnectSyncPathTitle => 'Ruta de sincronització';

  @override
  String get healthConnectSyncPathDescription =>
      'La teva app de fitness (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nActiva la sincronització amb Health Connect a la configuració de la teva app de fitness.';

  @override
  String get healthConnectMoreSensors => 'Vols més sensors?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Freqüència cardíaca, calories, seguiment del son i altres funcions es poden sol·licitar a GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Dona suport a Step Quest';

  @override
  String get supporterBadge => 'Col·laborador';

  @override
  String get supportThanks =>
      'Gràcies pel teu suport! La teva generositat manté la fortalesa en peu.';

  @override
  String get supportPrompt =>
      'Step Quest és gratuït i de codi obert. Les propines ajuden al desenvolupament i mantenen l\'app sense anuncis.';

  @override
  String get supportOpenTipJar => 'Obrir pot de propines';

  @override
  String get supportHideTipJar => 'Amagar pot de propines';

  @override
  String get supportTipComing =>
      'Pot de propines properament! Mentrestant, visita GitHub Sponsors.';

  @override
  String get supportSourceCode => 'Veure codi font';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Comprar un cafè';

  @override
  String get tipCoffeeDesc => 'Combustible pel viatge';

  @override
  String get tipGuild => 'Uneix-te al Gremi';

  @override
  String get tipGuildDesc => 'Uneix-te a altres aventurers';

  @override
  String get tipDragon => 'Caçador de Dracs';

  @override
  String get tipDragonDesc => 'Un heroi de generositat llegendària';

  @override
  String get supportThankYou => 'Gràcies pel teu suport!';

  @override
  String get supportError => 'Alguna cosa ha anat malament. Torna-ho a provar.';

  @override
  String get supportStoreUnavailable =>
      'La botiga no està disponible en aquest dispositiu.';

  @override
  String get watchTapToLog => 'Toca per registrar passos';

  @override
  String get watchStepsLabel => 'passos';

  @override
  String get watchQuickLogTitle => 'Registre ràpid';

  @override
  String watchLoggedSteps(int count) {
    return 'Registrats $count passos!';
  }

  @override
  String get streakGoalMet => 'Ben fet! Has assolit el teu objectiu avui!';

  @override
  String get streakGoalPrompt =>
      'Arriba a 10.000 passos per continuar la teva ratxa!';

  @override
  String streakDayStreak(int count) {
    return 'Ratxa de $count dies';
  }

  @override
  String get logTodayTitle => 'Registrar els passos d\'avui';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Avui: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count restants';
  }

  @override
  String get logEnterSteps => 'Introdueix passos...';

  @override
  String get logAddButton => 'Afegir';

  @override
  String get logAutoSaved => 'Progrés desat automàticament';

  @override
  String get levelTotalSteps => 'Passos totals';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Assoliments ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Desbloquejat!';

  @override
  String get achievementLocked => 'Bloquejat';

  @override
  String get closeButton => 'Tancar';

  @override
  String get watchAddSteps => 'Afegir passos';

  @override
  String get watchBack => '← Enrere';

  @override
  String get watchStepsAdded => 'passos afegits!';

  @override
  String watchLevelShort(int level) {
    return 'Niv $level';
  }

  @override
  String get easterEggUnlocked => 'Idioma secret desbloquejat!';

  @override
  String get easterEggTapDescription =>
      'Has tocat les runes antigues i has despertat els esperits de la muntanya!';

  @override
  String get easterEggKonamiDescription =>
      'La seqüència sagrada ha estat introduïda. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Toca el botó d\'idioma per canviar.';

  @override
  String get easterEggTryNow => 'Provar-ho ara';

  @override
  String get easterEggLater => 'Més tard';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSecretSection => 'Idiomes secrets';

  @override
  String get liveTracking => 'SEGUIMENT EN VIU';

  @override
  String get stepsThisSession => 'passos aquesta sessió';

  @override
  String get liveStarting => 'Iniciant...';

  @override
  String get pedometerUnavailable => 'Podòmetre no disponible';

  @override
  String get enableStepTracking => 'Activar seguiment de passos';

  @override
  String get enableStepTrackingDesc =>
      'Permet el reconeixement d\'activitat per comptar passos automàticament';

  @override
  String get enableButton => 'Activar';

  @override
  String get syncStepsNow => 'Sincronitzar passos ara';

  @override
  String get heroTitleDragonLord => 'Senyor Drac';

  @override
  String get heroTitleMonarch => 'Monarca';

  @override
  String get heroTitleChampion => 'Campió';

  @override
  String get heroTitleKnight => 'Cavaller';

  @override
  String get heroTitleWarrior => 'Guerrer';

  @override
  String get heroTitleRunner => 'Corredor';

  @override
  String get heroTitleWalker => 'Caminant';

  @override
  String get levelToday => 'Avui';

  @override
  String get streakBadgeLegend => 'Llegenda';

  @override
  String get streakBadgePro => 'Pro';

  @override
  String get streakBadgeHot => 'En ratxa';

  @override
  String get celebrationSteps => 'PASSOS!';
}
