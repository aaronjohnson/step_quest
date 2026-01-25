import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_ca.dart';
import 'app_localizations_da.dart';
import 'app_localizations_de.dart';
import 'app_localizations_en.dart';
import 'app_localizations_es.dart';
import 'app_localizations_fi.dart';
import 'app_localizations_hi.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_khz.dart';
import 'app_localizations_nb.dart';
import 'app_localizations_pt.dart';
import 'app_localizations_sv.dart';
import 'app_localizations_tlh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('ca'),
    Locale('da'),
    Locale('de'),
    Locale('en'),
    Locale('es'),
    Locale('fi'),
    Locale('hi'),
    Locale('ja'),
    Locale('khz'),
    Locale('nb'),
    Locale('pt'),
    Locale('sv'),
    Locale('tlh'),
  ];

  /// The app name
  ///
  /// In en, this message translates to:
  /// **'Step Quest'**
  String get appTitle;

  /// Main app tagline
  ///
  /// In en, this message translates to:
  /// **'Turn your steps into an adventure!'**
  String get appTagline;

  /// Player level display
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String levelLabel(int level);

  /// XP progress display
  ///
  /// In en, this message translates to:
  /// **'{current} / {total} XP'**
  String xpProgress(int current, int total);

  /// Total step count
  ///
  /// In en, this message translates to:
  /// **'{count} steps'**
  String totalSteps(int count);

  /// Today's step count
  ///
  /// In en, this message translates to:
  /// **'Today: {count}'**
  String todaySteps(int count);

  /// Streak card title
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get streakTitle;

  /// Streak day count
  ///
  /// In en, this message translates to:
  /// **'{count} days'**
  String streakDays(int count);

  /// Best streak record
  ///
  /// In en, this message translates to:
  /// **'Record: {count} days'**
  String streakRecord(int count);

  /// Message when no streak
  ///
  /// In en, this message translates to:
  /// **'Start walking to build your streak!'**
  String get streakEmpty;

  /// Log steps card title
  ///
  /// In en, this message translates to:
  /// **'Log Steps'**
  String get logStepsTitle;

  /// Log steps input hint
  ///
  /// In en, this message translates to:
  /// **'Enter steps'**
  String get logStepsHint;

  /// Log steps button
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get logStepsButton;

  /// Quick add button label
  ///
  /// In en, this message translates to:
  /// **'+{count}'**
  String logStepsQuickAdd(int count);

  /// Achievements card title
  ///
  /// In en, this message translates to:
  /// **'Achievements'**
  String get achievementsTitle;

  /// Number of achievements unlocked
  ///
  /// In en, this message translates to:
  /// **'{count} unlocked'**
  String achievementsUnlocked(int count);

  /// Health Connect card title
  ///
  /// In en, this message translates to:
  /// **'Health Connect'**
  String get healthConnectTitle;

  /// Health Connect connected status
  ///
  /// In en, this message translates to:
  /// **'Connected'**
  String get healthConnectConnected;

  /// Health Connect not connected status
  ///
  /// In en, this message translates to:
  /// **'Not Connected'**
  String get healthConnectNotConnected;

  /// Health Connect unavailable status
  ///
  /// In en, this message translates to:
  /// **'Unavailable'**
  String get healthConnectUnavailable;

  /// Health Connect checking status
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get healthConnectChecking;

  /// Message when Health Connect is connected
  ///
  /// In en, this message translates to:
  /// **'Steps sync automatically from Google Fit, Samsung Health, Fitbit, and other Health Connect apps.'**
  String get healthConnectSyncMessage;

  /// Message prompting to connect Health Connect
  ///
  /// In en, this message translates to:
  /// **'Connect to sync steps from Google Fit, Samsung Health, Fitbit, and other fitness apps.'**
  String get healthConnectPrompt;

  /// Message when Health Connect is unavailable
  ///
  /// In en, this message translates to:
  /// **'Health Connect is not available. Use manual step logging.'**
  String get healthConnectUnavailableMessage;

  /// Sync in progress
  ///
  /// In en, this message translates to:
  /// **'Syncing...'**
  String get healthConnectSyncing;

  /// Sync now button
  ///
  /// In en, this message translates to:
  /// **'Sync Now'**
  String get healthConnectSyncNow;

  /// Connect button
  ///
  /// In en, this message translates to:
  /// **'Connect Health'**
  String get healthConnectConnect;

  /// Info toggle text
  ///
  /// In en, this message translates to:
  /// **'How does sync work?'**
  String get healthConnectHowItWorks;

  /// Hide info toggle text
  ///
  /// In en, this message translates to:
  /// **'Hide details'**
  String get healthConnectHideDetails;

  /// Sync path section title
  ///
  /// In en, this message translates to:
  /// **'Sync Path'**
  String get healthConnectSyncPathTitle;

  /// Sync path explanation
  ///
  /// In en, this message translates to:
  /// **'Your fitness app (Samsung Health, Google Fit, Fitbit, etc.) → Health Connect → Step Quest\n\nEnable Health Connect sync in your fitness app\'s settings to share step data.'**
  String get healthConnectSyncPathDescription;

  /// More sensors section title
  ///
  /// In en, this message translates to:
  /// **'Want more sensors?'**
  String get healthConnectMoreSensors;

  /// More sensors explanation
  ///
  /// In en, this message translates to:
  /// **'Heart rate, calories, sleep tracking, and other sensor features can be requested on our GitHub:\ngithub.com/aaronjohnson/step_quest/issues'**
  String get healthConnectMoreSensorsDescription;

  /// Support card title
  ///
  /// In en, this message translates to:
  /// **'Support Step Quest'**
  String get supportTitle;

  /// Supporter badge text
  ///
  /// In en, this message translates to:
  /// **'Supporter'**
  String get supporterBadge;

  /// Thank you message for supporters
  ///
  /// In en, this message translates to:
  /// **'Thank you for supporting the quest! Your generosity keeps the fortress running.'**
  String get supportThanks;

  /// Support prompt for non-supporters
  ///
  /// In en, this message translates to:
  /// **'Step Quest is free and open source. Tips help fund development and keep ads away.'**
  String get supportPrompt;

  /// Open tip jar button
  ///
  /// In en, this message translates to:
  /// **'Open Tip Jar'**
  String get supportOpenTipJar;

  /// Hide tip jar button
  ///
  /// In en, this message translates to:
  /// **'Hide Tip Jar'**
  String get supportHideTipJar;

  /// Tip jar coming soon message
  ///
  /// In en, this message translates to:
  /// **'Tip jar coming soon! For now, visit GitHub Sponsors.'**
  String get supportTipComing;

  /// Source code link
  ///
  /// In en, this message translates to:
  /// **'View Source Code'**
  String get supportSourceCode;

  /// GitHub Sponsors link
  ///
  /// In en, this message translates to:
  /// **'GitHub Sponsors'**
  String get supportGitHubSponsors;

  /// Patreon link
  ///
  /// In en, this message translates to:
  /// **'Patreon'**
  String get supportPatreon;

  /// Coffee tier name (~$2)
  ///
  /// In en, this message translates to:
  /// **'Buy a Coffee'**
  String get tipCoffee;

  /// Coffee tier description
  ///
  /// In en, this message translates to:
  /// **'Fuel for the journey'**
  String get tipCoffeeDesc;

  /// Guild Member tier name (~$3)
  ///
  /// In en, this message translates to:
  /// **'Join the Guild'**
  String get tipGuild;

  /// Guild Member tier description
  ///
  /// In en, this message translates to:
  /// **'Stand with fellow adventurers'**
  String get tipGuildDesc;

  /// Dragon Slayer tier name (~$7)
  ///
  /// In en, this message translates to:
  /// **'Dragon Slayer'**
  String get tipDragon;

  /// Dragon Slayer tier description
  ///
  /// In en, this message translates to:
  /// **'A hero of legendary generosity'**
  String get tipDragonDesc;

  /// Thank you message after successful purchase
  ///
  /// In en, this message translates to:
  /// **'Thank you for your support!'**
  String get supportThankYou;

  /// Generic error message for purchases
  ///
  /// In en, this message translates to:
  /// **'Something went wrong. Please try again.'**
  String get supportError;

  /// Message when Play Store is unavailable
  ///
  /// In en, this message translates to:
  /// **'Store is not available on this device.'**
  String get supportStoreUnavailable;

  /// Watch home tap hint
  ///
  /// In en, this message translates to:
  /// **'Tap to log steps'**
  String get watchTapToLog;

  /// Steps label on watch
  ///
  /// In en, this message translates to:
  /// **'steps'**
  String get watchStepsLabel;

  /// Watch quick log screen title
  ///
  /// In en, this message translates to:
  /// **'Quick Log'**
  String get watchQuickLogTitle;

  /// Confirmation after logging steps on watch
  ///
  /// In en, this message translates to:
  /// **'Logged {count} steps!'**
  String watchLoggedSteps(int count);

  /// Message when daily goal is met
  ///
  /// In en, this message translates to:
  /// **'Great job! You\'ve hit your goal today!'**
  String get streakGoalMet;

  /// Message prompting user to reach goal
  ///
  /// In en, this message translates to:
  /// **'Hit 10,000 steps to continue your streak!'**
  String get streakGoalPrompt;

  /// Streak display with day count
  ///
  /// In en, this message translates to:
  /// **'{count} Day Streak'**
  String streakDayStreak(int count);

  /// Log steps card title
  ///
  /// In en, this message translates to:
  /// **'Log Today\'s Steps'**
  String get logTodayTitle;

  /// Today's progress display
  ///
  /// In en, this message translates to:
  /// **'Today: {current} / {goal}'**
  String logTodayProgress(String current, String goal);

  /// Steps remaining to goal
  ///
  /// In en, this message translates to:
  /// **'{count} to go'**
  String logStepsToGo(String count);

  /// Hint text for step input
  ///
  /// In en, this message translates to:
  /// **'Enter steps...'**
  String get logEnterSteps;

  /// Add button text
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get logAddButton;

  /// Auto-save confirmation text
  ///
  /// In en, this message translates to:
  /// **'Progress auto-saved'**
  String get logAutoSaved;

  /// Label for total steps in level card
  ///
  /// In en, this message translates to:
  /// **'Total Steps'**
  String get levelTotalSteps;

  /// Achievements header with progress
  ///
  /// In en, this message translates to:
  /// **'Achievements ({unlocked}/{total})'**
  String achievementsProgress(int unlocked, int total);

  /// Achievement unlocked status
  ///
  /// In en, this message translates to:
  /// **'Unlocked!'**
  String get achievementUnlocked;

  /// Achievement locked status
  ///
  /// In en, this message translates to:
  /// **'Locked'**
  String get achievementLocked;

  /// Generic close button
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get closeButton;

  /// Watch quick log title
  ///
  /// In en, this message translates to:
  /// **'Add Steps'**
  String get watchAddSteps;

  /// Watch back button
  ///
  /// In en, this message translates to:
  /// **'← Back'**
  String get watchBack;

  /// Confirmation after logging steps
  ///
  /// In en, this message translates to:
  /// **'steps added!'**
  String get watchStepsAdded;

  /// Short level display for ambient mode
  ///
  /// In en, this message translates to:
  /// **'Lv {level}'**
  String watchLevelShort(int level);

  /// Easter egg unlock dialog title
  ///
  /// In en, this message translates to:
  /// **'Secret Language Unlocked!'**
  String get easterEggUnlocked;

  /// Description when unlocking via tap
  ///
  /// In en, this message translates to:
  /// **'You tapped the ancient runes and awoke the mountain spirits!'**
  String get easterEggTapDescription;

  /// Description when unlocking via Konami code
  ///
  /// In en, this message translates to:
  /// **'The sacred sequence has been entered. Qapla\'!'**
  String get easterEggKonamiDescription;

  /// Hint about language button
  ///
  /// In en, this message translates to:
  /// **'Tap the language button to switch.'**
  String get easterEggTapLanguageHint;

  /// Button to try the new language
  ///
  /// In en, this message translates to:
  /// **'Try It Now'**
  String get easterEggTryNow;

  /// Button to dismiss
  ///
  /// In en, this message translates to:
  /// **'Later'**
  String get easterEggLater;

  /// Language selector title
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get languageTitle;

  /// Section header for unlocked secret languages
  ///
  /// In en, this message translates to:
  /// **'Secret Languages'**
  String get languageSecretSection;

  /// Live step tracking label
  ///
  /// In en, this message translates to:
  /// **'LIVE TRACKING'**
  String get liveTracking;

  /// Session step count label
  ///
  /// In en, this message translates to:
  /// **'steps this session'**
  String get stepsThisSession;

  /// Pedometer starting message
  ///
  /// In en, this message translates to:
  /// **'Starting...'**
  String get liveStarting;

  /// Error when pedometer not available
  ///
  /// In en, this message translates to:
  /// **'Pedometer unavailable'**
  String get pedometerUnavailable;

  /// Permission request title
  ///
  /// In en, this message translates to:
  /// **'Enable Step Tracking'**
  String get enableStepTracking;

  /// Permission request description
  ///
  /// In en, this message translates to:
  /// **'Allow activity recognition to count steps automatically'**
  String get enableStepTrackingDesc;

  /// Enable button text
  ///
  /// In en, this message translates to:
  /// **'Enable'**
  String get enableButton;

  /// Sync button tooltip
  ///
  /// In en, this message translates to:
  /// **'Sync steps now'**
  String get syncStepsNow;

  /// Hero title for level 50+
  ///
  /// In en, this message translates to:
  /// **'Dragon Lord'**
  String get heroTitleDragonLord;

  /// Hero title for level 40+
  ///
  /// In en, this message translates to:
  /// **'Monarch'**
  String get heroTitleMonarch;

  /// Hero title for level 30+
  ///
  /// In en, this message translates to:
  /// **'Champion'**
  String get heroTitleChampion;

  /// Hero title for level 20+
  ///
  /// In en, this message translates to:
  /// **'Knight'**
  String get heroTitleKnight;

  /// Hero title for level 10+
  ///
  /// In en, this message translates to:
  /// **'Warrior'**
  String get heroTitleWarrior;

  /// Hero title for level 5+
  ///
  /// In en, this message translates to:
  /// **'Runner'**
  String get heroTitleRunner;

  /// Hero title for level 1+
  ///
  /// In en, this message translates to:
  /// **'Walker'**
  String get heroTitleWalker;

  /// Today label in level card
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get levelToday;

  /// Streak badge for 30+ days
  ///
  /// In en, this message translates to:
  /// **'Legend'**
  String get streakBadgeLegend;

  /// Streak badge for 14+ days
  ///
  /// In en, this message translates to:
  /// **'Pro'**
  String get streakBadgePro;

  /// Streak badge for 7+ days
  ///
  /// In en, this message translates to:
  /// **'Hot'**
  String get streakBadgeHot;

  /// Celebration overlay text
  ///
  /// In en, this message translates to:
  /// **'STEPS!'**
  String get celebrationSteps;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>[
    'ca',
    'da',
    'de',
    'en',
    'es',
    'fi',
    'hi',
    'ja',
    'khz',
    'nb',
    'pt',
    'sv',
    'tlh',
  ].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'ca':
      return AppLocalizationsCa();
    case 'da':
      return AppLocalizationsDa();
    case 'de':
      return AppLocalizationsDe();
    case 'en':
      return AppLocalizationsEn();
    case 'es':
      return AppLocalizationsEs();
    case 'fi':
      return AppLocalizationsFi();
    case 'hi':
      return AppLocalizationsHi();
    case 'ja':
      return AppLocalizationsJa();
    case 'khz':
      return AppLocalizationsKhz();
    case 'nb':
      return AppLocalizationsNb();
    case 'pt':
      return AppLocalizationsPt();
    case 'sv':
      return AppLocalizationsSv();
    case 'tlh':
      return AppLocalizationsTlh();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
