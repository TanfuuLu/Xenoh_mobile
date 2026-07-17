import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

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

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
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
    Locale('en'),
    Locale('vi'),
  ];

  /// Generic cancel button label
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get commonCancel;

  /// Generic save button label
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get commonSave;

  /// Generic delete button label
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get commonDelete;

  /// Generic retry button label
  ///
  /// In en, this message translates to:
  /// **'Retry'**
  String get commonRetry;

  /// Generic remove button label
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get commonRemove;

  /// Tooltip for the chat composer's attach-file button
  ///
  /// In en, this message translates to:
  /// **'Attach'**
  String get commonAttachTooltip;

  /// Tooltip for the chat composer's emoji-picker button
  ///
  /// In en, this message translates to:
  /// **'Emoji'**
  String get commonEmojiTooltip;

  /// Generic loading state label
  ///
  /// In en, this message translates to:
  /// **'Loading'**
  String get commonLoading;

  /// Generic error card title when a request fails
  ///
  /// In en, this message translates to:
  /// **'Request failed'**
  String get commonRequestFailed;

  /// Confirmation dialog title before deleting a comment
  ///
  /// In en, this message translates to:
  /// **'Delete comment?'**
  String get commonDeleteCommentTitle;

  /// Confirmation dialog message before deleting a comment
  ///
  /// In en, this message translates to:
  /// **'This comment will be removed for everyone.'**
  String get commonDeleteCommentMessage;

  /// CTA button label to upgrade to a Pro subscription
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro'**
  String get commonUpgradeToPro;

  /// Generic fallback error message
  ///
  /// In en, this message translates to:
  /// **'Something went wrong.'**
  String get commonSomethingWentWrong;

  /// Error message for a 403 Forbidden API response
  ///
  /// In en, this message translates to:
  /// **'You do not have permission or the required subscription.'**
  String get commonForbiddenError;

  /// Error message for a 429 Too Many Requests API response
  ///
  /// In en, this message translates to:
  /// **'Too many requests. Please wait and try again.'**
  String get commonTooManyRequestsError;

  /// Generic back button label
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get commonBack;

  /// Generic validator message for a required field
  ///
  /// In en, this message translates to:
  /// **'Required'**
  String get commonRequiredError;

  /// Generic validator message when a field expects a number
  ///
  /// In en, this message translates to:
  /// **'Enter a number'**
  String get commonEnterNumberError;

  /// Generic reset button/tooltip label
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get commonReset;

  /// No description provided for @commonSaveChanges.
  ///
  /// In en, this message translates to:
  /// **'Save changes'**
  String get commonSaveChanges;

  /// No description provided for @commonEdit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get commonEdit;

  /// No description provided for @commonDuplicate.
  ///
  /// In en, this message translates to:
  /// **'Duplicate'**
  String get commonDuplicate;

  /// No description provided for @commonActivate.
  ///
  /// In en, this message translates to:
  /// **'Activate'**
  String get commonActivate;

  /// No description provided for @commonDeactivate.
  ///
  /// In en, this message translates to:
  /// **'Deactivate'**
  String get commonDeactivate;

  /// No description provided for @commonAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get commonAnalytics;

  /// No description provided for @commonComments.
  ///
  /// In en, this message translates to:
  /// **'Comments'**
  String get commonComments;

  /// No description provided for @commonAll.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get commonAll;

  /// No description provided for @commonDone.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get commonDone;

  /// No description provided for @commonRest.
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get commonRest;

  /// No description provided for @commonMissed.
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get commonMissed;

  /// No description provided for @commonToday.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get commonToday;

  /// No description provided for @commonProgress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get commonProgress;

  /// No description provided for @commonWarnings.
  ///
  /// In en, this message translates to:
  /// **'Warnings'**
  String get commonWarnings;

  /// Info severity label for an insight/alert
  ///
  /// In en, this message translates to:
  /// **'Info'**
  String get commonSeverityInfo;

  /// Warning severity label for an insight/alert
  ///
  /// In en, this message translates to:
  /// **'Warning'**
  String get commonSeverityWarning;

  /// Critical severity label for an insight/alert
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get commonSeverityCritical;

  /// Success/positive severity label for an insight/alert
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get commonSeveritySuccess;

  /// No description provided for @commonSuggestions.
  ///
  /// In en, this message translates to:
  /// **'Suggestions'**
  String get commonSuggestions;

  /// No description provided for @commonAdd.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get commonAdd;

  /// No description provided for @commonClose.
  ///
  /// In en, this message translates to:
  /// **'Close'**
  String get commonClose;

  /// Generic submit button label
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get commonSubmit;

  /// Generic read status label
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get commonRead;

  /// Generic unread status label
  ///
  /// In en, this message translates to:
  /// **'Unread'**
  String get commonUnread;

  /// Combined settings screen title, also used as the profile app bar tooltip
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settingsTitle;

  /// Settings screen hero subtitle
  ///
  /// In en, this message translates to:
  /// **'Preferences, account, and support — all in one place. Changes save automatically.'**
  String get settingsSubtitle;

  /// Preferences section header on the settings screen
  ///
  /// In en, this message translates to:
  /// **'Preferences'**
  String get profilePreferencesTitle;

  /// Label for the language preference field
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get profilePreferencesLanguageLabel;

  /// English language option
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get profilePreferencesLanguageEnglish;

  /// Vietnamese language option
  ///
  /// In en, this message translates to:
  /// **'Vietnamese'**
  String get profilePreferencesLanguageVietnamese;

  /// Label for the theme preference field
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get profilePreferencesThemeLabel;

  /// System theme option
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get profilePreferencesThemeSystem;

  /// Light theme option
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get profilePreferencesThemeLight;

  /// Label for the weight unit preference field
  ///
  /// In en, this message translates to:
  /// **'Weight unit'**
  String get profilePreferencesWeightUnitLabel;

  /// Kilograms weight unit option
  ///
  /// In en, this message translates to:
  /// **'Kilograms'**
  String get profilePreferencesWeightUnitKilograms;

  /// Pounds weight unit option
  ///
  /// In en, this message translates to:
  /// **'Pounds'**
  String get profilePreferencesWeightUnitPounds;

  /// Snackbar shown after preferences save successfully
  ///
  /// In en, this message translates to:
  /// **'Preferences saved.'**
  String get profilePreferencesSavedSnackbar;

  /// Snackbar shown after the profile background image is changed
  ///
  /// In en, this message translates to:
  /// **'Background updated.'**
  String get profilePreferencesBackgroundUpdated;

  /// Title of the screen for repositioning a background photo
  ///
  /// In en, this message translates to:
  /// **'Position your photo'**
  String get profileBackgroundPositionTitle;

  /// Instructions on the background photo position screen
  ///
  /// In en, this message translates to:
  /// **'Drag the photo to choose what shows on your cards.'**
  String get profileBackgroundPositionSubtitle;

  /// Dialog title for logging a bodyweight entry
  ///
  /// In en, this message translates to:
  /// **'Log bodyweight'**
  String get profileLogBodyweightTitle;

  /// Eyebrow label for the bodyweight card
  ///
  /// In en, this message translates to:
  /// **'BODYWEIGHT'**
  String get profileBodyweightEyebrow;

  /// Empty label when no bodyweight entries exist
  ///
  /// In en, this message translates to:
  /// **'No entries yet'**
  String get profileBodyweightNoEntries;

  /// Error shown when bodyweight history fails to load
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load history.'**
  String get profileBodyweightHistoryError;

  /// Prompt shown in the bodyweight card before a first log
  ///
  /// In en, this message translates to:
  /// **'Log your weight to start tracking a trend.'**
  String get profileBodyweightTrendPrompt;

  /// Button label for opening the bodyweight log dialog
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get profileBodyweightLogCta;

  /// Label for generic weight input fields
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get profileWeightLabel;

  /// Validation error for an entered weight outside a min/max range
  ///
  /// In en, this message translates to:
  /// **'Must be {min}-{max} {unit}'**
  String profileWeightRangeWithUnitError(String min, String max, String unit);

  /// Account section header on the settings screen
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get profileAccountTitle;

  /// Account menu item to return to profile
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profileAccountProfile;

  /// Account menu item for password change
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get profileAccountChangePassword;

  /// Account menu item for blocked users
  ///
  /// In en, this message translates to:
  /// **'Blocklist'**
  String get profileAccountBlocklist;

  /// Account menu item to report a bug
  ///
  /// In en, this message translates to:
  /// **'Report bug'**
  String get profileAccountReportBug;

  /// Account menu item to sign out
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get profileAccountSignOut;

  /// Edit profile screen title
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get profileEditTitle;

  /// Edit profile section header for name and bio
  ///
  /// In en, this message translates to:
  /// **'Basics'**
  String get profileEditBasicsSection;

  /// Edit profile section header for physical and training attributes
  ///
  /// In en, this message translates to:
  /// **'Body & training'**
  String get profileEditPhysicalSection;

  /// Edit profile section header for social media URLs
  ///
  /// In en, this message translates to:
  /// **'Social links'**
  String get profileEditSocialSection;

  /// Snackbar after profile update succeeds
  ///
  /// In en, this message translates to:
  /// **'Profile updated'**
  String get profileUpdatedSnackbar;

  /// Profile bio field label
  ///
  /// In en, this message translates to:
  /// **'Bio'**
  String get profileBioLabel;

  /// Profile bio field hint
  ///
  /// In en, this message translates to:
  /// **'A short line about you'**
  String get profileBioHint;

  /// Profile height field label
  ///
  /// In en, this message translates to:
  /// **'Height (cm)'**
  String get profileHeightLabel;

  /// Profile height field hint
  ///
  /// In en, this message translates to:
  /// **'50-300'**
  String get profileHeightHint;

  /// Validation error for profile height outside the allowed range
  ///
  /// In en, this message translates to:
  /// **'Must be 50-300 cm'**
  String get profileHeightRangeError;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get profileDateOfBirthLabel;

  /// Facebook URL field label
  ///
  /// In en, this message translates to:
  /// **'Facebook URL'**
  String get profileFacebookUrlLabel;

  /// Instagram URL field label
  ///
  /// In en, this message translates to:
  /// **'Instagram URL'**
  String get profileInstagramUrlLabel;

  /// Zalo URL field label
  ///
  /// In en, this message translates to:
  /// **'Zalo URL'**
  String get profileZaloUrlLabel;

  /// Validation error when a social URL is incomplete
  ///
  /// In en, this message translates to:
  /// **'Enter a full URL (https://...)'**
  String get profileFullUrlError;

  /// Button label to pick a date
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get profilePickDateCta;

  /// Tooltip to clear an optional date field
  ///
  /// In en, this message translates to:
  /// **'Clear'**
  String get profileClearDateTooltip;

  /// Snackbar after avatar upload succeeds
  ///
  /// In en, this message translates to:
  /// **'Avatar updated.'**
  String get profileAvatarUpdatedSnackbar;

  /// Action to choose a profile background image
  ///
  /// In en, this message translates to:
  /// **'Choose background image'**
  String get profileChooseBackgroundImage;

  /// Action to reset the profile background image
  ///
  /// In en, this message translates to:
  /// **'Use default background'**
  String get profileUseDefaultBackground;

  /// Snackbar after resetting profile background
  ///
  /// In en, this message translates to:
  /// **'Background reset.'**
  String get profileBackgroundResetSnackbar;

  /// Tooltip for changing profile background
  ///
  /// In en, this message translates to:
  /// **'Change background'**
  String get profileChangeBackgroundTooltip;

  /// Fallback text when profile has no bio
  ///
  /// In en, this message translates to:
  /// **'No bio yet.'**
  String get profileNoBioYet;

  /// Level card eyebrow
  ///
  /// In en, this message translates to:
  /// **'LEVEL'**
  String get profileLevelEyebrow;

  /// XP card eyebrow
  ///
  /// In en, this message translates to:
  /// **'XP'**
  String get profileXpEyebrow;

  /// Profile total trained time label
  ///
  /// In en, this message translates to:
  /// **'TOTAL TRAINED TIME'**
  String get profileTotalTrainedTimeLabel;

  /// Profile total weight label
  ///
  /// In en, this message translates to:
  /// **'TOTAL WEIGHT'**
  String get profileTotalWeightLabel;

  /// Bodyweight history sheet title
  ///
  /// In en, this message translates to:
  /// **'Bodyweight history'**
  String get profileBodyweightHistoryTitle;

  /// Tooltip to delete a bodyweight entry
  ///
  /// In en, this message translates to:
  /// **'Delete entry'**
  String get profileDeleteEntryTooltip;

  /// Profile details height label
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get profileDetailHeight;

  /// Profile details gender label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get profileDetailGender;

  /// Profile details date of birth label
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get profileDetailDateOfBirth;

  /// Profile details development direction label
  ///
  /// In en, this message translates to:
  /// **'Development direction'**
  String get profileDetailDevelopmentDirection;

  /// Profile details training discipline label
  ///
  /// In en, this message translates to:
  /// **'Training discipline'**
  String get profileDetailTrainingDiscipline;

  /// Profile details BMI label
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get profileDetailBmi;

  /// Profile details DOTS score label
  ///
  /// In en, this message translates to:
  /// **'DOTS Score'**
  String get profileDetailDotsScore;

  /// Profile details streak label
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get profileDetailStreak;

  /// Profile streak duration
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 day} other{{count} days}}'**
  String profileStreakDays(int count);

  /// Training calendar card title
  ///
  /// In en, this message translates to:
  /// **'TRAINING CALENDAR'**
  String get profileTrainingCalendarTitle;

  /// Error shown when monthly training activity fails to load
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load activity for this month.'**
  String get profileActivityMonthError;

  /// Change password screen title
  ///
  /// In en, this message translates to:
  /// **'Change password'**
  String get settingsChangePasswordTitle;

  /// Current password input label
  ///
  /// In en, this message translates to:
  /// **'Current password'**
  String get settingsCurrentPasswordLabel;

  /// New password input label
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get settingsNewPasswordLabel;

  /// Save password button label
  ///
  /// In en, this message translates to:
  /// **'Save password'**
  String get settingsSavePasswordCta;

  /// Snackbar shown after changing password successfully
  ///
  /// In en, this message translates to:
  /// **'Password updated.'**
  String get settingsPasswordUpdatedSnackbar;

  /// Blocklist screen title
  ///
  /// In en, this message translates to:
  /// **'Blocklist'**
  String get blocksBlocklistTitle;

  /// Blocklist header title
  ///
  /// In en, this message translates to:
  /// **'Blocked users'**
  String get blocksBlockedUsersTitle;

  /// Blocklist header subtitle
  ///
  /// In en, this message translates to:
  /// **'Unblock users when you want messages and profile access restored.'**
  String get blocksBlockedUsersSubtitle;

  /// Empty blocklist title
  ///
  /// In en, this message translates to:
  /// **'No blocked users'**
  String get blocksNoBlockedUsersTitle;

  /// Empty blocklist message
  ///
  /// In en, this message translates to:
  /// **'People you block appear here.'**
  String get blocksNoBlockedUsersMessage;

  /// Tooltip for unblocking a user
  ///
  /// In en, this message translates to:
  /// **'Unblock'**
  String get blocksUnblockTooltip;

  /// Report bug screen title
  ///
  /// In en, this message translates to:
  /// **'Report a bug'**
  String get reportBugTitle;

  /// Report bug screen subtitle
  ///
  /// In en, this message translates to:
  /// **'Send a reproducible issue to admins with severity and device details.'**
  String get reportBugSubtitle;

  /// Snackbar after a bug report is submitted
  ///
  /// In en, this message translates to:
  /// **'Bug report submitted.'**
  String get reportBugSubmittedSnackbar;

  /// Bug report title field label
  ///
  /// In en, this message translates to:
  /// **'Title'**
  String get reportBugTitleLabel;

  /// Bug report title field hint
  ///
  /// In en, this message translates to:
  /// **'What is broken?'**
  String get reportBugTitleHint;

  /// Validation message when bug report title is missing
  ///
  /// In en, this message translates to:
  /// **'Title is required.'**
  String get reportBugTitleRequiredError;

  /// Bug report severity field label
  ///
  /// In en, this message translates to:
  /// **'Severity'**
  String get reportBugSeverityLabel;

  /// Low bug severity option
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get reportBugSeverityLow;

  /// Medium bug severity option
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get reportBugSeverityMedium;

  /// High bug severity option
  ///
  /// In en, this message translates to:
  /// **'High'**
  String get reportBugSeverityHigh;

  /// Critical bug severity option
  ///
  /// In en, this message translates to:
  /// **'Critical'**
  String get reportBugSeverityCritical;

  /// Bug report affected screen field label
  ///
  /// In en, this message translates to:
  /// **'Screen'**
  String get reportBugScreenLabel;

  /// Bug report affected screen field hint
  ///
  /// In en, this message translates to:
  /// **'/plans, /nutrition, workout day, etc.'**
  String get reportBugScreenHint;

  /// Bug report description field label
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get reportBugDescriptionLabel;

  /// Bug report description field hint
  ///
  /// In en, this message translates to:
  /// **'What happened, what did you expect, and how can it be reproduced?'**
  String get reportBugDescriptionHint;

  /// Validation message when bug report description is missing
  ///
  /// In en, this message translates to:
  /// **'Description is required.'**
  String get reportBugDescriptionRequiredError;

  /// Bug report automatic device details note
  ///
  /// In en, this message translates to:
  /// **'Device details are attached automatically.'**
  String get reportBugDeviceDetailsAttached;

  /// Notifications screen title
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// Tooltip to mark all notifications read
  ///
  /// In en, this message translates to:
  /// **'Mark all read'**
  String get notificationsMarkAllReadTooltip;

  /// Notifications header title
  ///
  /// In en, this message translates to:
  /// **'Notification center'**
  String get notificationsCenterTitle;

  /// Notifications header subtitle
  ///
  /// In en, this message translates to:
  /// **'Realtime events also arrive through the SignalR hub.'**
  String get notificationsCenterSubtitle;

  /// Empty notifications title
  ///
  /// In en, this message translates to:
  /// **'No notifications'**
  String get notificationsEmptyTitle;

  /// Empty notifications message
  ///
  /// In en, this message translates to:
  /// **'Unread relationship, chat, and comment events appear here.'**
  String get notificationsEmptyMessage;

  /// Tooltip to mark one notification read
  ///
  /// In en, this message translates to:
  /// **'Mark read'**
  String get notificationsMarkReadTooltip;

  /// Progress screen title
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progressTitle;

  /// Pro locked title for progress analytics
  ///
  /// In en, this message translates to:
  /// **'Progress is a Pro feature'**
  String get progressProFeatureTitle;

  /// Progress overview tab label
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get progressOverviewTab;

  /// Progress powerlifting tab label
  ///
  /// In en, this message translates to:
  /// **'Powerlifting'**
  String get progressPowerliftingTab;

  /// Tooltip for selecting a plan in progress
  ///
  /// In en, this message translates to:
  /// **'Select plan'**
  String get progressSelectPlanTooltip;

  /// Plan selector eyebrow
  ///
  /// In en, this message translates to:
  /// **'PLAN'**
  String get progressPlanEyebrow;

  /// Active plan status label
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get progressActiveLabel;

  /// Empty progress state title
  ///
  /// In en, this message translates to:
  /// **'No plans yet'**
  String get progressNoPlansTitle;

  /// Empty progress state message
  ///
  /// In en, this message translates to:
  /// **'Create a training plan to track its progress here.'**
  String get progressNoPlansMessage;

  /// Plan analytics screen title
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get progressAnalyticsTitle;

  /// Pro locked title for plan analytics
  ///
  /// In en, this message translates to:
  /// **'Analytics is a Pro feature'**
  String get progressAnalyticsProFeatureTitle;

  /// Plan analytics insights section title
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get progressInsightsTitle;

  /// Plan analytics weekly training chart title
  ///
  /// In en, this message translates to:
  /// **'Weekly training: planned vs completed'**
  String get progressWeeklyTrainingTitle;

  /// Plan analytics weekly volume chart title
  ///
  /// In en, this message translates to:
  /// **'Weekly volume'**
  String get progressWeeklyVolumeTitle;

  /// Planned chart series label
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get progressPlannedLabel;

  /// Completed chart series label
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get progressCompletedLabel;

  /// Short week label for charts
  ///
  /// In en, this message translates to:
  /// **'W{week}'**
  String progressWeekShortLabel(int week);

  /// Plan analytics muscle groups section title
  ///
  /// In en, this message translates to:
  /// **'Muscle groups'**
  String get progressMuscleGroupsTitle;

  /// Training score label
  ///
  /// In en, this message translates to:
  /// **'TRAINING SCORE'**
  String get progressTrainingScoreLabel;

  /// Consistency metric label
  ///
  /// In en, this message translates to:
  /// **'consistency'**
  String get progressConsistencyLabel;

  /// Analytics workouts metric label
  ///
  /// In en, this message translates to:
  /// **'Workouts'**
  String get progressWorkoutsLabel;

  /// Analytics volume metric label
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get progressVolumeLabel;

  /// Analytics completed sets metric label
  ///
  /// In en, this message translates to:
  /// **'Completed sets'**
  String get progressCompletedSetsLabel;

  /// Analytics average sessions per week label
  ///
  /// In en, this message translates to:
  /// **'Avg sessions/wk'**
  String get progressAvgSessionsPerWeekLabel;

  /// Analytics average RPE label
  ///
  /// In en, this message translates to:
  /// **'Avg RPE'**
  String get progressAvgRpeLabel;

  /// Analytics high RPE sets label
  ///
  /// In en, this message translates to:
  /// **'High-RPE sets'**
  String get progressHighRpeSetsLabel;

  /// Analytics warning days label
  ///
  /// In en, this message translates to:
  /// **'Warning days'**
  String get progressWarningDaysLabel;

  /// Analytics time trained label
  ///
  /// In en, this message translates to:
  /// **'Time trained'**
  String get progressTimeTrainedLabel;

  /// No description provided for @progressSetsValue.
  ///
  /// In en, this message translates to:
  /// **'{count} sets'**
  String progressSetsValue(Object count);

  /// No description provided for @progressDurationMinutes.
  ///
  /// In en, this message translates to:
  /// **'{minutes} min'**
  String progressDurationMinutes(Object minutes);

  /// No description provided for @progressDurationHoursMinutes.
  ///
  /// In en, this message translates to:
  /// **'{hours} hr {minutes} min'**
  String progressDurationHoursMinutes(Object hours, Object minutes);

  /// No description provided for @progressInsightRepeatWeekTitle.
  ///
  /// In en, this message translates to:
  /// **'Repeat or simplify the week'**
  String get progressInsightRepeatWeekTitle;

  /// No description provided for @progressInsightRepeatWeekMessage.
  ///
  /// In en, this message translates to:
  /// **'The current load may be too much. Reduce friction, repeat key sessions, and rebuild consistency.'**
  String get progressInsightRepeatWeekMessage;

  /// No description provided for @progressInsightRepeatWeekMetric.
  ///
  /// In en, this message translates to:
  /// **'Training stress'**
  String get progressInsightRepeatWeekMetric;

  /// No description provided for @progressInsightConsistencyTitle.
  ///
  /// In en, this message translates to:
  /// **'Consistency is uneven'**
  String get progressInsightConsistencyTitle;

  /// No description provided for @progressInsightConsistencyMessage.
  ///
  /// In en, this message translates to:
  /// **'Some planned sessions are being missed. Keep the next week simple until adherence improves.'**
  String get progressInsightConsistencyMessage;

  /// No description provided for @progressInsightConsistencyMetric.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get progressInsightConsistencyMetric;

  /// No description provided for @progressInsightVolumeTitle.
  ///
  /// In en, this message translates to:
  /// **'Volume is trending down'**
  String get progressInsightVolumeTitle;

  /// No description provided for @progressInsightVolumeMessage.
  ///
  /// In en, this message translates to:
  /// **'Training volume dropped more than 20%. Repeat the week or avoid adding load yet.'**
  String get progressInsightVolumeMessage;

  /// No description provided for @progressInsightVolumeMetric.
  ///
  /// In en, this message translates to:
  /// **'Volume change'**
  String get progressInsightVolumeMetric;

  /// No description provided for @progressInsightMuscleBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Muscle distribution looks balanced'**
  String get progressInsightMuscleBalanceTitle;

  /// No description provided for @progressInsightMuscleBalanceMessage.
  ///
  /// In en, this message translates to:
  /// **'No single muscle group is dominating weighted volume.'**
  String get progressInsightMuscleBalanceMessage;

  /// No description provided for @progressInsightMuscleBalanceMetric.
  ///
  /// In en, this message translates to:
  /// **'Top group'**
  String get progressInsightMuscleBalanceMetric;

  /// No description provided for @progressInsightMissedTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Some sets missed target'**
  String get progressInsightMissedTargetTitle;

  /// No description provided for @progressInsightMissedTargetMessage.
  ///
  /// In en, this message translates to:
  /// **'A few sessions were below planned reps or weight. Monitor performance before adding load.'**
  String get progressInsightMissedTargetMessage;

  /// No description provided for @progressInsightMissedTargetMetric.
  ///
  /// In en, this message translates to:
  /// **'Warning days'**
  String get progressInsightMissedTargetMetric;

  /// No description provided for @progressInsightBenchSquatTitle.
  ///
  /// In en, this message translates to:
  /// **'Bench is lagging your squat'**
  String get progressInsightBenchSquatTitle;

  /// No description provided for @progressInsightBenchSquatMessage.
  ///
  /// In en, this message translates to:
  /// **'Your bench is 63% of your squat. A typical balance sits around 70%. Consider an extra bench session or upper-body accessory work.'**
  String get progressInsightBenchSquatMessage;

  /// No description provided for @progressInsightBenchSquatMetric.
  ///
  /// In en, this message translates to:
  /// **'Bench / Squat'**
  String get progressInsightBenchSquatMetric;

  /// No description provided for @progressMuscleBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get progressMuscleBack;

  /// No description provided for @progressMuscleAbs.
  ///
  /// In en, this message translates to:
  /// **'Abs'**
  String get progressMuscleAbs;

  /// No description provided for @progressMuscleShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get progressMuscleShoulders;

  /// No description provided for @progressMuscleChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get progressMuscleChest;

  /// No description provided for @progressMuscleTriceps.
  ///
  /// In en, this message translates to:
  /// **'Triceps'**
  String get progressMuscleTriceps;

  /// No description provided for @progressMuscleHamstrings.
  ///
  /// In en, this message translates to:
  /// **'Hamstrings'**
  String get progressMuscleHamstrings;

  /// No description provided for @progressMuscleQuads.
  ///
  /// In en, this message translates to:
  /// **'Quads'**
  String get progressMuscleQuads;

  /// No description provided for @progressMuscleBiceps.
  ///
  /// In en, this message translates to:
  /// **'Biceps'**
  String get progressMuscleBiceps;

  /// No description provided for @progressMuscleGlutes.
  ///
  /// In en, this message translates to:
  /// **'Glutes'**
  String get progressMuscleGlutes;

  /// No description provided for @progressMuscleForearms.
  ///
  /// In en, this message translates to:
  /// **'Forearms'**
  String get progressMuscleForearms;

  /// No description provided for @progressMuscleCalves.
  ///
  /// In en, this message translates to:
  /// **'Calves'**
  String get progressMuscleCalves;

  /// Empty chart message
  ///
  /// In en, this message translates to:
  /// **'No data yet.'**
  String get progressNoDataYet;

  /// Personal records screen title
  ///
  /// In en, this message translates to:
  /// **'Personal Records'**
  String get progressPersonalRecordsTitle;

  /// Empty personal records title
  ///
  /// In en, this message translates to:
  /// **'No personal records yet'**
  String get progressNoPersonalRecordsTitle;

  /// Empty personal records message
  ///
  /// In en, this message translates to:
  /// **'Complete sets in your workouts to set PRs.'**
  String get progressNoPersonalRecordsMessage;

  /// Tooltip for sharing a personal record
  ///
  /// In en, this message translates to:
  /// **'Share PR'**
  String get progressSharePrTooltip;

  /// PR history load error
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load history.'**
  String get progressHistoryLoadError;

  /// Prompt shown when PR history has too few points
  ///
  /// In en, this message translates to:
  /// **'Keep logging to build a PR trend.'**
  String get progressKeepLoggingTrend;

  /// PR progression section title
  ///
  /// In en, this message translates to:
  /// **'PROGRESSION'**
  String get progressProgressionTitle;

  /// Snackbar after copying PR share link
  ///
  /// In en, this message translates to:
  /// **'PR link copied to clipboard'**
  String get progressPrCopiedSnackbar;

  /// Tooltip for the hamburger menu button that opens the drawer
  ///
  /// In en, this message translates to:
  /// **'Open menu'**
  String get appShellOpenMenuTooltip;

  /// Tooltip for the notifications bell icon
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get appShellNotificationsTooltip;

  /// Bottom nav / drawer label for the Dashboard tab
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get appShellNavDashboard;

  /// Bottom nav / drawer label for the Plans tab
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get appShellNavPlans;

  /// Bottom nav / drawer label for a coach's Clients tab
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get appShellNavClients;

  /// Bottom nav / drawer label for the Nutrition tab
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get appShellNavNutrition;

  /// Bottom nav / drawer label for the Cycle tab
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get appShellNavCycle;

  /// No description provided for @cycleInsightTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle insight'**
  String get cycleInsightTitle;

  /// No description provided for @cycleInsightFemaleOnlyMessage.
  ///
  /// In en, this message translates to:
  /// **'Cycle insight is available for female profiles.'**
  String get cycleInsightFemaleOnlyMessage;

  /// No description provided for @cycleAiInsightTitle.
  ///
  /// In en, this message translates to:
  /// **'AI cycle insight'**
  String get cycleAiInsightTitle;

  /// No description provided for @cycleCachedLabel.
  ///
  /// In en, this message translates to:
  /// **'Cached'**
  String get cycleCachedLabel;

  /// No description provided for @cycleFreshLabel.
  ///
  /// In en, this message translates to:
  /// **'Fresh'**
  String get cycleFreshLabel;

  /// No description provided for @cyclePatternsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle patterns'**
  String get cyclePatternsTitle;

  /// No description provided for @cycleSymptomPatternsTitle.
  ///
  /// In en, this message translates to:
  /// **'Symptom patterns'**
  String get cycleSymptomPatternsTitle;

  /// No description provided for @cycleTrainingCorrelationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Training correlations'**
  String get cycleTrainingCorrelationsTitle;

  /// No description provided for @cycleCautionsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cautions'**
  String get cycleCautionsTitle;

  /// No description provided for @cycleRefreshInsightButton.
  ///
  /// In en, this message translates to:
  /// **'Refresh insight'**
  String get cycleRefreshInsightButton;

  /// No description provided for @cyclePhaseRecommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Phase recommendations'**
  String get cyclePhaseRecommendationsTitle;

  /// No description provided for @cycleTrainingRecommendationLabel.
  ///
  /// In en, this message translates to:
  /// **'Training: {value}'**
  String cycleTrainingRecommendationLabel(String value);

  /// No description provided for @cycleNutritionRecommendationLabel.
  ///
  /// In en, this message translates to:
  /// **'Nutrition: {value}'**
  String cycleNutritionRecommendationLabel(String value);

  /// No description provided for @cycleTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get cycleTitle;

  /// No description provided for @cycleLogImprovePredictionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Log your period days to improve predictions.'**
  String get cycleLogImprovePredictionsMessage;

  /// No description provided for @cycleDayMissingLabel.
  ///
  /// In en, this message translates to:
  /// **'Cycle day -'**
  String get cycleDayMissingLabel;

  /// No description provided for @cycleDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Cycle day {day}'**
  String cycleDayLabel(int day);

  /// No description provided for @cycleNextPeriodMissingLabel.
  ///
  /// In en, this message translates to:
  /// **'Next period -'**
  String get cycleNextPeriodMissingLabel;

  /// No description provided for @cycleDaysToPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'{days}d to period'**
  String cycleDaysToPeriodLabel(int days);

  /// No description provided for @cycleDaysLateLabel.
  ///
  /// In en, this message translates to:
  /// **'{days}d late'**
  String cycleDaysLateLabel(int days);

  /// No description provided for @cycleLogTodayButton.
  ///
  /// In en, this message translates to:
  /// **'Log today'**
  String get cycleLogTodayButton;

  /// No description provided for @cycleSettingsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get cycleSettingsTooltip;

  /// No description provided for @cycleCycleLengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Cycle length'**
  String get cycleCycleLengthLabel;

  /// No description provided for @cyclePeriodLengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Period length'**
  String get cyclePeriodLengthLabel;

  /// No description provided for @cycleRegularityLabel.
  ///
  /// In en, this message translates to:
  /// **'Regularity'**
  String get cycleRegularityLabel;

  /// No description provided for @cycleRegularLabel.
  ///
  /// In en, this message translates to:
  /// **'Regular'**
  String get cycleRegularLabel;

  /// No description provided for @cycleVariableLabel.
  ///
  /// In en, this message translates to:
  /// **'Variable'**
  String get cycleVariableLabel;

  /// No description provided for @cycleVariabilityLabel.
  ///
  /// In en, this message translates to:
  /// **'Variability'**
  String get cycleVariabilityLabel;

  /// No description provided for @cycleRecentLogsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent logs'**
  String get cycleRecentLogsTitle;

  /// No description provided for @cycleNoLogsMessage.
  ///
  /// In en, this message translates to:
  /// **'No cycle logs yet.'**
  String get cycleNoLogsMessage;

  /// No description provided for @cyclePreviousMonthTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous month'**
  String get cyclePreviousMonthTooltip;

  /// No description provided for @cycleTodayButton.
  ///
  /// In en, this message translates to:
  /// **'today'**
  String get cycleTodayButton;

  /// No description provided for @cycleNextMonthTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next month'**
  String get cycleNextMonthTooltip;

  /// No description provided for @cycleLegendPeriod.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get cycleLegendPeriod;

  /// No description provided for @cycleLegendPredicted.
  ///
  /// In en, this message translates to:
  /// **'Predicted'**
  String get cycleLegendPredicted;

  /// No description provided for @cycleLegendOvulation.
  ///
  /// In en, this message translates to:
  /// **'Ovulation'**
  String get cycleLegendOvulation;

  /// No description provided for @cycleLegendFertile.
  ///
  /// In en, this message translates to:
  /// **'Fertile'**
  String get cycleLegendFertile;

  /// No description provided for @cycleSymptomCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {1 symptom} other {{count} symptoms}}'**
  String cycleSymptomCountLabel(int count);

  /// No description provided for @cycleFemaleOnlyTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle tracking is available for female profiles.'**
  String get cycleFemaleOnlyTitle;

  /// No description provided for @cycleFemaleOnlyMessage.
  ///
  /// In en, this message translates to:
  /// **'Update your profile if this feature applies to you. Backend authorization remains the source of truth.'**
  String get cycleFemaleOnlyMessage;

  /// No description provided for @cycleEditProfileButton.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get cycleEditProfileButton;

  /// No description provided for @cycleLogDateTitle.
  ///
  /// In en, this message translates to:
  /// **'Log {date}'**
  String cycleLogDateTitle(String date);

  /// No description provided for @cycleFlowLabel.
  ///
  /// In en, this message translates to:
  /// **'Flow'**
  String get cycleFlowLabel;

  /// No description provided for @cycleMoodLabel.
  ///
  /// In en, this message translates to:
  /// **'Mood'**
  String get cycleMoodLabel;

  /// No description provided for @cycleEnergyLabel.
  ///
  /// In en, this message translates to:
  /// **'Energy {value}'**
  String cycleEnergyLabel(String value);

  /// No description provided for @cycleSymptomsLabel.
  ///
  /// In en, this message translates to:
  /// **'Symptoms'**
  String get cycleSymptomsLabel;

  /// No description provided for @cycleNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get cycleNotesLabel;

  /// No description provided for @cycleDeleteButton.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get cycleDeleteButton;

  /// No description provided for @cycleSaveButton.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get cycleSaveButton;

  /// No description provided for @cycleSettingsTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle settings'**
  String get cycleSettingsTitle;

  /// No description provided for @cycleLengthOverrideLabel.
  ///
  /// In en, this message translates to:
  /// **'Cycle length override'**
  String get cycleLengthOverrideLabel;

  /// No description provided for @cyclePeriodLengthOverrideLabel.
  ///
  /// In en, this message translates to:
  /// **'Period length override'**
  String get cyclePeriodLengthOverrideLabel;

  /// No description provided for @cycleMarkerPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Period'**
  String get cycleMarkerPeriodLabel;

  /// No description provided for @cycleMarkerPreMenstrualLabel.
  ///
  /// In en, this message translates to:
  /// **'Pre-menstrual'**
  String get cycleMarkerPreMenstrualLabel;

  /// No description provided for @cycleExample28Hint.
  ///
  /// In en, this message translates to:
  /// **'Example: 28'**
  String get cycleExample28Hint;

  /// No description provided for @cycleExample5Hint.
  ///
  /// In en, this message translates to:
  /// **'Example: 5'**
  String get cycleExample5Hint;

  /// No description provided for @cycleShareWithCoachTitle.
  ///
  /// In en, this message translates to:
  /// **'Share with coach'**
  String get cycleShareWithCoachTitle;

  /// No description provided for @cycleShareWithCoachSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Allow your active coach to view cycle summary.'**
  String get cycleShareWithCoachSubtitle;

  /// No description provided for @cycleSaveSettingsButton.
  ///
  /// In en, this message translates to:
  /// **'Save settings'**
  String get cycleSaveSettingsButton;

  /// No description provided for @cycleTrackingCyclesMessage.
  ///
  /// In en, this message translates to:
  /// **'Tracking {days} day cycles.'**
  String cycleTrackingCyclesMessage(int days);

  /// No description provided for @cycleNextPredictedPeriodMessage.
  ///
  /// In en, this message translates to:
  /// **'Next predicted period: {date}.'**
  String cycleNextPredictedPeriodMessage(String date);

  /// No description provided for @cycleTrendsLast60DaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Trends (last 60 days)'**
  String get cycleTrendsLast60DaysTitle;

  /// No description provided for @cycleLogMoreDaysTrendMessage.
  ///
  /// In en, this message translates to:
  /// **'Log more days to build a trend chart.'**
  String get cycleLogMoreDaysTrendMessage;

  /// No description provided for @cycleNoSymptomsLast60DaysMessage.
  ///
  /// In en, this message translates to:
  /// **'No symptoms logged in the last 60 days.'**
  String get cycleNoSymptomsLast60DaysMessage;

  /// No description provided for @cycleMostFrequentSymptomsTitle.
  ///
  /// In en, this message translates to:
  /// **'Most frequent symptoms'**
  String get cycleMostFrequentSymptomsTitle;

  /// Bottom nav / drawer label for the Profile tab
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get appShellNavProfile;

  /// Drawer section title for training-related items
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get appShellDrawerTrainingSection;

  /// Drawer section title shown instead of Training for coach accounts
  ///
  /// In en, this message translates to:
  /// **'Coach workspace'**
  String get appShellDrawerCoachWorkspaceSection;

  /// Drawer item label for a coach's dashboard overview
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get appShellDrawerOverview;

  /// Drawer item label for the exercise library
  ///
  /// In en, this message translates to:
  /// **'Exercise Library'**
  String get appShellDrawerExerciseLibrary;

  /// Drawer section title and item label for Progress
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get appShellDrawerProgressSection;

  /// Drawer item label for personal records
  ///
  /// In en, this message translates to:
  /// **'Personal Records'**
  String get appShellDrawerPersonalRecords;

  /// Drawer section title and item label for Community
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get appShellDrawerCommunitySection;

  /// Drawer item label for Friends
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get appShellDrawerFriends;

  /// Drawer section title for AI-powered tools
  ///
  /// In en, this message translates to:
  /// **'AI tools'**
  String get appShellDrawerAiToolsSection;

  /// Drawer item label for AI Insights
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get appShellDrawerInsights;

  /// Drawer item label for the AI coach chat
  ///
  /// In en, this message translates to:
  /// **'AI Coach Chat'**
  String get appShellDrawerAiCoachChat;

  /// Drawer section title for coach-only tools
  ///
  /// In en, this message translates to:
  /// **'Coach tools'**
  String get appShellDrawerCoachToolsSection;

  /// Drawer item label for the coach key vault
  ///
  /// In en, this message translates to:
  /// **'Key Vault'**
  String get appShellDrawerKeyVault;

  /// Drawer item label for coach/client chat
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get appShellDrawerChat;

  /// Drawer section title for connecting with a coach
  ///
  /// In en, this message translates to:
  /// **'Coach access'**
  String get appShellDrawerCoachAccessSection;

  /// Drawer item label for viewing one's own coach
  ///
  /// In en, this message translates to:
  /// **'My Coach'**
  String get appShellDrawerMyCoach;

  /// Drawer item label to enter a coach invite code
  ///
  /// In en, this message translates to:
  /// **'Enter Coach Code'**
  String get appShellDrawerEnterCoachCode;

  /// No description provided for @coachChatTitle.
  ///
  /// In en, this message translates to:
  /// **'Chat'**
  String get coachChatTitle;

  /// No description provided for @coachChatHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Relationship chat'**
  String get coachChatHeaderTitle;

  /// No description provided for @coachChatHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Message history, send, read state, and realtime echo support.'**
  String get coachChatHeaderSubtitle;

  /// No description provided for @coachChatNoRelationshipsTitle.
  ///
  /// In en, this message translates to:
  /// **'No relationships'**
  String get coachChatNoRelationshipsTitle;

  /// No description provided for @coachChatNoRelationshipsMessage.
  ///
  /// In en, this message translates to:
  /// **'Active coach-client relationships can chat here.'**
  String get coachChatNoRelationshipsMessage;

  /// No description provided for @coachChatNoMessagesTitle.
  ///
  /// In en, this message translates to:
  /// **'No messages'**
  String get coachChatNoMessagesTitle;

  /// No description provided for @coachChatNoMessagesMessage.
  ///
  /// In en, this message translates to:
  /// **'Send the first message for this relationship.'**
  String get coachChatNoMessagesMessage;

  /// No description provided for @coachChatUserFallback.
  ///
  /// In en, this message translates to:
  /// **'User'**
  String get coachChatUserFallback;

  /// No description provided for @coachChatReadLabel.
  ///
  /// In en, this message translates to:
  /// **'Read'**
  String get coachChatReadLabel;

  /// No description provided for @coachChatMessageLabel.
  ///
  /// In en, this message translates to:
  /// **'Message'**
  String get coachChatMessageLabel;

  /// No description provided for @coachChatSendButton.
  ///
  /// In en, this message translates to:
  /// **'Send'**
  String get coachChatSendButton;

  /// No description provided for @coachEnterCodeTitle.
  ///
  /// In en, this message translates to:
  /// **'Enter coach code'**
  String get coachEnterCodeTitle;

  /// No description provided for @coachEnterCodeHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Connect to coach'**
  String get coachEnterCodeHeaderTitle;

  /// No description provided for @coachEnterCodeHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Enter an invite code from your coach.'**
  String get coachEnterCodeHeaderSubtitle;

  /// No description provided for @coachInviteCodeLabel.
  ///
  /// In en, this message translates to:
  /// **'Invite code'**
  String get coachInviteCodeLabel;

  /// No description provided for @coachConnectButton.
  ///
  /// In en, this message translates to:
  /// **'Connect'**
  String get coachConnectButton;

  /// No description provided for @coachConnectionRequestSentSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Coach connection request sent.'**
  String get coachConnectionRequestSentSnackbar;

  /// No description provided for @coachKeyVaultTitle.
  ///
  /// In en, this message translates to:
  /// **'Key vault'**
  String get coachKeyVaultTitle;

  /// No description provided for @coachGenerateInviteCodeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Generate invite code'**
  String get coachGenerateInviteCodeTooltip;

  /// No description provided for @coachInviteCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'Invite codes'**
  String get coachInviteCodesTitle;

  /// No description provided for @coachInviteCodesSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Generate, share, and revoke client invite codes.'**
  String get coachInviteCodesSubtitle;

  /// No description provided for @coachNoActiveCodesTitle.
  ///
  /// In en, this message translates to:
  /// **'No active codes'**
  String get coachNoActiveCodesTitle;

  /// No description provided for @coachNoActiveCodesMessage.
  ///
  /// In en, this message translates to:
  /// **'Tap the add button to generate one.'**
  String get coachNoActiveCodesMessage;

  /// No description provided for @coachActiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get coachActiveStatus;

  /// No description provided for @coachInactiveStatus.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get coachInactiveStatus;

  /// No description provided for @coachCopyCodeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy code'**
  String get coachCopyCodeTooltip;

  /// No description provided for @coachRevokeButton.
  ///
  /// In en, this message translates to:
  /// **'Revoke'**
  String get coachRevokeButton;

  /// No description provided for @coachKeyCreatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Coach key created.'**
  String get coachKeyCreatedSnackbar;

  /// No description provided for @coachKeyCopiedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Coach key copied.'**
  String get coachKeyCopiedSnackbar;

  /// No description provided for @coachCreateKeyTitle.
  ///
  /// In en, this message translates to:
  /// **'Create coach key'**
  String get coachCreateKeyTitle;

  /// No description provided for @coachCreateKeySubtitle.
  ///
  /// In en, this message translates to:
  /// **'Set the coaching access window for this invite code.'**
  String get coachCreateKeySubtitle;

  /// No description provided for @coachPickStartEndDatesError.
  ///
  /// In en, this message translates to:
  /// **'Pick start and end dates'**
  String get coachPickStartEndDatesError;

  /// No description provided for @coachEndDateAfterStartError.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get coachEndDateAfterStartError;

  /// No description provided for @coachStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get coachStartLabel;

  /// No description provided for @coachEndLabel.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get coachEndLabel;

  /// No description provided for @coachCreateKeyButton.
  ///
  /// In en, this message translates to:
  /// **'Create key'**
  String get coachCreateKeyButton;

  /// No description provided for @coachPickDateButton.
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get coachPickDateButton;

  /// No description provided for @coachDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get coachDefaultName;

  /// No description provided for @coachActiveStatusFallback.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get coachActiveStatusFallback;

  /// No description provided for @coachOpenEndedDate.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get coachOpenEndedDate;

  /// No description provided for @coachMoreActionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'More actions'**
  String get coachMoreActionsTooltip;

  /// No description provided for @coachRelationshipActionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Relationship actions'**
  String get coachRelationshipActionsTooltip;

  /// No description provided for @coachRequestTerminationAction.
  ///
  /// In en, this message translates to:
  /// **'Request termination'**
  String get coachRequestTerminationAction;

  /// No description provided for @coachAcceptTerminationAction.
  ///
  /// In en, this message translates to:
  /// **'Accept termination'**
  String get coachAcceptTerminationAction;

  /// No description provided for @coachRejectTerminationAction.
  ///
  /// In en, this message translates to:
  /// **'Reject termination'**
  String get coachRejectTerminationAction;

  /// No description provided for @coachRequestRenewalAction.
  ///
  /// In en, this message translates to:
  /// **'Request renewal'**
  String get coachRequestRenewalAction;

  /// No description provided for @coachAcceptRenewalAction.
  ///
  /// In en, this message translates to:
  /// **'Accept renewal'**
  String get coachAcceptRenewalAction;

  /// No description provided for @coachRejectRenewalAction.
  ///
  /// In en, this message translates to:
  /// **'Reject renewal'**
  String get coachRejectRenewalAction;

  /// No description provided for @coachDisconnectAction.
  ///
  /// In en, this message translates to:
  /// **'Disconnect'**
  String get coachDisconnectAction;

  /// No description provided for @coachAcceptAction.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get coachAcceptAction;

  /// No description provided for @coachMyCoachTitle.
  ///
  /// In en, this message translates to:
  /// **'My coach'**
  String get coachMyCoachTitle;

  /// No description provided for @coachProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Coach profile'**
  String get coachProfileTitle;

  /// No description provided for @coachProfileSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Details from your active coaching relationship.'**
  String get coachProfileSubtitle;

  /// No description provided for @coachNoCoachConnectedTitle.
  ///
  /// In en, this message translates to:
  /// **'No coach connected'**
  String get coachNoCoachConnectedTitle;

  /// No description provided for @coachNoCoachConnectedMessage.
  ///
  /// In en, this message translates to:
  /// **'Use an invite code to connect with a Pro Coach.'**
  String get coachNoCoachConnectedMessage;

  /// No description provided for @coachDisconnectConfirmTitle.
  ///
  /// In en, this message translates to:
  /// **'Disconnect from coach?'**
  String get coachDisconnectConfirmTitle;

  /// No description provided for @coachDisconnectConfirmMessage.
  ///
  /// In en, this message translates to:
  /// **'This ends your active coaching relationship. You can reconnect later with a new invite code.'**
  String get coachDisconnectConfirmMessage;

  /// No description provided for @coachCoachingPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Coaching period'**
  String get coachCoachingPeriodLabel;

  /// No description provided for @coachMessageCoachButton.
  ///
  /// In en, this message translates to:
  /// **'Message coach'**
  String get coachMessageCoachButton;

  /// No description provided for @coachIntroductionLabel.
  ///
  /// In en, this message translates to:
  /// **'Introduction'**
  String get coachIntroductionLabel;

  /// No description provided for @coachConnectedSinceLabel.
  ///
  /// In en, this message translates to:
  /// **'Connected since {date}'**
  String coachConnectedSinceLabel(String date);

  /// No description provided for @coachClientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Clients'**
  String get coachClientsTitle;

  /// No description provided for @coachManageClientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Manage clients'**
  String get coachManageClientsTitle;

  /// No description provided for @coachClientRosterSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Client roster and attention signals'**
  String get coachClientRosterSubtitle;

  /// No description provided for @coachActiveClientCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, one {1 active client} other {{count} active clients}}'**
  String coachActiveClientCount(int count);

  /// No description provided for @coachScheduleTitle.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get coachScheduleTitle;

  /// No description provided for @coachSixMonthsLabel.
  ///
  /// In en, this message translates to:
  /// **'6 months'**
  String get coachSixMonthsLabel;

  /// No description provided for @coachActivePlansAppearMessage.
  ///
  /// In en, this message translates to:
  /// **'Active client plans will appear here.'**
  String get coachActivePlansAppearMessage;

  /// No description provided for @coachPendingRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Pending requests'**
  String get coachPendingRequestsTitle;

  /// No description provided for @coachNoActiveClientsTitle.
  ///
  /// In en, this message translates to:
  /// **'No active clients'**
  String get coachNoActiveClientsTitle;

  /// No description provided for @coachNoActiveClientsMessage.
  ///
  /// In en, this message translates to:
  /// **'Open Key Vault and share an invite code with a client.'**
  String get coachNoActiveClientsMessage;

  /// No description provided for @coachActiveClientsTitle.
  ///
  /// In en, this message translates to:
  /// **'Active clients'**
  String get coachActiveClientsTitle;

  /// No description provided for @coachNeedsAttentionLabel.
  ///
  /// In en, this message translates to:
  /// **'Needs attention'**
  String get coachNeedsAttentionLabel;

  /// No description provided for @coachMetricActiveClients.
  ///
  /// In en, this message translates to:
  /// **'Active clients'**
  String get coachMetricActiveClients;

  /// No description provided for @coachMetricNeedAttention.
  ///
  /// In en, this message translates to:
  /// **'Need attention'**
  String get coachMetricNeedAttention;

  /// No description provided for @coachMetricNoActivePlan.
  ///
  /// In en, this message translates to:
  /// **'No active plan'**
  String get coachMetricNoActivePlan;

  /// No description provided for @coachMetricInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get coachMetricInactive;

  /// Drawer section title for admin-only tools
  ///
  /// In en, this message translates to:
  /// **'Administration'**
  String get appShellDrawerAdministrationSection;

  /// Drawer item label for the admin dashboard
  ///
  /// In en, this message translates to:
  /// **'Admin Dashboard'**
  String get appShellDrawerAdminDashboard;

  /// Drawer item label for admin analytics
  ///
  /// In en, this message translates to:
  /// **'Analytics'**
  String get appShellDrawerAdminAnalytics;

  /// Drawer item label for admin reports
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get appShellDrawerAdminReports;

  /// Drawer item label for admin bug reports
  ///
  /// In en, this message translates to:
  /// **'Bug reports'**
  String get appShellDrawerAdminBugReports;

  /// Drawer item label for admin user management
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get appShellDrawerAdminUsers;

  /// Drawer item label for admin platform subscription plans
  ///
  /// In en, this message translates to:
  /// **'Platform Plans'**
  String get appShellDrawerAdminPlans;

  /// Drawer item label for admin payments
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get appShellDrawerAdminPayments;

  /// Drawer section title for subscription/billing
  ///
  /// In en, this message translates to:
  /// **'Updates and billing'**
  String get appShellDrawerUpdatesBillingSection;

  /// Drawer item label for the subscription screen
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get appShellDrawerSubscription;

  /// Email field label, shared across auth screens
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get authEmailLabel;

  /// Email field hint, shared across auth screens
  ///
  /// In en, this message translates to:
  /// **'you@example.com'**
  String get authEmailHint;

  /// Password field label, shared across auth screens
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get authPasswordLabel;

  /// Validator message when the email field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your email'**
  String get authEnterEmailError;

  /// Validator message when the email format is invalid
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email'**
  String get authInvalidEmailError;

  /// Sign in button label
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get authSignInCta;

  /// Login screen hero title
  ///
  /// In en, this message translates to:
  /// **'Welcome back'**
  String get authLoginTitle;

  /// Login screen hero subtitle
  ///
  /// In en, this message translates to:
  /// **'Sign in to manage training, nutrition, recovery, and coach feedback in one place.'**
  String get authLoginSubtitle;

  /// Prompt shown before the create-account link
  ///
  /// In en, this message translates to:
  /// **'Don\'t have an account?'**
  String get authLoginNoAccountPrompt;

  /// Link label to go to the register screen
  ///
  /// In en, this message translates to:
  /// **'Create one'**
  String get authLoginCreateAccountCta;

  /// Password field hint on the login screen
  ///
  /// In en, this message translates to:
  /// **'Your password'**
  String get authPasswordHint;

  /// Validator message when the password field is empty
  ///
  /// In en, this message translates to:
  /// **'Enter your password'**
  String get authEnterPasswordError;

  /// Link label to the forgot-password screen
  ///
  /// In en, this message translates to:
  /// **'Forgot password?'**
  String get authForgotPasswordCta;

  /// Toast shown when submitting registration without a date of birth
  ///
  /// In en, this message translates to:
  /// **'Please select your date of birth'**
  String get authSelectDobError;

  /// Snackbar shown after successful registration
  ///
  /// In en, this message translates to:
  /// **'Account created. Please sign in.'**
  String get authAccountCreatedSnackbar;

  /// Register screen hero title, account step
  ///
  /// In en, this message translates to:
  /// **'Create your account'**
  String get authRegisterTitleStep0;

  /// Register screen hero title, profile step
  ///
  /// In en, this message translates to:
  /// **'Shape your training'**
  String get authRegisterTitleStep1;

  /// Register screen hero subtitle, account step
  ///
  /// In en, this message translates to:
  /// **'Start with the sign-in details you will use to access Xenoh.'**
  String get authRegisterSubtitleStep0;

  /// Register screen hero subtitle, profile step
  ///
  /// In en, this message translates to:
  /// **'Add the profile details Xenoh uses for training, nutrition, and coaching context.'**
  String get authRegisterSubtitleStep1;

  /// Prompt shown before the sign-in link on the register screen
  ///
  /// In en, this message translates to:
  /// **'Already have an account?'**
  String get authRegisterHaveAccountPrompt;

  /// Step indicator for the account details step
  ///
  /// In en, this message translates to:
  /// **'Step 1 of 2'**
  String get authRegisterStep1Of2;

  /// Section title for the account details step
  ///
  /// In en, this message translates to:
  /// **'Account details'**
  String get authRegisterAccountDetailsTitle;

  /// First name field label
  ///
  /// In en, this message translates to:
  /// **'First name'**
  String get authFirstNameLabel;

  /// Last name field label
  ///
  /// In en, this message translates to:
  /// **'Last name'**
  String get authLastNameLabel;

  /// Password field hint on the register screen
  ///
  /// In en, this message translates to:
  /// **'At least 8 characters'**
  String get authPasswordMinHint;

  /// Validator message when the password is too short
  ///
  /// In en, this message translates to:
  /// **'Use at least 8 characters'**
  String get authPasswordTooShortError;

  /// Button label to continue to the next registration step
  ///
  /// In en, this message translates to:
  /// **'Continue'**
  String get authContinueCta;

  /// Step indicator for the training profile step
  ///
  /// In en, this message translates to:
  /// **'Step 2 of 2'**
  String get authRegisterStep2Of2;

  /// Section title for the training profile step
  ///
  /// In en, this message translates to:
  /// **'Training profile'**
  String get authRegisterTrainingProfileTitle;

  /// Gender field label
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get authGenderLabel;

  /// Date of birth field label
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get authDobLabel;

  /// Button label to open the date picker
  ///
  /// In en, this message translates to:
  /// **'Select date'**
  String get authSelectDateCta;

  /// Height field label on the register screen
  ///
  /// In en, this message translates to:
  /// **'Height (cm) - optional'**
  String get authHeightLabel;

  /// Weight field label on the register screen
  ///
  /// In en, this message translates to:
  /// **'Weight (kg) - optional'**
  String get authWeightLabel;

  /// Development direction field label
  ///
  /// In en, this message translates to:
  /// **'Development direction'**
  String get authDevelopmentDirectionLabel;

  /// Training discipline field label
  ///
  /// In en, this message translates to:
  /// **'Training discipline'**
  String get authTrainingDisciplineLabel;

  /// Register submit button label
  ///
  /// In en, this message translates to:
  /// **'Register'**
  String get authRegisterCta;

  /// Generic dropdown hint on the register screen
  ///
  /// In en, this message translates to:
  /// **'Select one'**
  String get authSelectOneHint;

  /// Validator message when an optional numeric field is out of range
  ///
  /// In en, this message translates to:
  /// **'Must be {min}-{max}'**
  String authOptionalRangeError(String min, String max);

  /// Gender option: male
  ///
  /// In en, this message translates to:
  /// **'Male'**
  String get authGenderMale;

  /// Gender option: female
  ///
  /// In en, this message translates to:
  /// **'Female'**
  String get authGenderFemale;

  /// Gender option: other
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get authGenderOther;

  /// Development direction option: strength
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get authDevStrength;

  /// Development direction option: hypertrophy
  ///
  /// In en, this message translates to:
  /// **'Hypertrophy'**
  String get authDevHypertrophy;

  /// Development direction option: fat loss
  ///
  /// In en, this message translates to:
  /// **'Fat loss'**
  String get authDevFatLoss;

  /// Development direction option: recomposition
  ///
  /// In en, this message translates to:
  /// **'Recomposition'**
  String get authDevRecomposition;

  /// Development direction option: endurance
  ///
  /// In en, this message translates to:
  /// **'Endurance'**
  String get authDevEndurance;

  /// Development direction option: general health
  ///
  /// In en, this message translates to:
  /// **'General health'**
  String get authDevGeneralHealth;

  /// Training discipline option: powerlifting
  ///
  /// In en, this message translates to:
  /// **'Powerlifting'**
  String get authDisciplinePowerlifting;

  /// Training discipline option: bodybuilding
  ///
  /// In en, this message translates to:
  /// **'Bodybuilding'**
  String get authDisciplineBodybuilding;

  /// Training discipline option: weightlifting
  ///
  /// In en, this message translates to:
  /// **'Weightlifting'**
  String get authDisciplineWeightlifting;

  /// Training discipline option: calisthenics
  ///
  /// In en, this message translates to:
  /// **'Calisthenics'**
  String get authDisciplineCalisthenics;

  /// Training discipline option: CrossFit
  ///
  /// In en, this message translates to:
  /// **'CrossFit'**
  String get authDisciplineCrossFit;

  /// Training discipline option: running
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get authDisciplineRunning;

  /// Training discipline option: general fitness
  ///
  /// In en, this message translates to:
  /// **'General fitness'**
  String get authDisciplineGeneralFitness;

  /// Forgot-password screen title and submit CTA when a code has been sent
  ///
  /// In en, this message translates to:
  /// **'Reset password'**
  String get authResetPasswordTitle;

  /// Instruction shown after a reset code has been sent
  ///
  /// In en, this message translates to:
  /// **'Enter the reset code and your new password.'**
  String get authForgotPasswordCodeSentMessage;

  /// Instruction shown before a reset code has been requested
  ///
  /// In en, this message translates to:
  /// **'Enter your email to receive a reset code.'**
  String get authForgotPasswordInitialMessage;

  /// Reset code field label
  ///
  /// In en, this message translates to:
  /// **'Reset code'**
  String get authResetCodeLabel;

  /// New password field label
  ///
  /// In en, this message translates to:
  /// **'New password'**
  String get authNewPasswordLabel;

  /// Button label to request a reset code
  ///
  /// In en, this message translates to:
  /// **'Send reset code'**
  String get authSendResetCodeCta;

  /// Snackbar shown after a successful password reset
  ///
  /// In en, this message translates to:
  /// **'Password reset. Sign in with your new password.'**
  String get authPasswordResetSuccessSnackbar;

  /// Snackbar shown after a reset code is sent
  ///
  /// In en, this message translates to:
  /// **'Reset code sent.'**
  String get authResetCodeSentSnackbar;

  /// Fallback error shown when social sign-in fails
  ///
  /// In en, this message translates to:
  /// **'Social sign-in failed.'**
  String get authSocialSignInFailedError;

  /// Button label to return to the login screen after a social sign-in failure
  ///
  /// In en, this message translates to:
  /// **'Back to login'**
  String get authBackToLoginCta;

  /// Error shown when the social sign-in callback has no ticket
  ///
  /// In en, this message translates to:
  /// **'Missing social sign-in ticket.'**
  String get authMissingSocialTicketError;

  /// Tooltip for the sign-out icon button
  ///
  /// In en, this message translates to:
  /// **'Sign out'**
  String get dashboardSignOutTooltip;

  /// Tooltip for the notifications bell icon
  ///
  /// In en, this message translates to:
  /// **'Notifications'**
  String get dashboardNotificationsTooltip;

  /// Snackbar shown after logging a bodyweight entry
  ///
  /// In en, this message translates to:
  /// **'Bodyweight logged'**
  String get dashboardBodyweightLoggedSnackbar;

  /// Small label above the user's name on the dashboard hero
  ///
  /// In en, this message translates to:
  /// **'Today in training'**
  String get dashboardTodayInTraining;

  /// Short level prefix in the dashboard hero
  ///
  /// In en, this message translates to:
  /// **'Lv'**
  String get dashboardLevelPrefix;

  /// Section title for dashboard next actions
  ///
  /// In en, this message translates to:
  /// **'NEXT ACTIONS'**
  String get dashboardNextActionsTitle;

  /// No description provided for @dashboardNextActionWorkoutLabel.
  ///
  /// In en, this message translates to:
  /// **'Start today\'s workout'**
  String get dashboardNextActionWorkoutLabel;

  /// No description provided for @dashboardNextActionWorkoutDescription.
  ///
  /// In en, this message translates to:
  /// **'Open today\'s workout and complete your planned sets.'**
  String get dashboardNextActionWorkoutDescription;

  /// No description provided for @dashboardNextActionWorkoutProgress.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} sets completed.'**
  String dashboardNextActionWorkoutProgress(Object completed, Object total);

  /// No description provided for @dashboardNextActionNutritionLabel.
  ///
  /// In en, this message translates to:
  /// **'Log today\'s nutrition'**
  String get dashboardNextActionNutritionLabel;

  /// No description provided for @dashboardNextActionNutritionDescription.
  ///
  /// In en, this message translates to:
  /// **'Track calories and macros against your daily target.'**
  String get dashboardNextActionNutritionDescription;

  /// No description provided for @dashboardNextActionInsightsLabel.
  ///
  /// In en, this message translates to:
  /// **'Review insights'**
  String get dashboardNextActionInsightsLabel;

  /// No description provided for @dashboardNextActionInsightsDescription.
  ///
  /// In en, this message translates to:
  /// **'See training recommendations and trends.'**
  String get dashboardNextActionInsightsDescription;

  /// No description provided for @dashboardInsightPlanProgressTitle.
  ///
  /// In en, this message translates to:
  /// **'Active plan progress'**
  String get dashboardInsightPlanProgressTitle;

  /// No description provided for @dashboardInsightPlanProgressMessage.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} training days completed.'**
  String dashboardInsightPlanProgressMessage(Object completed, Object total);

  /// No description provided for @dashboardInsightTodayTrainingTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s training'**
  String get dashboardInsightTodayTrainingTitle;

  /// No description provided for @dashboardInsightTodayTrainingMessage.
  ///
  /// In en, this message translates to:
  /// **'{percent}% of today\'s sets are done.'**
  String dashboardInsightTodayTrainingMessage(Object percent);

  /// No description provided for @dashboardInsightNutritionTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition target'**
  String get dashboardInsightNutritionTargetTitle;

  /// No description provided for @dashboardInsightNutritionTargetMessage.
  ///
  /// In en, this message translates to:
  /// **'{logged}/{target} kcal logged today.'**
  String dashboardInsightNutritionTargetMessage(Object logged, Object target);

  /// Empty state when there's no workout scheduled today
  ///
  /// In en, this message translates to:
  /// **'No workout scheduled today. Enjoy your recovery.'**
  String get dashboardNoWorkoutMessage;

  /// Eyebrow label above today's workout card
  ///
  /// In en, this message translates to:
  /// **'Today\'s workout'**
  String get dashboardTodaysWorkoutEyebrow;

  /// Chip label when today's workout is complete
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get dashboardWorkoutDone;

  /// Chip label for a rest day
  ///
  /// In en, this message translates to:
  /// **'Rest'**
  String get dashboardWorkoutRest;

  /// Chip label when today's workout was missed
  ///
  /// In en, this message translates to:
  /// **'Missed'**
  String get dashboardWorkoutMissed;

  /// Metric label for exercise count
  ///
  /// In en, this message translates to:
  /// **'exercises'**
  String get dashboardExercisesLabel;

  /// Metric label for set count
  ///
  /// In en, this message translates to:
  /// **'sets'**
  String get dashboardSetsLabel;

  /// Metric label for the current streak
  ///
  /// In en, this message translates to:
  /// **'streak'**
  String get dashboardStreakLabel;

  /// Metric label for total planned training volume, with the user's weight unit suffix
  ///
  /// In en, this message translates to:
  /// **'{unit} volume'**
  String dashboardVolumeLabel(String unit);

  /// Eyebrow label above the nutrition summary card
  ///
  /// In en, this message translates to:
  /// **'Nutrition today'**
  String get dashboardNutritionTodayEyebrow;

  /// Error message when the nutrition card fails to load
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load nutrition.'**
  String get dashboardNutritionLoadError;

  /// Protein macro label
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get dashboardMacroProtein;

  /// Carbs macro label
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get dashboardMacroCarbs;

  /// Fat macro label
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get dashboardMacroFat;

  /// Shown when logged calories are under target
  ///
  /// In en, this message translates to:
  /// **'{count} kcal remaining'**
  String dashboardCaloriesRemaining(int count);

  /// Shown when logged calories exceed target
  ///
  /// In en, this message translates to:
  /// **'{count} kcal over target'**
  String dashboardCaloriesOverTarget(int count);

  /// Prompt shown when no nutrition targets are configured
  ///
  /// In en, this message translates to:
  /// **'Set up your nutrition profile to see targets.'**
  String get dashboardSetupNutritionMessage;

  /// Eyebrow label above today's meal plan card
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S MEAL PLAN'**
  String get dashboardMealPlanEyebrow;

  /// Tooltip to navigate to the nutrition screen
  ///
  /// In en, this message translates to:
  /// **'Open nutrition'**
  String get dashboardOpenNutritionTooltip;

  /// Error message when the meal plan card fails to load
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load today\'s meal plan.'**
  String get dashboardMealPlanLoadError;

  /// Empty state when there's no meal plan for today
  ///
  /// In en, this message translates to:
  /// **'No meal plan for today yet.'**
  String get dashboardMealPlanEmpty;

  /// Button to create a meal plan from the nutrition screen
  ///
  /// In en, this message translates to:
  /// **'Create in nutrition'**
  String get dashboardMealPlanCreateCta;

  /// Label for the planned macro totals
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get dashboardMealPlanSummaryPlanned;

  /// Label for the completed macro totals
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get dashboardMealPlanSummaryDone;

  /// Title of the Pro upsell teaser on the dashboard
  ///
  /// In en, this message translates to:
  /// **'Unlock AI insights'**
  String get dashboardUnlockAiInsightsTitle;

  /// Default message for the Pro upsell teaser
  ///
  /// In en, this message translates to:
  /// **'Go Pro for personalized training analysis.'**
  String get dashboardUnlockAiInsightsMessage;

  /// Title of the unlocked AI insights card
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get dashboardInsightsTitle;

  /// Title of the plate calculator entry button
  ///
  /// In en, this message translates to:
  /// **'Plate calculator'**
  String get dashboardPlateCalculatorTitle;

  /// Subtitle of the plate calculator entry button
  ///
  /// In en, this message translates to:
  /// **'Calculate plates or sum a loaded bar'**
  String get dashboardPlateCalculatorSubtitle;

  /// Eyebrow label inside the plate calculator card
  ///
  /// In en, this message translates to:
  /// **'PLATE CALCULATOR'**
  String get dashboardPlateCalculatorEyebrow;

  /// Mode toggle: calculate plates from a target weight
  ///
  /// In en, this message translates to:
  /// **'Calculate'**
  String get dashboardPlateModeCalculate;

  /// Mode toggle: sum a loaded bar from plate counts
  ///
  /// In en, this message translates to:
  /// **'Sum plates'**
  String get dashboardPlateModeSumPlates;

  /// Label for the target weight input
  ///
  /// In en, this message translates to:
  /// **'Target weight'**
  String get dashboardPlateTargetWeightLabel;

  /// Section label for per-plate count inputs
  ///
  /// In en, this message translates to:
  /// **'Plates per side'**
  String get dashboardPlatesPerSideLabel;

  /// Empty state prompting a target weight
  ///
  /// In en, this message translates to:
  /// **'Enter a target weight.'**
  String get dashboardPlateEnterTargetMessage;

  /// Label for the per-side loaded weight
  ///
  /// In en, this message translates to:
  /// **'Per side'**
  String get dashboardPlatePerSideLabel;

  /// Label for the total loadable weight in target mode
  ///
  /// In en, this message translates to:
  /// **'Loadable'**
  String get dashboardPlateLoadableLabel;

  /// Label for the total current weight in sum-plates mode
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get dashboardPlateCurrentLabel;

  /// Shown when the target weight is at or below the bar's own weight
  ///
  /// In en, this message translates to:
  /// **'Use the {bar} kg bar only.'**
  String dashboardPlateUseBarOnlyMessage(String bar);

  /// Shown when the target weight can't be loaded exactly
  ///
  /// In en, this message translates to:
  /// **'{weight} kg is not exactly loadable with 2.5 kg plates.'**
  String dashboardPlateNotExactMessage(String weight);

  /// Separator shown before the alternative plate combination (e.g. '1 × 25  or  2 × 20')
  ///
  /// In en, this message translates to:
  /// **'or'**
  String get dashboardPlateAltSetLabel;

  /// Shown when the target is met by the bar alone
  ///
  /// In en, this message translates to:
  /// **'No plates needed.'**
  String get dashboardPlateNoPlatesNeededMessage;

  /// Shown in sum-plates mode when no plates are counted
  ///
  /// In en, this message translates to:
  /// **'Bar only. Add plates per side.'**
  String get dashboardPlateBarOnlyMessage;

  /// Label for a selectable bar weight, and the bar sublabel on the barbell visual
  ///
  /// In en, this message translates to:
  /// **'{weight} kg bar'**
  String dashboardPlateBarWeightLabel(String weight);

  /// No description provided for @trainingNewPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'New plan'**
  String get trainingNewPlanTitle;

  /// No description provided for @trainingEditPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit plan'**
  String get trainingEditPlanTitle;

  /// No description provided for @trainingDuplicatePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Duplicate plan'**
  String get trainingDuplicatePlanTitle;

  /// No description provided for @trainingCreatePlanCta.
  ///
  /// In en, this message translates to:
  /// **'Create plan'**
  String get trainingCreatePlanCta;

  /// No description provided for @trainingCreateCopyCta.
  ///
  /// In en, this message translates to:
  /// **'Create copy'**
  String get trainingCreateCopyCta;

  /// No description provided for @trainingDuplicatePlanName.
  ///
  /// In en, this message translates to:
  /// **'{name} copy'**
  String trainingDuplicatePlanName(String name);

  /// No description provided for @trainingPickDatesError.
  ///
  /// In en, this message translates to:
  /// **'Pick start and end dates'**
  String get trainingPickDatesError;

  /// No description provided for @trainingEndAfterStartError.
  ///
  /// In en, this message translates to:
  /// **'End date must be after start date'**
  String get trainingEndAfterStartError;

  /// No description provided for @trainingPlanNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan name'**
  String get trainingPlanNameLabel;

  /// No description provided for @trainingPlanNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Off-season hypertrophy'**
  String get trainingPlanNameHint;

  /// No description provided for @trainingPlanNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter a name (2+ chars)'**
  String get trainingPlanNameError;

  /// No description provided for @trainingStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get trainingStartLabel;

  /// No description provided for @trainingEndLabel.
  ///
  /// In en, this message translates to:
  /// **'End'**
  String get trainingEndLabel;

  /// No description provided for @trainingPickDateCta.
  ///
  /// In en, this message translates to:
  /// **'Pick'**
  String get trainingPickDateCta;

  /// No description provided for @trainingCoachBadge.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get trainingCoachBadge;

  /// No description provided for @trainingPlanActive.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get trainingPlanActive;

  /// No description provided for @trainingPlanInactive.
  ///
  /// In en, this message translates to:
  /// **'Inactive'**
  String get trainingPlanInactive;

  /// No description provided for @trainingCoachPlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Coach plan'**
  String get trainingCoachPlanTooltip;

  /// No description provided for @trainingDeactivatePlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Deactivate plan'**
  String get trainingDeactivatePlanTooltip;

  /// No description provided for @trainingActivatePlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Activate plan'**
  String get trainingActivatePlanTooltip;

  /// No description provided for @trainingExportPlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Export plan'**
  String get trainingExportPlanTooltip;

  /// No description provided for @trainingReviewPlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Review plan'**
  String get trainingReviewPlanTooltip;

  /// No description provided for @trainingDeletePlanTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete plan'**
  String get trainingDeletePlanTooltip;

  /// No description provided for @trainingMuscleChest.
  ///
  /// In en, this message translates to:
  /// **'Chest'**
  String get trainingMuscleChest;

  /// No description provided for @trainingMuscleBack.
  ///
  /// In en, this message translates to:
  /// **'Back'**
  String get trainingMuscleBack;

  /// No description provided for @trainingMuscleShoulders.
  ///
  /// In en, this message translates to:
  /// **'Shoulders'**
  String get trainingMuscleShoulders;

  /// No description provided for @trainingMuscleBiceps.
  ///
  /// In en, this message translates to:
  /// **'Biceps'**
  String get trainingMuscleBiceps;

  /// No description provided for @trainingMuscleTriceps.
  ///
  /// In en, this message translates to:
  /// **'Triceps'**
  String get trainingMuscleTriceps;

  /// No description provided for @trainingMuscleForearms.
  ///
  /// In en, this message translates to:
  /// **'Forearms'**
  String get trainingMuscleForearms;

  /// No description provided for @trainingMuscleAbs.
  ///
  /// In en, this message translates to:
  /// **'Abs'**
  String get trainingMuscleAbs;

  /// No description provided for @trainingMuscleQuads.
  ///
  /// In en, this message translates to:
  /// **'Quads'**
  String get trainingMuscleQuads;

  /// No description provided for @trainingMuscleHamstrings.
  ///
  /// In en, this message translates to:
  /// **'Hamstrings'**
  String get trainingMuscleHamstrings;

  /// No description provided for @trainingMuscleGlutes.
  ///
  /// In en, this message translates to:
  /// **'Glutes'**
  String get trainingMuscleGlutes;

  /// No description provided for @trainingMuscleCalves.
  ///
  /// In en, this message translates to:
  /// **'Calves'**
  String get trainingMuscleCalves;

  /// No description provided for @trainingMuscleFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full Body'**
  String get trainingMuscleFullBody;

  /// No description provided for @trainingCardio.
  ///
  /// In en, this message translates to:
  /// **'Cardio'**
  String get trainingCardio;

  /// No description provided for @trainingMuscleTraps.
  ///
  /// In en, this message translates to:
  /// **'Traps'**
  String get trainingMuscleTraps;

  /// No description provided for @trainingMuscleNeck.
  ///
  /// In en, this message translates to:
  /// **'Neck'**
  String get trainingMuscleNeck;

  /// No description provided for @trainingMuscleAdductors.
  ///
  /// In en, this message translates to:
  /// **'Adductors'**
  String get trainingMuscleAdductors;

  /// No description provided for @trainingMuscleAbductors.
  ///
  /// In en, this message translates to:
  /// **'Abductors'**
  String get trainingMuscleAbductors;

  /// No description provided for @trainingExerciseNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get trainingExerciseNameLabel;

  /// No description provided for @trainingExerciseNameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Pause squat'**
  String get trainingExerciseNameHint;

  /// No description provided for @trainingExerciseNameError.
  ///
  /// In en, this message translates to:
  /// **'Name is required'**
  String get trainingExerciseNameError;

  /// No description provided for @trainingDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get trainingDescriptionLabel;

  /// No description provided for @trainingDescriptionHint.
  ///
  /// In en, this message translates to:
  /// **'Optional coaching note'**
  String get trainingDescriptionHint;

  /// No description provided for @trainingKindLabel.
  ///
  /// In en, this message translates to:
  /// **'Kind'**
  String get trainingKindLabel;

  /// No description provided for @trainingKindStrength.
  ///
  /// In en, this message translates to:
  /// **'Strength'**
  String get trainingKindStrength;

  /// No description provided for @trainingPrimaryMuscleGroupLabel.
  ///
  /// In en, this message translates to:
  /// **'Primary muscle group'**
  String get trainingPrimaryMuscleGroupLabel;

  /// No description provided for @trainingSecondaryMuscleGroupsLabel.
  ///
  /// In en, this message translates to:
  /// **'Secondary muscle groups'**
  String get trainingSecondaryMuscleGroupsLabel;

  /// No description provided for @trainingIntRangeError.
  ///
  /// In en, this message translates to:
  /// **'{min}–{max}'**
  String trainingIntRangeError(String min, String max);

  /// No description provided for @trainingSetsLabel.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get trainingSetsLabel;

  /// No description provided for @trainingRepsLabel.
  ///
  /// In en, this message translates to:
  /// **'Reps'**
  String get trainingRepsLabel;

  /// No description provided for @trainingWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight ({unit})'**
  String trainingWeightLabel(String unit);

  /// No description provided for @trainingOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'opt.'**
  String get trainingOptionalHint;

  /// No description provided for @trainingWeightRangeError.
  ///
  /// In en, this message translates to:
  /// **'0–{max}'**
  String trainingWeightRangeError(String max);

  /// No description provided for @trainingNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get trainingNotesLabel;

  /// No description provided for @trainingNotesHint.
  ///
  /// In en, this message translates to:
  /// **'Optional cue or instruction'**
  String get trainingNotesHint;

  /// No description provided for @trainingSetTitle.
  ///
  /// In en, this message translates to:
  /// **'Set {setNumber} · {exerciseName}'**
  String trainingSetTitle(int setNumber, String exerciseName);

  /// No description provided for @trainingRpeLabel.
  ///
  /// In en, this message translates to:
  /// **'RPE'**
  String get trainingRpeLabel;

  /// Title for the RPE picker sheet
  ///
  /// In en, this message translates to:
  /// **'Set {setNumber} · RPE'**
  String trainingRpePickerTitle(int setNumber);

  /// Subtitle for the RPE picker sheet
  ///
  /// In en, this message translates to:
  /// **'How hard was that set?'**
  String get trainingRpePickerSubtitle;

  /// No description provided for @trainingWeekRecommendationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recommendations'**
  String get trainingWeekRecommendationsTitle;

  /// No description provided for @trainingWeekLowCompletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Repeat or simplify this week'**
  String get trainingWeekLowCompletionTitle;

  /// No description provided for @trainingWeekLowCompletionBody.
  ///
  /// In en, this message translates to:
  /// **'Completion is low. Keep load steady until key sessions are completed consistently.'**
  String get trainingWeekLowCompletionBody;

  /// No description provided for @trainingWeekCompletionDetail.
  ///
  /// In en, this message translates to:
  /// **'Completion: {percent}%'**
  String trainingWeekCompletionDetail(int percent);

  /// No description provided for @trainingWeekLowVolumeTitle.
  ///
  /// In en, this message translates to:
  /// **'Volume below plan'**
  String get trainingWeekLowVolumeTitle;

  /// No description provided for @trainingWeekLowVolumeBody.
  ///
  /// In en, this message translates to:
  /// **'Actual volume is below the plan. Rebuild consistency before increasing load.'**
  String get trainingWeekLowVolumeBody;

  /// No description provided for @trainingWeekVolumeDetail.
  ///
  /// In en, this message translates to:
  /// **'Volume vs plan: {percent}%'**
  String trainingWeekVolumeDetail(int percent);

  /// No description provided for @trainingWeekHighEffortTitle.
  ///
  /// In en, this message translates to:
  /// **'High effort week'**
  String get trainingWeekHighEffortTitle;

  /// No description provided for @trainingWeekHighEffortBody.
  ///
  /// In en, this message translates to:
  /// **'Average RPE is high. Watch recovery before adding more intensity.'**
  String get trainingWeekHighEffortBody;

  /// No description provided for @trainingWeekAverageRpeDetail.
  ///
  /// In en, this message translates to:
  /// **'Average RPE: {rpe}'**
  String trainingWeekAverageRpeDetail(String rpe);

  /// No description provided for @trainingWeekMissedDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Missed training days'**
  String get trainingWeekMissedDaysTitle;

  /// No description provided for @trainingWeekMissedDaysBody.
  ///
  /// In en, this message translates to:
  /// **'Move the missed work only if it will not crowd the next training days.'**
  String get trainingWeekMissedDaysBody;

  /// No description provided for @trainingWeekMissedDaysDetail.
  ///
  /// In en, this message translates to:
  /// **'Missed days: {count}'**
  String trainingWeekMissedDaysDetail(int count);

  /// No description provided for @trainingWeekOnTrackTitle.
  ///
  /// In en, this message translates to:
  /// **'Week is on track'**
  String get trainingWeekOnTrackTitle;

  /// No description provided for @trainingWeekOnTrackBody.
  ///
  /// In en, this message translates to:
  /// **'Completion and volume are close to target. Keep the next week steady.'**
  String get trainingWeekOnTrackBody;

  /// No description provided for @trainingWeekNoMajorWarningDetail.
  ///
  /// In en, this message translates to:
  /// **'No major warning'**
  String get trainingWeekNoMajorWarningDetail;

  /// No description provided for @trainingMarkCompleteCta.
  ///
  /// In en, this message translates to:
  /// **'Mark complete'**
  String get trainingMarkCompleteCta;

  /// No description provided for @trainingFullGymDefault.
  ///
  /// In en, this message translates to:
  /// **'Full gym'**
  String get trainingFullGymDefault;

  /// No description provided for @trainingGoalBuildMuscle.
  ///
  /// In en, this message translates to:
  /// **'Build muscle'**
  String get trainingGoalBuildMuscle;

  /// No description provided for @trainingGoalGainStrength.
  ///
  /// In en, this message translates to:
  /// **'Gain strength'**
  String get trainingGoalGainStrength;

  /// No description provided for @trainingGoalLoseFat.
  ///
  /// In en, this message translates to:
  /// **'Lose fat'**
  String get trainingGoalLoseFat;

  /// No description provided for @trainingGoalGeneralFitness.
  ///
  /// In en, this message translates to:
  /// **'General fitness'**
  String get trainingGoalGeneralFitness;

  /// No description provided for @trainingExperienceBeginner.
  ///
  /// In en, this message translates to:
  /// **'Beginner'**
  String get trainingExperienceBeginner;

  /// No description provided for @trainingExperienceIntermediate.
  ///
  /// In en, this message translates to:
  /// **'Intermediate'**
  String get trainingExperienceIntermediate;

  /// No description provided for @trainingExperienceAdvanced.
  ///
  /// In en, this message translates to:
  /// **'Advanced'**
  String get trainingExperienceAdvanced;

  /// No description provided for @trainingSplitFullBody.
  ///
  /// In en, this message translates to:
  /// **'Full body'**
  String get trainingSplitFullBody;

  /// No description provided for @trainingSplitUpperLower.
  ///
  /// In en, this message translates to:
  /// **'Upper / lower'**
  String get trainingSplitUpperLower;

  /// No description provided for @trainingSplitPushPullLegs.
  ///
  /// In en, this message translates to:
  /// **'Push pull legs'**
  String get trainingSplitPushPullLegs;

  /// No description provided for @trainingSplitBroSplit.
  ///
  /// In en, this message translates to:
  /// **'Bro split'**
  String get trainingSplitBroSplit;

  /// No description provided for @trainingPickValidDatesError.
  ///
  /// In en, this message translates to:
  /// **'Pick a valid start and end date.'**
  String get trainingPickValidDatesError;

  /// No description provided for @trainingAiGeneratePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Generate plan with AI'**
  String get trainingAiGeneratePlanTitle;

  /// No description provided for @trainingAiGeneratePlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Answer a few questions and AI drafts a full training block you can edit afterwards.'**
  String get trainingAiGeneratePlanSubtitle;

  /// No description provided for @trainingGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get trainingGoalLabel;

  /// No description provided for @trainingExperienceLabel.
  ///
  /// In en, this message translates to:
  /// **'Experience'**
  String get trainingExperienceLabel;

  /// No description provided for @trainingSplitPreferenceLabel.
  ///
  /// In en, this message translates to:
  /// **'Split preference'**
  String get trainingSplitPreferenceLabel;

  /// No description provided for @trainingDaysPerWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Training days / week'**
  String get trainingDaysPerWeekLabel;

  /// No description provided for @trainingSessionLengthLabel.
  ///
  /// In en, this message translates to:
  /// **'Session length (min)'**
  String get trainingSessionLengthLabel;

  /// No description provided for @trainingEquipmentLabel.
  ///
  /// In en, this message translates to:
  /// **'Equipment'**
  String get trainingEquipmentLabel;

  /// No description provided for @trainingEquipmentHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Full gym, dumbbells only, home'**
  String get trainingEquipmentHint;

  /// No description provided for @trainingEquipmentError.
  ///
  /// In en, this message translates to:
  /// **'Describe your equipment'**
  String get trainingEquipmentError;

  /// No description provided for @trainingPlanNameOptionalLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan name (optional)'**
  String get trainingPlanNameOptionalLabel;

  /// No description provided for @trainingPlanNameOptionalHint.
  ///
  /// In en, this message translates to:
  /// **'Leave blank to let AI name it'**
  String get trainingPlanNameOptionalHint;

  /// No description provided for @trainingGeneratePlanCta.
  ///
  /// In en, this message translates to:
  /// **'Generate plan'**
  String get trainingGeneratePlanCta;

  /// No description provided for @trainingAiDesigningMessage.
  ///
  /// In en, this message translates to:
  /// **'AI is designing your plan… this can take a few seconds.'**
  String get trainingAiDesigningMessage;

  /// No description provided for @trainingAiProFeatureError.
  ///
  /// In en, this message translates to:
  /// **'AI plans are a Pro feature. Upgrade to use this.'**
  String get trainingAiProFeatureError;

  /// No description provided for @trainingAiLimitReachedError.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached your AI limit. Try again later.'**
  String get trainingAiLimitReachedError;

  /// No description provided for @trainingCustomExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom exercise'**
  String get trainingCustomExerciseTitle;

  /// No description provided for @trainingCreateExerciseCta.
  ///
  /// In en, this message translates to:
  /// **'Create exercise'**
  String get trainingCreateExerciseCta;

  /// No description provided for @trainingAddExerciseCta.
  ///
  /// In en, this message translates to:
  /// **'Add exercise'**
  String get trainingAddExerciseCta;

  /// No description provided for @trainingNewCustomExerciseCta.
  ///
  /// In en, this message translates to:
  /// **'New custom exercise'**
  String get trainingNewCustomExerciseCta;

  /// No description provided for @trainingSearchExercisesHint.
  ///
  /// In en, this message translates to:
  /// **'Search exercises'**
  String get trainingSearchExercisesHint;

  /// No description provided for @trainingNoExercisesFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No exercises found.'**
  String get trainingNoExercisesFoundMessage;

  /// No description provided for @trainingUseExerciseCta.
  ///
  /// In en, this message translates to:
  /// **'Use exercise'**
  String get trainingUseExerciseCta;

  /// No description provided for @trainingEditExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Edit exercise'**
  String get trainingEditExerciseTitle;

  /// No description provided for @trainingDeleteCustomExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete custom exercise?'**
  String get trainingDeleteCustomExerciseTitle;

  /// No description provided for @trainingDeleteCustomExerciseMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from your exercise library?'**
  String trainingDeleteCustomExerciseMessage(String name);

  /// No description provided for @trainingExerciseCreatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Exercise created'**
  String get trainingExerciseCreatedSnackbar;

  /// No description provided for @trainingExerciseUpdatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Exercise updated'**
  String get trainingExerciseUpdatedSnackbar;

  /// No description provided for @trainingDeleteExerciseTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete exercise?'**
  String get trainingDeleteExerciseTitle;

  /// No description provided for @trainingDeleteExerciseMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" will be removed from your library.'**
  String trainingDeleteExerciseMessage(String name);

  /// No description provided for @trainingExerciseDeletedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Exercise deleted'**
  String get trainingExerciseDeletedSnackbar;

  /// No description provided for @trainingExerciseLibraryTitle.
  ///
  /// In en, this message translates to:
  /// **'Exercise Library'**
  String get trainingExerciseLibraryTitle;

  /// No description provided for @trainingCustomLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get trainingCustomLabel;

  /// No description provided for @trainingExerciseLibraryEyebrow.
  ///
  /// In en, this message translates to:
  /// **'EXERCISE LIBRARY'**
  String get trainingExerciseLibraryEyebrow;

  /// No description provided for @trainingTemplatesCount.
  ///
  /// In en, this message translates to:
  /// **'{count} templates'**
  String trainingTemplatesCount(int count);

  /// No description provided for @trainingCustomExercisesAvailable.
  ///
  /// In en, this message translates to:
  /// **'{count} custom exercises available for planning sessions.'**
  String trainingCustomExercisesAvailable(int count);

  /// No description provided for @trainingNoExercisesMatchFilterMessage.
  ///
  /// In en, this message translates to:
  /// **'No exercises match this filter.'**
  String get trainingNoExercisesMatchFilterMessage;

  /// No description provided for @trainingPrimaryMovementSuffix.
  ///
  /// In en, this message translates to:
  /// **'primary movement'**
  String get trainingPrimaryMovementSuffix;

  /// No description provided for @trainingPrWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'PR {weight} {unit}'**
  String trainingPrWeightLabel(String weight, String unit);

  /// No description provided for @trainingBalanceCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'Balance check'**
  String get trainingBalanceCheckTitle;

  /// No description provided for @trainingAiBalanceCheckTitle.
  ///
  /// In en, this message translates to:
  /// **'AI balance check'**
  String get trainingAiBalanceCheckTitle;

  /// No description provided for @trainingAiBalanceCheckSubtitle.
  ///
  /// In en, this message translates to:
  /// **'How well this plan distributes training across the body.'**
  String get trainingAiBalanceCheckSubtitle;

  /// No description provided for @trainingReviewingPlanMessage.
  ///
  /// In en, this message translates to:
  /// **'Reviewing your plan…'**
  String get trainingReviewingPlanMessage;

  /// No description provided for @trainingBalanceReviewFallback.
  ///
  /// In en, this message translates to:
  /// **'Balance review'**
  String get trainingBalanceReviewFallback;

  /// No description provided for @trainingLookingBalancedTitle.
  ///
  /// In en, this message translates to:
  /// **'Looking balanced'**
  String get trainingLookingBalancedTitle;

  /// No description provided for @trainingNoWarningsMessage.
  ///
  /// In en, this message translates to:
  /// **'No warnings or suggestions for this plan.'**
  String get trainingNoWarningsMessage;

  /// No description provided for @trainingDesignAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Design analysis'**
  String get trainingDesignAnalysisTitle;

  /// No description provided for @trainingPlanDesignAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan design analysis'**
  String get trainingPlanDesignAnalysisTitle;

  /// No description provided for @trainingPlanDesignAnalysisSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Structure, workload, muscle coverage, and recovery risk.'**
  String get trainingPlanDesignAnalysisSubtitle;

  /// No description provided for @trainingAnalyzingDesignMessage.
  ///
  /// In en, this message translates to:
  /// **'Analyzing plan design…'**
  String get trainingAnalyzingDesignMessage;

  /// No description provided for @trainingStructureLabel.
  ///
  /// In en, this message translates to:
  /// **'Structure'**
  String get trainingStructureLabel;

  /// No description provided for @trainingTotalWeeksLabel.
  ///
  /// In en, this message translates to:
  /// **'Total weeks'**
  String get trainingTotalWeeksLabel;

  /// No description provided for @trainingTrainingDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Training days'**
  String get trainingTrainingDaysLabel;

  /// No description provided for @trainingRestDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Rest days'**
  String get trainingRestDaysLabel;

  /// No description provided for @trainingAvgDaysPerWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg days/wk'**
  String get trainingAvgDaysPerWeekLabel;

  /// No description provided for @trainingWorkloadLabel.
  ///
  /// In en, this message translates to:
  /// **'Workload'**
  String get trainingWorkloadLabel;

  /// No description provided for @trainingExercisesLabel.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get trainingExercisesLabel;

  /// No description provided for @trainingSetsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Sets'**
  String get trainingSetsCountLabel;

  /// No description provided for @trainingRepVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Rep volume'**
  String get trainingRepVolumeLabel;

  /// No description provided for @trainingTonnageLabel.
  ///
  /// In en, this message translates to:
  /// **'Tonnage'**
  String get trainingTonnageLabel;

  /// No description provided for @trainingMuscleCoverageLabel.
  ///
  /// In en, this message translates to:
  /// **'Muscle coverage'**
  String get trainingMuscleCoverageLabel;

  /// No description provided for @trainingRecoveryRisksTitle.
  ///
  /// In en, this message translates to:
  /// **'Recovery risks'**
  String get trainingRecoveryRisksTitle;

  /// No description provided for @trainingDominantLabel.
  ///
  /// In en, this message translates to:
  /// **'Dominant'**
  String get trainingDominantLabel;

  /// No description provided for @trainingUndertrainedLabel.
  ///
  /// In en, this message translates to:
  /// **'Undertrained'**
  String get trainingUndertrainedLabel;

  /// No description provided for @trainingPlanFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get trainingPlanFallbackTitle;

  /// No description provided for @trainingPlanActionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Plan actions'**
  String get trainingPlanActionsTooltip;

  /// No description provided for @trainingTrainingWeeksLabel.
  ///
  /// In en, this message translates to:
  /// **'Training weeks'**
  String get trainingTrainingWeeksLabel;

  /// No description provided for @trainingTotalCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} total'**
  String trainingTotalCountLabel(int count);

  /// No description provided for @trainingDeletePlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete plan?'**
  String get trainingDeletePlanTitle;

  /// No description provided for @trainingDeletePlanMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" will be permanently removed.'**
  String trainingDeletePlanMessage(String name);

  /// No description provided for @trainingWeekComplete.
  ///
  /// In en, this message translates to:
  /// **'Complete'**
  String get trainingWeekComplete;

  /// No description provided for @trainingWeekInFocus.
  ///
  /// In en, this message translates to:
  /// **'In focus'**
  String get trainingWeekInFocus;

  /// No description provided for @trainingWeekNeedsCheck.
  ///
  /// In en, this message translates to:
  /// **'Needs check'**
  String get trainingWeekNeedsCheck;

  /// No description provided for @trainingWeekScheduled.
  ///
  /// In en, this message translates to:
  /// **'Scheduled'**
  String get trainingWeekScheduled;

  /// No description provided for @trainingRenameWeekTooltip.
  ///
  /// In en, this message translates to:
  /// **'Rename week'**
  String get trainingRenameWeekTooltip;

  /// No description provided for @trainingPlanTimelineLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan timeline'**
  String get trainingPlanTimelineLabel;

  /// No description provided for @trainingWeeksSummary.
  ///
  /// In en, this message translates to:
  /// **'{weeks} weeks - {completedDays}/{totalDays} days complete'**
  String trainingWeeksSummary(int weeks, int completedDays, int totalDays);

  /// No description provided for @trainingWeeksDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Weeks done'**
  String get trainingWeeksDoneLabel;

  /// No description provided for @trainingWeekMark.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get trainingWeekMark;

  /// No description provided for @trainingReviewWeekMessage.
  ///
  /// In en, this message translates to:
  /// **'Review this week before continuing.'**
  String get trainingReviewWeekMessage;

  /// No description provided for @trainingWeekNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Week name'**
  String get trainingWeekNameLabel;

  /// No description provided for @trainingWeekFallbackTitle.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get trainingWeekFallbackTitle;

  /// No description provided for @trainingExercisesCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} exercises'**
  String trainingExercisesCountLabel(int completed, int total);

  /// No description provided for @trainingNoExercisesPlannedMessage.
  ///
  /// In en, this message translates to:
  /// **'No exercises planned'**
  String get trainingNoExercisesPlannedMessage;

  /// No description provided for @trainingDayActionsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Day actions'**
  String get trainingDayActionsTooltip;

  /// No description provided for @trainingMarkNormalCta.
  ///
  /// In en, this message translates to:
  /// **'Mark normal'**
  String get trainingMarkNormalCta;

  /// No description provided for @trainingMarkRestCta.
  ///
  /// In en, this message translates to:
  /// **'Mark rest'**
  String get trainingMarkRestCta;

  /// No description provided for @trainingMarkMissedCta.
  ///
  /// In en, this message translates to:
  /// **'Mark missed'**
  String get trainingMarkMissedCta;

  /// No description provided for @trainingCopyToDayCta.
  ///
  /// In en, this message translates to:
  /// **'Copy to day'**
  String get trainingCopyToDayCta;

  /// No description provided for @trainingTargetDayOption.
  ///
  /// In en, this message translates to:
  /// **'{dayOfWeek} - {date}'**
  String trainingTargetDayOption(String dayOfWeek, String date);

  /// No description provided for @trainingNoTargetDaysMessage.
  ///
  /// In en, this message translates to:
  /// **'No target days available.'**
  String get trainingNoTargetDaysMessage;

  /// No description provided for @trainingWeekExecutionLabel.
  ///
  /// In en, this message translates to:
  /// **'Week execution'**
  String get trainingWeekExecutionLabel;

  /// No description provided for @trainingWeekExecutionSummary.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} days complete - {completedExercises}/{exercises} exercises'**
  String trainingWeekExecutionSummary(
    int completed,
    int total,
    int completedExercises,
    int exercises,
  );

  /// No description provided for @trainingRecoveryDayMessage.
  ///
  /// In en, this message translates to:
  /// **'Recovery day'**
  String get trainingRecoveryDayMessage;

  /// No description provided for @trainingDayNeedsReviewMessage.
  ///
  /// In en, this message translates to:
  /// **'This day needs review.'**
  String get trainingDayNeedsReviewMessage;

  /// No description provided for @trainingPlanCreatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Plan created'**
  String get trainingPlanCreatedSnackbar;

  /// No description provided for @trainingAiPlanCreatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'AI plan created'**
  String get trainingAiPlanCreatedSnackbar;

  /// No description provided for @trainingCsvCopiedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'CSV for \"{name}\" copied'**
  String trainingCsvCopiedSnackbar(String name);

  /// No description provided for @trainingDeleteClientPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete client plan?'**
  String get trainingDeleteClientPlanTitle;

  /// No description provided for @trainingDeleteClientPlanMessage.
  ///
  /// In en, this message translates to:
  /// **'\"{name}\" for {owner} will be permanently removed.'**
  String trainingDeleteClientPlanMessage(String name, String owner);

  /// No description provided for @trainingMyPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'My plans'**
  String get trainingMyPlansTitle;

  /// No description provided for @trainingMyPlansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count}/unlimited plan'**
  String trainingMyPlansSubtitle(int count);

  /// No description provided for @trainingAiStarterCta.
  ///
  /// In en, this message translates to:
  /// **'AI starter'**
  String get trainingAiStarterCta;

  /// No description provided for @trainingNoPersonalPlansMessage.
  ///
  /// In en, this message translates to:
  /// **'No personal plans yet.'**
  String get trainingNoPersonalPlansMessage;

  /// No description provided for @trainingCoachPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Coach plans'**
  String get trainingCoachPlansTitle;

  /// No description provided for @trainingCoachPlansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{count} plan'**
  String trainingCoachPlansSubtitle(int count);

  /// No description provided for @trainingClientPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Client plans'**
  String get trainingClientPlansTitle;

  /// No description provided for @trainingNoClientPlansMessage.
  ///
  /// In en, this message translates to:
  /// **'No client plans yet. Build one from a client profile.'**
  String get trainingNoClientPlansMessage;

  /// No description provided for @trainingPlansBuiltForClientsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plans you built for clients'**
  String get trainingPlansBuiltForClientsSubtitle;

  /// No description provided for @trainingClientPlansCountSubtitle.
  ///
  /// In en, this message translates to:
  /// **'{plans, plural, one {1 plan} other {{plans} plans}} · {clients, plural, one {1 client} other {{clients} clients}}'**
  String trainingClientPlansCountSubtitle(int plans, int clients);

  /// No description provided for @trainingPlansHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get trainingPlansHeaderTitle;

  /// No description provided for @trainingPlansHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build, review, and manage your training blocks.'**
  String get trainingPlansHeaderSubtitle;

  /// No description provided for @trainingWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout'**
  String get trainingWorkoutTitle;

  /// No description provided for @trainingCompleteAllTooltip.
  ///
  /// In en, this message translates to:
  /// **'Complete all'**
  String get trainingCompleteAllTooltip;

  /// No description provided for @trainingDoneReorderingTooltip.
  ///
  /// In en, this message translates to:
  /// **'Done reordering'**
  String get trainingDoneReorderingTooltip;

  /// No description provided for @trainingReorderExercisesTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reorder exercises'**
  String get trainingReorderExercisesTooltip;

  /// No description provided for @trainingNoExercisesForDayMessage.
  ///
  /// In en, this message translates to:
  /// **'No exercises for this day.'**
  String get trainingNoExercisesForDayMessage;

  /// No description provided for @trainingRemoveExerciseMessage.
  ///
  /// In en, this message translates to:
  /// **'Remove \"{name}\" from this workout?'**
  String trainingRemoveExerciseMessage(String name);

  /// No description provided for @trainingCompetitionChip.
  ///
  /// In en, this message translates to:
  /// **'Competition'**
  String get trainingCompetitionChip;

  /// No description provided for @trainingSkipUnskipTooltip.
  ///
  /// In en, this message translates to:
  /// **'Skip or unskip exercise'**
  String get trainingSkipUnskipTooltip;

  /// No description provided for @trainingDeleteExerciseTooltip.
  ///
  /// In en, this message translates to:
  /// **'Delete exercise'**
  String get trainingDeleteExerciseTooltip;

  /// No description provided for @trainingNoEstLabel.
  ///
  /// In en, this message translates to:
  /// **'No est.'**
  String get trainingNoEstLabel;

  /// No description provided for @trainingFinishCta.
  ///
  /// In en, this message translates to:
  /// **'Finish'**
  String get trainingFinishCta;

  /// No description provided for @trainingStartCta.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get trainingStartCta;

  /// No description provided for @trainingSaveTimeTooltip.
  ///
  /// In en, this message translates to:
  /// **'Save time'**
  String get trainingSaveTimeTooltip;

  /// No description provided for @trainingRepsSuffix.
  ///
  /// In en, this message translates to:
  /// **'reps'**
  String get trainingRepsSuffix;

  /// No description provided for @trainingSetLabel.
  ///
  /// In en, this message translates to:
  /// **'Set {number}'**
  String trainingSetLabel(int number);

  /// No description provided for @trainingMarkDoneTooltip.
  ///
  /// In en, this message translates to:
  /// **'Mark done'**
  String get trainingMarkDoneTooltip;

  /// No description provided for @trainingPlanCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan comments'**
  String get trainingPlanCommentsTitle;

  /// No description provided for @trainingWeekCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Week comments'**
  String get trainingWeekCommentsTitle;

  /// No description provided for @trainingWriteNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Write a note for this {scope}'**
  String trainingWriteNoteHint(String scope);

  /// No description provided for @trainingNoCommentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No comments'**
  String get trainingNoCommentsTitle;

  /// No description provided for @trainingNoCommentsMessage.
  ///
  /// In en, this message translates to:
  /// **'Comments between coach and client appear here.'**
  String get trainingNoCommentsMessage;

  /// No description provided for @trainingPlanCardProgress.
  ///
  /// In en, this message translates to:
  /// **'{completedWeeks}/{totalWeeks} wk · {completedDays}/{totalDays} d'**
  String trainingPlanCardProgress(
    int completedWeeks,
    int totalWeeks,
    int completedDays,
    int totalDays,
  );

  /// No description provided for @trainingPlanDuplicatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Plan duplicated'**
  String get trainingPlanDuplicatedSnackbar;

  /// No description provided for @trainingDaysCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} days'**
  String trainingDaysCountLabel(int completed, int total);

  /// No description provided for @trainingExercisesCopiedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'{count} exercises copied'**
  String trainingExercisesCopiedSnackbar(int count);

  /// No description provided for @trainingExportNoDataError.
  ///
  /// In en, this message translates to:
  /// **'Export returned no data.'**
  String get trainingExportNoDataError;

  /// No description provided for @trainingCouldNotLoadClientPlansMessage.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load client plans. Pull to refresh.'**
  String get trainingCouldNotLoadClientPlansMessage;

  /// No description provided for @trainingMinutesSecondsLabel.
  ///
  /// In en, this message translates to:
  /// **'m:s'**
  String get trainingMinutesSecondsLabel;

  /// No description provided for @trainingPrWeightNoSpaceLabel.
  ///
  /// In en, this message translates to:
  /// **'PR {weight}{unit}'**
  String trainingPrWeightNoSpaceLabel(String weight, String unit);

  /// No description provided for @trainingScopePlan.
  ///
  /// In en, this message translates to:
  /// **'plan'**
  String get trainingScopePlan;

  /// No description provided for @trainingScopeWeek.
  ///
  /// In en, this message translates to:
  /// **'week'**
  String get trainingScopeWeek;

  /// No description provided for @nutritionAddFoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Add food'**
  String get nutritionAddFoodTitle;

  /// No description provided for @nutritionAiEstimateCta.
  ///
  /// In en, this message translates to:
  /// **'AI estimate'**
  String get nutritionAiEstimateCta;

  /// No description provided for @nutritionAiLookupCta.
  ///
  /// In en, this message translates to:
  /// **'Look up with AI'**
  String get nutritionAiLookupCta;

  /// No description provided for @nutritionCustomCta.
  ///
  /// In en, this message translates to:
  /// **'Custom'**
  String get nutritionCustomCta;

  /// No description provided for @nutritionSearchFoodsLabel.
  ///
  /// In en, this message translates to:
  /// **'Search foods'**
  String get nutritionSearchFoodsLabel;

  /// No description provided for @nutritionSearchFoodsHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. rice, chicken'**
  String get nutritionSearchFoodsHint;

  /// No description provided for @nutritionTypeAtLeast2CharsMessage.
  ///
  /// In en, this message translates to:
  /// **'Type at least 2 characters to search.'**
  String get nutritionTypeAtLeast2CharsMessage;

  /// No description provided for @nutritionNoMatchesMessage.
  ///
  /// In en, this message translates to:
  /// **'No matches. Try \"AI estimate\" or \"Custom\" to add your own.'**
  String get nutritionNoMatchesMessage;

  /// No description provided for @nutritionNoResultsForQuery.
  ///
  /// In en, this message translates to:
  /// **'No results for \"{query}\"'**
  String nutritionNoResultsForQuery(String query);

  /// No description provided for @nutritionTypeFoodNameFirstMessage.
  ///
  /// In en, this message translates to:
  /// **'Type a food name first, then tap AI estimate.'**
  String get nutritionTypeFoodNameFirstMessage;

  /// No description provided for @nutritionAiProFeatureError.
  ///
  /// In en, this message translates to:
  /// **'AI estimation is a Pro feature. Upgrade to use it.'**
  String get nutritionAiProFeatureError;

  /// No description provided for @nutritionAiLimitReachedError.
  ///
  /// In en, this message translates to:
  /// **'You\'ve reached your AI limit. Try again later.'**
  String get nutritionAiLimitReachedError;

  /// No description provided for @nutritionLoggedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Logged {name}'**
  String nutritionLoggedSnackbar(String name);

  /// No description provided for @nutritionUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'Unit'**
  String get nutritionUnitLabel;

  /// No description provided for @nutritionGramsOption.
  ///
  /// In en, this message translates to:
  /// **'Grams'**
  String get nutritionGramsOption;

  /// No description provided for @nutritionServingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Servings'**
  String get nutritionServingsLabel;

  /// No description provided for @nutritionCustomFoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Custom food'**
  String get nutritionCustomFoodTitle;

  /// No description provided for @nutritionValuesPer100gMessage.
  ///
  /// In en, this message translates to:
  /// **'Values per 100 g.'**
  String get nutritionValuesPer100gMessage;

  /// No description provided for @nutritionNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get nutritionNameLabel;

  /// No description provided for @nutritionEnterNameError.
  ///
  /// In en, this message translates to:
  /// **'Enter a name'**
  String get nutritionEnterNameError;

  /// No description provided for @nutritionCaloriesPer100gLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories /100g'**
  String get nutritionCaloriesPer100gLabel;

  /// No description provided for @nutritionProteinLabel.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get nutritionProteinLabel;

  /// No description provided for @nutritionCarbsLabel.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get nutritionCarbsLabel;

  /// No description provided for @nutritionFatLabel.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get nutritionFatLabel;

  /// No description provided for @nutritionCreateAndLogCta.
  ///
  /// In en, this message translates to:
  /// **'Create & log'**
  String get nutritionCreateAndLogCta;

  /// No description provided for @nutritionNumberError.
  ///
  /// In en, this message translates to:
  /// **'Number'**
  String get nutritionNumberError;

  /// No description provided for @nutritionCreateMealPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Create meal plan'**
  String get nutritionCreateMealPlanTitle;

  /// No description provided for @nutritionDayCreateSegment.
  ///
  /// In en, this message translates to:
  /// **'Day Create'**
  String get nutritionDayCreateSegment;

  /// No description provided for @nutritionWeeklyCreateSegment.
  ///
  /// In en, this message translates to:
  /// **'Weekly Create'**
  String get nutritionWeeklyCreateSegment;

  /// No description provided for @nutritionCreateForLabel.
  ///
  /// In en, this message translates to:
  /// **'Create for'**
  String get nutritionCreateForLabel;

  /// No description provided for @nutritionWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Week'**
  String get nutritionWeekLabel;

  /// No description provided for @nutritionChooseDayCta.
  ///
  /// In en, this message translates to:
  /// **'Choose day'**
  String get nutritionChooseDayCta;

  /// No description provided for @nutritionMealLabel.
  ///
  /// In en, this message translates to:
  /// **'Meal'**
  String get nutritionMealLabel;

  /// No description provided for @nutritionRemoveMealTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove meal'**
  String get nutritionRemoveMealTooltip;

  /// No description provided for @nutritionNoFoodsAddedMessage.
  ///
  /// In en, this message translates to:
  /// **'No foods added.'**
  String get nutritionNoFoodsAddedMessage;

  /// No description provided for @nutritionMealBreakfast.
  ///
  /// In en, this message translates to:
  /// **'Breakfast'**
  String get nutritionMealBreakfast;

  /// No description provided for @nutritionMealLunch.
  ///
  /// In en, this message translates to:
  /// **'Lunch'**
  String get nutritionMealLunch;

  /// No description provided for @nutritionMealDinner.
  ///
  /// In en, this message translates to:
  /// **'Dinner'**
  String get nutritionMealDinner;

  /// No description provided for @nutritionMealSnack.
  ///
  /// In en, this message translates to:
  /// **'Snack'**
  String get nutritionMealSnack;

  /// No description provided for @nutritionAddMealCta.
  ///
  /// In en, this message translates to:
  /// **'Add meal'**
  String get nutritionAddMealCta;

  /// No description provided for @nutritionNotesLabel.
  ///
  /// In en, this message translates to:
  /// **'Notes'**
  String get nutritionNotesLabel;

  /// No description provided for @nutritionCreateDayCta.
  ///
  /// In en, this message translates to:
  /// **'Create day'**
  String get nutritionCreateDayCta;

  /// No description provided for @nutritionSelectFoodTitle.
  ///
  /// In en, this message translates to:
  /// **'Select food'**
  String get nutritionSelectFoodTitle;

  /// No description provided for @nutritionTypeAtLeast2CharsShortMessage.
  ///
  /// In en, this message translates to:
  /// **'Type at least 2 characters.'**
  String get nutritionTypeAtLeast2CharsShortMessage;

  /// No description provided for @nutritionNoFoodsFoundMessage.
  ///
  /// In en, this message translates to:
  /// **'No foods found.'**
  String get nutritionNoFoodsFoundMessage;

  /// No description provided for @nutritionRemoveFoodTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove food'**
  String get nutritionRemoveFoodTooltip;

  /// No description provided for @nutritionActivitySedentary.
  ///
  /// In en, this message translates to:
  /// **'Sedentary'**
  String get nutritionActivitySedentary;

  /// No description provided for @nutritionActivityLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get nutritionActivityLight;

  /// No description provided for @nutritionActivityModerate.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get nutritionActivityModerate;

  /// No description provided for @nutritionActivityVeryActive.
  ///
  /// In en, this message translates to:
  /// **'Very Active'**
  String get nutritionActivityVeryActive;

  /// No description provided for @nutritionActivityAthlete.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get nutritionActivityAthlete;

  /// No description provided for @nutritionGoalCut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get nutritionGoalCut;

  /// No description provided for @nutritionGoalMaintain.
  ///
  /// In en, this message translates to:
  /// **'Maintain'**
  String get nutritionGoalMaintain;

  /// No description provided for @nutritionGoalBulk.
  ///
  /// In en, this message translates to:
  /// **'Bulk'**
  String get nutritionGoalBulk;

  /// No description provided for @nutritionProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition profile'**
  String get nutritionProfileTitle;

  /// No description provided for @nutritionGoalLabel.
  ///
  /// In en, this message translates to:
  /// **'Goal'**
  String get nutritionGoalLabel;

  /// No description provided for @nutritionActivityLevelLabel.
  ///
  /// In en, this message translates to:
  /// **'Activity level'**
  String get nutritionActivityLevelLabel;

  /// No description provided for @nutritionTargetWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Target weight ({unit})'**
  String nutritionTargetWeightLabel(String unit);

  /// No description provided for @nutritionRangeError.
  ///
  /// In en, this message translates to:
  /// **'Must be {min}–{max}'**
  String nutritionRangeError(String min, String max);

  /// No description provided for @nutritionCustomCalorieTargetLabel.
  ///
  /// In en, this message translates to:
  /// **'Custom calorie target (kcal)'**
  String get nutritionCustomCalorieTargetLabel;

  /// No description provided for @nutritionCalorieTargetHint.
  ///
  /// In en, this message translates to:
  /// **'Optional · 800–8000'**
  String get nutritionCalorieTargetHint;

  /// No description provided for @nutritionCalorieRangeError.
  ///
  /// In en, this message translates to:
  /// **'Must be 800–8000'**
  String get nutritionCalorieRangeError;

  /// No description provided for @nutritionProteinPerKgLabel.
  ///
  /// In en, this message translates to:
  /// **'Protein /kg'**
  String get nutritionProteinPerKgLabel;

  /// No description provided for @nutritionProteinPerKgHint.
  ///
  /// In en, this message translates to:
  /// **'0.5–4.0'**
  String get nutritionProteinPerKgHint;

  /// No description provided for @nutritionFatPerKgLabel.
  ///
  /// In en, this message translates to:
  /// **'Fat /kg'**
  String get nutritionFatPerKgLabel;

  /// No description provided for @nutritionFatPerKgHint.
  ///
  /// In en, this message translates to:
  /// **'0.2–2.0'**
  String get nutritionFatPerKgHint;

  /// No description provided for @nutritionSaveProfileCta.
  ///
  /// In en, this message translates to:
  /// **'Save profile'**
  String get nutritionSaveProfileCta;

  /// No description provided for @nutritionScreenTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get nutritionScreenTitle;

  /// No description provided for @nutritionEditProfileTooltip.
  ///
  /// In en, this message translates to:
  /// **'Edit profile'**
  String get nutritionEditProfileTooltip;

  /// No description provided for @nutritionMealPlanCreatedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Meal plan created'**
  String get nutritionMealPlanCreatedSnackbar;

  /// No description provided for @nutritionDailyTitle.
  ///
  /// In en, this message translates to:
  /// **'Daily nutrition'**
  String get nutritionDailyTitle;

  /// No description provided for @nutritionCalorieTargetTitle.
  ///
  /// In en, this message translates to:
  /// **'{calories} kcal target'**
  String nutritionCalorieTargetTitle(int calories);

  /// No description provided for @nutritionKcalRemaining.
  ///
  /// In en, this message translates to:
  /// **'{calories} kcal remaining'**
  String nutritionKcalRemaining(int calories);

  /// No description provided for @nutritionKcalOverTarget.
  ///
  /// In en, this message translates to:
  /// **'{calories} kcal over target'**
  String nutritionKcalOverTarget(int calories);

  /// No description provided for @nutritionTodayEyebrow.
  ///
  /// In en, this message translates to:
  /// **'TODAY'**
  String get nutritionTodayEyebrow;

  /// No description provided for @nutritionTodaysFoodEyebrow.
  ///
  /// In en, this message translates to:
  /// **'TODAY\'S FOOD'**
  String get nutritionTodaysFoodEyebrow;

  /// No description provided for @nutritionFoodLogEyebrow.
  ///
  /// In en, this message translates to:
  /// **'FOOD LOG'**
  String get nutritionFoodLogEyebrow;

  /// No description provided for @nutritionPreviousDayTooltip.
  ///
  /// In en, this message translates to:
  /// **'Previous day'**
  String get nutritionPreviousDayTooltip;

  /// No description provided for @nutritionNextDayTooltip.
  ///
  /// In en, this message translates to:
  /// **'Next day'**
  String get nutritionNextDayTooltip;

  /// No description provided for @nutritionWeekdayMonday.
  ///
  /// In en, this message translates to:
  /// **'Monday'**
  String get nutritionWeekdayMonday;

  /// No description provided for @nutritionWeekdayTuesday.
  ///
  /// In en, this message translates to:
  /// **'Tuesday'**
  String get nutritionWeekdayTuesday;

  /// No description provided for @nutritionWeekdayWednesday.
  ///
  /// In en, this message translates to:
  /// **'Wednesday'**
  String get nutritionWeekdayWednesday;

  /// No description provided for @nutritionWeekdayThursday.
  ///
  /// In en, this message translates to:
  /// **'Thursday'**
  String get nutritionWeekdayThursday;

  /// No description provided for @nutritionWeekdayFriday.
  ///
  /// In en, this message translates to:
  /// **'Friday'**
  String get nutritionWeekdayFriday;

  /// No description provided for @nutritionWeekdaySaturday.
  ///
  /// In en, this message translates to:
  /// **'Saturday'**
  String get nutritionWeekdaySaturday;

  /// No description provided for @nutritionWeekdaySunday.
  ///
  /// In en, this message translates to:
  /// **'Sunday'**
  String get nutritionWeekdaySunday;

  /// No description provided for @nutritionMealPlanEyebrow.
  ///
  /// In en, this message translates to:
  /// **'MEAL PLAN'**
  String get nutritionMealPlanEyebrow;

  /// No description provided for @nutritionMealPlanCreateCta.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get nutritionMealPlanCreateCta;

  /// No description provided for @nutritionMealPlanEditCta.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get nutritionMealPlanEditCta;

  /// No description provided for @nutritionPlannedLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get nutritionPlannedLabel;

  /// No description provided for @nutritionDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get nutritionDoneLabel;

  /// No description provided for @nutritionMealPlanLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load meal plan.'**
  String get nutritionMealPlanLoadError;

  /// No description provided for @nutritionNoMealPlanMessage.
  ///
  /// In en, this message translates to:
  /// **'No meal plan for this date yet.'**
  String get nutritionNoMealPlanMessage;

  /// No description provided for @nutritionProAnalysisChip.
  ///
  /// In en, this message translates to:
  /// **'Pro analysis'**
  String get nutritionProAnalysisChip;

  /// No description provided for @nutritionCompleteProfileTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete your nutrition profile'**
  String get nutritionCompleteProfileTitle;

  /// No description provided for @nutritionCompleteProfileMessage.
  ///
  /// In en, this message translates to:
  /// **'Set your goal, activity, and targets to unlock calorie and macro recommendations.'**
  String get nutritionCompleteProfileMessage;

  /// No description provided for @nutritionKcalLabel.
  ///
  /// In en, this message translates to:
  /// **'kcal'**
  String get nutritionKcalLabel;

  /// No description provided for @nutritionFoodLoadError.
  ///
  /// In en, this message translates to:
  /// **'Couldn\'t load today\'s food.'**
  String get nutritionFoodLoadError;

  /// No description provided for @nutritionNothingLoggedMessage.
  ///
  /// In en, this message translates to:
  /// **'Nothing logged yet. Tap \"Add food\" to start.'**
  String get nutritionNothingLoggedMessage;

  /// No description provided for @nutritionBmrLabel.
  ///
  /// In en, this message translates to:
  /// **'BMR'**
  String get nutritionBmrLabel;

  /// No description provided for @nutritionTdeeLabel.
  ///
  /// In en, this message translates to:
  /// **'TDEE'**
  String get nutritionTdeeLabel;

  /// No description provided for @nutritionRecommendedLabel.
  ///
  /// In en, this message translates to:
  /// **'Recommended'**
  String get nutritionRecommendedLabel;

  /// No description provided for @nutritionBodyweightLabel.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight'**
  String get nutritionBodyweightLabel;

  /// No description provided for @nutritionAgeLabel.
  ///
  /// In en, this message translates to:
  /// **'Age'**
  String get nutritionAgeLabel;

  /// No description provided for @nutritionTargetWeightStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Target weight'**
  String get nutritionTargetWeightStatLabel;

  /// No description provided for @nutritionCalculationEyebrow.
  ///
  /// In en, this message translates to:
  /// **'CALCULATION'**
  String get nutritionCalculationEyebrow;

  /// No description provided for @insightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get insightsTitle;

  /// No description provided for @insightsRefreshTooltip.
  ///
  /// In en, this message translates to:
  /// **'Refresh'**
  String get insightsRefreshTooltip;

  /// No description provided for @insightsHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'AI training analysis'**
  String get insightsHeaderTitle;

  /// No description provided for @insightsHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Pro-gated analysis, coach tips, cached results, and quota states.'**
  String get insightsHeaderSubtitle;

  /// No description provided for @insightsCoachTipTitle.
  ///
  /// In en, this message translates to:
  /// **'Coach tip'**
  String get insightsCoachTipTitle;

  /// No description provided for @insightsTipFallback.
  ///
  /// In en, this message translates to:
  /// **'Tip'**
  String get insightsTipFallback;

  /// No description provided for @insightsPersonalAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal analysis'**
  String get insightsPersonalAnalysisTitle;

  /// No description provided for @insightsAnalysisReadyFallback.
  ///
  /// In en, this message translates to:
  /// **'Analysis ready'**
  String get insightsAnalysisReadyFallback;

  /// No description provided for @insightsSectionTrainingAdherence.
  ///
  /// In en, this message translates to:
  /// **'Training adherence'**
  String get insightsSectionTrainingAdherence;

  /// No description provided for @insightsSectionBodyMetrics.
  ///
  /// In en, this message translates to:
  /// **'Body metrics'**
  String get insightsSectionBodyMetrics;

  /// No description provided for @insightsSectionVolumeStrength.
  ///
  /// In en, this message translates to:
  /// **'Volume & strength'**
  String get insightsSectionVolumeStrength;

  /// No description provided for @insightsSectionMuscleBalance.
  ///
  /// In en, this message translates to:
  /// **'Muscle balance'**
  String get insightsSectionMuscleBalance;

  /// No description provided for @insightsSectionEffortGap.
  ///
  /// In en, this message translates to:
  /// **'Effort gap'**
  String get insightsSectionEffortGap;

  /// No description provided for @insightsTrainingSnapshotTitle.
  ///
  /// In en, this message translates to:
  /// **'Training snapshot'**
  String get insightsTrainingSnapshotTitle;

  /// No description provided for @insightsWhatWentWrongLabel.
  ///
  /// In en, this message translates to:
  /// **'WHAT WENT WRONG'**
  String get insightsWhatWentWrongLabel;

  /// No description provided for @insightsCoachSuggestionsLabel.
  ///
  /// In en, this message translates to:
  /// **'COACH SUGGESTIONS'**
  String get insightsCoachSuggestionsLabel;

  /// No description provided for @insightsLastAnalyzedAtLabel.
  ///
  /// In en, this message translates to:
  /// **'LAST ANALYZED AT'**
  String get insightsLastAnalyzedAtLabel;

  /// No description provided for @insightsFromCacheLabel.
  ///
  /// In en, this message translates to:
  /// **'From cache'**
  String get insightsFromCacheLabel;

  /// No description provided for @insightsWeightTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Weight trend'**
  String get insightsWeightTrendTitle;

  /// No description provided for @insightsWeekComparisonTitle.
  ///
  /// In en, this message translates to:
  /// **'Week comparison'**
  String get insightsWeekComparisonTitle;

  /// No description provided for @insightsMuscleBalanceTitle.
  ///
  /// In en, this message translates to:
  /// **'Muscle balance'**
  String get insightsMuscleBalanceTitle;

  /// No description provided for @insightsEffortGapTitle.
  ///
  /// In en, this message translates to:
  /// **'Effort gap'**
  String get insightsEffortGapTitle;

  /// No description provided for @insightsRecentPrsTitle.
  ///
  /// In en, this message translates to:
  /// **'Recent PRs'**
  String get insightsRecentPrsTitle;

  /// No description provided for @insightsPlanCompletionLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan completion'**
  String get insightsPlanCompletionLabel;

  /// No description provided for @insightsRecentVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Recent volume'**
  String get insightsRecentVolumeLabel;

  /// No description provided for @insightsSetsCompletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Sets completed'**
  String get insightsSetsCompletedLabel;

  /// No description provided for @insightsBodyweightLabel.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight'**
  String get insightsBodyweightLabel;

  /// No description provided for @insightsNoBodyweightDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No bodyweight data yet.'**
  String get insightsNoBodyweightDataMessage;

  /// No description provided for @insightsPreviousWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Previous week'**
  String get insightsPreviousWeekLabel;

  /// No description provided for @insightsCurrentWeekLabel.
  ///
  /// In en, this message translates to:
  /// **'Current week'**
  String get insightsCurrentWeekLabel;

  /// No description provided for @insightsHighRpeMissesLabel.
  ///
  /// In en, this message translates to:
  /// **'High-RPE misses'**
  String get insightsHighRpeMissesLabel;

  /// No description provided for @insightsLowRpeWinsLabel.
  ///
  /// In en, this message translates to:
  /// **'Low-RPE wins'**
  String get insightsLowRpeWinsLabel;

  /// No description provided for @insightsMuscleBalanceStats.
  ///
  /// In en, this message translates to:
  /// **'{sets} sets · {sharePercent}% · {volume} {unit}'**
  String insightsMuscleBalanceStats(
    int sets,
    int sharePercent,
    String volume,
    String unit,
  );

  /// No description provided for @insightsEffortGapStats.
  ///
  /// In en, this message translates to:
  /// **'{sets} sets · RPE {rpe}'**
  String insightsEffortGapStats(int sets, String rpe);

  /// No description provided for @aiCoachChatTitle.
  ///
  /// In en, this message translates to:
  /// **'AI coach chat'**
  String get aiCoachChatTitle;

  /// No description provided for @aiCoachChatThinkingMessage.
  ///
  /// In en, this message translates to:
  /// **'AI coach is thinking…'**
  String get aiCoachChatThinkingMessage;

  /// No description provided for @aiCoachChatComposerHint.
  ///
  /// In en, this message translates to:
  /// **'What should I adjust this week?'**
  String get aiCoachChatComposerHint;

  /// No description provided for @aiCoachChatEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get aiCoachChatEmptyTitle;

  /// No description provided for @aiCoachChatEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Ask about your training, nutrition, recovery, or plan.'**
  String get aiCoachChatEmptyMessage;

  /// No description provided for @aiCoachChatAuthorLabel.
  ///
  /// In en, this message translates to:
  /// **'AI coach'**
  String get aiCoachChatAuthorLabel;

  /// No description provided for @aiCoachChatNoResponseMessage.
  ///
  /// In en, this message translates to:
  /// **'No response.'**
  String get aiCoachChatNoResponseMessage;

  /// No description provided for @aiCoachChatProRequiredMessage.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro to chat with your AI coach.'**
  String get aiCoachChatProRequiredMessage;

  /// No description provided for @aiCoachChatQuotaReachedMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used your AI quota for now. Try again later.'**
  String get aiCoachChatQuotaReachedMessage;

  /// No description provided for @powerliftingAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Powerlifting analysis'**
  String get powerliftingAnalysisTitle;

  /// No description provided for @powerliftingE1rmTrendTitle.
  ///
  /// In en, this message translates to:
  /// **'Estimated 1RM trend'**
  String get powerliftingE1rmTrendTitle;

  /// No description provided for @powerliftingLogLiftsHintMessage.
  ///
  /// In en, this message translates to:
  /// **'Log your squat, bench and deadlift to see strength trends.'**
  String get powerliftingLogLiftsHintMessage;

  /// No description provided for @powerliftingPrTimelineTitle.
  ///
  /// In en, this message translates to:
  /// **'PR timeline'**
  String get powerliftingPrTimelineTitle;

  /// No description provided for @powerliftingNoPrsMessage.
  ///
  /// In en, this message translates to:
  /// **'No personal records logged yet.'**
  String get powerliftingNoPrsMessage;

  /// No description provided for @powerliftingDotsOverTimeTitle.
  ///
  /// In en, this message translates to:
  /// **'DOTS over time'**
  String get powerliftingDotsOverTimeTitle;

  /// No description provided for @powerliftingDotsHintMessage.
  ///
  /// In en, this message translates to:
  /// **'DOTS needs logged competition lifts and bodyweight.'**
  String get powerliftingDotsHintMessage;

  /// No description provided for @powerliftingDotsLabel.
  ///
  /// In en, this message translates to:
  /// **'DOTS'**
  String get powerliftingDotsLabel;

  /// No description provided for @powerliftingPlateauLabel.
  ///
  /// In en, this message translates to:
  /// **'Plateau'**
  String get powerliftingPlateauLabel;

  /// No description provided for @powerliftingE1rmUnitLabel.
  ///
  /// In en, this message translates to:
  /// **'{unit} e1RM'**
  String powerliftingE1rmUnitLabel(String unit);

  /// No description provided for @powerliftingTrainingMaxLabel.
  ///
  /// In en, this message translates to:
  /// **'Training max: {value} {unit}'**
  String powerliftingTrainingMaxLabel(String value, String unit);

  /// No description provided for @powerliftingTrainingMaxUnknownLabel.
  ///
  /// In en, this message translates to:
  /// **'Training max: —'**
  String get powerliftingTrainingMaxUnknownLabel;

  /// No description provided for @powerliftingE1rmPrefixLabel.
  ///
  /// In en, this message translates to:
  /// **'e1RM · {value}'**
  String powerliftingE1rmPrefixLabel(String value);

  /// No description provided for @powerliftingNoPrsYetMessage.
  ///
  /// In en, this message translates to:
  /// **'No PRs yet'**
  String get powerliftingNoPrsYetMessage;

  /// No description provided for @powerliftingNoneLabel.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get powerliftingNoneLabel;

  /// No description provided for @powerliftingLiftSquat.
  ///
  /// In en, this message translates to:
  /// **'Squat'**
  String get powerliftingLiftSquat;

  /// No description provided for @powerliftingLiftBench.
  ///
  /// In en, this message translates to:
  /// **'Bench'**
  String get powerliftingLiftBench;

  /// No description provided for @powerliftingLiftDeadlift.
  ///
  /// In en, this message translates to:
  /// **'Deadlift'**
  String get powerliftingLiftDeadlift;

  /// No description provided for @powerliftingEstimatedTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Estimated total'**
  String get powerliftingEstimatedTotalLabel;

  /// No description provided for @powerliftingTrainingMaxTotalLabel.
  ///
  /// In en, this message translates to:
  /// **'Training-max total'**
  String get powerliftingTrainingMaxTotalLabel;

  /// No description provided for @powerliftingBenchSquatRatioLabel.
  ///
  /// In en, this message translates to:
  /// **'Bench / squat'**
  String get powerliftingBenchSquatRatioLabel;

  /// No description provided for @powerliftingDeadliftSquatRatioLabel.
  ///
  /// In en, this message translates to:
  /// **'Deadlift / squat'**
  String get powerliftingDeadliftSquatRatioLabel;

  /// No description provided for @powerliftingPrsLast30Label.
  ///
  /// In en, this message translates to:
  /// **'PRs last 30 days'**
  String get powerliftingPrsLast30Label;

  /// No description provided for @powerliftingLatestPrLabel.
  ///
  /// In en, this message translates to:
  /// **'Latest PR'**
  String get powerliftingLatestPrLabel;

  /// No description provided for @powerliftingPlateauLiftsLabel.
  ///
  /// In en, this message translates to:
  /// **'Plateau lifts'**
  String get powerliftingPlateauLiftsLabel;

  /// No description provided for @powerliftingBodyweightDotsLabel.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight (DOTS)'**
  String get powerliftingBodyweightDotsLabel;

  /// No description provided for @cycleAiInsightSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Phase-aware training and nutrition guidance.'**
  String get cycleAiInsightSubtitle;

  /// No description provided for @cycleWeekdayMon.
  ///
  /// In en, this message translates to:
  /// **'Mon'**
  String get cycleWeekdayMon;

  /// No description provided for @cycleWeekdayTue.
  ///
  /// In en, this message translates to:
  /// **'Tue'**
  String get cycleWeekdayTue;

  /// No description provided for @cycleWeekdayWed.
  ///
  /// In en, this message translates to:
  /// **'Wed'**
  String get cycleWeekdayWed;

  /// No description provided for @cycleWeekdayThu.
  ///
  /// In en, this message translates to:
  /// **'Thu'**
  String get cycleWeekdayThu;

  /// No description provided for @cycleWeekdayFri.
  ///
  /// In en, this message translates to:
  /// **'Fri'**
  String get cycleWeekdayFri;

  /// No description provided for @cycleWeekdaySat.
  ///
  /// In en, this message translates to:
  /// **'Sat'**
  String get cycleWeekdaySat;

  /// No description provided for @cycleWeekdaySun.
  ///
  /// In en, this message translates to:
  /// **'Sun'**
  String get cycleWeekdaySun;

  /// No description provided for @cycleFlowSpotting.
  ///
  /// In en, this message translates to:
  /// **'Spotting'**
  String get cycleFlowSpotting;

  /// No description provided for @cycleFlowLight.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get cycleFlowLight;

  /// No description provided for @cycleFlowMedium.
  ///
  /// In en, this message translates to:
  /// **'Medium'**
  String get cycleFlowMedium;

  /// No description provided for @cycleFlowHeavy.
  ///
  /// In en, this message translates to:
  /// **'Heavy'**
  String get cycleFlowHeavy;

  /// No description provided for @cycleMoodGreat.
  ///
  /// In en, this message translates to:
  /// **'Great'**
  String get cycleMoodGreat;

  /// No description provided for @cycleMoodGood.
  ///
  /// In en, this message translates to:
  /// **'Good'**
  String get cycleMoodGood;

  /// No description provided for @cycleMoodNeutral.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get cycleMoodNeutral;

  /// No description provided for @cycleMoodLow.
  ///
  /// In en, this message translates to:
  /// **'Low'**
  String get cycleMoodLow;

  /// No description provided for @cycleMoodIrritable.
  ///
  /// In en, this message translates to:
  /// **'Irritable'**
  String get cycleMoodIrritable;

  /// No description provided for @cycleSymptomCramps.
  ///
  /// In en, this message translates to:
  /// **'Cramps'**
  String get cycleSymptomCramps;

  /// No description provided for @cycleSymptomHeadache.
  ///
  /// In en, this message translates to:
  /// **'Headache'**
  String get cycleSymptomHeadache;

  /// No description provided for @cycleSymptomBloating.
  ///
  /// In en, this message translates to:
  /// **'Bloating'**
  String get cycleSymptomBloating;

  /// No description provided for @cycleSymptomBreastTenderness.
  ///
  /// In en, this message translates to:
  /// **'Breast Tenderness'**
  String get cycleSymptomBreastTenderness;

  /// No description provided for @cycleSymptomFatigue.
  ///
  /// In en, this message translates to:
  /// **'Fatigue'**
  String get cycleSymptomFatigue;

  /// No description provided for @cycleSymptomBackPain.
  ///
  /// In en, this message translates to:
  /// **'Back Pain'**
  String get cycleSymptomBackPain;

  /// No description provided for @cycleSymptomNausea.
  ///
  /// In en, this message translates to:
  /// **'Nausea'**
  String get cycleSymptomNausea;

  /// No description provided for @cycleSymptomAcne.
  ///
  /// In en, this message translates to:
  /// **'Acne'**
  String get cycleSymptomAcne;

  /// No description provided for @cycleSymptomCravings.
  ///
  /// In en, this message translates to:
  /// **'Cravings'**
  String get cycleSymptomCravings;

  /// No description provided for @cycleSymptomInsomnia.
  ///
  /// In en, this message translates to:
  /// **'Insomnia'**
  String get cycleSymptomInsomnia;

  /// No description provided for @cycleSymptomMoodSwings.
  ///
  /// In en, this message translates to:
  /// **'Mood Swings'**
  String get cycleSymptomMoodSwings;

  /// No description provided for @sharingPrShareTitle.
  ///
  /// In en, this message translates to:
  /// **'PR share'**
  String get sharingPrShareTitle;

  /// No description provided for @sharingPersonalRecordTitle.
  ///
  /// In en, this message translates to:
  /// **'Personal record'**
  String get sharingPersonalRecordTitle;

  /// No description provided for @sharingPersonalRecordSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Public share image generated by the backend.'**
  String get sharingPersonalRecordSubtitle;

  /// No description provided for @sharingImageUnavailableTitle.
  ///
  /// In en, this message translates to:
  /// **'Image unavailable'**
  String get sharingImageUnavailableTitle;

  /// No description provided for @sharingImageUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'The PR share image could not be loaded.'**
  String get sharingImageUnavailableMessage;

  /// No description provided for @coachRelationshipChatMessageHint.
  ///
  /// In en, this message translates to:
  /// **'Message {name}'**
  String coachRelationshipChatMessageHint(String name);

  /// No description provided for @coachRelationshipChatEmptyTitle.
  ///
  /// In en, this message translates to:
  /// **'No messages yet'**
  String get coachRelationshipChatEmptyTitle;

  /// No description provided for @coachRelationshipChatEmptyMessage.
  ///
  /// In en, this message translates to:
  /// **'Send the first message to your coach.'**
  String get coachRelationshipChatEmptyMessage;

  /// No description provided for @coachRelationshipChatAttachImage.
  ///
  /// In en, this message translates to:
  /// **'Photo'**
  String get coachRelationshipChatAttachImage;

  /// No description provided for @coachRelationshipChatAttachFile.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get coachRelationshipChatAttachFile;

  /// No description provided for @coachPendingStatusFallback.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get coachPendingStatusFallback;

  /// No description provided for @coachTodaysWorkoutChip.
  ///
  /// In en, this message translates to:
  /// **'Today\'s workout'**
  String get coachTodaysWorkoutChip;

  /// No description provided for @coachForThisClientChip.
  ///
  /// In en, this message translates to:
  /// **'For this client'**
  String get coachForThisClientChip;

  /// No description provided for @coachCurrentTrainingBlockFallback.
  ///
  /// In en, this message translates to:
  /// **'Current training block'**
  String get coachCurrentTrainingBlockFallback;

  /// No description provided for @coachClientPlanProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'Client plan progress'**
  String get coachClientPlanProgressLabel;

  /// No description provided for @coachNoPlanCreatedMessage.
  ///
  /// In en, this message translates to:
  /// **'No plan created for this client yet.'**
  String get coachNoPlanCreatedMessage;

  /// No description provided for @coachClientDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'Client detail'**
  String get coachClientDetailTitle;

  /// No description provided for @coachAiInsightButton.
  ///
  /// In en, this message translates to:
  /// **'AI Insight'**
  String get coachAiInsightButton;

  /// No description provided for @coachStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get coachStreakLabel;

  /// No description provided for @coachDaysUnit.
  ///
  /// In en, this message translates to:
  /// **'days'**
  String get coachDaysUnit;

  /// No description provided for @coachWeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Weight'**
  String get coachWeightLabel;

  /// No description provided for @coachBmiLabel.
  ///
  /// In en, this message translates to:
  /// **'BMI'**
  String get coachBmiLabel;

  /// No description provided for @coachDotsScoreLabel.
  ///
  /// In en, this message translates to:
  /// **'DOTS score'**
  String get coachDotsScoreLabel;

  /// No description provided for @coachStatsTitle.
  ///
  /// In en, this message translates to:
  /// **'Stats'**
  String get coachStatsTitle;

  /// No description provided for @coachHeightLabel.
  ///
  /// In en, this message translates to:
  /// **'Height'**
  String get coachHeightLabel;

  /// No description provided for @coachGenderLabel.
  ///
  /// In en, this message translates to:
  /// **'Gender'**
  String get coachGenderLabel;

  /// No description provided for @coachDateOfBirthLabel.
  ///
  /// In en, this message translates to:
  /// **'Date of birth'**
  String get coachDateOfBirthLabel;

  /// No description provided for @coachDevelopmentDirectionLabel.
  ///
  /// In en, this message translates to:
  /// **'Development direction'**
  String get coachDevelopmentDirectionLabel;

  /// No description provided for @coachTrainingDisciplineLabel.
  ///
  /// In en, this message translates to:
  /// **'Training discipline'**
  String get coachTrainingDisciplineLabel;

  /// No description provided for @coachTrainingPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Training plan'**
  String get coachTrainingPlanTitle;

  /// No description provided for @coachNutritionTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition'**
  String get coachNutritionTitle;

  /// No description provided for @coachCaloriesLabel.
  ///
  /// In en, this message translates to:
  /// **'Calories'**
  String get coachCaloriesLabel;

  /// No description provided for @coachProteinLabel.
  ///
  /// In en, this message translates to:
  /// **'Protein'**
  String get coachProteinLabel;

  /// No description provided for @coachCarbsLabel.
  ///
  /// In en, this message translates to:
  /// **'Carbs'**
  String get coachCarbsLabel;

  /// No description provided for @coachFatLabel.
  ///
  /// In en, this message translates to:
  /// **'Fat'**
  String get coachFatLabel;

  /// No description provided for @coachTodaysMealPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Today\'s meal plan'**
  String get coachTodaysMealPlanTitle;

  /// No description provided for @coachNoMealPlanForDateMessage.
  ///
  /// In en, this message translates to:
  /// **'No meal plan for {date}.'**
  String coachNoMealPlanForDateMessage(String date);

  /// No description provided for @coachPlannedLabel.
  ///
  /// In en, this message translates to:
  /// **'Planned'**
  String get coachPlannedLabel;

  /// No description provided for @coachDoneLabel.
  ///
  /// In en, this message translates to:
  /// **'Done'**
  String get coachDoneLabel;

  /// No description provided for @coachCycleTitle.
  ///
  /// In en, this message translates to:
  /// **'Cycle'**
  String get coachCycleTitle;

  /// No description provided for @coachCurrentDayLabel.
  ///
  /// In en, this message translates to:
  /// **'Current day'**
  String get coachCurrentDayLabel;

  /// No description provided for @coachPhaseLabel.
  ///
  /// In en, this message translates to:
  /// **'Phase'**
  String get coachPhaseLabel;

  /// No description provided for @coachNextPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Next period'**
  String get coachNextPeriodLabel;

  /// No description provided for @coachDaysToPeriodLabel.
  ///
  /// In en, this message translates to:
  /// **'Days to period'**
  String get coachDaysToPeriodLabel;

  /// No description provided for @coachCycleNotSharedMessage.
  ///
  /// In en, this message translates to:
  /// **'This client isn\'t sharing cycle data, or there\'s nothing tracked yet.'**
  String get coachCycleNotSharedMessage;

  /// No description provided for @coachBodyweightAnalysisTitle.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight analysis'**
  String get coachBodyweightAnalysisTitle;

  /// No description provided for @coachNoBodyweightEntriesMessage.
  ///
  /// In en, this message translates to:
  /// **'No bodyweight entries yet.'**
  String get coachNoBodyweightEntriesMessage;

  /// No description provided for @coachEntriesChip.
  ///
  /// In en, this message translates to:
  /// **'{count} entries'**
  String coachEntriesChip(int count);

  /// No description provided for @coachLast90DaysChip.
  ///
  /// In en, this message translates to:
  /// **'Last 90 days'**
  String get coachLast90DaysChip;

  /// No description provided for @coachAiClientInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI Client Insights'**
  String get coachAiClientInsightsTitle;

  /// No description provided for @coachAiClientInsightFallback.
  ///
  /// In en, this message translates to:
  /// **'AI client insight'**
  String get coachAiClientInsightFallback;

  /// No description provided for @coachNoAdditionalAiInsightMessage.
  ///
  /// In en, this message translates to:
  /// **'No additional AI insight sections returned.'**
  String get coachNoAdditionalAiInsightMessage;

  /// No description provided for @coachCachedLabel.
  ///
  /// In en, this message translates to:
  /// **'Cached'**
  String get coachCachedLabel;

  /// No description provided for @coachPlanFallbackLabel.
  ///
  /// In en, this message translates to:
  /// **'Plan'**
  String get coachPlanFallbackLabel;

  /// No description provided for @communityFriendsTitle.
  ///
  /// In en, this message translates to:
  /// **'Friends'**
  String get communityFriendsTitle;

  /// No description provided for @communityFindFriendsTooltip.
  ///
  /// In en, this message translates to:
  /// **'Find friends'**
  String get communityFindFriendsTooltip;

  /// No description provided for @communityIncomingRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Incoming requests'**
  String get communityIncomingRequestsTitle;

  /// No description provided for @communityNoIncomingRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'No pending incoming requests.'**
  String get communityNoIncomingRequestsMessage;

  /// No description provided for @communityNoFriendsMessage.
  ///
  /// In en, this message translates to:
  /// **'No friends yet.'**
  String get communityNoFriendsMessage;

  /// No description provided for @communityRemoveFriendTooltip.
  ///
  /// In en, this message translates to:
  /// **'Remove friend'**
  String get communityRemoveFriendTooltip;

  /// No description provided for @communitySentRequestsTitle.
  ///
  /// In en, this message translates to:
  /// **'Sent requests'**
  String get communitySentRequestsTitle;

  /// No description provided for @communityNoOutgoingRequestsMessage.
  ///
  /// In en, this message translates to:
  /// **'No outgoing requests.'**
  String get communityNoOutgoingRequestsMessage;

  /// No description provided for @communityPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get communityPendingLabel;

  /// No description provided for @communityAcceptButton.
  ///
  /// In en, this message translates to:
  /// **'Accept'**
  String get communityAcceptButton;

  /// No description provided for @communityRejectTooltip.
  ///
  /// In en, this message translates to:
  /// **'Reject'**
  String get communityRejectTooltip;

  /// No description provided for @communityXenohAthleteFallback.
  ///
  /// In en, this message translates to:
  /// **'Xenoh athlete'**
  String get communityXenohAthleteFallback;

  /// No description provided for @communityAddButton.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get communityAddButton;

  /// No description provided for @communityPrChipLabel.
  ///
  /// In en, this message translates to:
  /// **'PR'**
  String get communityPrChipLabel;

  /// No description provided for @communityExercisesMetricLabel.
  ///
  /// In en, this message translates to:
  /// **'Exercises'**
  String get communityExercisesMetricLabel;

  /// No description provided for @communityVolumeMetricLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get communityVolumeMetricLabel;

  /// No description provided for @communityDurationMetricLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get communityDurationMetricLabel;

  /// No description provided for @communityAvgRpeMetricLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg RPE'**
  String get communityAvgRpeMetricLabel;

  /// No description provided for @communityLovedLabel.
  ///
  /// In en, this message translates to:
  /// **'Loved'**
  String get communityLovedLabel;

  /// No description provided for @communityLoveLabel.
  ///
  /// In en, this message translates to:
  /// **'Love'**
  String get communityLoveLabel;

  /// No description provided for @communityLoveCount.
  ///
  /// In en, this message translates to:
  /// **'{count, plural, =1{1 love} other{{count} loves}}'**
  String communityLoveCount(int count);

  /// No description provided for @communityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community'**
  String get communityTitle;

  /// No description provided for @communityEyebrowLabel.
  ///
  /// In en, this message translates to:
  /// **'COMMUNITY'**
  String get communityEyebrowLabel;

  /// No description provided for @communityFindLiftersMessage.
  ///
  /// In en, this message translates to:
  /// **'Find lifters and follow shared training days.'**
  String get communityFindLiftersMessage;

  /// No description provided for @communitySearchAthletesHint.
  ///
  /// In en, this message translates to:
  /// **'Search athletes'**
  String get communitySearchAthletesHint;

  /// No description provided for @communityNoAthletesMatchMessage.
  ///
  /// In en, this message translates to:
  /// **'No athletes match this search.'**
  String get communityNoAthletesMatchMessage;

  /// No description provided for @communityFriendFeedTitle.
  ///
  /// In en, this message translates to:
  /// **'Friend feed'**
  String get communityFriendFeedTitle;

  /// No description provided for @communityNoFriendSharesMessage.
  ///
  /// In en, this message translates to:
  /// **'No friend shares yet.'**
  String get communityNoFriendSharesMessage;

  /// No description provided for @communityTypeAtLeast2CharsMessage.
  ///
  /// In en, this message translates to:
  /// **'Type at least 2 characters to discover athletes.'**
  String get communityTypeAtLeast2CharsMessage;

  /// No description provided for @communityAthleteTitle.
  ///
  /// In en, this message translates to:
  /// **'Athlete'**
  String get communityAthleteTitle;

  /// No description provided for @communityTrainingChipFallback.
  ///
  /// In en, this message translates to:
  /// **'Training'**
  String get communityTrainingChipFallback;

  /// No description provided for @communityLevelChipLabel.
  ///
  /// In en, this message translates to:
  /// **'Level {level}'**
  String communityLevelChipLabel(String level);

  /// No description provided for @communityFriendChipLabel.
  ///
  /// In en, this message translates to:
  /// **'Friend'**
  String get communityFriendChipLabel;

  /// No description provided for @communityStreakLabel.
  ///
  /// In en, this message translates to:
  /// **'Streak'**
  String get communityStreakLabel;

  /// No description provided for @communityStreakDaysValue.
  ///
  /// In en, this message translates to:
  /// **'{days} days'**
  String communityStreakDaysValue(int days);

  /// No description provided for @communityBodyweightLabel.
  ///
  /// In en, this message translates to:
  /// **'Bodyweight'**
  String get communityBodyweightLabel;

  /// No description provided for @communityDotsLabel.
  ///
  /// In en, this message translates to:
  /// **'DOTS'**
  String get communityDotsLabel;

  /// No description provided for @communityTimeTrainedLabel.
  ///
  /// In en, this message translates to:
  /// **'Time trained'**
  String get communityTimeTrainedLabel;

  /// No description provided for @communityAddFriendHintMessage.
  ///
  /// In en, this message translates to:
  /// **'Add this athlete as a friend to see training stats and shared days.'**
  String get communityAddFriendHintMessage;

  /// No description provided for @communitySharedTrainingDaysTitle.
  ///
  /// In en, this message translates to:
  /// **'Shared training days'**
  String get communitySharedTrainingDaysTitle;

  /// No description provided for @communityNoSharedDaysMessage.
  ///
  /// In en, this message translates to:
  /// **'No shared training days yet.'**
  String get communityNoSharedDaysMessage;

  /// No description provided for @communityBig3Title.
  ///
  /// In en, this message translates to:
  /// **'Big 3'**
  String get communityBig3Title;

  /// No description provided for @subscriptionTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription'**
  String get subscriptionTitle;

  /// No description provided for @subscriptionExtendOrChangeTitle.
  ///
  /// In en, this message translates to:
  /// **'Extend or change plan'**
  String get subscriptionExtendOrChangeTitle;

  /// No description provided for @subscriptionGoProTitle.
  ///
  /// In en, this message translates to:
  /// **'Go Pro'**
  String get subscriptionGoProTitle;

  /// No description provided for @subscriptionUnlockMessage.
  ///
  /// In en, this message translates to:
  /// **'Unlock AI insights, analytics and coaching tools.'**
  String get subscriptionUnlockMessage;

  /// No description provided for @subscriptionContinueToPaymentCta.
  ///
  /// In en, this message translates to:
  /// **'Continue to payment'**
  String get subscriptionContinueToPaymentCta;

  /// No description provided for @subscriptionRenewCta.
  ///
  /// In en, this message translates to:
  /// **'Renew {tier}'**
  String subscriptionRenewCta(String tier);

  /// No description provided for @subscriptionSwitchToCta.
  ///
  /// In en, this message translates to:
  /// **'Switch to {tier}'**
  String subscriptionSwitchToCta(String tier);

  /// No description provided for @subscriptionDevActivateCta.
  ///
  /// In en, this message translates to:
  /// **'Dev: activate Pro now'**
  String get subscriptionDevActivateCta;

  /// No description provided for @subscriptionCurrentPlanLabel.
  ///
  /// In en, this message translates to:
  /// **'CURRENT PLAN'**
  String get subscriptionCurrentPlanLabel;

  /// No description provided for @subscriptionExpiresLabel.
  ///
  /// In en, this message translates to:
  /// **'Expires'**
  String get subscriptionExpiresLabel;

  /// No description provided for @subscriptionExpiredLabel.
  ///
  /// In en, this message translates to:
  /// **'Expired'**
  String get subscriptionExpiredLabel;

  /// No description provided for @subscriptionNoExpiryLabel.
  ///
  /// In en, this message translates to:
  /// **'No expiry'**
  String get subscriptionNoExpiryLabel;

  /// No description provided for @subscriptionAiRequestsThisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'AI requests this month'**
  String get subscriptionAiRequestsThisMonthLabel;

  /// No description provided for @subscriptionNotIncludedLabel.
  ///
  /// In en, this message translates to:
  /// **'Not included'**
  String get subscriptionNotIncludedLabel;

  /// No description provided for @subscriptionRemainingLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} remaining'**
  String subscriptionRemainingLabel(int count);

  /// No description provided for @subscriptionCurrentChipLabel.
  ///
  /// In en, this message translates to:
  /// **'Current'**
  String get subscriptionCurrentChipLabel;

  /// No description provided for @subscriptionIncludedInProCoachMessage.
  ///
  /// In en, this message translates to:
  /// **'Included in your Pro Coach plan'**
  String get subscriptionIncludedInProCoachMessage;

  /// No description provided for @subscriptionRenewToExtendMessage.
  ///
  /// In en, this message translates to:
  /// **'Renew to extend your plan'**
  String get subscriptionRenewToExtendMessage;

  /// No description provided for @subscriptionBilledOnceMessage.
  ///
  /// In en, this message translates to:
  /// **'Billed once by bank transfer'**
  String get subscriptionBilledOnceMessage;

  /// No description provided for @subscriptionPaymentNoteMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment is by Vietnamese bank transfer. Your plan activates automatically once the transfer is confirmed (usually within a few minutes).'**
  String get subscriptionPaymentNoteMessage;

  /// No description provided for @subscriptionPerMonthSuffix.
  ///
  /// In en, this message translates to:
  /// **'/mo'**
  String get subscriptionPerMonthSuffix;

  /// No description provided for @subscriptionTierProIndividual.
  ///
  /// In en, this message translates to:
  /// **'Pro Individual'**
  String get subscriptionTierProIndividual;

  /// No description provided for @subscriptionTierProIndividualTagline.
  ///
  /// In en, this message translates to:
  /// **'For athletes training solo'**
  String get subscriptionTierProIndividualTagline;

  /// No description provided for @subscriptionTierProCoach.
  ///
  /// In en, this message translates to:
  /// **'Pro Coach'**
  String get subscriptionTierProCoach;

  /// No description provided for @subscriptionTierProCoachTagline.
  ///
  /// In en, this message translates to:
  /// **'For coaches managing clients'**
  String get subscriptionTierProCoachTagline;

  /// No description provided for @subscriptionTierFree.
  ///
  /// In en, this message translates to:
  /// **'Free'**
  String get subscriptionTierFree;

  /// No description provided for @subscriptionMonthsLabel.
  ///
  /// In en, this message translates to:
  /// **'{months, plural, =1{1 month} other{{months} months}}'**
  String subscriptionMonthsLabel(int months);

  /// No description provided for @subscriptionBestValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Best value'**
  String get subscriptionBestValueLabel;

  /// No description provided for @subscriptionCompletePaymentTitle.
  ///
  /// In en, this message translates to:
  /// **'Complete payment'**
  String get subscriptionCompletePaymentTitle;

  /// No description provided for @subscriptionAmountToTransferLabel.
  ///
  /// In en, this message translates to:
  /// **'AMOUNT TO TRANSFER'**
  String get subscriptionAmountToTransferLabel;

  /// No description provided for @subscriptionScanInstructionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Scan the QR with your banking app, or transfer manually using the details below. Include the transfer description so we can match your payment automatically.'**
  String get subscriptionScanInstructionsMessage;

  /// No description provided for @subscriptionBankLabel.
  ///
  /// In en, this message translates to:
  /// **'Bank'**
  String get subscriptionBankLabel;

  /// No description provided for @subscriptionAccountNumberLabel.
  ///
  /// In en, this message translates to:
  /// **'Account number'**
  String get subscriptionAccountNumberLabel;

  /// No description provided for @subscriptionAccountNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Account name'**
  String get subscriptionAccountNameLabel;

  /// No description provided for @subscriptionAmountLabel.
  ///
  /// In en, this message translates to:
  /// **'Amount'**
  String get subscriptionAmountLabel;

  /// No description provided for @subscriptionTransferDescriptionLabel.
  ///
  /// In en, this message translates to:
  /// **'Transfer description'**
  String get subscriptionTransferDescriptionLabel;

  /// No description provided for @subscriptionOrderExpiresMessage.
  ///
  /// In en, this message translates to:
  /// **'This order expires {datetime}.'**
  String subscriptionOrderExpiresMessage(String datetime);

  /// No description provided for @subscriptionCopyTooltip.
  ///
  /// In en, this message translates to:
  /// **'Copy {label}'**
  String subscriptionCopyTooltip(String label);

  /// No description provided for @subscriptionCopiedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'{label} copied'**
  String subscriptionCopiedSnackbar(String label);

  /// No description provided for @subscriptionOrderExpiredMessage.
  ///
  /// In en, this message translates to:
  /// **'This order has expired. Go back to start a new one.'**
  String get subscriptionOrderExpiredMessage;

  /// No description provided for @subscriptionWaitingForTransferMessage.
  ///
  /// In en, this message translates to:
  /// **'Waiting for your transfer…'**
  String get subscriptionWaitingForTransferMessage;

  /// No description provided for @subscriptionAutoUpdateMessage.
  ///
  /// In en, this message translates to:
  /// **'This page updates automatically once payment is confirmed (usually within a few minutes).'**
  String get subscriptionAutoUpdateMessage;

  /// No description provided for @subscriptionScanToPayLabel.
  ///
  /// In en, this message translates to:
  /// **'SCAN TO PAY'**
  String get subscriptionScanToPayLabel;

  /// No description provided for @subscriptionQrUnavailableMessage.
  ///
  /// In en, this message translates to:
  /// **'QR unavailable — use the transfer details below.'**
  String get subscriptionQrUnavailableMessage;

  /// No description provided for @subscriptionOpenBankingAppMessage.
  ///
  /// In en, this message translates to:
  /// **'Open your banking app and scan with VietQR'**
  String get subscriptionOpenBankingAppMessage;

  /// No description provided for @subscriptionUpgradeToastMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'re now on {tier} 🎉'**
  String subscriptionUpgradeToastMessage(String tier);

  /// No description provided for @marketingPricingTitle.
  ///
  /// In en, this message translates to:
  /// **'Pricing'**
  String get marketingPricingTitle;

  /// No description provided for @marketingChooseYourPlanTitle.
  ///
  /// In en, this message translates to:
  /// **'Choose your Pro plan'**
  String get marketingChooseYourPlanTitle;

  /// No description provided for @marketingChooseYourPlanSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Public pricing for AI insights, analytics, and coach workflows.'**
  String get marketingChooseYourPlanSubtitle;

  /// No description provided for @marketingCreateAccountCta.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get marketingCreateAccountCta;

  /// No description provided for @marketingSignInCta.
  ///
  /// In en, this message translates to:
  /// **'Sign in'**
  String get marketingSignInCta;

  /// No description provided for @marketingCoachChipLabel.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get marketingCoachChipLabel;

  /// No description provided for @marketingFeatureAiInsights.
  ///
  /// In en, this message translates to:
  /// **'AI insights and quota-backed coach tips'**
  String get marketingFeatureAiInsights;

  /// No description provided for @marketingFeaturePlanAnalytics.
  ///
  /// In en, this message translates to:
  /// **'Plan analytics, balance checks, and progress insight'**
  String get marketingFeaturePlanAnalytics;

  /// No description provided for @marketingFeatureNutritionInsight.
  ///
  /// In en, this message translates to:
  /// **'Nutrition insight and richer progress views'**
  String get marketingFeatureNutritionInsight;

  /// No description provided for @marketingFeatureClientManagement.
  ///
  /// In en, this message translates to:
  /// **'Client management, invite codes, and coach dashboard'**
  String get marketingFeatureClientManagement;

  /// No description provided for @marketingFeatureClientPlans.
  ///
  /// In en, this message translates to:
  /// **'Client plans, nutrition oversight, AI briefs, and chat'**
  String get marketingFeatureClientPlans;

  /// No description provided for @marketingSavePercentLabel.
  ///
  /// In en, this message translates to:
  /// **'Save {percent}%'**
  String marketingSavePercentLabel(int percent);

  /// No description provided for @adminDashboardTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin dashboard'**
  String get adminDashboardTitle;

  /// No description provided for @adminPlatformOperationsTitle.
  ///
  /// In en, this message translates to:
  /// **'Platform operations'**
  String get adminPlatformOperationsTitle;

  /// No description provided for @adminPlatformOperationsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'KPIs, users, revenue, reports, subscriptions, and AI usage.'**
  String get adminPlatformOperationsSubtitle;

  /// No description provided for @adminUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Users'**
  String get adminUsersLabel;

  /// No description provided for @adminNewThisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'New this month'**
  String get adminNewThisMonthLabel;

  /// No description provided for @adminActiveCoachesLabel.
  ///
  /// In en, this message translates to:
  /// **'Active coaches'**
  String get adminActiveCoachesLabel;

  /// No description provided for @adminPaidSubsLabel.
  ///
  /// In en, this message translates to:
  /// **'Paid subs'**
  String get adminPaidSubsLabel;

  /// No description provided for @adminPendingReportsLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending reports'**
  String get adminPendingReportsLabel;

  /// No description provided for @adminPlansLabel.
  ///
  /// In en, this message translates to:
  /// **'Plans'**
  String get adminPlansLabel;

  /// No description provided for @adminWorkoutDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Workout days'**
  String get adminWorkoutDaysLabel;

  /// No description provided for @adminRevenueMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'Revenue month'**
  String get adminRevenueMonthLabel;

  /// No description provided for @adminReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get adminReportsTitle;

  /// No description provided for @adminModerationQueueTitle.
  ///
  /// In en, this message translates to:
  /// **'Moderation queue'**
  String get adminModerationQueueTitle;

  /// No description provided for @adminModerationQueueSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review reports and resolve or dismiss them from mobile.'**
  String get adminModerationQueueSubtitle;

  /// No description provided for @adminNoReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'No reports'**
  String get adminNoReportsTitle;

  /// No description provided for @adminNoReportsMessage.
  ///
  /// In en, this message translates to:
  /// **'Pending reports appear here.'**
  String get adminNoReportsMessage;

  /// No description provided for @adminReviewTooltip.
  ///
  /// In en, this message translates to:
  /// **'Review'**
  String get adminReviewTooltip;

  /// No description provided for @adminResolveAction.
  ///
  /// In en, this message translates to:
  /// **'Resolve'**
  String get adminResolveAction;

  /// No description provided for @adminDismissAction.
  ///
  /// In en, this message translates to:
  /// **'Dismiss'**
  String get adminDismissAction;

  /// No description provided for @adminReviewedOnMobileNote.
  ///
  /// In en, this message translates to:
  /// **'Reviewed on mobile'**
  String get adminReviewedOnMobileNote;

  /// No description provided for @adminPlatformPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'Platform plans'**
  String get adminPlatformPlansTitle;

  /// No description provided for @adminPlatformPlansSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Plan ownership, active state, completion, and volume.'**
  String get adminPlatformPlansSubtitle;

  /// No description provided for @adminNoPlansTitle.
  ///
  /// In en, this message translates to:
  /// **'No plans'**
  String get adminNoPlansTitle;

  /// No description provided for @adminNoPlansMessage.
  ///
  /// In en, this message translates to:
  /// **'Platform plans appear here.'**
  String get adminNoPlansMessage;

  /// No description provided for @adminDaysProgressLabel.
  ///
  /// In en, this message translates to:
  /// **'{completed}/{total} days'**
  String adminDaysProgressLabel(String completed, String total);

  /// No description provided for @adminVolumeLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume'**
  String get adminVolumeLabel;

  /// No description provided for @adminVolumeValueLabel.
  ///
  /// In en, this message translates to:
  /// **'Volume {value}'**
  String adminVolumeValueLabel(String value);

  /// No description provided for @adminUserManagementTitle.
  ///
  /// In en, this message translates to:
  /// **'User management'**
  String get adminUserManagementTitle;

  /// No description provided for @adminUserManagementSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Search filters are handled by the backend endpoint; destructive actions require a tap confirmation.'**
  String get adminUserManagementSubtitle;

  /// No description provided for @adminNoUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'No users'**
  String get adminNoUsersTitle;

  /// No description provided for @adminNoUsersMessage.
  ///
  /// In en, this message translates to:
  /// **'No users matched the current filters.'**
  String get adminNoUsersMessage;

  /// No description provided for @adminSuspendedLabel.
  ///
  /// In en, this message translates to:
  /// **'Suspended'**
  String get adminSuspendedLabel;

  /// No description provided for @adminUnsuspendUserTooltip.
  ///
  /// In en, this message translates to:
  /// **'Unsuspend user'**
  String get adminUnsuspendUserTooltip;

  /// No description provided for @adminSuspendUserTooltip.
  ///
  /// In en, this message translates to:
  /// **'Suspend user'**
  String get adminSuspendUserTooltip;

  /// No description provided for @adminPlanAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Plan analytics'**
  String get adminPlanAnalyticsTitle;

  /// No description provided for @adminPlanAnalyticsHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin plan analytics'**
  String get adminPlanAnalyticsHeaderTitle;

  /// No description provided for @adminPlanAnalyticsHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Owner, completion, volume, exercises, and plan state.'**
  String get adminPlanAnalyticsHeaderSubtitle;

  /// No description provided for @adminNameLabel.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get adminNameLabel;

  /// No description provided for @adminOwnerLabel.
  ///
  /// In en, this message translates to:
  /// **'Owner'**
  String get adminOwnerLabel;

  /// No description provided for @adminCoachLabel.
  ///
  /// In en, this message translates to:
  /// **'Coach'**
  String get adminCoachLabel;

  /// No description provided for @adminTypeLabel.
  ///
  /// In en, this message translates to:
  /// **'Type'**
  String get adminTypeLabel;

  /// No description provided for @adminActiveLabel.
  ///
  /// In en, this message translates to:
  /// **'Active'**
  String get adminActiveLabel;

  /// No description provided for @adminCompletionLabel.
  ///
  /// In en, this message translates to:
  /// **'Completion'**
  String get adminCompletionLabel;

  /// No description provided for @adminDaysLabel.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get adminDaysLabel;

  /// No description provided for @adminPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments'**
  String get adminPaymentsTitle;

  /// No description provided for @adminPaymentsHeaderTitle.
  ///
  /// In en, this message translates to:
  /// **'Payments and subscriptions'**
  String get adminPaymentsHeaderTitle;

  /// No description provided for @adminPaymentsHeaderSubtitle.
  ///
  /// In en, this message translates to:
  /// **'SePay order state, tier, revenue, and active subscriptions.'**
  String get adminPaymentsHeaderSubtitle;

  /// No description provided for @adminRevenueLabel.
  ///
  /// In en, this message translates to:
  /// **'Revenue'**
  String get adminRevenueLabel;

  /// No description provided for @adminThisMonthLabel.
  ///
  /// In en, this message translates to:
  /// **'This month'**
  String get adminThisMonthLabel;

  /// No description provided for @adminPendingLabel.
  ///
  /// In en, this message translates to:
  /// **'Pending'**
  String get adminPendingLabel;

  /// No description provided for @adminCompletedLabel.
  ///
  /// In en, this message translates to:
  /// **'Completed'**
  String get adminCompletedLabel;

  /// No description provided for @adminNoPaymentsTitle.
  ///
  /// In en, this message translates to:
  /// **'No payments'**
  String get adminNoPaymentsTitle;

  /// No description provided for @adminNoPaymentsMessage.
  ///
  /// In en, this message translates to:
  /// **'Payment orders appear here.'**
  String get adminNoPaymentsMessage;

  /// No description provided for @adminNoSubscriptionsTitle.
  ///
  /// In en, this message translates to:
  /// **'No subscriptions'**
  String get adminNoSubscriptionsTitle;

  /// No description provided for @adminNoSubscriptionsMessage.
  ///
  /// In en, this message translates to:
  /// **'Active and historical subscriptions appear here.'**
  String get adminNoSubscriptionsMessage;

  /// No description provided for @adminAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Admin analytics'**
  String get adminAnalyticsTitle;

  /// No description provided for @adminInsightsTab.
  ///
  /// In en, this message translates to:
  /// **'Insights'**
  String get adminInsightsTab;

  /// No description provided for @adminMarketingTab.
  ///
  /// In en, this message translates to:
  /// **'Marketing'**
  String get adminMarketingTab;

  /// No description provided for @adminAiUsageTab.
  ///
  /// In en, this message translates to:
  /// **'AI Usage'**
  String get adminAiUsageTab;

  /// No description provided for @adminPlatformInsightsTitle.
  ///
  /// In en, this message translates to:
  /// **'Platform insights'**
  String get adminPlatformInsightsTitle;

  /// No description provided for @adminPlatformInsightsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Growth, revenue, workouts, reports, AI, and community.'**
  String get adminPlatformInsightsSubtitle;

  /// No description provided for @adminTotalUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Total users'**
  String get adminTotalUsersLabel;

  /// No description provided for @adminNewUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'New users'**
  String get adminNewUsersLabel;

  /// No description provided for @adminActiveUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Active users'**
  String get adminActiveUsersLabel;

  /// No description provided for @adminAiRequestsLabel.
  ///
  /// In en, this message translates to:
  /// **'AI requests'**
  String get adminAiRequestsLabel;

  /// No description provided for @adminUserRegistrationsTitle.
  ///
  /// In en, this message translates to:
  /// **'User registrations'**
  String get adminUserRegistrationsTitle;

  /// No description provided for @adminCommunityActivityTitle.
  ///
  /// In en, this message translates to:
  /// **'Community activity'**
  String get adminCommunityActivityTitle;

  /// No description provided for @adminMarketingAnalyticsTitle.
  ///
  /// In en, this message translates to:
  /// **'Marketing analytics'**
  String get adminMarketingAnalyticsTitle;

  /// No description provided for @adminMarketingAnalyticsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Traffic, sessions, registrations, usage, and flows.'**
  String get adminMarketingAnalyticsSubtitle;

  /// No description provided for @adminPageViewsLabel.
  ///
  /// In en, this message translates to:
  /// **'Page views'**
  String get adminPageViewsLabel;

  /// No description provided for @adminSessionsLabel.
  ///
  /// In en, this message translates to:
  /// **'Sessions'**
  String get adminSessionsLabel;

  /// No description provided for @adminKnownUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Known users'**
  String get adminKnownUsersLabel;

  /// No description provided for @adminLoginsLabel.
  ///
  /// In en, this message translates to:
  /// **'Logins'**
  String get adminLoginsLabel;

  /// No description provided for @adminRegistrationsLabel.
  ///
  /// In en, this message translates to:
  /// **'Registrations'**
  String get adminRegistrationsLabel;

  /// No description provided for @adminUsageTimeLabel.
  ///
  /// In en, this message translates to:
  /// **'Usage time'**
  String get adminUsageTimeLabel;

  /// No description provided for @adminOpenBugsLabel.
  ///
  /// In en, this message translates to:
  /// **'Open bugs'**
  String get adminOpenBugsLabel;

  /// No description provided for @adminAvgSessionLabel.
  ///
  /// In en, this message translates to:
  /// **'Avg session'**
  String get adminAvgSessionLabel;

  /// No description provided for @adminTopSourcesTitle.
  ///
  /// In en, this message translates to:
  /// **'Top sources'**
  String get adminTopSourcesTitle;

  /// No description provided for @adminTopCampaignsTitle.
  ///
  /// In en, this message translates to:
  /// **'Top campaigns'**
  String get adminTopCampaignsTitle;

  /// No description provided for @adminAiUsageTitle.
  ///
  /// In en, this message translates to:
  /// **'AI usage'**
  String get adminAiUsageTitle;

  /// No description provided for @adminAiUsageSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Monthly quota consumption by tier, feature, and user.'**
  String get adminAiUsageSubtitle;

  /// No description provided for @adminPeriodStartLabel.
  ///
  /// In en, this message translates to:
  /// **'Period start'**
  String get adminPeriodStartLabel;

  /// No description provided for @adminUsedRequestsLabel.
  ///
  /// In en, this message translates to:
  /// **'Used requests'**
  String get adminUsedRequestsLabel;

  /// No description provided for @adminQuotaUsersLabel.
  ///
  /// In en, this message translates to:
  /// **'Quota users'**
  String get adminQuotaUsersLabel;

  /// No description provided for @adminByTierTitle.
  ///
  /// In en, this message translates to:
  /// **'By tier'**
  String get adminByTierTitle;

  /// No description provided for @adminByFeatureTitle.
  ///
  /// In en, this message translates to:
  /// **'By feature'**
  String get adminByFeatureTitle;

  /// No description provided for @adminNoDataMessage.
  ///
  /// In en, this message translates to:
  /// **'No data.'**
  String get adminNoDataMessage;

  /// No description provided for @adminTopFlowsTitle.
  ///
  /// In en, this message translates to:
  /// **'Top flows'**
  String get adminTopFlowsTitle;

  /// No description provided for @adminCountLabel.
  ///
  /// In en, this message translates to:
  /// **'Count {count}'**
  String adminCountLabel(String count);

  /// No description provided for @adminTopUsersTitle.
  ///
  /// In en, this message translates to:
  /// **'Top users'**
  String get adminTopUsersTitle;

  /// No description provided for @adminNoUsageYetMessage.
  ///
  /// In en, this message translates to:
  /// **'No usage yet.'**
  String get adminNoUsageYetMessage;

  /// No description provided for @adminRequestsCountLabel.
  ///
  /// In en, this message translates to:
  /// **'{count} requests'**
  String adminRequestsCountLabel(String count);

  /// No description provided for @adminBugReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'Bug reports'**
  String get adminBugReportsTitle;

  /// No description provided for @adminBugReportsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Review user-submitted issues and update moderation state.'**
  String get adminBugReportsSubtitle;

  /// No description provided for @adminStatusLabel.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get adminStatusLabel;

  /// No description provided for @adminNoBugReportsTitle.
  ///
  /// In en, this message translates to:
  /// **'No bug reports'**
  String get adminNoBugReportsTitle;

  /// No description provided for @adminNoBugReportsMessage.
  ///
  /// In en, this message translates to:
  /// **'No reports match the current filters.'**
  String get adminNoBugReportsMessage;

  /// No description provided for @adminAllFilterLabel.
  ///
  /// In en, this message translates to:
  /// **'All'**
  String get adminAllFilterLabel;

  /// No description provided for @adminScreenLabel.
  ///
  /// In en, this message translates to:
  /// **'Screen'**
  String get adminScreenLabel;

  /// No description provided for @adminDeviceLabel.
  ///
  /// In en, this message translates to:
  /// **'Device'**
  String get adminDeviceLabel;

  /// No description provided for @adminNoteLabel.
  ///
  /// In en, this message translates to:
  /// **'Admin note'**
  String get adminNoteLabel;

  /// No description provided for @adminNoteHint.
  ///
  /// In en, this message translates to:
  /// **'Optional note for this review'**
  String get adminNoteHint;

  /// No description provided for @adminInProgressAction.
  ///
  /// In en, this message translates to:
  /// **'In progress'**
  String get adminInProgressAction;

  /// No description provided for @adminBugStatusOpen.
  ///
  /// In en, this message translates to:
  /// **'Open'**
  String get adminBugStatusOpen;

  /// No description provided for @adminBugStatusInProgress.
  ///
  /// In en, this message translates to:
  /// **'In Progress'**
  String get adminBugStatusInProgress;

  /// No description provided for @adminBugStatusResolved.
  ///
  /// In en, this message translates to:
  /// **'Resolved'**
  String get adminBugStatusResolved;

  /// No description provided for @adminBugStatusDismissed.
  ///
  /// In en, this message translates to:
  /// **'Dismissed'**
  String get adminBugStatusDismissed;

  /// No description provided for @adminUserDetailTitle.
  ///
  /// In en, this message translates to:
  /// **'User detail'**
  String get adminUserDetailTitle;

  /// No description provided for @adminUserDetailSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Profile, relationships, suspension, and subscription.'**
  String get adminUserDetailSubtitle;

  /// No description provided for @adminEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get adminEmailLabel;

  /// No description provided for @adminTierLabel.
  ///
  /// In en, this message translates to:
  /// **'Tier'**
  String get adminTierLabel;

  /// No description provided for @adminReportsStatLabel.
  ///
  /// In en, this message translates to:
  /// **'Reports'**
  String get adminReportsStatLabel;

  /// No description provided for @adminSubscriptionTierLabel.
  ///
  /// In en, this message translates to:
  /// **'Subscription tier'**
  String get adminSubscriptionTierLabel;

  /// No description provided for @adminDurationLabel.
  ///
  /// In en, this message translates to:
  /// **'Duration'**
  String get adminDurationLabel;

  /// No description provided for @adminReasonLabel.
  ///
  /// In en, this message translates to:
  /// **'Reason'**
  String get adminReasonLabel;

  /// No description provided for @adminReasonHint.
  ///
  /// In en, this message translates to:
  /// **'Manual admin adjustment'**
  String get adminReasonHint;

  /// No description provided for @adminAdjustSubscriptionCta.
  ///
  /// In en, this message translates to:
  /// **'Adjust subscription'**
  String get adminAdjustSubscriptionCta;

  /// No description provided for @adminManualAdjustmentDefaultReason.
  ///
  /// In en, this message translates to:
  /// **'Manual mobile admin adjustment'**
  String get adminManualAdjustmentDefaultReason;

  /// No description provided for @adminSubscriptionAdjustedSnackbar.
  ///
  /// In en, this message translates to:
  /// **'Subscription adjusted.'**
  String get adminSubscriptionAdjustedSnackbar;

  /// No description provided for @legalPrivacyTitle.
  ///
  /// In en, this message translates to:
  /// **'Privacy Policy'**
  String get legalPrivacyTitle;

  /// No description provided for @legalPrivacySubtitle.
  ///
  /// In en, this message translates to:
  /// **'How Xenoh handles account, training, nutrition, and coaching data.'**
  String get legalPrivacySubtitle;

  /// No description provided for @legalPrivacyDataWeUseTitle.
  ///
  /// In en, this message translates to:
  /// **'Data We Use'**
  String get legalPrivacyDataWeUseTitle;

  /// No description provided for @legalPrivacyDataWeUseBody.
  ///
  /// In en, this message translates to:
  /// **'Xenoh stores profile details, workout plans, exercise logs, bodyweight entries, nutrition logs, coach-client relationships, messages, reports, and subscription state needed to run the product.'**
  String get legalPrivacyDataWeUseBody;

  /// No description provided for @legalPrivacyCoachingVisibilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Coaching Visibility'**
  String get legalPrivacyCoachingVisibilityTitle;

  /// No description provided for @legalPrivacyCoachingVisibilityBody.
  ///
  /// In en, this message translates to:
  /// **'When you connect with a coach, authorized coach views can access the client information required for coaching workflows, including plans, workout progress, nutrition data, and shared cycle data when enabled.'**
  String get legalPrivacyCoachingVisibilityBody;

  /// No description provided for @legalPrivacySecurityTitle.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get legalPrivacySecurityTitle;

  /// No description provided for @legalPrivacySecurityBody.
  ///
  /// In en, this message translates to:
  /// **'Authenticated app requests use JWT authorization. Tokens are stored in secure device storage and backend authorization remains the source of truth for access.'**
  String get legalPrivacySecurityBody;

  /// No description provided for @legalTermsTitle.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get legalTermsTitle;

  /// No description provided for @legalTermsSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Rules for using Xenoh training, nutrition, AI, and coaching tools.'**
  String get legalTermsSubtitle;

  /// No description provided for @legalTermsTrainingResponsibilityTitle.
  ///
  /// In en, this message translates to:
  /// **'Training Responsibility'**
  String get legalTermsTrainingResponsibilityTitle;

  /// No description provided for @legalTermsTrainingResponsibilityBody.
  ///
  /// In en, this message translates to:
  /// **'Workout, nutrition, and AI outputs are support tools. Users remain responsible for training safely and consulting qualified professionals where appropriate.'**
  String get legalTermsTrainingResponsibilityBody;

  /// No description provided for @legalTermsAccountAccessTitle.
  ///
  /// In en, this message translates to:
  /// **'Account Access'**
  String get legalTermsAccountAccessTitle;

  /// No description provided for @legalTermsAccountAccessBody.
  ///
  /// In en, this message translates to:
  /// **'Users must keep account credentials secure. Role and subscription access may be changed or revoked when required by backend policy.'**
  String get legalTermsAccountAccessBody;

  /// No description provided for @legalTermsAiLimitsTitle.
  ///
  /// In en, this message translates to:
  /// **'AI And Subscription Limits'**
  String get legalTermsAiLimitsTitle;

  /// No description provided for @legalTermsAiLimitsBody.
  ///
  /// In en, this message translates to:
  /// **'AI features may be gated by subscription tier, quota, and backend availability. The mobile app displays upgrade, quota, and failure states when returned by the API.'**
  String get legalTermsAiLimitsBody;

  /// No description provided for @legalRefundTitle.
  ///
  /// In en, this message translates to:
  /// **'Refund Policy'**
  String get legalRefundTitle;

  /// No description provided for @legalRefundSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription and payment expectations for Pro plans.'**
  String get legalRefundSubtitle;

  /// No description provided for @legalRefundPaymentOrdersTitle.
  ///
  /// In en, this message translates to:
  /// **'Subscription access'**
  String get legalRefundPaymentOrdersTitle;

  /// No description provided for @legalRefundPaymentOrdersBody.
  ///
  /// In en, this message translates to:
  /// **'Pro subscriptions are purchased and managed on the Xenoh website. The mobile app reflects subscription access after the website account is updated.'**
  String get legalRefundPaymentOrdersBody;

  /// No description provided for @legalRefundReviewProcessTitle.
  ///
  /// In en, this message translates to:
  /// **'Review Process'**
  String get legalRefundReviewProcessTitle;

  /// No description provided for @legalRefundReviewProcessBody.
  ///
  /// In en, this message translates to:
  /// **'Refund requests are handled through the Xenoh website according to the applicable purchase terms and account state.'**
  String get legalRefundReviewProcessBody;

  /// No description provided for @legalRefundAccessChangesTitle.
  ///
  /// In en, this message translates to:
  /// **'Access Changes'**
  String get legalRefundAccessChangesTitle;

  /// No description provided for @legalRefundAccessChangesBody.
  ///
  /// In en, this message translates to:
  /// **'If a refund or manual adjustment changes the active subscription, Pro, Pro Coach, and AI access may be updated immediately after refresh.'**
  String get legalRefundAccessChangesBody;

  /// No description provided for @legalDisclaimerMessage.
  ///
  /// In en, this message translates to:
  /// **'This mobile summary mirrors the current Xenoh product behavior and should be replaced with finalized legal copy before production launch.'**
  String get legalDisclaimerMessage;

  /// No description provided for @marketingAboutTitle.
  ///
  /// In en, this message translates to:
  /// **'About Xenoh'**
  String get marketingAboutTitle;

  /// No description provided for @marketingBuiltForTitle.
  ///
  /// In en, this message translates to:
  /// **'Built for lifters and coaches'**
  String get marketingBuiltForTitle;

  /// No description provided for @marketingBuiltForSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Xenoh keeps the backend as the source of truth while the mobile app focuses on fast daily execution.'**
  String get marketingBuiltForSubtitle;

  /// No description provided for @marketingIndividualsTitle.
  ///
  /// In en, this message translates to:
  /// **'Individuals'**
  String get marketingIndividualsTitle;

  /// No description provided for @marketingIndividualsBody.
  ///
  /// In en, this message translates to:
  /// **'Create plans, complete workouts, track nutrition, follow PRs, and upgrade for analytics and AI insights.'**
  String get marketingIndividualsBody;

  /// No description provided for @marketingCoachesTitle.
  ///
  /// In en, this message translates to:
  /// **'Coaches'**
  String get marketingCoachesTitle;

  /// No description provided for @marketingCoachesBody.
  ///
  /// In en, this message translates to:
  /// **'Pro Coach unlocks client management, invite codes, client plans, chat, nutrition oversight, and AI briefs.'**
  String get marketingCoachesBody;

  /// No description provided for @marketingViewPricingCta.
  ///
  /// In en, this message translates to:
  /// **'View pricing'**
  String get marketingViewPricingCta;

  /// No description provided for @marketingAboutNavLabel.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get marketingAboutNavLabel;

  /// No description provided for @marketingHeroTitle.
  ///
  /// In en, this message translates to:
  /// **'Training, nutrition, coaching, and progress in one mobile flow.'**
  String get marketingHeroTitle;

  /// No description provided for @marketingHeroSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Build plans, log workouts, track macros, collaborate with a coach, and unlock AI feedback when your subscription allows it.'**
  String get marketingHeroSubtitle;

  /// No description provided for @marketingFeatureWorkoutTitle.
  ///
  /// In en, this message translates to:
  /// **'Workout execution'**
  String get marketingFeatureWorkoutTitle;

  /// No description provided for @marketingFeatureWorkoutBody.
  ///
  /// In en, this message translates to:
  /// **'Plans, days, exercises, sets, timers, and PR tracking.'**
  String get marketingFeatureWorkoutBody;

  /// No description provided for @marketingFeatureNutritionTitle.
  ///
  /// In en, this message translates to:
  /// **'Nutrition logging'**
  String get marketingFeatureNutritionTitle;

  /// No description provided for @marketingFeatureNutritionBody.
  ///
  /// In en, this message translates to:
  /// **'Daily calories and macros with food search and history.'**
  String get marketingFeatureNutritionBody;

  /// No description provided for @marketingFeatureCoachTitle.
  ///
  /// In en, this message translates to:
  /// **'Coach collaboration'**
  String get marketingFeatureCoachTitle;

  /// No description provided for @marketingFeatureCoachBody.
  ///
  /// In en, this message translates to:
  /// **'Invite codes, relationship lifecycle, chat, and comments.'**
  String get marketingFeatureCoachBody;

  /// No description provided for @marketingPrivacyNavLabel.
  ///
  /// In en, this message translates to:
  /// **'Privacy'**
  String get marketingPrivacyNavLabel;

  /// No description provided for @marketingTermsNavLabel.
  ///
  /// In en, this message translates to:
  /// **'Terms'**
  String get marketingTermsNavLabel;

  /// No description provided for @marketingRefundsNavLabel.
  ///
  /// In en, this message translates to:
  /// **'Refunds'**
  String get marketingRefundsNavLabel;

  /// No description provided for @aiErrorProFeatureTitle.
  ///
  /// In en, this message translates to:
  /// **'Pro feature'**
  String get aiErrorProFeatureTitle;

  /// No description provided for @aiErrorProFeatureMessage.
  ///
  /// In en, this message translates to:
  /// **'Upgrade to Pro to unlock AI training tools.'**
  String get aiErrorProFeatureMessage;

  /// No description provided for @aiQuotaLimitReachedTitle.
  ///
  /// In en, this message translates to:
  /// **'AI limit reached'**
  String get aiQuotaLimitReachedTitle;

  /// No description provided for @aiQuotaLimitReachedMessage.
  ///
  /// In en, this message translates to:
  /// **'You\'ve used your AI quota for now. Please try again later, or upgrade for a higher limit.'**
  String get aiQuotaLimitReachedMessage;

  /// No description provided for @aiTryAgainButton.
  ///
  /// In en, this message translates to:
  /// **'Try again'**
  String get aiTryAgainButton;

  /// No description provided for @aiUpgradeButton.
  ///
  /// In en, this message translates to:
  /// **'Upgrade'**
  String get aiUpgradeButton;

  /// No description provided for @trainingPlanDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Training plan'**
  String get trainingPlanDefaultName;

  /// No description provided for @coachClientDefaultName.
  ///
  /// In en, this message translates to:
  /// **'Client'**
  String get coachClientDefaultName;

  /// No description provided for @accountDeletionAppBarTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete Xenoh account'**
  String get accountDeletionAppBarTitle;

  /// No description provided for @accountDeletionTitle.
  ///
  /// In en, this message translates to:
  /// **'Account deletion'**
  String get accountDeletionTitle;

  /// No description provided for @accountDeletionDescription.
  ///
  /// In en, this message translates to:
  /// **'Request permanent deletion of your Xenoh account and associated data. We will verify that you own the email address before processing the request.'**
  String get accountDeletionDescription;

  /// No description provided for @accountDeletionSuccessMessage.
  ///
  /// In en, this message translates to:
  /// **'Check your email for the next step. If an account exists for that address, you will receive a verification message.'**
  String get accountDeletionSuccessMessage;

  /// No description provided for @accountDeletionEmailLabel.
  ///
  /// In en, this message translates to:
  /// **'Email address'**
  String get accountDeletionEmailLabel;

  /// No description provided for @accountDeletionInvalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Enter a valid email address.'**
  String get accountDeletionInvalidEmail;

  /// No description provided for @accountDeletionSubmitLabel.
  ///
  /// In en, this message translates to:
  /// **'Request deletion'**
  String get accountDeletionSubmitLabel;

  /// No description provided for @accountDeletionSettingsLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get accountDeletionSettingsLabel;

  /// No description provided for @accountDeletionConfirmationTitle.
  ///
  /// In en, this message translates to:
  /// **'Delete account?'**
  String get accountDeletionConfirmationTitle;

  /// No description provided for @accountDeletionConfirmationMessage.
  ///
  /// In en, this message translates to:
  /// **'This permanently deletes your Xenoh account and its associated data. This action cannot be undone.'**
  String get accountDeletionConfirmationMessage;

  /// No description provided for @accountDeletionConfirmLabel.
  ///
  /// In en, this message translates to:
  /// **'Delete account'**
  String get accountDeletionConfirmLabel;

  /// No description provided for @commonNotNow.
  ///
  /// In en, this message translates to:
  /// **'Not now'**
  String get commonNotNow;

  /// No description provided for @commonAllow.
  ///
  /// In en, this message translates to:
  /// **'Allow'**
  String get commonAllow;

  /// No description provided for @workoutLockScreenPermissionTitle.
  ///
  /// In en, this message translates to:
  /// **'Show workout on your lock screen?'**
  String get workoutLockScreenPermissionTitle;

  /// No description provided for @workoutLockScreenPermissionMessage.
  ///
  /// In en, this message translates to:
  /// **'Xenoh can show today\'s exercise, set, reps, weight, and timer on your lock screen while a workout is active. Android will open the Workout progress notification settings so you can allow lock-screen display.'**
  String get workoutLockScreenPermissionMessage;

  /// No description provided for @workoutNotificationPermissionDenied.
  ///
  /// In en, this message translates to:
  /// **'Notification permission was not granted.'**
  String get workoutNotificationPermissionDenied;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
