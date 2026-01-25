// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Finnish (`fi`).
class AppLocalizationsFi extends AppLocalizations {
  AppLocalizationsFi([String locale = 'fi']) : super(locale);

  @override
  String get appTitle => 'Step Quest';

  @override
  String get appTagline => 'Muuta askeleesi seikkailuksi!';

  @override
  String levelLabel(int level) {
    return 'Taso $level';
  }

  @override
  String xpProgress(int current, int total) {
    return '$current / $total XP';
  }

  @override
  String totalSteps(int count) {
    return '$count askelta';
  }

  @override
  String todaySteps(int count) {
    return 'Tänään: $count';
  }

  @override
  String get streakTitle => 'Putki';

  @override
  String streakDays(int count) {
    return '$count päivää';
  }

  @override
  String streakRecord(int count) {
    return 'Ennätys: $count päivää';
  }

  @override
  String get streakEmpty => 'Aloita kävely ja rakenna putkesi!';

  @override
  String get logStepsTitle => 'Kirjaa askeleet';

  @override
  String get logStepsHint => 'Syötä askeleet';

  @override
  String get logStepsButton => 'Kirjaa';

  @override
  String logStepsQuickAdd(int count) {
    return '+$count';
  }

  @override
  String get achievementsTitle => 'Saavutukset';

  @override
  String achievementsUnlocked(int count) {
    return '$count avattu';
  }

  @override
  String get healthConnectTitle => 'Health Connect';

  @override
  String get healthConnectConnected => 'Yhdistetty';

  @override
  String get healthConnectNotConnected => 'Ei yhdistetty';

  @override
  String get healthConnectUnavailable => 'Ei saatavilla';

  @override
  String get healthConnectChecking => 'Tarkistetaan...';

  @override
  String get healthConnectSyncMessage =>
      'Askeleet synkronoidaan automaattisesti Google Fitistä, Samsung Healthista, Fitbitistä ja muista Health Connect -sovelluksista.';

  @override
  String get healthConnectPrompt =>
      'Yhdistä synkronoidaksesi askeleet Google Fitistä, Samsung Healthista, Fitbitistä ja muista kuntoilusovelluksista.';

  @override
  String get healthConnectUnavailableMessage =>
      'Health Connect ei ole saatavilla. Käytä manuaalista askelten kirjausta.';

  @override
  String get healthConnectSyncing => 'Synkronoidaan...';

  @override
  String get healthConnectSyncNow => 'Synkronoi nyt';

  @override
  String get healthConnectConnect => 'Yhdistä Health';

  @override
  String get healthConnectHowItWorks => 'Miten synkronointi toimii?';

  @override
  String get healthConnectHideDetails => 'Piilota tiedot';

  @override
  String get healthConnectSyncPathTitle => 'Synkronointipolku';

  @override
  String get healthConnectSyncPathDescription =>
      'Kuntoilusovelluksesi (Samsung Health, Google Fit, Fitbit jne.) → Health Connect → Step Quest\n\nOta Health Connect -synkronointi käyttöön kuntoilusovelluksesi asetuksissa.';

  @override
  String get healthConnectMoreSensors => 'Haluatko lisää sensoreita?';

  @override
  String get healthConnectMoreSensorsDescription =>
      'Sykettä, kaloreita, unenseurantaa ja muita sensoriominaisuuksia voi pyytää GitHubissa:\ngithub.com/aaronjohnson/step_quest/issues';

  @override
  String get supportTitle => 'Tue Step Questia';

  @override
  String get supporterBadge => 'Tukija';

  @override
  String get supportThanks =>
      'Kiitos tuestasi! Anteliaisuutesi pitää linnoituksen pystyssä.';

  @override
  String get supportPrompt =>
      'Step Quest on ilmainen ja avoimen lähdekoodin. Tipit auttavat kehityksessä ja pitävät mainokset poissa.';

  @override
  String get supportOpenTipJar => 'Avaa tippipurkki';

  @override
  String get supportHideTipJar => 'Piilota tippipurkki';

  @override
  String get supportTipComing =>
      'Tippipurkki tulossa pian! Käy GitHub Sponsorsissa sillä välin.';

  @override
  String get supportSourceCode => 'Näytä lähdekoodi';

  @override
  String get supportGitHubSponsors => 'GitHub Sponsors';

  @override
  String get supportPatreon => 'Patreon';

  @override
  String get tipCoffee => 'Osta kahvi';

  @override
  String get tipCoffeeDesc => 'Polttoainetta matkalle';

  @override
  String get tipGuild => 'Liity kiltaan';

  @override
  String get tipGuildDesc => 'Seiso muiden seikkailijoiden rinnalla';

  @override
  String get tipDragon => 'Lohikäärmeen tappaja';

  @override
  String get tipDragonDesc => 'Legendaarisen anteliaisuuden sankari';

  @override
  String get supportThankYou => 'Kiitos tuestasi!';

  @override
  String get supportError => 'Jokin meni pieleen. Yritä uudelleen.';

  @override
  String get supportStoreUnavailable =>
      'Kauppa ei ole saatavilla tällä laitteella.';

  @override
  String get watchTapToLog => 'Napauta kirjataksesi askeleet';

  @override
  String get watchStepsLabel => 'askelta';

  @override
  String get watchQuickLogTitle => 'Pikakirjaus';

  @override
  String watchLoggedSteps(int count) {
    return 'Kirjattiin $count askelta!';
  }

  @override
  String get streakGoalMet => 'Hienoa! Olet saavuttanut tavoitteesi tänään!';

  @override
  String get streakGoalPrompt => 'Saavuta 10 000 askelta jatkaaksesi putkea!';

  @override
  String streakDayStreak(int count) {
    return '$count päivän putki';
  }

  @override
  String get logTodayTitle => 'Kirjaa päivän askeleet';

  @override
  String logTodayProgress(String current, String goal) {
    return 'Tänään: $current / $goal';
  }

  @override
  String logStepsToGo(String count) {
    return '$count jäljellä';
  }

  @override
  String get logEnterSteps => 'Syötä askeleet...';

  @override
  String get logAddButton => 'Lisää';

  @override
  String get logAutoSaved => 'Edistyminen tallennettu automaattisesti';

  @override
  String get levelTotalSteps => 'Askeleet yhteensä';

  @override
  String achievementsProgress(int unlocked, int total) {
    return 'Saavutukset ($unlocked/$total)';
  }

  @override
  String get achievementUnlocked => 'Avattu!';

  @override
  String get achievementLocked => 'Lukittu';

  @override
  String get closeButton => 'Sulje';

  @override
  String get watchAddSteps => 'Lisää askeleita';

  @override
  String get watchBack => '← Takaisin';

  @override
  String get watchStepsAdded => 'askelta lisätty!';

  @override
  String watchLevelShort(int level) {
    return 'Taso $level';
  }

  @override
  String get easterEggUnlocked => 'Salainen kieli avattu!';

  @override
  String get easterEggTapDescription =>
      'Napautit muinaisia riimuja ja herätit vuorihenget!';

  @override
  String get easterEggKonamiDescription =>
      'Pyhä sekvenssi on syötetty. Qapla\'!';

  @override
  String get easterEggTapLanguageHint => 'Napauta kielinappia vaihtaaksesi.';

  @override
  String get easterEggTryNow => 'Kokeile nyt';

  @override
  String get easterEggLater => 'Myöhemmin';

  @override
  String get languageTitle => 'Kieli';

  @override
  String get languageSecretSection => 'Salaiset kielet';

  @override
  String get liveTracking => 'LIVE SEURANTA';

  @override
  String get stepsThisSession => 'askelta tässä sessiossa';

  @override
  String get liveStarting => 'Käynnistyy...';

  @override
  String get pedometerUnavailable => 'Askelmittari ei saatavilla';

  @override
  String get enableStepTracking => 'Ota askelseuranta käyttöön';

  @override
  String get enableStepTrackingDesc =>
      'Salli aktiviteetin tunnistus laskeaksesi askeleita automaattisesti';

  @override
  String get enableButton => 'Ota käyttöön';

  @override
  String get syncStepsNow => 'Synkronoi askeleet nyt';

  @override
  String get heroTitleDragonLord => 'Lohikäärmelordi';

  @override
  String get heroTitleMonarch => 'Hallitsija';

  @override
  String get heroTitleChampion => 'Mestari';

  @override
  String get heroTitleKnight => 'Ritari';

  @override
  String get heroTitleWarrior => 'Soturi';

  @override
  String get heroTitleRunner => 'Juoksija';

  @override
  String get heroTitleWalker => 'Kulkija';

  @override
  String get levelToday => 'Tänään';

  @override
  String get streakBadgeLegend => 'Legenda';

  @override
  String get streakBadgePro => 'Pro';

  @override
  String get streakBadgeHot => 'Kuuma';

  @override
  String get celebrationSteps => 'ASKELTA!';
}
