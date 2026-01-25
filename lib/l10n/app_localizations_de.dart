// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for German (`de`).
class AppLocalizationsDe extends AppLocalizations {
  AppLocalizationsDe([String locale = 'de']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Verwandle deine Schritte in ein Abenteuer!';

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
    return '$count Schritte';
  }

  @override
  String todaySteps(int count) {
    return 'Heute: $count';
  }

  @override
  String get streakTitle => 'Serie';

  @override
  String streakDays(int count) {
    return '$count Tage';
  }

  @override
  String streakRecord(int count) {
    return 'Rekord: $count Tage';
  }

  @override
  String get streakEmpty => 'Beginne zu laufen und baue deine Serie auf!';

  @override
  String get logStepsTitle => 'Schritte erfassen';

  @override
  String get logStepsHint => 'Schritte eingeben';

  @override
  String get logStepsButton => 'Erfassen';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Erfolge';

  @override
  String achievementsUnlocked(int count) {
    return '$count freigeschaltet';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Verbunden';

  @override
  String get healthConnectNotConnected => 'Nicht verbunden';

  @override
  String get healthConnectUnavailable => 'Nicht verfügbar';

  @override
  String get healthConnectChecking => 'Prüfe...';

  @override
  String get healthConnectSyncMessage =>
      'Schritte werden automatisch von Google Fit, Samsung Health, Fitbit und anderen Health Connect Apps synchronisiert.';

  @override
  String get healthConnectPrompt =>
      'Verbinde dich, um Schritte von Google Fit, Samsung Health, Fitbit und anderen Fitness-Apps zu synchronisieren.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect ist nicht verfügbar. Verwende die manuelle Schritteingabe.';

  @override
  String get healthConnectSyncing => 'Synchronisiere...';

  @override
  String get healthConnectSyncNow => 'Jetzt synchronisieren';

  @override
  String get healthConnectConnect => 'Health verbinden';

  @override
  String get healthConnectHowItWorks =>
      'Wie funktioniert die Synchronisierung?';

  @override
  String get healthConnectHideDetails => 'Details ausblenden';

  @override
  String get healthConnectSyncPathTitle => 'Synchronisierungspfad';

  @override
  String get healthConnectSyncPathDescription =>
      'Deine Fitness-App (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nAktiviere Health Connect Sync in den Einstellungen deiner Fitness-App.';

  @override
  String get healthConnectMoreSensors => 'Mehr Sensoren gewünscht?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Herzfrequenz, Kalorien, Schlaftracking und andere Sensorfunktionen können auf GitHub angefragt werden:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Step Quest unterstützen';

  @override
  String get supporterBadge => 'Unterstützer';

  @override
  String get supportThanks =>
      'Danke für deine Unterstützung! Deine Großzügigkeit hält die Festung am Laufen.';

  @override
  String get supportPrompt =>
      'Step Quest ist kostenlos und Open Source. Trinkgelder helfen bei der Entwicklung und halten Werbung fern.';

  @override
  String get supportOpenTipJar => 'Trinkgeldkasse öffnen';

  @override
  String get supportHideTipJar => 'Trinkgeldkasse ausblenden';

  @override
  String get supportTipComing =>
      'Trinkgeldkasse kommt bald! Besuche vorerst GitHub Sponsors.';

  @override
  String get supportSourceCode => 'Quellcode ansehen';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Kaffee ausgeben';

  @override
  String get tipCoffeeDesc => 'Treibstoff für die Reise';

  @override
  String get tipGuild => 'Der Gilde beitreten';

  @override
  String get tipGuildDesc => 'Steh mit anderen Abenteurern zusammen';

  @override
  String get tipDragon => 'Drachentöter';

  @override
  String get tipDragonDesc => 'Ein Held von legendärer Großzügigkeit';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

  @override
  String get watchTapToLog => 'Tippen zum Erfassen';

  @override
  String get watchStepsLabel => 'Schritte';

  @override
  String get watchQuickLogTitle => 'Schnellerfassung';

  @override
  String watchLoggedSteps(int count) {
    return '$count Schritte erfasst!';
  }

  @override
  String get streakGoalMet => 'Großartig! Du hast dein Tagesziel erreicht!';

  @override
  String get streakGoalPrompt =>
      'Erreiche 10.000 Schritte, um deine Serie fortzusetzen!';

  @override
  String streakDayStreak(int count) {
    return '$count-Tage-Serie';
  }

  @override
  String get logTodayTitle => 'Heutige Schritte erfassen';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Heute: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return 'noch $count';
  }

  @override
  String get logEnterSteps => 'Schritte eingeben...';

  @override
  String get logAddButton => 'Hinzufügen';

  @override
  String get logAutoSaved => 'Fortschritt automatisch gespeichert';

  @override
  String get levelTotalSteps => 'Gesamtschritte';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Erfolge ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Freigeschaltet!';

  @override
  String get achievementLocked => 'Gesperrt';

  @override
  String get closeButton => 'Schließen';

  @override
  String get watchAddSteps => 'Schritte hinzufügen';

  @override
  String get watchBack => '← Zurück';

  @override
  String get watchStepsAdded => 'Schritte hinzugefügt!';

  @override
  String watchLevelShort(int level) {
    return 'Lv $level';
  }

  @override
  String get easterEggUnlocked => 'Geheime Sprache freigeschaltet!';

  @override
  String get easterEggTapDescription =>
      'Du hast die alten Runen berührt und die Berggeister erweckt!';

  @override
  String get easterEggKonamiDescription =>
      'Die heilige Sequenz wurde eingegeben. Qapla\'!';

  @override
  String get easterEggTapLanguageHint =>
      'Tippe auf die Sprachauswahl zum Wechseln.';

  @override
  String get easterEggTryNow => 'Jetzt ausprobieren';

  @override
  String get easterEggLater => 'Später';

  @override
  String get languageTitle => 'Sprache';

  @override
  String get languageSecretSection => 'Geheime Sprachen';

  @override
  String get liveTracking => 'LIVE-TRACKING';

  @override
  String get stepsThisSession => 'Schritte in dieser Sitzung';

  @override
  String get liveStarting => 'Startet...';

  @override
  String get pedometerUnavailable => 'Schrittzähler nicht verfügbar';

  @override
  String get enableStepTracking => 'Schrittzählung aktivieren';

  @override
  String get enableStepTrackingDesc =>
      'Aktivitätserkennung erlauben, um Schritte automatisch zu zählen';

  @override
  String get enableButton => 'Aktivieren';

  @override
  String get syncStepsNow => 'Schritte jetzt synchronisieren';

  @override
  String get heroTitleDragonLord => 'Drachenlord';

  @override
  String get heroTitleMonarch => 'Monarch';

  @override
  String get heroTitleChampion => 'Champion';

  @override
  String get heroTitleKnight => 'Ritter';

  @override
  String get heroTitleWarrior => 'Krieger';

  @override
  String get heroTitleRunner => 'Läufer';

  @override
  String get heroTitleWalker => 'Wanderer';

  @override
  String get levelToday => 'Heute';

  @override
  String get streakBadgeLegend => 'Legende';

  @override
  String get streakBadgePro => 'Profi';

  @override
  String get streakBadgeHot => 'Heiß';

  @override
  String get celebrationSteps => 'SCHRITTE!';
}
