// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Swedish (`sv`).
class AppLocalizationsSv extends AppLocalizations {
  AppLocalizationsSv([String locale = 'sv']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Förvandla dina steg till ett äventyr!';

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
    return '$count steg';
  }

  @override
  String todaySteps(int count) {
    return 'Idag: $count';
  }

  @override
  String get streakTitle => 'Svit';

  @override
  String streakDays(int count) {
    return '$count dagar';
  }

  @override
  String streakRecord(int count) {
    return 'Rekord: $count dagar';
  }

  @override
  String get streakEmpty => 'Börja gå och bygg upp din svit!';

  @override
  String get logStepsTitle => 'Registrera steg';

  @override
  String get logStepsHint => 'Ange steg';

  @override
  String get logStepsButton => 'Registrera';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Prestationer';

  @override
  String achievementsUnlocked(int count) {
    return '$count upplåsta';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Ansluten';

  @override
  String get healthConnectNotConnected => 'Inte ansluten';

  @override
  String get healthConnectUnavailable => 'Otillgänglig';

  @override
  String get healthConnectChecking => 'Kontrollerar...';

  @override
  String get healthConnectSyncMessage =>
      'Steg synkroniseras automatiskt från Google Fit, Samsung Health, Fitbit och andra Health Connect-appar.';

  @override
  String get healthConnectPrompt =>
      'Anslut för att synkronisera steg från Google Fit, Samsung Health, Fitbit och andra träningsappar.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect är inte tillgänglig. Använd manuell stegregistrering.';

  @override
  String get healthConnectSyncing => 'Synkroniserar...';

  @override
  String get healthConnectSyncNow => 'Synkronisera nu';

  @override
  String get healthConnectConnect => 'Anslut Health';

  @override
  String get healthConnectHowItWorks => 'Hur fungerar synkronisering?';

  @override
  String get healthConnectHideDetails => 'Dölj detaljer';

  @override
  String get healthConnectSyncPathTitle => 'Synkroniseringsväg';

  @override
  String get healthConnectSyncPathDescription =>
      'Din träningsapp (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nAktivera Health Connect-synkronisering i din träningsapps inställningar.';

  @override
  String get healthConnectMoreSensors => 'Vill du ha fler sensorer?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Puls, kalorier, sömnspårning och andra sensorfunktioner kan efterfrågas på GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Stöd Step Quest';

  @override
  String get supporterBadge => 'Supporter';

  @override
  String get supportThanks =>
      'Tack för ditt stöd! Din generositet håller fästningen igång.';

  @override
  String get supportPrompt =>
      'Step Quest är gratis och öppen källkod. Dricks hjälper utvecklingen och håller reklam borta.';

  @override
  String get supportOpenTipJar => 'Öppna dricksburk';

  @override
  String get supportHideTipJar => 'Dölj dricksburk';

  @override
  String get supportTipComing =>
      'Dricksburk kommer snart! Besök GitHub Sponsors tills vidare.';

  @override
  String get supportSourceCode => 'Visa källkod';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Köp en kaffe';

  @override
  String get tipCoffeeDesc => 'Ett litet tack!';

  @override
  String get tipSupporter => 'Stöd äventyret';

  @override
  String get tipSupporterDesc => 'Hjälp till att hålla utvecklingen igång';

  @override
  String get tipLegendary => 'Legendarisk beskyddare';

  @override
  String get tipLegendaryDesc => 'Du är en legend!';

  @override
  String get supportThankYou => 'Tack för ditt stöd!';

  @override
  String get supportError => 'Något gick fel. Försök igen.';

  @override
  String get supportStoreUnavailable =>
      'Butiken är inte tillgänglig på denna enhet.';

  @override
  String get watchTapToLog => 'Tryck för att registrera steg';

  @override
  String get watchStepsLabel => 'steg';

  @override
  String get watchQuickLogTitle => 'Snabbregistrering';

  @override
  String watchLoggedSteps(int count) {
    return 'Registrerade $count steg!';
  }

  @override
  String get streakGoalMet => 'Bra jobbat! Du har nått ditt mål idag!';

  @override
  String get streakGoalPrompt => 'Nå 10 000 steg för att fortsätta din svit!';

  @override
  String streakDayStreak(int count) {
    return '$count dagars svit';
  }

  @override
  String get logTodayTitle => 'Registrera dagens steg';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Idag: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count kvar';
  }

  @override
  String get logEnterSteps => 'Ange steg...';

  @override
  String get logAddButton => 'Lägg till';

  @override
  String get logAutoSaved => 'Framsteg automatiskt sparat';

  @override
  String get levelTotalSteps => 'Totalt antal steg';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Prestationer ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Upplåst!';

  @override
  String get achievementLocked => 'Låst';

  @override
  String get closeButton => 'Stäng';

  @override
  String get watchAddSteps => 'Lägg till steg';

  @override
  String get watchBack => '← Tillbaka';

  @override
  String get watchStepsAdded => 'steg tillagda!';

  @override
  String watchLevelShort(int level) {
    return 'Niv $level';
  }

  @override
  String get easterEggUnlocked => 'Hemligt språk upplåst!';

  @override
  String get easterEggTapDescription =>
      'Du tryckte på de gamla runorna och väckte bergsandarna!';

  @override
  String get easterEggKonamiDescription =>
      'Den heliga sekvensen har matats in. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Tryck på språkknappen för att byta.';

  @override
  String get easterEggTryNow => 'Prova nu';

  @override
  String get easterEggLater => 'Senare';

  @override
  String get languageTitle => 'Språk';

  @override
  String get languageSecretSection => 'Hemliga språk';

  @override
  String get liveTracking => 'LIVE SPÅRNING';

  @override
  String get stepsThisSession => 'steg denna session';

  @override
  String get liveStarting => 'Startar...';

  @override
  String get pedometerUnavailable => 'Stegräknare otillgänglig';

  @override
  String get enableStepTracking => 'Aktivera stegspårning';

  @override
  String get enableStepTrackingDesc =>
      'Tillåt aktivitetsigenkänning för att räkna steg automatiskt';

  @override
  String get enableButton => 'Aktivera';

  @override
  String get syncStepsNow => 'Synkronisera steg nu';

  @override
  String get heroTitleDragonLord => 'Drakherre';

  @override
  String get heroTitleMonarch => 'Monark';

  @override
  String get heroTitleChampion => 'Mästare';

  @override
  String get heroTitleKnight => 'Riddare';

  @override
  String get heroTitleWarrior => 'Krigare';

  @override
  String get heroTitleRunner => 'Löpare';

  @override
  String get heroTitleWalker => 'Vandrare';

  @override
  String get levelToday => 'Idag';

  @override
  String get streakBadgeLegend => 'Legend';

  @override
  String get streakBadgePro => 'Proffs';

  @override
  String get streakBadgeHot => 'Het';

  @override
  String get celebrationSteps => 'STEG!';
}
