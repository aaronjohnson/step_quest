// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Hindi (`hi`).
class AppLocalizationsHi extends AppLocalizations {
  AppLocalizationsHi([String locale = 'hi']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'अपने कदमों को एक साहसिक यात्रा में बदलें!';

  @override
  String levelLabel(int level) {
    return 'लेवल $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count कदम';
  }

  @override
  String todaySteps(int count) {
    return 'आज: $count';
  }

  @override
  String get streakTitle => 'लगातार दिन';

  @override
  String streakDays(int count) {
    return '$count दिन';
  }

  @override
  String streakRecord(int count) {
    return 'रिकॉर्ड: $count दिन';
  }

  @override
  String get streakEmpty => 'चलना शुरू करें और अपनी स्ट्रीक बनाएं!';

  @override
  String get logStepsTitle => 'कदम दर्ज करें';

  @override
  String get logStepsHint => 'कदम दर्ज करें';

  @override
  String get logStepsButton => 'दर्ज करें';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'उपलब्धियां';

  @override
  String achievementsUnlocked(int count) {
    return '$count अनलॉक';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'कनेक्टेड';

  @override
  String get healthConnectNotConnected => 'कनेक्ट नहीं';

  @override
  String get healthConnectUnavailable => 'उपलब्ध नहीं';

  @override
  String get healthConnectChecking => 'जांच रहा है...';

  @override
  String get healthConnectSyncMessage =>
      'Google Fit, Samsung Health, Fitbit और अन्य Health Connect ऐप्स से कदम अपने आप सिंक होते हैं।';

  @override
  String get healthConnectPrompt =>
      'Google Fit, Samsung Health, Fitbit और अन्य फिटनेस ऐप्स से कदम सिंक करने के लिए कनेक्ट करें।';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect उपलब्ध नहीं है। मैन्युअल कदम दर्ज करें।';

  @override
  String get healthConnectSyncing => 'सिंक हो रहा है...';

  @override
  String get healthConnectSyncNow => 'अभी सिंक करें';

  @override
  String get healthConnectConnect => 'Health कनेक्ट करें';

  @override
  String get healthConnectHowItWorks => 'सिंक कैसे काम करता है?';

  @override
  String get healthConnectHideDetails => 'विवरण छुपाएं';

  @override
  String get healthConnectSyncPathTitle => 'सिंक पथ';

  @override
  String get healthConnectSyncPathDescription =>
      'आपका फिटनेस ऐप (Samsung Health, Google Fit, Fitbit, आदि) → Health Connect → Step Quest\n\nअपने फिटनेस ऐप की सेटिंग्स में Health Connect सिंक सक्षम करें।';

  @override
  String get healthConnectMoreSensors => 'और सेंसर चाहिए?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'हृदय गति, कैलोरी, नींद ट्रैकिंग और अन्य सेंसर सुविधाओं के लिए GitHub पर अनुरोध करें:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Step Quest का समर्थन करें';

  @override
  String get supporterBadge => 'समर्थक';

  @override
  String get supportThanks =>
      'समर्थन के लिए धन्यवाद! आपकी उदारता इस किले को चालू रखती है।';

  @override
  String get supportPrompt =>
      'Step Quest मुफ्त और ओपन सोर्स है। टिप्स विकास में मदद करती हैं और विज्ञापनों को दूर रखती हैं।';

  @override
  String get supportOpenTipJar => 'टिप जार खोलें';

  @override
  String get supportHideTipJar => 'टिप जार छुपाएं';

  @override
  String get supportTipComing =>
      'टिप जार जल्द आ रहा है! अभी के लिए GitHub Sponsors देखें।';

  @override
  String get supportSourceCode => 'सोर्स कोड देखें';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'कॉफी पिलाएं';

  @override
  String get tipCoffeeDesc => 'एक छोटा धन्यवाद!';

  @override
  String get tipSupporter => 'क्वेस्ट का समर्थन करें';

  @override
  String get tipSupporterDesc => 'विकास जारी रखने में मदद करें';

  @override
  String get tipLegendary => 'महान संरक्षक';

  @override
  String get tipLegendaryDesc => 'आप एक महान हैं!';

  @override
  String get watchTapToLog => 'दर्ज करने के लिए टैप करें';

  @override
  String get watchStepsLabel => 'कदम';

  @override
  String get watchQuickLogTitle => 'त्वरित दर्ज';

  @override
  String watchLoggedSteps(int count) {
    return '$count कदम दर्ज हुए!';
  }
}
