// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Portuguese (`pt`).
class AppLocalizationsPt extends AppLocalizations {
  AppLocalizationsPt([String locale = 'pt']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Transforme seus passos em uma aventura!';

  @override
  String levelLabel(int level) {
    return 'Nível $level';
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
    return 'Hoje: $count';
  }

  @override
  String get streakTitle => 'Sequência';

  @override
  String streakDays(int count) {
    return '$count dias';
  }

  @override
  String streakRecord(int count) {
    return 'Recorde: $count dias';
  }

  @override
  String get streakEmpty => 'Comece a caminhar para criar sua sequência!';

  @override
  String get logStepsTitle => 'Registrar passos';

  @override
  String get logStepsHint => 'Digite os passos';

  @override
  String get logStepsButton => 'Registrar';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Conquistas';

  @override
  String achievementsUnlocked(int count) {
    return '$count desbloqueadas';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Conectado';

  @override
  String get healthConnectNotConnected => 'Não conectado';

  @override
  String get healthConnectUnavailable => 'Indisponível';

  @override
  String get healthConnectChecking => 'Verificando...';

  @override
  String get healthConnectSyncMessage =>
      'Os passos são sincronizados automaticamente do Google Fit, Samsung Health, Fitbit e outros apps do Health Connect.';

  @override
  String get healthConnectPrompt =>
      'Conecte-se para sincronizar passos do Google Fit, Samsung Health, Fitbit e outros apps de fitness.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect não está disponível. Use o registro manual de passos.';

  @override
  String get healthConnectSyncing => 'Sincronizando...';

  @override
  String get healthConnectSyncNow => 'Sincronizar agora';

  @override
  String get healthConnectConnect => 'Conectar Health';

  @override
  String get healthConnectHowItWorks => 'Como funciona a sincronização?';

  @override
  String get healthConnectHideDetails => 'Ocultar detalhes';

  @override
  String get healthConnectSyncPathTitle => 'Caminho de sincronização';

  @override
  String get healthConnectSyncPathDescription =>
      'Seu app de fitness (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nAtive a sincronização do Health Connect nas configurações do seu app de fitness.';

  @override
  String get healthConnectMoreSensors => 'Quer mais sensores?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Frequência cardíaca, calorias, monitoramento de sono e outros recursos podem ser solicitados no GitHub:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Apoie o Step Quest';

  @override
  String get supporterBadge => 'Apoiador';

  @override
  String get supportThanks =>
      'Obrigado por apoiar a aventura! Sua generosidade mantém a fortaleza de pé.';

  @override
  String get supportPrompt =>
      'Step Quest é gratuito e código aberto. Gorjetas ajudam no desenvolvimento e mantêm o app sem anúncios.';

  @override
  String get supportOpenTipJar => 'Abrir gorjetas';

  @override
  String get supportHideTipJar => 'Fechar gorjetas';

  @override
  String get supportTipComing =>
      'Gorjetas em breve! Por enquanto, visite GitHub Sponsors.';

  @override
  String get supportSourceCode => 'Ver código fonte';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Pagar um café';

  @override
  String get tipCoffeeDesc => 'Um pequeno agradecimento!';

  @override
  String get tipSupporter => 'Apoiar a aventura';

  @override
  String get tipSupporterDesc => 'Ajude a manter o desenvolvimento';

  @override
  String get tipLegendary => 'Patrono lendário';

  @override
  String get tipLegendaryDesc => 'Você é uma lenda!';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

  @override
  String get watchTapToLog => 'Toque para registrar';

  @override
  String get watchStepsLabel => 'passos';

  @override
  String get watchQuickLogTitle => 'Registro rápido';

  @override
  String watchLoggedSteps(int count) {
    return '$count passos registrados!';
  }

  @override
  String get streakGoalMet => 'Ótimo trabalho! Você atingiu sua meta hoje!';

  @override
  String get streakGoalPrompt =>
      'Alcance 10.000 passos para manter sua sequência!';

  @override
  String streakDayStreak(int count) {
    return 'Sequência de $count dias';
  }

  @override
  String get logTodayTitle => 'Registrar passos de hoje';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Hoje: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return 'faltam $count';
  }

  @override
  String get logEnterSteps => 'Digite os passos...';

  @override
  String get logAddButton => 'Adicionar';

  @override
  String get logAutoSaved => 'Progresso salvo automaticamente';

  @override
  String get levelTotalSteps => 'Passos totais';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Conquistas ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Desbloqueado!';

  @override
  String get achievementLocked => 'Bloqueado';

  @override
  String get closeButton => 'Fechar';

  @override
  String get watchAddSteps => 'Adicionar passos';

  @override
  String get watchBack => '← Voltar';

  @override
  String get watchStepsAdded => 'passos adicionados!';

  @override
  String watchLevelShort(int level) {
    return 'Nv $level';
  }

  @override
  String get easterEggUnlocked => 'Idioma secreto desbloqueado!';

  @override
  String get easterEggTapDescription =>
      'Você tocou as runas antigas e despertou os espíritos da montanha!';

  @override
  String get easterEggKonamiDescription =>
      'A sequência sagrada foi inserida. Qapla\'!';

  @override
  String get easterEggTapLanguageHint =>
      'Toque no botão de idioma para trocar.';

  @override
  String get easterEggTryNow => 'Experimentar agora';

  @override
  String get easterEggLater => 'Depois';

  @override
  String get languageTitle => 'Idioma';

  @override
  String get languageSecretSection => 'Idiomas secretos';

  @override
  String get liveTracking => 'RASTREAMENTO AO VIVO';

  @override
  String get stepsThisSession => 'passos nesta sessão';

  @override
  String get liveStarting => 'Iniciando...';

  @override
  String get pedometerUnavailable => 'Pedômetro indisponível';

  @override
  String get enableStepTracking => 'Ativar rastreamento de passos';

  @override
  String get enableStepTrackingDesc =>
      'Permitir reconhecimento de atividade para contar passos automaticamente';

  @override
  String get enableButton => 'Ativar';

  @override
  String get syncStepsNow => 'Sincronizar passos agora';

  @override
  String get heroTitleDragonLord => 'Senhor Dragão';

  @override
  String get heroTitleMonarch => 'Monarca';

  @override
  String get heroTitleChampion => 'Campeão';

  @override
  String get heroTitleKnight => 'Cavaleiro';

  @override
  String get heroTitleWarrior => 'Guerreiro';

  @override
  String get heroTitleRunner => 'Corredor';

  @override
  String get heroTitleWalker => 'Caminhante';

  @override
  String get levelToday => 'Hoje';

  @override
  String get streakBadgeLegend => 'Lenda';

  @override
  String get streakBadgePro => 'Pro';

  @override
  String get streakBadgeHot => 'Em alta';

  @override
  String get celebrationSteps => 'PASSOS!';
}
