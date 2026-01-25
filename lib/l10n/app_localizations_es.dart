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
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

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

  @override
  String get streakGoalMet => '¡Excelente! ¡Alcanzaste tu meta de hoy!';

  @override
  String get streakGoalPrompt =>
      '¡Alcanza 10,000 pasos para continuar tu racha!';

  @override
  String streakDayStreak(int count) {
    return 'Racha de $count días';
  }

  @override
  String get logTodayTitle => 'Registrar pasos de hoy';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Hoy: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count restantes';
  }

  @override
  String get logEnterSteps => 'Ingresar pasos...';

  @override
  String get logAddButton => 'Agregar';

  @override
  String get logAutoSaved => 'Progreso guardado automáticamente';

  @override
  String get levelTotalSteps => 'Pasos totales';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Logros ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => '¡Desbloqueado!';

  @override
  String get achievementLocked => 'Bloqueado';

  @override
  String get closeButton => 'Cerrar';

  @override
  String get watchAddSteps => 'Agregar pasos';

  @override
  String get watchBack => '← Volver';

  @override
  String get watchStepsAdded => '¡pasos agregados!';

  @override
  String watchLevelShort(int level) {
    return 'Nv $level';
  }

  @override
  String get easterEggUnlocked => '¡Idioma secreto desbloqueado!';

  @override
  String get easterEggTapDescription =>
      '¡Tocaste las runas antiguas y despertaste a los espíritus de la montaña!';

  @override
  String get easterEggKonamiDescription =>
      'La secuencia sagrada ha sido introducida. ¡Qapla\'!';

  @override
  String get easterEggTapLanguageHint =>
      'Toca el botón de idioma para cambiar.';

  @override
  String get easterEggTryNow => 'Probar ahora';

  @override
  String get easterEggLater => 'Después';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSecretSection => 'Idiomas secretos';

  @override
  String get liveTracking => 'SEGUIMIENTO EN VIVO';

  @override
  String get stepsThisSession => 'pasos en esta sesión';

  @override
  String get liveStarting => 'Iniciando...';

  @override
  String get pedometerUnavailable => 'Podómetro no disponible';

  @override
  String get enableStepTracking => 'Activar seguimiento de pasos';

  @override
  String get enableStepTrackingDesc =>
      'Permitir reconocimiento de actividad para contar pasos automáticamente';

  @override
  String get enableButton => 'Activar';

  @override
  String get syncStepsNow => 'Sincronizar pasos ahora';

  @override
  String get heroTitleDragonLord => 'Señor Dragón';

  @override
  String get heroTitleMonarch => 'Monarca';

  @override
  String get heroTitleChampion => 'Campeón';

  @override
  String get heroTitleKnight => 'Caballero';

  @override
  String get heroTitleWarrior => 'Guerrero';

  @override
  String get heroTitleRunner => 'Corredor';

  @override
  String get heroTitleWalker => 'Caminante';

  @override
  String get levelToday => 'Hoy';

  @override
  String get streakBadgeLegend => 'Leyenda';

  @override
  String get streakBadgePro => 'Pro';

  @override
  String get streakBadgeHot => 'En racha';

  @override
  String get celebrationSteps => '¡PASOS!';
}
