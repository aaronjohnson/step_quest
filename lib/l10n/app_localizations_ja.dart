// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Japanese (`ja`).
class AppLocalizationsJa extends AppLocalizations {
  AppLocalizationsJa([String locale = 'ja']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => '歩数を冒険に変えよう！';

  @override
  String levelLabel(int level) {
    return 'レベル $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count 歩';
  }

  @override
  String todaySteps(int count) {
    return '今日: $count';
  }

  @override
  String get streakTitle => '連続記録';

  @override
  String streakDays(int count) {
    return '$count 日';
  }

  @override
  String streakRecord(int count) {
    return '記録: $count 日';
  }

  @override
  String get streakEmpty => '歩いて連続記録を作ろう！';

  @override
  String get logStepsTitle => '歩数を記録';

  @override
  String get logStepsHint => '歩数を入力';

  @override
  String get logStepsButton => '記録';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => '実績';

  @override
  String achievementsUnlocked(int count) {
    return '$count 件達成';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => '接続済み';

  @override
  String get healthConnectNotConnected => '未接続';

  @override
  String get healthConnectUnavailable => '利用不可';

  @override
  String get healthConnectChecking => '確認中...';

  @override
  String get healthConnectSyncMessage =>
      'Google Fit、Samsung Health、Fitbit、その他のHealth Connectアプリから歩数が自動同期されます。';

  @override
  String get healthConnectPrompt =>
      '接続してGoogle Fit、Samsung Health、Fitbitなどのフィットネスアプリから歩数を同期しましょう。';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connectは利用できません。手動で歩数を入力してください。';

  @override
  String get healthConnectSyncing => '同期中...';

  @override
  String get healthConnectSyncNow => '今すぐ同期';

  @override
  String get healthConnectConnect => 'Healthに接続';

  @override
  String get healthConnectHowItWorks => '同期の仕組みは？';

  @override
  String get healthConnectHideDetails => '詳細を隠す';

  @override
  String get healthConnectSyncPathTitle => '同期パス';

  @override
  String get healthConnectSyncPathDescription =>
      'フィットネスアプリ (Samsung Health、Google Fit、Fitbitなど) → Health Connect → Step Quest\n\nフィットネスアプリの設定でHealth Connect同期を有効にしてください。';

  @override
  String get healthConnectMoreSensors => 'もっとセンサーが欲しい？';

  @override
  String get healthConnectMoreSensorsDescription =>
      '心拍数、カロリー、睡眠トラッキングなどのセンサー機能はGitHubでリクエストできます:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Step Questを応援';

  @override
  String get supporterBadge => 'サポーター';

  @override
  String get supportThanks => '応援ありがとうございます！あなたの支援が開発を支えています。';

  @override
  String get supportPrompt =>
      'Step Questは無料でオープンソースです。チップは開発費に充てられ、広告なしを維持します。';

  @override
  String get supportOpenTipJar => 'チップを送る';

  @override
  String get supportHideTipJar => '閉じる';

  @override
  String get supportTipComing => 'チップ機能は近日公開！今はGitHub Sponsorsをご利用ください。';

  @override
  String get supportSourceCode => 'ソースコードを見る';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'コーヒーをおごる';

  @override
  String get tipCoffeeDesc => 'ちょっとしたお礼！';

  @override
  String get tipSupporter => 'クエストを応援';

  @override
  String get tipSupporterDesc => '開発の継続を支援';

  @override
  String get tipLegendary => '伝説のパトロン';

  @override
  String get tipLegendaryDesc => 'あなたは伝説です！';

  @override
  String get supportThankYou => 'Thank you for your support!';

  @override
  String get supportError => 'Something went wrong. Please try again.';

  @override
  String get supportStoreUnavailable =>
      'Store is not available on this device.';

  @override
  String get watchTapToLog => 'タップして記録';

  @override
  String get watchStepsLabel => '歩';

  @override
  String get watchQuickLogTitle => 'クイック記録';

  @override
  String watchLoggedSteps(int count) {
    return '$count 歩を記録しました！';
  }

  @override
  String get streakGoalMet => '素晴らしい！今日の目標を達成しました！';

  @override
  String get streakGoalPrompt => '連続記録を続けるために10,000歩を達成しよう！';

  @override
  String streakDayStreak(int count) {
    return '$count日連続';
  }

  @override
  String get logTodayTitle => '今日の歩数を記録';

  @override
  String logTodayProgress(String current, String goal) {
    return '今日: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return 'あと$count';
  }

  @override
  String get logEnterSteps => '歩数を入力...';

  @override
  String get logAddButton => '追加';

  @override
  String get logAutoSaved => '自動保存されました';

  @override
  String get levelTotalSteps => '総歩数';

  @override
  String achievementsProgress(int unlocked, int total) {
    return '実績 ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => '達成！';

  @override
  String get achievementLocked => '未達成';

  @override
  String get closeButton => '閉じる';

  @override
  String get watchAddSteps => '歩数を追加';

  @override
  String get watchBack => '← 戻る';

  @override
  String get watchStepsAdded => '歩追加しました！';

  @override
  String watchLevelShort(int level) {
    return 'Lv $level';
  }

  @override
  String get easterEggUnlocked => '秘密の言語がアンロック！';

  @override
  String get easterEggTapDescription => '古代のルーンに触れ、山の精霊を目覚めさせた！';

  @override
  String get easterEggKonamiDescription => '聖なるシーケンスが入力されました。Qapla\'!';

  @override
  String get easterEggTapLanguageHint => '言語ボタンをタップして切り替えましょう。';

  @override
  String get easterEggTryNow => '今すぐ試す';

  @override
  String get easterEggLater => '後で';

  @override
  String get languageTitle => '言語';

  @override
  String get languageSecretSection => '秘密の言語';

  @override
  String get liveTracking => 'ライブトラッキング';

  @override
  String get stepsThisSession => 'このセッションの歩数';

  @override
  String get liveStarting => '開始中...';

  @override
  String get pedometerUnavailable => '歩数計が利用できません';

  @override
  String get enableStepTracking => '歩数トラッキングを有効化';

  @override
  String get enableStepTrackingDesc => '歩数を自動カウントするため、活動認識を許可してください';

  @override
  String get enableButton => '有効化';

  @override
  String get syncStepsNow => '今すぐ歩数を同期';

  @override
  String get heroTitleDragonLord => '竜王';

  @override
  String get heroTitleMonarch => '君主';

  @override
  String get heroTitleChampion => '王者';

  @override
  String get heroTitleKnight => '騎士';

  @override
  String get heroTitleWarrior => '戦士';

  @override
  String get heroTitleRunner => '走者';

  @override
  String get heroTitleWalker => '歩行者';

  @override
  String get levelToday => '今日';

  @override
  String get streakBadgeLegend => '伝説';

  @override
  String get streakBadgePro => 'プロ';

  @override
  String get streakBadgeHot => '好調';

  @override
  String get celebrationSteps => '歩!';
}
