// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Spanish Castilian (`es`).
class AppLocalizationsEs extends AppLocalizations {
  AppLocalizationsEs([String locale = 'es']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => '¡Convierte tus pasos en una aventura!';

  @override
  String levelLabel(int level) {
    return 'Nivel $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count pasos';
  }

  @override
  String todaySteps(int count) {
    return 'Hoy: $count';
  }

  @override
  String get streakTitle => 'Racha';

  @override
  String streakDays(int count) {
    return '$count días';
  }

  @override
  String streakRecord(int count) {
    return 'Récord: $count días';
  }

  @override
  String get streakEmpty => '¡Empieza a caminar para crear tu racha!';

  @override
  String get logStepsTitle => 'Registrar pasos';

  @override
  String get logStepsHint => 'Ingresar pasos';

  @override
  String get logStepsButton => 'Registrar';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Logros';

  @override
  String achievementsUnlocked(int count) {
    return '$count desbloqueados';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Conectado';

  @override
  String get healthConnectNotConnected => 'No conectado';

  @override
  String get healthConnectUnavailable => 'No disponible';

  @override
  String get healthConnectChecking => 'Verificando...';

  @override
  String get healthConnectSyncMessage =>
      'Los pasos se sincronizan automáticamente desde Google Fit, Samsung Health, Fitbit y otras apps de Health Connect.';

  @override
  String get healthConnectPrompt =>
      'Conéctate para sincronizar pasos desde Google Fit, Samsung Health, Fitbit y otras apps de fitness.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect no está disponible. Usa el registro manual de pasos.';

  @override
  String get healthConnectSyncing => 'Sincronizando...';

  @override
  String get healthConnectSyncNow => 'Sincronizar ahora';

  @override
  String get healthConnectConnect => 'Conectar Health';

  @override
  String get healthConnectHowItWorks => '¿Cómo funciona la sincronización?';

  @override
  String get healthConnectHideDetails => 'Ocultar detalles';

  @override
  String get healthConnectSyncPathTitle => 'Ruta de sincronización';

  @override
  String get healthConnectSyncPathDescription =>
      'Tu app de fitness (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nActiva la sincronización con Health Connect en la configuración de tu app de fitness.';

  @override
  String get healthConnectMoreSensors => '¿Quieres más sensores?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Frecuencia cardíaca, calorías, seguimiento del sueño y otras funciones se pueden solicitar en GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Apoya Step Quest';

  @override
  String get supporterBadge => 'Patrocinador';

  @override
  String get supportThanks =>
      '¡Gracias por apoyar la aventura! Tu generosidad mantiene la fortaleza en pie.';

  @override
  String get supportPrompt =>
      'Step Quest es gratis y de código abierto. Las propinas ayudan al desarrollo y mantienen la app sin anuncios.';

  @override
  String get supportOpenTipJar => 'Abrir propinas';

  @override
  String get supportHideTipJar => 'Ocultar propinas';

  @override
  String get supportTipComing =>
      '¡Propinas próximamente! Por ahora, visita GitHub Sponsors.';

  @override
  String get supportSourceCode => 'Ver código fuente';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Invitar un café';

  @override
  String get tipCoffeeDesc => '¡Un pequeño agradecimiento!';

  @override
  String get tipSupporter => 'Apoyar la aventura';

  @override
  String get tipSupporterDesc => 'Ayuda a continuar el desarrollo';

  @override
  String get tipLegendary => 'Patrón legendario';

  @override
  String get tipLegendaryDesc => '¡Eres una leyenda!';

  @override
  String get watchTapToLog => 'Toca para registrar';

  @override
  String get watchStepsLabel => 'pasos';

  @override
  String get watchQuickLogTitle => 'Registro rápido';

  @override
  String watchLoggedSteps(int count) {
    return '¡$count pasos registrados!';
  }
}
