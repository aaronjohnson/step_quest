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
  String get tipCoffeeDesc => 'Ein kleines Dankeschön!';

  @override
  String get tipSupporter => 'Die Quest unterstützen';

  @override
  String get tipSupporterDesc => 'Hilf, die Entwicklung fortzusetzen';

  @override
  String get tipLegendary => 'Legendärer Patron';

  @override
  String get tipLegendaryDesc => 'Du bist eine Legende!';

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
}
