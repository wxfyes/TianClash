import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_ja.dart';
import 'app_localizations_ru.dart';
import 'app_localizations_zh.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'arb/app_localizations.dart';
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
    Locale('en'),
    Locale('ja'),
    Locale('ru'),
    Locale('zh'),
    Locale('zh', 'CN')
  ];

  /// No description provided for @rule.
  ///
  /// In en, this message translates to:
  /// **'Rule'**
  String get rule;

  /// No description provided for @global.
  ///
  /// In en, this message translates to:
  /// **'Global'**
  String get global;

  /// No description provided for @direct.
  ///
  /// In en, this message translates to:
  /// **'Direct'**
  String get direct;

  /// No description provided for @dashboard.
  ///
  /// In en, this message translates to:
  /// **'Dashboard'**
  String get dashboard;

  /// No description provided for @proxies.
  ///
  /// In en, this message translates to:
  /// **'Proxies'**
  String get proxies;

  /// No description provided for @profile.
  ///
  /// In en, this message translates to:
  /// **'Profile'**
  String get profile;

  /// No description provided for @profiles.
  ///
  /// In en, this message translates to:
  /// **'Profiles'**
  String get profiles;

  /// No description provided for @tianque.
  ///
  /// In en, this message translates to:
  /// **'Tianque'**
  String get tianque;

  /// No description provided for @tools.
  ///
  /// In en, this message translates to:
  /// **'Tools'**
  String get tools;

  /// No description provided for @logs.
  ///
  /// In en, this message translates to:
  /// **'Logs'**
  String get logs;

  /// No description provided for @logsDesc.
  ///
  /// In en, this message translates to:
  /// **'Log capture records'**
  String get logsDesc;

  /// No description provided for @resources.
  ///
  /// In en, this message translates to:
  /// **'Resources'**
  String get resources;

  /// No description provided for @resourcesDesc.
  ///
  /// In en, this message translates to:
  /// **'External resource related info'**
  String get resourcesDesc;

  /// No description provided for @trafficUsage.
  ///
  /// In en, this message translates to:
  /// **'Traffic usage'**
  String get trafficUsage;

  /// No description provided for @coreInfo.
  ///
  /// In en, this message translates to:
  /// **'Core info'**
  String get coreInfo;

  /// No description provided for @networkSpeed.
  ///
  /// In en, this message translates to:
  /// **'Network speed'**
  String get networkSpeed;

  /// No description provided for @outboundMode.
  ///
  /// In en, this message translates to:
  /// **'Outbound mode'**
  String get outboundMode;

  /// No description provided for @networkDetection.
  ///
  /// In en, this message translates to:
  /// **'Network detection'**
  String get networkDetection;

  /// No description provided for @upload.
  ///
  /// In en, this message translates to:
  /// **'Upload'**
  String get upload;

  /// No description provided for @download.
  ///
  /// In en, this message translates to:
  /// **'Download'**
  String get download;

  /// No description provided for @noProxy.
  ///
  /// In en, this message translates to:
  /// **'No proxy'**
  String get noProxy;

  /// No description provided for @noProxyDesc.
  ///
  /// In en, this message translates to:
  /// **'Please create a profile or add a valid profile'**
  String get noProxyDesc;

  /// No description provided for @nullProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'No profile, Please add a profile'**
  String get nullProfileDesc;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @language.
  ///
  /// In en, this message translates to:
  /// **'Language'**
  String get language;

  /// No description provided for @defaultText.
  ///
  /// In en, this message translates to:
  /// **'Default'**
  String get defaultText;

  /// No description provided for @more.
  ///
  /// In en, this message translates to:
  /// **'More'**
  String get more;

  /// No description provided for @other.
  ///
  /// In en, this message translates to:
  /// **'Other'**
  String get other;

  /// No description provided for @about.
  ///
  /// In en, this message translates to:
  /// **'About'**
  String get about;

  /// No description provided for @en.
  ///
  /// In en, this message translates to:
  /// **'English'**
  String get en;

  /// No description provided for @ja.
  ///
  /// In en, this message translates to:
  /// **'Japanese'**
  String get ja;

  /// No description provided for @ru.
  ///
  /// In en, this message translates to:
  /// **'Russian'**
  String get ru;

  /// No description provided for @zh_CN.
  ///
  /// In en, this message translates to:
  /// **'Simplified Chinese'**
  String get zh_CN;

  /// No description provided for @theme.
  ///
  /// In en, this message translates to:
  /// **'Theme'**
  String get theme;

  /// No description provided for @themeDesc.
  ///
  /// In en, this message translates to:
  /// **'Set dark mode,adjust the color'**
  String get themeDesc;

  /// No description provided for @override.
  ///
  /// In en, this message translates to:
  /// **'Override'**
  String get override;

  /// No description provided for @overrideDesc.
  ///
  /// In en, this message translates to:
  /// **'Override Proxy related config'**
  String get overrideDesc;

  /// No description provided for @allowLan.
  ///
  /// In en, this message translates to:
  /// **'AllowLan'**
  String get allowLan;

  /// No description provided for @allowLanDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow access proxy through the LAN'**
  String get allowLanDesc;

  /// No description provided for @tun.
  ///
  /// In en, this message translates to:
  /// **'TUN'**
  String get tun;

  /// No description provided for @tunDesc.
  ///
  /// In en, this message translates to:
  /// **'only effective in administrator mode'**
  String get tunDesc;

  /// No description provided for @minimizeOnExit.
  ///
  /// In en, this message translates to:
  /// **'Minimize on exit'**
  String get minimizeOnExit;

  /// No description provided for @minimizeOnExitDesc.
  ///
  /// In en, this message translates to:
  /// **'Modify the default system exit event'**
  String get minimizeOnExitDesc;

  /// No description provided for @autoLaunch.
  ///
  /// In en, this message translates to:
  /// **'Auto launch'**
  String get autoLaunch;

  /// No description provided for @autoLaunchDesc.
  ///
  /// In en, this message translates to:
  /// **'Follow the system self startup'**
  String get autoLaunchDesc;

  /// No description provided for @silentLaunch.
  ///
  /// In en, this message translates to:
  /// **'SilentLaunch'**
  String get silentLaunch;

  /// No description provided for @silentLaunchDesc.
  ///
  /// In en, this message translates to:
  /// **'Start in the background'**
  String get silentLaunchDesc;

  /// No description provided for @autoRun.
  ///
  /// In en, this message translates to:
  /// **'AutoRun'**
  String get autoRun;

  /// No description provided for @autoRunDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto run when the application is opened'**
  String get autoRunDesc;

  /// No description provided for @logcat.
  ///
  /// In en, this message translates to:
  /// **'Logcat'**
  String get logcat;

  /// No description provided for @logcatDesc.
  ///
  /// In en, this message translates to:
  /// **'Disabling will hide the log entry'**
  String get logcatDesc;

  /// No description provided for @autoCheckUpdate.
  ///
  /// In en, this message translates to:
  /// **'Auto check updates'**
  String get autoCheckUpdate;

  /// No description provided for @autoCheckUpdateDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto check for updates when the app starts'**
  String get autoCheckUpdateDesc;

  /// No description provided for @accessControl.
  ///
  /// In en, this message translates to:
  /// **'AccessControl'**
  String get accessControl;

  /// No description provided for @accessControlDesc.
  ///
  /// In en, this message translates to:
  /// **'Configure application access proxy'**
  String get accessControlDesc;

  /// No description provided for @application.
  ///
  /// In en, this message translates to:
  /// **'Application'**
  String get application;

  /// No description provided for @applicationDesc.
  ///
  /// In en, this message translates to:
  /// **'Modify application related settings'**
  String get applicationDesc;

  /// No description provided for @edit.
  ///
  /// In en, this message translates to:
  /// **'Edit'**
  String get edit;

  /// No description provided for @confirm.
  ///
  /// In en, this message translates to:
  /// **'Confirm'**
  String get confirm;

  /// No description provided for @update.
  ///
  /// In en, this message translates to:
  /// **'Update'**
  String get update;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @years.
  ///
  /// In en, this message translates to:
  /// **'Years'**
  String get years;

  /// No description provided for @months.
  ///
  /// In en, this message translates to:
  /// **'Months'**
  String get months;

  /// No description provided for @hours.
  ///
  /// In en, this message translates to:
  /// **'Hours'**
  String get hours;

  /// No description provided for @days.
  ///
  /// In en, this message translates to:
  /// **'Days'**
  String get days;

  /// No description provided for @minutes.
  ///
  /// In en, this message translates to:
  /// **'Minutes'**
  String get minutes;

  /// No description provided for @seconds.
  ///
  /// In en, this message translates to:
  /// **'Seconds'**
  String get seconds;

  /// No description provided for @ago.
  ///
  /// In en, this message translates to:
  /// **' Ago'**
  String get ago;

  /// No description provided for @just.
  ///
  /// In en, this message translates to:
  /// **'Just'**
  String get just;

  /// No description provided for @qrcode.
  ///
  /// In en, this message translates to:
  /// **'QR code'**
  String get qrcode;

  /// No description provided for @qrcodeDesc.
  ///
  /// In en, this message translates to:
  /// **'Scan QR code to obtain profile'**
  String get qrcodeDesc;

  /// No description provided for @url.
  ///
  /// In en, this message translates to:
  /// **'URL'**
  String get url;

  /// No description provided for @urlDesc.
  ///
  /// In en, this message translates to:
  /// **'Obtain profile through URL'**
  String get urlDesc;

  /// No description provided for @file.
  ///
  /// In en, this message translates to:
  /// **'File'**
  String get file;

  /// No description provided for @fileDesc.
  ///
  /// In en, this message translates to:
  /// **'Directly upload profile'**
  String get fileDesc;

  /// No description provided for @name.
  ///
  /// In en, this message translates to:
  /// **'Name'**
  String get name;

  /// No description provided for @profileNameNullValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input the profile name'**
  String get profileNameNullValidationDesc;

  /// No description provided for @profileUrlNullValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input the profile URL'**
  String get profileUrlNullValidationDesc;

  /// No description provided for @profileUrlInvalidValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input a valid profile URL'**
  String get profileUrlInvalidValidationDesc;

  /// No description provided for @autoUpdate.
  ///
  /// In en, this message translates to:
  /// **'Auto update'**
  String get autoUpdate;

  /// No description provided for @autoUpdateInterval.
  ///
  /// In en, this message translates to:
  /// **'Auto update interval (minutes)'**
  String get autoUpdateInterval;

  /// No description provided for @profileAutoUpdateIntervalNullValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please enter the auto update interval time'**
  String get profileAutoUpdateIntervalNullValidationDesc;

  /// No description provided for @profileAutoUpdateIntervalInvalidValidationDesc.
  ///
  /// In en, this message translates to:
  /// **'Please input a valid interval time format'**
  String get profileAutoUpdateIntervalInvalidValidationDesc;

  /// No description provided for @themeMode.
  ///
  /// In en, this message translates to:
  /// **'Theme mode'**
  String get themeMode;

  /// No description provided for @themeColor.
  ///
  /// In en, this message translates to:
  /// **'Theme color'**
  String get themeColor;

  /// No description provided for @preview.
  ///
  /// In en, this message translates to:
  /// **'Preview'**
  String get preview;

  /// No description provided for @auto.
  ///
  /// In en, this message translates to:
  /// **'Auto'**
  String get auto;

  /// No description provided for @light.
  ///
  /// In en, this message translates to:
  /// **'Light'**
  String get light;

  /// No description provided for @dark.
  ///
  /// In en, this message translates to:
  /// **'Dark'**
  String get dark;

  /// No description provided for @importFromURL.
  ///
  /// In en, this message translates to:
  /// **'Import from URL'**
  String get importFromURL;

  /// No description provided for @submit.
  ///
  /// In en, this message translates to:
  /// **'Submit'**
  String get submit;

  /// No description provided for @doYouWantToPass.
  ///
  /// In en, this message translates to:
  /// **'Do you want to pass'**
  String get doYouWantToPass;

  /// No description provided for @create.
  ///
  /// In en, this message translates to:
  /// **'Create'**
  String get create;

  /// No description provided for @defaultSort.
  ///
  /// In en, this message translates to:
  /// **'Sort by default'**
  String get defaultSort;

  /// No description provided for @delaySort.
  ///
  /// In en, this message translates to:
  /// **'Sort by delay'**
  String get delaySort;

  /// No description provided for @nameSort.
  ///
  /// In en, this message translates to:
  /// **'Sort by name'**
  String get nameSort;

  /// No description provided for @pleaseUploadFile.
  ///
  /// In en, this message translates to:
  /// **'Please upload file'**
  String get pleaseUploadFile;

  /// No description provided for @pleaseUploadValidQrcode.
  ///
  /// In en, this message translates to:
  /// **'Please upload a valid QR code'**
  String get pleaseUploadValidQrcode;

  /// No description provided for @blacklistMode.
  ///
  /// In en, this message translates to:
  /// **'Blacklist mode'**
  String get blacklistMode;

  /// No description provided for @whitelistMode.
  ///
  /// In en, this message translates to:
  /// **'Whitelist mode'**
  String get whitelistMode;

  /// No description provided for @filterSystemApp.
  ///
  /// In en, this message translates to:
  /// **'Filter system app'**
  String get filterSystemApp;

  /// No description provided for @cancelFilterSystemApp.
  ///
  /// In en, this message translates to:
  /// **'Cancel filter system app'**
  String get cancelFilterSystemApp;

  /// No description provided for @selectAll.
  ///
  /// In en, this message translates to:
  /// **'Select all'**
  String get selectAll;

  /// No description provided for @cancelSelectAll.
  ///
  /// In en, this message translates to:
  /// **'Cancel select all'**
  String get cancelSelectAll;

  /// No description provided for @appAccessControl.
  ///
  /// In en, this message translates to:
  /// **'App access control'**
  String get appAccessControl;

  /// No description provided for @accessControlAllowDesc.
  ///
  /// In en, this message translates to:
  /// **'Only allow selected app to enter VPN'**
  String get accessControlAllowDesc;

  /// No description provided for @accessControlNotAllowDesc.
  ///
  /// In en, this message translates to:
  /// **'The selected application will be excluded from VPN'**
  String get accessControlNotAllowDesc;

  /// No description provided for @selected.
  ///
  /// In en, this message translates to:
  /// **'Selected'**
  String get selected;

  /// No description provided for @unableToUpdateCurrentProfileDesc.
  ///
  /// In en, this message translates to:
  /// **'unable to update current profile'**
  String get unableToUpdateCurrentProfileDesc;

  /// No description provided for @noMoreInfoDesc.
  ///
  /// In en, this message translates to:
  /// **'No more info'**
  String get noMoreInfoDesc;

  /// No description provided for @profileParseErrorDesc.
  ///
  /// In en, this message translates to:
  /// **'profile parse error'**
  String get profileParseErrorDesc;

  /// No description provided for @proxyPort.
  ///
  /// In en, this message translates to:
  /// **'ProxyPort'**
  String get proxyPort;

  /// No description provided for @proxyPortDesc.
  ///
  /// In en, this message translates to:
  /// **'Set the Clash listening port'**
  String get proxyPortDesc;

  /// No description provided for @port.
  ///
  /// In en, this message translates to:
  /// **'Port'**
  String get port;

  /// No description provided for @logLevel.
  ///
  /// In en, this message translates to:
  /// **'LogLevel'**
  String get logLevel;

  /// No description provided for @show.
  ///
  /// In en, this message translates to:
  /// **'Show'**
  String get show;

  /// No description provided for @exit.
  ///
  /// In en, this message translates to:
  /// **'Exit'**
  String get exit;

  /// No description provided for @systemProxy.
  ///
  /// In en, this message translates to:
  /// **'System proxy'**
  String get systemProxy;

  /// No description provided for @project.
  ///
  /// In en, this message translates to:
  /// **'Project'**
  String get project;

  /// No description provided for @core.
  ///
  /// In en, this message translates to:
  /// **'Core'**
  String get core;

  /// No description provided for @tabAnimation.
  ///
  /// In en, this message translates to:
  /// **'Tab animation'**
  String get tabAnimation;

  /// No description provided for @desc.
  ///
  /// In en, this message translates to:
  /// **'A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.'**
  String get desc;

  /// No description provided for @startVpn.
  ///
  /// In en, this message translates to:
  /// **'Starting VPN...'**
  String get startVpn;

  /// No description provided for @stopVpn.
  ///
  /// In en, this message translates to:
  /// **'Stopping VPN...'**
  String get stopVpn;

  /// No description provided for @discovery.
  ///
  /// In en, this message translates to:
  /// **'Discovery a new version'**
  String get discovery;

  /// No description provided for @compatible.
  ///
  /// In en, this message translates to:
  /// **'Compatibility mode'**
  String get compatible;

  /// No description provided for @compatibleDesc.
  ///
  /// In en, this message translates to:
  /// **'Opening it will lose part of its application ability and gain the support of full amount of Clash.'**
  String get compatibleDesc;

  /// No description provided for @notSelectedTip.
  ///
  /// In en, this message translates to:
  /// **'The current proxy group cannot be selected.'**
  String get notSelectedTip;

  /// No description provided for @tip.
  ///
  /// In en, this message translates to:
  /// **'tip'**
  String get tip;

  /// No description provided for @backupAndRecovery.
  ///
  /// In en, this message translates to:
  /// **'Backup and Recovery'**
  String get backupAndRecovery;

  /// No description provided for @backupAndRecoveryDesc.
  ///
  /// In en, this message translates to:
  /// **'Sync data via WebDAV or file'**
  String get backupAndRecoveryDesc;

  /// No description provided for @account.
  ///
  /// In en, this message translates to:
  /// **'Account'**
  String get account;

  /// No description provided for @backup.
  ///
  /// In en, this message translates to:
  /// **'Backup'**
  String get backup;

  /// No description provided for @recovery.
  ///
  /// In en, this message translates to:
  /// **'Recovery'**
  String get recovery;

  /// No description provided for @recoveryProfiles.
  ///
  /// In en, this message translates to:
  /// **'Only recovery profiles'**
  String get recoveryProfiles;

  /// No description provided for @recoveryAll.
  ///
  /// In en, this message translates to:
  /// **'Recovery all data'**
  String get recoveryAll;

  /// No description provided for @recoverySuccess.
  ///
  /// In en, this message translates to:
  /// **'Recovery success'**
  String get recoverySuccess;

  /// No description provided for @backupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Backup success'**
  String get backupSuccess;

  /// No description provided for @noInfo.
  ///
  /// In en, this message translates to:
  /// **'No info'**
  String get noInfo;

  /// No description provided for @pleaseBindWebDAV.
  ///
  /// In en, this message translates to:
  /// **'Please bind WebDAV'**
  String get pleaseBindWebDAV;

  /// No description provided for @bind.
  ///
  /// In en, this message translates to:
  /// **'Bind'**
  String get bind;

  /// No description provided for @connectivity.
  ///
  /// In en, this message translates to:
  /// **'Connectivity：'**
  String get connectivity;

  /// No description provided for @webDAVConfiguration.
  ///
  /// In en, this message translates to:
  /// **'WebDAV configuration'**
  String get webDAVConfiguration;

  /// No description provided for @address.
  ///
  /// In en, this message translates to:
  /// **'Address'**
  String get address;

  /// No description provided for @addressHelp.
  ///
  /// In en, this message translates to:
  /// **'WebDAV server address'**
  String get addressHelp;

  /// No description provided for @addressTip.
  ///
  /// In en, this message translates to:
  /// **'Please enter a valid WebDAV address'**
  String get addressTip;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @checkUpdate.
  ///
  /// In en, this message translates to:
  /// **'Check for updates'**
  String get checkUpdate;

  /// No description provided for @discoverNewVersion.
  ///
  /// In en, this message translates to:
  /// **'Discover the new version'**
  String get discoverNewVersion;

  /// No description provided for @checkUpdateError.
  ///
  /// In en, this message translates to:
  /// **'The current application is already the latest version'**
  String get checkUpdateError;

  /// No description provided for @goDownload.
  ///
  /// In en, this message translates to:
  /// **'Go to download'**
  String get goDownload;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @geoData.
  ///
  /// In en, this message translates to:
  /// **'GeoData'**
  String get geoData;

  /// No description provided for @externalResources.
  ///
  /// In en, this message translates to:
  /// **'External resources'**
  String get externalResources;

  /// No description provided for @checking.
  ///
  /// In en, this message translates to:
  /// **'Checking...'**
  String get checking;

  /// No description provided for @country.
  ///
  /// In en, this message translates to:
  /// **'Country'**
  String get country;

  /// No description provided for @checkError.
  ///
  /// In en, this message translates to:
  /// **'Check error'**
  String get checkError;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @allowBypass.
  ///
  /// In en, this message translates to:
  /// **'Allow applications to bypass VPN'**
  String get allowBypass;

  /// No description provided for @allowBypassDesc.
  ///
  /// In en, this message translates to:
  /// **'Some apps can bypass VPN when turned on'**
  String get allowBypassDesc;

  /// No description provided for @externalController.
  ///
  /// In en, this message translates to:
  /// **'ExternalController'**
  String get externalController;

  /// No description provided for @externalControllerDesc.
  ///
  /// In en, this message translates to:
  /// **'Once enabled, the Clash kernel can be controlled on port 9090'**
  String get externalControllerDesc;

  /// No description provided for @ipv6Desc.
  ///
  /// In en, this message translates to:
  /// **'When turned on it will be able to receive IPv6 traffic'**
  String get ipv6Desc;

  /// No description provided for @app.
  ///
  /// In en, this message translates to:
  /// **'App'**
  String get app;

  /// No description provided for @general.
  ///
  /// In en, this message translates to:
  /// **'General'**
  String get general;

  /// No description provided for @vpnSystemProxyDesc.
  ///
  /// In en, this message translates to:
  /// **'Attach HTTP proxy to VpnService'**
  String get vpnSystemProxyDesc;

  /// No description provided for @systemProxyDesc.
  ///
  /// In en, this message translates to:
  /// **'Attach HTTP proxy to VpnService'**
  String get systemProxyDesc;

  /// No description provided for @unifiedDelay.
  ///
  /// In en, this message translates to:
  /// **'Unified delay'**
  String get unifiedDelay;

  /// No description provided for @unifiedDelayDesc.
  ///
  /// In en, this message translates to:
  /// **'Remove extra delays such as handshaking'**
  String get unifiedDelayDesc;

  /// No description provided for @tcpConcurrent.
  ///
  /// In en, this message translates to:
  /// **'TCP concurrent'**
  String get tcpConcurrent;

  /// No description provided for @tcpConcurrentDesc.
  ///
  /// In en, this message translates to:
  /// **'Enabling it will allow TCP concurrency'**
  String get tcpConcurrentDesc;

  /// No description provided for @geodataLoader.
  ///
  /// In en, this message translates to:
  /// **'Geo Low Memory Mode'**
  String get geodataLoader;

  /// No description provided for @geodataLoaderDesc.
  ///
  /// In en, this message translates to:
  /// **'Enabling will use the Geo low memory loader'**
  String get geodataLoaderDesc;

  /// No description provided for @requests.
  ///
  /// In en, this message translates to:
  /// **'Requests'**
  String get requests;

  /// No description provided for @requestsDesc.
  ///
  /// In en, this message translates to:
  /// **'View recently request records'**
  String get requestsDesc;

  /// No description provided for @findProcessMode.
  ///
  /// In en, this message translates to:
  /// **'Find process'**
  String get findProcessMode;

  /// No description provided for @init.
  ///
  /// In en, this message translates to:
  /// **'Init'**
  String get init;

  /// No description provided for @infiniteTime.
  ///
  /// In en, this message translates to:
  /// **'Long term effective'**
  String get infiniteTime;

  /// No description provided for @expirationTime.
  ///
  /// In en, this message translates to:
  /// **'Expiration time'**
  String get expirationTime;

  /// No description provided for @connections.
  ///
  /// In en, this message translates to:
  /// **'Connections'**
  String get connections;

  /// No description provided for @connectionsDesc.
  ///
  /// In en, this message translates to:
  /// **'View current connections data'**
  String get connectionsDesc;

  /// No description provided for @intranetIP.
  ///
  /// In en, this message translates to:
  /// **'Intranet IP'**
  String get intranetIP;

  /// No description provided for @view.
  ///
  /// In en, this message translates to:
  /// **'View'**
  String get view;

  /// No description provided for @cut.
  ///
  /// In en, this message translates to:
  /// **'Cut'**
  String get cut;

  /// No description provided for @copy.
  ///
  /// In en, this message translates to:
  /// **'Copy'**
  String get copy;

  /// No description provided for @paste.
  ///
  /// In en, this message translates to:
  /// **'Paste'**
  String get paste;

  /// No description provided for @testUrl.
  ///
  /// In en, this message translates to:
  /// **'Test url'**
  String get testUrl;

  /// No description provided for @sync.
  ///
  /// In en, this message translates to:
  /// **'Sync'**
  String get sync;

  /// No description provided for @exclude.
  ///
  /// In en, this message translates to:
  /// **'Hidden from recent tasks'**
  String get exclude;

  /// No description provided for @excludeDesc.
  ///
  /// In en, this message translates to:
  /// **'When the app is in the background, the app is hidden from the recent task'**
  String get excludeDesc;

  /// No description provided for @oneColumn.
  ///
  /// In en, this message translates to:
  /// **'One column'**
  String get oneColumn;

  /// No description provided for @twoColumns.
  ///
  /// In en, this message translates to:
  /// **'Two columns'**
  String get twoColumns;

  /// No description provided for @threeColumns.
  ///
  /// In en, this message translates to:
  /// **'Three columns'**
  String get threeColumns;

  /// No description provided for @fourColumns.
  ///
  /// In en, this message translates to:
  /// **'Four columns'**
  String get fourColumns;

  /// No description provided for @expand.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get expand;

  /// No description provided for @shrink.
  ///
  /// In en, this message translates to:
  /// **'Shrink'**
  String get shrink;

  /// No description provided for @min.
  ///
  /// In en, this message translates to:
  /// **'Min'**
  String get min;

  /// No description provided for @tab.
  ///
  /// In en, this message translates to:
  /// **'Tab'**
  String get tab;

  /// No description provided for @list.
  ///
  /// In en, this message translates to:
  /// **'List'**
  String get list;

  /// No description provided for @delay.
  ///
  /// In en, this message translates to:
  /// **'Delay'**
  String get delay;

  /// No description provided for @style.
  ///
  /// In en, this message translates to:
  /// **'Style'**
  String get style;

  /// No description provided for @size.
  ///
  /// In en, this message translates to:
  /// **'Size'**
  String get size;

  /// No description provided for @sort.
  ///
  /// In en, this message translates to:
  /// **'Sort'**
  String get sort;

  /// No description provided for @columns.
  ///
  /// In en, this message translates to:
  /// **'Columns'**
  String get columns;

  /// No description provided for @proxiesSetting.
  ///
  /// In en, this message translates to:
  /// **'Proxies setting'**
  String get proxiesSetting;

  /// No description provided for @proxyGroup.
  ///
  /// In en, this message translates to:
  /// **'Proxy group'**
  String get proxyGroup;

  /// No description provided for @go.
  ///
  /// In en, this message translates to:
  /// **'Go'**
  String get go;

  /// No description provided for @externalLink.
  ///
  /// In en, this message translates to:
  /// **'External link'**
  String get externalLink;

  /// No description provided for @otherContributors.
  ///
  /// In en, this message translates to:
  /// **'Other contributors'**
  String get otherContributors;

  /// No description provided for @autoCloseConnections.
  ///
  /// In en, this message translates to:
  /// **'Auto close connections'**
  String get autoCloseConnections;

  /// No description provided for @autoCloseConnectionsDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto close connections after change node'**
  String get autoCloseConnectionsDesc;

  /// No description provided for @onlyStatisticsProxy.
  ///
  /// In en, this message translates to:
  /// **'Only statistics proxy'**
  String get onlyStatisticsProxy;

  /// No description provided for @onlyStatisticsProxyDesc.
  ///
  /// In en, this message translates to:
  /// **'When turned on, only statistics proxy traffic'**
  String get onlyStatisticsProxyDesc;

  /// No description provided for @pureBlackMode.
  ///
  /// In en, this message translates to:
  /// **'Pure black mode'**
  String get pureBlackMode;

  /// No description provided for @keepAliveIntervalDesc.
  ///
  /// In en, this message translates to:
  /// **'Tcp keep alive interval'**
  String get keepAliveIntervalDesc;

  /// No description provided for @entries.
  ///
  /// In en, this message translates to:
  /// **' entries'**
  String get entries;

  /// No description provided for @local.
  ///
  /// In en, this message translates to:
  /// **'Local'**
  String get local;

  /// No description provided for @remote.
  ///
  /// In en, this message translates to:
  /// **'Remote'**
  String get remote;

  /// No description provided for @remoteBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Backup local data to WebDAV'**
  String get remoteBackupDesc;

  /// No description provided for @remoteRecoveryDesc.
  ///
  /// In en, this message translates to:
  /// **'Recovery data from WebDAV'**
  String get remoteRecoveryDesc;

  /// No description provided for @localBackupDesc.
  ///
  /// In en, this message translates to:
  /// **'Backup local data to local'**
  String get localBackupDesc;

  /// No description provided for @localRecoveryDesc.
  ///
  /// In en, this message translates to:
  /// **'Recovery data from file'**
  String get localRecoveryDesc;

  /// No description provided for @mode.
  ///
  /// In en, this message translates to:
  /// **'Mode'**
  String get mode;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @source.
  ///
  /// In en, this message translates to:
  /// **'Source'**
  String get source;

  /// No description provided for @allApps.
  ///
  /// In en, this message translates to:
  /// **'All apps'**
  String get allApps;

  /// No description provided for @onlyOtherApps.
  ///
  /// In en, this message translates to:
  /// **'Only third-party apps'**
  String get onlyOtherApps;

  /// No description provided for @action.
  ///
  /// In en, this message translates to:
  /// **'Action'**
  String get action;

  /// No description provided for @intelligentSelected.
  ///
  /// In en, this message translates to:
  /// **'Intelligent selection'**
  String get intelligentSelected;

  /// No description provided for @clipboardImport.
  ///
  /// In en, this message translates to:
  /// **'Clipboard import'**
  String get clipboardImport;

  /// No description provided for @clipboardExport.
  ///
  /// In en, this message translates to:
  /// **'Export clipboard'**
  String get clipboardExport;

  /// No description provided for @layout.
  ///
  /// In en, this message translates to:
  /// **'Layout'**
  String get layout;

  /// No description provided for @tight.
  ///
  /// In en, this message translates to:
  /// **'Tight'**
  String get tight;

  /// No description provided for @standard.
  ///
  /// In en, this message translates to:
  /// **'Standard'**
  String get standard;

  /// No description provided for @loose.
  ///
  /// In en, this message translates to:
  /// **'Loose'**
  String get loose;

  /// No description provided for @profilesSort.
  ///
  /// In en, this message translates to:
  /// **'Profiles sort'**
  String get profilesSort;

  /// No description provided for @start.
  ///
  /// In en, this message translates to:
  /// **'Start'**
  String get start;

  /// No description provided for @stop.
  ///
  /// In en, this message translates to:
  /// **'Stop'**
  String get stop;

  /// No description provided for @appDesc.
  ///
  /// In en, this message translates to:
  /// **'Processing app related settings'**
  String get appDesc;

  /// No description provided for @vpnDesc.
  ///
  /// In en, this message translates to:
  /// **'Modify VPN related settings'**
  String get vpnDesc;

  /// No description provided for @dnsDesc.
  ///
  /// In en, this message translates to:
  /// **'Update DNS related settings'**
  String get dnsDesc;

  /// No description provided for @key.
  ///
  /// In en, this message translates to:
  /// **'Key'**
  String get key;

  /// No description provided for @value.
  ///
  /// In en, this message translates to:
  /// **'Value'**
  String get value;

  /// No description provided for @hostsDesc.
  ///
  /// In en, this message translates to:
  /// **'Add Hosts'**
  String get hostsDesc;

  /// No description provided for @vpnTip.
  ///
  /// In en, this message translates to:
  /// **'Changes take effect after restarting the VPN'**
  String get vpnTip;

  /// No description provided for @vpnEnableDesc.
  ///
  /// In en, this message translates to:
  /// **'Auto routes all system traffic through VpnService'**
  String get vpnEnableDesc;

  /// No description provided for @options.
  ///
  /// In en, this message translates to:
  /// **'Options'**
  String get options;

  /// No description provided for @loopback.
  ///
  /// In en, this message translates to:
  /// **'Loopback unlock tool'**
  String get loopback;

  /// No description provided for @loopbackDesc.
  ///
  /// In en, this message translates to:
  /// **'Used for UWP loopback unlocking'**
  String get loopbackDesc;

  /// No description provided for @providers.
  ///
  /// In en, this message translates to:
  /// **'Providers'**
  String get providers;

  /// No description provided for @proxyProviders.
  ///
  /// In en, this message translates to:
  /// **'Proxy providers'**
  String get proxyProviders;

  /// No description provided for @ruleProviders.
  ///
  /// In en, this message translates to:
  /// **'Rule providers'**
  String get ruleProviders;

  /// No description provided for @overrideDns.
  ///
  /// In en, this message translates to:
  /// **'Override Dns'**
  String get overrideDns;

  /// No description provided for @overrideDnsDesc.
  ///
  /// In en, this message translates to:
  /// **'Turning it on will override the DNS options in the profile'**
  String get overrideDnsDesc;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @statusDesc.
  ///
  /// In en, this message translates to:
  /// **'System DNS will be used when turned off'**
  String get statusDesc;

  /// No description provided for @preferH3Desc.
  ///
  /// In en, this message translates to:
  /// **'Prioritize the use of DOH\'s http/3'**
  String get preferH3Desc;

  /// No description provided for @respectRules.
  ///
  /// In en, this message translates to:
  /// **'Respect rules'**
  String get respectRules;

  /// No description provided for @respectRulesDesc.
  ///
  /// In en, this message translates to:
  /// **'DNS connection following rules, need to configure proxy-server-nameserver'**
  String get respectRulesDesc;

  /// No description provided for @dnsMode.
  ///
  /// In en, this message translates to:
  /// **'DNS mode'**
  String get dnsMode;

  /// No description provided for @fakeipRange.
  ///
  /// In en, this message translates to:
  /// **'Fakeip range'**
  String get fakeipRange;

  /// No description provided for @fakeipFilter.
  ///
  /// In en, this message translates to:
  /// **'Fakeip filter'**
  String get fakeipFilter;

  /// No description provided for @defaultNameserver.
  ///
  /// In en, this message translates to:
  /// **'Default nameserver'**
  String get defaultNameserver;

  /// No description provided for @defaultNameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'For resolving DNS server'**
  String get defaultNameserverDesc;

  /// No description provided for @nameserver.
  ///
  /// In en, this message translates to:
  /// **'Nameserver'**
  String get nameserver;

  /// No description provided for @nameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'For resolving domain'**
  String get nameserverDesc;

  /// No description provided for @useHosts.
  ///
  /// In en, this message translates to:
  /// **'Use hosts'**
  String get useHosts;

  /// No description provided for @useSystemHosts.
  ///
  /// In en, this message translates to:
  /// **'Use system hosts'**
  String get useSystemHosts;

  /// No description provided for @nameserverPolicy.
  ///
  /// In en, this message translates to:
  /// **'Nameserver policy'**
  String get nameserverPolicy;

  /// No description provided for @nameserverPolicyDesc.
  ///
  /// In en, this message translates to:
  /// **'Specify the corresponding nameserver policy'**
  String get nameserverPolicyDesc;

  /// No description provided for @proxyNameserver.
  ///
  /// In en, this message translates to:
  /// **'Proxy nameserver'**
  String get proxyNameserver;

  /// No description provided for @proxyNameserverDesc.
  ///
  /// In en, this message translates to:
  /// **'Domain for resolving proxy nodes'**
  String get proxyNameserverDesc;

  /// No description provided for @fallback.
  ///
  /// In en, this message translates to:
  /// **'Fallback'**
  String get fallback;

  /// No description provided for @fallbackDesc.
  ///
  /// In en, this message translates to:
  /// **'Generally use offshore DNS'**
  String get fallbackDesc;

  /// No description provided for @fallbackFilter.
  ///
  /// In en, this message translates to:
  /// **'Fallback filter'**
  String get fallbackFilter;

  /// No description provided for @geoipCode.
  ///
  /// In en, this message translates to:
  /// **'Geoip code'**
  String get geoipCode;

  /// No description provided for @ipcidr.
  ///
  /// In en, this message translates to:
  /// **'Ipcidr'**
  String get ipcidr;

  /// No description provided for @domain.
  ///
  /// In en, this message translates to:
  /// **'Domain'**
  String get domain;

  /// No description provided for @reset.
  ///
  /// In en, this message translates to:
  /// **'Reset'**
  String get reset;

  /// No description provided for @action_view.
  ///
  /// In en, this message translates to:
  /// **'Show/Hide'**
  String get action_view;

  /// No description provided for @action_start.
  ///
  /// In en, this message translates to:
  /// **'Start/Stop'**
  String get action_start;

  /// No description provided for @action_mode.
  ///
  /// In en, this message translates to:
  /// **'Switch mode'**
  String get action_mode;

  /// No description provided for @action_proxy.
  ///
  /// In en, this message translates to:
  /// **'System proxy'**
  String get action_proxy;

  /// No description provided for @action_tun.
  ///
  /// In en, this message translates to:
  /// **'TUN'**
  String get action_tun;

  /// No description provided for @disclaimer.
  ///
  /// In en, this message translates to:
  /// **'Disclaimer'**
  String get disclaimer;

  /// No description provided for @disclaimerDesc.
  ///
  /// In en, this message translates to:
  /// **'This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.'**
  String get disclaimerDesc;

  /// No description provided for @agree.
  ///
  /// In en, this message translates to:
  /// **'Agree'**
  String get agree;

  /// No description provided for @hotkeyManagement.
  ///
  /// In en, this message translates to:
  /// **'Hotkey Management'**
  String get hotkeyManagement;

  /// No description provided for @hotkeyManagementDesc.
  ///
  /// In en, this message translates to:
  /// **'Use keyboard to control applications'**
  String get hotkeyManagementDesc;

  /// No description provided for @pressKeyboard.
  ///
  /// In en, this message translates to:
  /// **'Please press the keyboard.'**
  String get pressKeyboard;

  /// No description provided for @inputCorrectHotkey.
  ///
  /// In en, this message translates to:
  /// **'Please enter the correct hotkey'**
  String get inputCorrectHotkey;

  /// No description provided for @hotkeyConflict.
  ///
  /// In en, this message translates to:
  /// **'Hotkey conflict'**
  String get hotkeyConflict;

  /// No description provided for @remove.
  ///
  /// In en, this message translates to:
  /// **'Remove'**
  String get remove;

  /// No description provided for @noHotKey.
  ///
  /// In en, this message translates to:
  /// **'No HotKey'**
  String get noHotKey;

  /// No description provided for @noNetwork.
  ///
  /// In en, this message translates to:
  /// **'No network'**
  String get noNetwork;

  /// No description provided for @ipv6InboundDesc.
  ///
  /// In en, this message translates to:
  /// **'Allow IPv6 inbound'**
  String get ipv6InboundDesc;

  /// No description provided for @exportLogs.
  ///
  /// In en, this message translates to:
  /// **'Export logs'**
  String get exportLogs;

  /// No description provided for @exportSuccess.
  ///
  /// In en, this message translates to:
  /// **'Export Success'**
  String get exportSuccess;

  /// No description provided for @iconStyle.
  ///
  /// In en, this message translates to:
  /// **'Icon style'**
  String get iconStyle;

  /// No description provided for @onlyIcon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get onlyIcon;

  /// No description provided for @noIcon.
  ///
  /// In en, this message translates to:
  /// **'None'**
  String get noIcon;

  /// No description provided for @stackMode.
  ///
  /// In en, this message translates to:
  /// **'Stack mode'**
  String get stackMode;

  /// No description provided for @network.
  ///
  /// In en, this message translates to:
  /// **'Network'**
  String get network;

  /// No description provided for @networkDesc.
  ///
  /// In en, this message translates to:
  /// **'Modify network-related settings'**
  String get networkDesc;

  /// No description provided for @bypassDomain.
  ///
  /// In en, this message translates to:
  /// **'Bypass domain'**
  String get bypassDomain;

  /// No description provided for @bypassDomainDesc.
  ///
  /// In en, this message translates to:
  /// **'Only takes effect when the system proxy is enabled'**
  String get bypassDomainDesc;

  /// No description provided for @resetTip.
  ///
  /// In en, this message translates to:
  /// **'Make sure to reset'**
  String get resetTip;

  /// No description provided for @regExp.
  ///
  /// In en, this message translates to:
  /// **'RegExp'**
  String get regExp;

  /// No description provided for @icon.
  ///
  /// In en, this message translates to:
  /// **'Icon'**
  String get icon;

  /// No description provided for @iconConfiguration.
  ///
  /// In en, this message translates to:
  /// **'Icon configuration'**
  String get iconConfiguration;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data'**
  String get noData;

  /// No description provided for @adminAutoLaunch.
  ///
  /// In en, this message translates to:
  /// **'Admin auto launch'**
  String get adminAutoLaunch;

  /// No description provided for @adminAutoLaunchDesc.
  ///
  /// In en, this message translates to:
  /// **'Boot up by using admin mode'**
  String get adminAutoLaunchDesc;

  /// No description provided for @fontFamily.
  ///
  /// In en, this message translates to:
  /// **'FontFamily'**
  String get fontFamily;

  /// No description provided for @systemFont.
  ///
  /// In en, this message translates to:
  /// **'System font'**
  String get systemFont;

  /// No description provided for @toggle.
  ///
  /// In en, this message translates to:
  /// **'Toggle'**
  String get toggle;

  /// No description provided for @system.
  ///
  /// In en, this message translates to:
  /// **'System'**
  String get system;

  /// No description provided for @routeMode.
  ///
  /// In en, this message translates to:
  /// **'Route mode'**
  String get routeMode;

  /// No description provided for @routeMode_bypassPrivate.
  ///
  /// In en, this message translates to:
  /// **'Bypass private route address'**
  String get routeMode_bypassPrivate;

  /// No description provided for @routeMode_config.
  ///
  /// In en, this message translates to:
  /// **'Use config'**
  String get routeMode_config;

  /// No description provided for @routeAddress.
  ///
  /// In en, this message translates to:
  /// **'Route address'**
  String get routeAddress;

  /// No description provided for @routeAddressDesc.
  ///
  /// In en, this message translates to:
  /// **'Config listen route address'**
  String get routeAddressDesc;

  /// No description provided for @pleaseInputAdminPassword.
  ///
  /// In en, this message translates to:
  /// **'Please enter the admin password'**
  String get pleaseInputAdminPassword;

  /// No description provided for @copyEnvVar.
  ///
  /// In en, this message translates to:
  /// **'Copying environment variables'**
  String get copyEnvVar;

  /// No description provided for @memoryInfo.
  ///
  /// In en, this message translates to:
  /// **'Memory info'**
  String get memoryInfo;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @fileIsUpdate.
  ///
  /// In en, this message translates to:
  /// **'The file has been modified. Do you want to save the changes?'**
  String get fileIsUpdate;

  /// No description provided for @profileHasUpdate.
  ///
  /// In en, this message translates to:
  /// **'The profile has been modified. Do you want to disable auto update?'**
  String get profileHasUpdate;

  /// No description provided for @hasCacheChange.
  ///
  /// In en, this message translates to:
  /// **'Do you want to cache the changes?'**
  String get hasCacheChange;

  /// No description provided for @copySuccess.
  ///
  /// In en, this message translates to:
  /// **'Copy success'**
  String get copySuccess;

  /// No description provided for @copyLink.
  ///
  /// In en, this message translates to:
  /// **'Copy link'**
  String get copyLink;

  /// No description provided for @exportFile.
  ///
  /// In en, this message translates to:
  /// **'Export file'**
  String get exportFile;

  /// No description provided for @cacheCorrupt.
  ///
  /// In en, this message translates to:
  /// **'The cache is corrupt. Do you want to clear it?'**
  String get cacheCorrupt;

  /// No description provided for @detectionTip.
  ///
  /// In en, this message translates to:
  /// **'Relying on third-party api is for reference only'**
  String get detectionTip;

  /// No description provided for @listen.
  ///
  /// In en, this message translates to:
  /// **'Listen'**
  String get listen;

  /// No description provided for @undo.
  ///
  /// In en, this message translates to:
  /// **'undo'**
  String get undo;

  /// No description provided for @redo.
  ///
  /// In en, this message translates to:
  /// **'redo'**
  String get redo;

  /// No description provided for @none.
  ///
  /// In en, this message translates to:
  /// **'none'**
  String get none;

  /// No description provided for @basicConfig.
  ///
  /// In en, this message translates to:
  /// **'Basic configuration'**
  String get basicConfig;

  /// No description provided for @basicConfigDesc.
  ///
  /// In en, this message translates to:
  /// **'Modify the basic configuration globally'**
  String get basicConfigDesc;

  /// No description provided for @selectedCountTitle.
  ///
  /// In en, this message translates to:
  /// **'{count} items have been selected'**
  String selectedCountTitle(Object count);

  /// No description provided for @addRule.
  ///
  /// In en, this message translates to:
  /// **'Add rule'**
  String get addRule;

  /// No description provided for @ruleName.
  ///
  /// In en, this message translates to:
  /// **'Rule name'**
  String get ruleName;

  /// No description provided for @content.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get content;

  /// No description provided for @subRule.
  ///
  /// In en, this message translates to:
  /// **'Sub rule'**
  String get subRule;

  /// No description provided for @ruleTarget.
  ///
  /// In en, this message translates to:
  /// **'Rule target'**
  String get ruleTarget;

  /// No description provided for @sourceIp.
  ///
  /// In en, this message translates to:
  /// **'Source IP'**
  String get sourceIp;

  /// No description provided for @noResolve.
  ///
  /// In en, this message translates to:
  /// **'No resolve IP'**
  String get noResolve;

  /// No description provided for @getOriginRules.
  ///
  /// In en, this message translates to:
  /// **'Get original rules'**
  String get getOriginRules;

  /// No description provided for @overrideOriginRules.
  ///
  /// In en, this message translates to:
  /// **'Override the original rule'**
  String get overrideOriginRules;

  /// No description provided for @addedOriginRules.
  ///
  /// In en, this message translates to:
  /// **'Attach on the original rules'**
  String get addedOriginRules;

  /// No description provided for @enableOverride.
  ///
  /// In en, this message translates to:
  /// **'Enable override'**
  String get enableOverride;

  /// No description provided for @saveChanges.
  ///
  /// In en, this message translates to:
  /// **'Do you want to save the changes?'**
  String get saveChanges;

  /// No description provided for @generalDesc.
  ///
  /// In en, this message translates to:
  /// **'Modify general settings'**
  String get generalDesc;

  /// No description provided for @findProcessModeDesc.
  ///
  /// In en, this message translates to:
  /// **'There is a certain performance loss after opening'**
  String get findProcessModeDesc;

  /// No description provided for @tabAnimationDesc.
  ///
  /// In en, this message translates to:
  /// **'Effective only in mobile view'**
  String get tabAnimationDesc;

  /// No description provided for @saveTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to save?'**
  String get saveTip;

  /// No description provided for @colorSchemes.
  ///
  /// In en, this message translates to:
  /// **'Color schemes'**
  String get colorSchemes;

  /// No description provided for @palette.
  ///
  /// In en, this message translates to:
  /// **'Palette'**
  String get palette;

  /// No description provided for @tonalSpotScheme.
  ///
  /// In en, this message translates to:
  /// **'TonalSpot'**
  String get tonalSpotScheme;

  /// No description provided for @fidelityScheme.
  ///
  /// In en, this message translates to:
  /// **'Fidelity'**
  String get fidelityScheme;

  /// No description provided for @monochromeScheme.
  ///
  /// In en, this message translates to:
  /// **'Monochrome'**
  String get monochromeScheme;

  /// No description provided for @neutralScheme.
  ///
  /// In en, this message translates to:
  /// **'Neutral'**
  String get neutralScheme;

  /// No description provided for @vibrantScheme.
  ///
  /// In en, this message translates to:
  /// **'Vibrant'**
  String get vibrantScheme;

  /// No description provided for @expressiveScheme.
  ///
  /// In en, this message translates to:
  /// **'Expressive'**
  String get expressiveScheme;

  /// No description provided for @contentScheme.
  ///
  /// In en, this message translates to:
  /// **'Content'**
  String get contentScheme;

  /// No description provided for @rainbowScheme.
  ///
  /// In en, this message translates to:
  /// **'Rainbow'**
  String get rainbowScheme;

  /// No description provided for @fruitSaladScheme.
  ///
  /// In en, this message translates to:
  /// **'FruitSalad'**
  String get fruitSaladScheme;

  /// No description provided for @developerMode.
  ///
  /// In en, this message translates to:
  /// **'Developer mode'**
  String get developerMode;

  /// No description provided for @developerModeEnableTip.
  ///
  /// In en, this message translates to:
  /// **'Developer mode is enabled.'**
  String get developerModeEnableTip;

  /// No description provided for @messageTest.
  ///
  /// In en, this message translates to:
  /// **'Message test'**
  String get messageTest;

  /// No description provided for @messageTestTip.
  ///
  /// In en, this message translates to:
  /// **'This is a message.'**
  String get messageTestTip;

  /// No description provided for @crashTest.
  ///
  /// In en, this message translates to:
  /// **'Crash test'**
  String get crashTest;

  /// No description provided for @clearData.
  ///
  /// In en, this message translates to:
  /// **'Clear Data'**
  String get clearData;

  /// No description provided for @textScale.
  ///
  /// In en, this message translates to:
  /// **'Text Scaling'**
  String get textScale;

  /// No description provided for @internet.
  ///
  /// In en, this message translates to:
  /// **'Internet'**
  String get internet;

  /// No description provided for @systemApp.
  ///
  /// In en, this message translates to:
  /// **'System APP'**
  String get systemApp;

  /// No description provided for @noNetworkApp.
  ///
  /// In en, this message translates to:
  /// **'No network APP'**
  String get noNetworkApp;

  /// No description provided for @contactMe.
  ///
  /// In en, this message translates to:
  /// **'Contact me'**
  String get contactMe;

  /// No description provided for @recoveryStrategy.
  ///
  /// In en, this message translates to:
  /// **'Recovery strategy'**
  String get recoveryStrategy;

  /// No description provided for @recoveryStrategy_override.
  ///
  /// In en, this message translates to:
  /// **'Override'**
  String get recoveryStrategy_override;

  /// No description provided for @recoveryStrategy_compatible.
  ///
  /// In en, this message translates to:
  /// **'Compatible'**
  String get recoveryStrategy_compatible;

  /// No description provided for @logsTest.
  ///
  /// In en, this message translates to:
  /// **'Logs test'**
  String get logsTest;

  /// No description provided for @emptyTip.
  ///
  /// In en, this message translates to:
  /// **'{label} cannot be empty'**
  String emptyTip(Object label);

  /// No description provided for @urlTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be a url'**
  String urlTip(Object label);

  /// No description provided for @numberTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be a number'**
  String numberTip(Object label);

  /// No description provided for @interval.
  ///
  /// In en, this message translates to:
  /// **'Interval'**
  String get interval;

  /// No description provided for @existsTip.
  ///
  /// In en, this message translates to:
  /// **'Current {label} already exists'**
  String existsTip(Object label);

  /// No description provided for @deleteTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the current {label}?'**
  String deleteTip(Object label);

  /// No description provided for @deleteMultipTip.
  ///
  /// In en, this message translates to:
  /// **'Are you sure you want to delete the selected {label}?'**
  String deleteMultipTip(Object label);

  /// No description provided for @nullTip.
  ///
  /// In en, this message translates to:
  /// **'No {label} at the moment'**
  String nullTip(Object label);

  /// No description provided for @script.
  ///
  /// In en, this message translates to:
  /// **'Script'**
  String get script;

  /// No description provided for @color.
  ///
  /// In en, this message translates to:
  /// **'Color'**
  String get color;

  /// No description provided for @rename.
  ///
  /// In en, this message translates to:
  /// **'Rename'**
  String get rename;

  /// No description provided for @unnamed.
  ///
  /// In en, this message translates to:
  /// **'Unnamed'**
  String get unnamed;

  /// No description provided for @pleaseEnterScriptName.
  ///
  /// In en, this message translates to:
  /// **'Please enter a script name'**
  String get pleaseEnterScriptName;

  /// No description provided for @overrideInvalidTip.
  ///
  /// In en, this message translates to:
  /// **'Does not take effect in script mode'**
  String get overrideInvalidTip;

  /// No description provided for @mixedPort.
  ///
  /// In en, this message translates to:
  /// **'Mixed Port'**
  String get mixedPort;

  /// No description provided for @socksPort.
  ///
  /// In en, this message translates to:
  /// **'Socks Port'**
  String get socksPort;

  /// No description provided for @redirPort.
  ///
  /// In en, this message translates to:
  /// **'Redir Port'**
  String get redirPort;

  /// No description provided for @tproxyPort.
  ///
  /// In en, this message translates to:
  /// **'Tproxy Port'**
  String get tproxyPort;

  /// No description provided for @portTip.
  ///
  /// In en, this message translates to:
  /// **'{label} must be between 1024 and 49151'**
  String portTip(Object label);

  /// No description provided for @portConflictTip.
  ///
  /// In en, this message translates to:
  /// **'Please enter a different port'**
  String get portConflictTip;

  /// No description provided for @import.
  ///
  /// In en, this message translates to:
  /// **'Import'**
  String get import;

  /// No description provided for @importFile.
  ///
  /// In en, this message translates to:
  /// **'Import from file'**
  String get importFile;

  /// No description provided for @importUrl.
  ///
  /// In en, this message translates to:
  /// **'Import from URL'**
  String get importUrl;

  /// No description provided for @autoSetSystemDns.
  ///
  /// In en, this message translates to:
  /// **'Auto set system DNS'**
  String get autoSetSystemDns;

  /// No description provided for @details.
  ///
  /// In en, this message translates to:
  /// **'{label} details'**
  String details(Object label);

  /// No description provided for @creationTime.
  ///
  /// In en, this message translates to:
  /// **'Creation time'**
  String get creationTime;

  /// No description provided for @progress.
  ///
  /// In en, this message translates to:
  /// **'Progress'**
  String get progress;

  /// No description provided for @host.
  ///
  /// In en, this message translates to:
  /// **'Host'**
  String get host;

  /// No description provided for @destination.
  ///
  /// In en, this message translates to:
  /// **'Destination'**
  String get destination;

  /// No description provided for @destinationGeoIP.
  ///
  /// In en, this message translates to:
  /// **'Destination GeoIP'**
  String get destinationGeoIP;

  /// No description provided for @destinationIPASN.
  ///
  /// In en, this message translates to:
  /// **'Destination IPASN'**
  String get destinationIPASN;

  /// No description provided for @specialProxy.
  ///
  /// In en, this message translates to:
  /// **'Special proxy'**
  String get specialProxy;

  /// No description provided for @specialRules.
  ///
  /// In en, this message translates to:
  /// **'special rules'**
  String get specialRules;

  /// No description provided for @remoteDestination.
  ///
  /// In en, this message translates to:
  /// **'Remote destination'**
  String get remoteDestination;

  /// No description provided for @networkType.
  ///
  /// In en, this message translates to:
  /// **'Network type'**
  String get networkType;

  /// No description provided for @proxyChains.
  ///
  /// In en, this message translates to:
  /// **'Proxy chains'**
  String get proxyChains;

  /// No description provided for @log.
  ///
  /// In en, this message translates to:
  /// **'Log'**
  String get log;

  /// No description provided for @connection.
  ///
  /// In en, this message translates to:
  /// **'Connection'**
  String get connection;

  /// No description provided for @request.
  ///
  /// In en, this message translates to:
  /// **'Request'**
  String get request;
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
      <String>['en', 'ja', 'ru', 'zh'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when language+country codes are specified.
  switch (locale.languageCode) {
    case 'zh':
      {
        switch (locale.countryCode) {
          case 'CN':
            return AppLocalizationsZhCn();
        }
        break;
      }
  }

  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'ja':
      return AppLocalizationsJa();
    case 'ru':
      return AppLocalizationsRu();
    case 'zh':
      return AppLocalizationsZh();
  }

  throw FlutterError(
      'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
      'an issue with the localizations generation tool. Please file an issue '
      'on GitHub with a reproducible sample app and the gen-l10n configuration '
      'that was used.');
}
