// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'en';

  static String m0(label) =>
      "Are you sure you want to delete the selected ${label}?";

  static String m1(label) =>
      "Are you sure you want to delete the current ${label}?";

  static String m2(label) => "${label} details";

  static String m3(label) => "${label} cannot be empty";

  static String m4(label) => "Current ${label} already exists";

  static String m5(label) => "No ${label} at the moment";

  static String m6(label) => "${label} must be a number";

  static String m7(label) => "${label} must be between 1024 and 49151";

  static String m8(count) => "${count} items have been selected";

  static String m9(label) => "${label} must be a url";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("About"),
    "accessControl": MessageLookupByLibrary.simpleMessage("AccessControl"),
    "accessControlAllowDesc": MessageLookupByLibrary.simpleMessage(
      "Only allow selected app to enter VPN",
    ),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage(
      "Configure application access proxy",
    ),
    "accessControlNotAllowDesc": MessageLookupByLibrary.simpleMessage(
      "The selected application will be excluded from VPN",
    ),
    "account": MessageLookupByLibrary.simpleMessage("Account"),
    "action": MessageLookupByLibrary.simpleMessage("Action"),
    "action_mode": MessageLookupByLibrary.simpleMessage("Switch mode"),
    "action_proxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "action_start": MessageLookupByLibrary.simpleMessage("Start/Stop"),
    "action_tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "action_view": MessageLookupByLibrary.simpleMessage("Show/Hide"),
    "add": MessageLookupByLibrary.simpleMessage("Add"),
    "addRule": MessageLookupByLibrary.simpleMessage("Add rule"),
    "addedOriginRules": MessageLookupByLibrary.simpleMessage(
      "Attach on the original rules",
    ),
    "address": MessageLookupByLibrary.simpleMessage("Address"),
    "addressHelp": MessageLookupByLibrary.simpleMessage(
      "WebDAV server address",
    ),
    "addressTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a valid WebDAV address",
    ),
    "adminAutoLaunch": MessageLookupByLibrary.simpleMessage(
      "Admin auto launch",
    ),
    "adminAutoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Boot up by using admin mode",
    ),
    "ago": MessageLookupByLibrary.simpleMessage(" Ago"),
    "agree": MessageLookupByLibrary.simpleMessage("Agree"),
    "allApps": MessageLookupByLibrary.simpleMessage("All apps"),
    "allowBypass": MessageLookupByLibrary.simpleMessage(
      "Allow applications to bypass VPN",
    ),
    "allowBypassDesc": MessageLookupByLibrary.simpleMessage(
      "Some apps can bypass VPN when turned on",
    ),
    "allowLan": MessageLookupByLibrary.simpleMessage("AllowLan"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage(
      "Allow access proxy through the LAN",
    ),
    "amount": MessageLookupByLibrary.simpleMessage("Amount"),
    "app": MessageLookupByLibrary.simpleMessage("App"),
    "appAccessControl": MessageLookupByLibrary.simpleMessage(
      "App access control",
    ),
    "appDesc": MessageLookupByLibrary.simpleMessage(
      "Processing app related settings",
    ),
    "appendSystemDns": MessageLookupByLibrary.simpleMessage(
      "Append System DNS",
    ),
    "appendSystemDnsTip": MessageLookupByLibrary.simpleMessage(
      "Forcefully append system DNS to the configuration",
    ),
    "application": MessageLookupByLibrary.simpleMessage("Application"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage(
      "Modify application related settings",
    ),
    "auto": MessageLookupByLibrary.simpleMessage("Auto"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage(
      "Auto check updates",
    ),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage(
      "Auto check for updates when the app starts",
    ),
    "autoCloseConnections": MessageLookupByLibrary.simpleMessage(
      "Auto close connections",
    ),
    "autoCloseConnectionsDesc": MessageLookupByLibrary.simpleMessage(
      "Auto close connections after change node",
    ),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("Auto launch"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Follow the system self startup",
    ),
    "autoRun": MessageLookupByLibrary.simpleMessage("AutoRun"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage(
      "Auto run when the application is opened",
    ),
    "autoSetSystemDns": MessageLookupByLibrary.simpleMessage(
      "Auto set system DNS",
    ),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("Auto update"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage(
      "Auto update interval (minutes)",
    ),
    "backup": MessageLookupByLibrary.simpleMessage("Backup"),
    "backupAndRecovery": MessageLookupByLibrary.simpleMessage(
      "Backup and Recovery",
    ),
    "backupAndRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Sync data via WebDAV or file",
    ),
    "backupSuccess": MessageLookupByLibrary.simpleMessage("Backup success"),
    "balance": MessageLookupByLibrary.simpleMessage("Balance"),
    "basicConfig": MessageLookupByLibrary.simpleMessage("Basic configuration"),
    "basicConfigDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the basic configuration globally",
    ),
    "bind": MessageLookupByLibrary.simpleMessage("Bind"),
    "blacklistMode": MessageLookupByLibrary.simpleMessage("Blacklist mode"),
    "bypassDomain": MessageLookupByLibrary.simpleMessage("Bypass domain"),
    "bypassDomainDesc": MessageLookupByLibrary.simpleMessage(
      "Only takes effect when the system proxy is enabled",
    ),
    "cacheCorrupt": MessageLookupByLibrary.simpleMessage(
      "The cache is corrupt. Do you want to clear it?",
    ),
    "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
    "cancelFilterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Cancel filter system app",
    ),
    "cancelOrder": MessageLookupByLibrary.simpleMessage("Cancel Order"),
    "cancelSelectAll": MessageLookupByLibrary.simpleMessage(
      "Cancel select all",
    ),
    "cancelled": MessageLookupByLibrary.simpleMessage("Cancelled"),
    "changePassword": MessageLookupByLibrary.simpleMessage("Change Password"),
    "checkError": MessageLookupByLibrary.simpleMessage("Check error"),
    "checkUpdate": MessageLookupByLibrary.simpleMessage("Check for updates"),
    "checkUpdateError": MessageLookupByLibrary.simpleMessage(
      "The current application is already the latest version",
    ),
    "checking": MessageLookupByLibrary.simpleMessage("Checking..."),
    "checkoutFailed": MessageLookupByLibrary.simpleMessage("Checkout failed"),
    "clearData": MessageLookupByLibrary.simpleMessage("Clear Data"),
    "clipboardExport": MessageLookupByLibrary.simpleMessage("Export clipboard"),
    "clipboardImport": MessageLookupByLibrary.simpleMessage("Clipboard import"),
    "color": MessageLookupByLibrary.simpleMessage("Color"),
    "colorSchemes": MessageLookupByLibrary.simpleMessage("Color schemes"),
    "columns": MessageLookupByLibrary.simpleMessage("Columns"),
    "commissionBalance": MessageLookupByLibrary.simpleMessage(
      "Commission Balance",
    ),
    "commissionRate": MessageLookupByLibrary.simpleMessage("Commission Rate"),
    "compatible": MessageLookupByLibrary.simpleMessage("Compatibility mode"),
    "compatibleDesc": MessageLookupByLibrary.simpleMessage(
      "Opening it will lose part of its application ability and gain the support of full amount of Clash.",
    ),
    "completed": MessageLookupByLibrary.simpleMessage("Completed"),
    "confirm": MessageLookupByLibrary.simpleMessage("Confirm"),
    "connected": MessageLookupByLibrary.simpleMessage("Connected"),
    "connecting": MessageLookupByLibrary.simpleMessage("Connecting..."),
    "connection": MessageLookupByLibrary.simpleMessage("Connection"),
    "connections": MessageLookupByLibrary.simpleMessage("Connections"),
    "connectionsDesc": MessageLookupByLibrary.simpleMessage(
      "View current connections data",
    ),
    "connectivity": MessageLookupByLibrary.simpleMessage("Connectivity："),
    "contactMe": MessageLookupByLibrary.simpleMessage("Contact me"),
    "content": MessageLookupByLibrary.simpleMessage("Content"),
    "contentScheme": MessageLookupByLibrary.simpleMessage("Content"),
    "copy": MessageLookupByLibrary.simpleMessage("Copy"),
    "copyEnvVar": MessageLookupByLibrary.simpleMessage(
      "Copying environment variables",
    ),
    "copyLink": MessageLookupByLibrary.simpleMessage("Copy link"),
    "copySuccess": MessageLookupByLibrary.simpleMessage("Copy success"),
    "core": MessageLookupByLibrary.simpleMessage("Core"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("Core info"),
    "coreStatus": MessageLookupByLibrary.simpleMessage("Core status"),
    "country": MessageLookupByLibrary.simpleMessage("Country"),
    "crashTest": MessageLookupByLibrary.simpleMessage("Crash test"),
    "crashlytics": MessageLookupByLibrary.simpleMessage("Crash Analysis"),
    "crashlyticsTip": MessageLookupByLibrary.simpleMessage(
      "When enabled, automatically uploads crash logs without sensitive information when the app crashes",
    ),
    "create": MessageLookupByLibrary.simpleMessage("Create"),
    "creationTime": MessageLookupByLibrary.simpleMessage("Creation time"),
    "customAmount": MessageLookupByLibrary.simpleMessage("Custom Amount"),
    "cut": MessageLookupByLibrary.simpleMessage("Cut"),
    "dark": MessageLookupByLibrary.simpleMessage("Dark"),
    "dashboard": MessageLookupByLibrary.simpleMessage("Dashboard"),
    "dataCollectionContent": MessageLookupByLibrary.simpleMessage(
      "This app uses Firebase Crashlytics to collect crash information to improve app stability.\\nThe collected data includes device information and crash details, but does not contain personal sensitive data.\\nYou can disable this feature in settings.",
    ),
    "dataCollectionTip": MessageLookupByLibrary.simpleMessage(
      "Data Collection Notice",
    ),
    "days": MessageLookupByLibrary.simpleMessage("Days"),
    "defaultNameserver": MessageLookupByLibrary.simpleMessage(
      "Default nameserver",
    ),
    "defaultNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving DNS server",
    ),
    "defaultSort": MessageLookupByLibrary.simpleMessage("Sort by default"),
    "defaultText": MessageLookupByLibrary.simpleMessage("Default"),
    "delay": MessageLookupByLibrary.simpleMessage("Delay"),
    "delaySort": MessageLookupByLibrary.simpleMessage("Sort by delay"),
    "delete": MessageLookupByLibrary.simpleMessage("Delete"),
    "deleteMultipTip": m0,
    "deleteTip": m1,
    "deposit": MessageLookupByLibrary.simpleMessage("Deposit"),
    "desc": MessageLookupByLibrary.simpleMessage(
      "A multi-platform proxy client based on ClashMeta, simple and easy to use, open-source and ad-free.",
    ),
    "destination": MessageLookupByLibrary.simpleMessage("Destination"),
    "destinationGeoIP": MessageLookupByLibrary.simpleMessage(
      "Destination GeoIP",
    ),
    "destinationIPASN": MessageLookupByLibrary.simpleMessage(
      "Destination IPASN",
    ),
    "details": m2,
    "detectionTip": MessageLookupByLibrary.simpleMessage(
      "Relying on third-party api is for reference only",
    ),
    "developerMode": MessageLookupByLibrary.simpleMessage("Developer mode"),
    "developerModeEnableTip": MessageLookupByLibrary.simpleMessage(
      "Developer mode is enabled.",
    ),
    "direct": MessageLookupByLibrary.simpleMessage("Direct"),
    "disclaimer": MessageLookupByLibrary.simpleMessage("Disclaimer"),
    "disclaimerDesc": MessageLookupByLibrary.simpleMessage(
      "This software is only used for non-commercial purposes such as learning exchanges and scientific research. It is strictly prohibited to use this software for commercial purposes. Any commercial activity, if any, has nothing to do with this software.",
    ),
    "disconnected": MessageLookupByLibrary.simpleMessage("Disconnected"),
    "discoverNewVersion": MessageLookupByLibrary.simpleMessage(
      "Discover the new version",
    ),
    "discovery": MessageLookupByLibrary.simpleMessage(
      "Discovery a new version",
    ),
    "dnsDesc": MessageLookupByLibrary.simpleMessage(
      "Update DNS related settings",
    ),
    "dnsHijacking": MessageLookupByLibrary.simpleMessage("DNS Hijacking"),
    "dnsMode": MessageLookupByLibrary.simpleMessage("DNS mode"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage(
      "Do you want to pass",
    ),
    "domain": MessageLookupByLibrary.simpleMessage("Domain"),
    "download": MessageLookupByLibrary.simpleMessage("Download"),
    "edit": MessageLookupByLibrary.simpleMessage("Edit"),
    "email": MessageLookupByLibrary.simpleMessage("Email"),
    "emptyTip": m3,
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "enableOverride": MessageLookupByLibrary.simpleMessage("Enable override"),
    "enterEmail": MessageLookupByLibrary.simpleMessage("Please enter email"),
    "enterPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter password",
    ),
    "enterUrl": MessageLookupByLibrary.simpleMessage("Please enter URL"),
    "entries": MessageLookupByLibrary.simpleMessage(" entries"),
    "error": MessageLookupByLibrary.simpleMessage("Error"),
    "exclude": MessageLookupByLibrary.simpleMessage("Hidden from recent tasks"),
    "excludeDesc": MessageLookupByLibrary.simpleMessage(
      "When the app is in the background, the app is hidden from the recent task",
    ),
    "existsTip": m4,
    "exit": MessageLookupByLibrary.simpleMessage("Exit"),
    "expand": MessageLookupByLibrary.simpleMessage("Standard"),
    "expirationTime": MessageLookupByLibrary.simpleMessage("Expiration time"),
    "expireDate": MessageLookupByLibrary.simpleMessage("Expire Date"),
    "exportFile": MessageLookupByLibrary.simpleMessage("Export file"),
    "exportLogs": MessageLookupByLibrary.simpleMessage("Export logs"),
    "exportSuccess": MessageLookupByLibrary.simpleMessage("Export success"),
    "expressiveScheme": MessageLookupByLibrary.simpleMessage("Expressive"),
    "externalController": MessageLookupByLibrary.simpleMessage(
      "ExternalController",
    ),
    "externalControllerDesc": MessageLookupByLibrary.simpleMessage(
      "Once enabled, the Clash kernel can be controlled on port 9090",
    ),
    "externalLink": MessageLookupByLibrary.simpleMessage("External link"),
    "externalResources": MessageLookupByLibrary.simpleMessage(
      "External resources",
    ),
    "failedToGenerateInviteCode": MessageLookupByLibrary.simpleMessage(
      "Failed to generate invite code",
    ),
    "fakeipFilter": MessageLookupByLibrary.simpleMessage("Fakeip filter"),
    "fakeipRange": MessageLookupByLibrary.simpleMessage("Fakeip range"),
    "fallback": MessageLookupByLibrary.simpleMessage("Fallback"),
    "fallbackDesc": MessageLookupByLibrary.simpleMessage(
      "Generally use offshore DNS",
    ),
    "fallbackFilter": MessageLookupByLibrary.simpleMessage("Fallback filter"),
    "fidelityScheme": MessageLookupByLibrary.simpleMessage("Fidelity"),
    "file": MessageLookupByLibrary.simpleMessage("File"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("Directly upload profile"),
    "fileIsUpdate": MessageLookupByLibrary.simpleMessage(
      "The file has been modified. Do you want to save the changes?",
    ),
    "filterSystemApp": MessageLookupByLibrary.simpleMessage(
      "Filter system app",
    ),
    "findProcessMode": MessageLookupByLibrary.simpleMessage("Find process"),
    "findProcessModeDesc": MessageLookupByLibrary.simpleMessage(
      "There is a certain performance loss after opening",
    ),
    "fontFamily": MessageLookupByLibrary.simpleMessage("FontFamily"),
    "forceRestartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to force restart the core?",
    ),
    "fourColumns": MessageLookupByLibrary.simpleMessage("Four columns"),
    "fruitSaladScheme": MessageLookupByLibrary.simpleMessage("FruitSalad"),
    "general": MessageLookupByLibrary.simpleMessage("General"),
    "generalDesc": MessageLookupByLibrary.simpleMessage(
      "Modify general settings",
    ),
    "generateInviteCode": MessageLookupByLibrary.simpleMessage(
      "Generate Invite Code",
    ),
    "geoData": MessageLookupByLibrary.simpleMessage("GeoData"),
    "geodataLoader": MessageLookupByLibrary.simpleMessage(
      "Geo Low Memory Mode",
    ),
    "geodataLoaderDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling will use the Geo low memory loader",
    ),
    "geoipCode": MessageLookupByLibrary.simpleMessage("Geoip code"),
    "getOriginRules": MessageLookupByLibrary.simpleMessage(
      "Get original rules",
    ),
    "global": MessageLookupByLibrary.simpleMessage("Global"),
    "go": MessageLookupByLibrary.simpleMessage("Go"),
    "goDownload": MessageLookupByLibrary.simpleMessage("Go to download"),
    "hasCacheChange": MessageLookupByLibrary.simpleMessage(
      "Do you want to cache the changes?",
    ),
    "host": MessageLookupByLibrary.simpleMessage("Host"),
    "hostsDesc": MessageLookupByLibrary.simpleMessage("Add Hosts"),
    "hotkeyConflict": MessageLookupByLibrary.simpleMessage("Hotkey conflict"),
    "hotkeyManagement": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hotkeyManagementDesc": MessageLookupByLibrary.simpleMessage(
      "Hotkey Management",
    ),
    "hours": MessageLookupByLibrary.simpleMessage("Hours"),
    "icon": MessageLookupByLibrary.simpleMessage("Icon"),
    "iconConfiguration": MessageLookupByLibrary.simpleMessage(
      "Icon configuration",
    ),
    "iconStyle": MessageLookupByLibrary.simpleMessage("Icon Style"),
    "import": MessageLookupByLibrary.simpleMessage("Import"),
    "importFile": MessageLookupByLibrary.simpleMessage("Import from file"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "importUrl": MessageLookupByLibrary.simpleMessage("Import from URL"),
    "infiniteTime": MessageLookupByLibrary.simpleMessage("Long term effective"),
    "init": MessageLookupByLibrary.simpleMessage("Init"),
    "inputCorrectHotkey": MessageLookupByLibrary.simpleMessage(
      "Please input correct hotkey",
    ),
    "intelligentSelected": MessageLookupByLibrary.simpleMessage(
      "Intelligent selection",
    ),
    "internet": MessageLookupByLibrary.simpleMessage("Internet"),
    "interval": MessageLookupByLibrary.simpleMessage("Interval"),
    "intranetIP": MessageLookupByLibrary.simpleMessage("Intranet IP"),
    "invalidUrl": MessageLookupByLibrary.simpleMessage("Invalid URL"),
    "inviteCodeGenerated": MessageLookupByLibrary.simpleMessage(
      "Invite code generated",
    ),
    "inviteManagement": MessageLookupByLibrary.simpleMessage(
      "Invite Management",
    ),
    "ipcidr": MessageLookupByLibrary.simpleMessage("Ipcidr"),
    "ipv6Desc": MessageLookupByLibrary.simpleMessage(
      "When turned on it will be able to receive IPv6 traffic",
    ),
    "ipv6InboundDesc": MessageLookupByLibrary.simpleMessage(
      "When enabled, it will be able to receive IPv6 inbound traffic",
    ),
    "ja": MessageLookupByLibrary.simpleMessage("Japanese"),
    "just": MessageLookupByLibrary.simpleMessage("Just"),
    "keepAliveIntervalDesc": MessageLookupByLibrary.simpleMessage(
      "Tcp keep alive interval",
    ),
    "key": MessageLookupByLibrary.simpleMessage("Key"),
    "language": MessageLookupByLibrary.simpleMessage("Language"),
    "layout": MessageLookupByLibrary.simpleMessage("Layout"),
    "light": MessageLookupByLibrary.simpleMessage("Light"),
    "list": MessageLookupByLibrary.simpleMessage("List"),
    "listen": MessageLookupByLibrary.simpleMessage("Listen"),
    "loadConfig": MessageLookupByLibrary.simpleMessage("Load Config"),
    "loading": MessageLookupByLibrary.simpleMessage("Loading..."),
    "local": MessageLookupByLibrary.simpleMessage("Local"),
    "localBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to local",
    ),
    "localRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Recovery data from file",
    ),
    "log": MessageLookupByLibrary.simpleMessage("Log"),
    "logLevel": MessageLookupByLibrary.simpleMessage("LogLevel"),
    "logcat": MessageLookupByLibrary.simpleMessage("Logcat"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage(
      "Disabling will hide the log entry",
    ),
    "loginAndImport": MessageLookupByLibrary.simpleMessage("Login & Import"),
    "loginFailed": MessageLookupByLibrary.simpleMessage(
      "Login failed or no subscription found",
    ),
    "loginToV2Board": MessageLookupByLibrary.simpleMessage("Login to V2Board"),
    "logs": MessageLookupByLibrary.simpleMessage("Logs"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("Log capture records"),
    "logsTest": MessageLookupByLibrary.simpleMessage("Logs test"),
    "loopback": MessageLookupByLibrary.simpleMessage("Loopback unlock tool"),
    "loopbackDesc": MessageLookupByLibrary.simpleMessage(
      "Used for UWP loopback unlocking",
    ),
    "loose": MessageLookupByLibrary.simpleMessage("Loose"),
    "memoryInfo": MessageLookupByLibrary.simpleMessage("Memory info"),
    "messageTest": MessageLookupByLibrary.simpleMessage("Message test"),
    "messageTestTip": MessageLookupByLibrary.simpleMessage(
      "This is a message.",
    ),
    "min": MessageLookupByLibrary.simpleMessage("Min"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("Minimize on exit"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage(
      "Modify the default system exit event",
    ),
    "minutes": MessageLookupByLibrary.simpleMessage("Minutes"),
    "mixedPort": MessageLookupByLibrary.simpleMessage("Mixed Port"),
    "mode": MessageLookupByLibrary.simpleMessage("Mode"),
    "monochromeScheme": MessageLookupByLibrary.simpleMessage("Monochrome"),
    "months": MessageLookupByLibrary.simpleMessage("Months"),
    "more": MessageLookupByLibrary.simpleMessage("More"),
    "myCodes": MessageLookupByLibrary.simpleMessage("My Codes"),
    "myOrders": MessageLookupByLibrary.simpleMessage("My Orders"),
    "name": MessageLookupByLibrary.simpleMessage("Name"),
    "nameSort": MessageLookupByLibrary.simpleMessage("Sort by name"),
    "nameserver": MessageLookupByLibrary.simpleMessage("Nameserver"),
    "nameserverDesc": MessageLookupByLibrary.simpleMessage(
      "For resolving domain",
    ),
    "nameserverPolicy": MessageLookupByLibrary.simpleMessage(
      "Nameserver policy",
    ),
    "nameserverPolicyDesc": MessageLookupByLibrary.simpleMessage(
      "Specify the corresponding nameserver policy",
    ),
    "network": MessageLookupByLibrary.simpleMessage("Network"),
    "networkDesc": MessageLookupByLibrary.simpleMessage(
      "Modify network-related settings",
    ),
    "networkDetection": MessageLookupByLibrary.simpleMessage(
      "Network detection",
    ),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("Network speed"),
    "networkType": MessageLookupByLibrary.simpleMessage("Network type"),
    "neutralScheme": MessageLookupByLibrary.simpleMessage("Neutral"),
    "noData": MessageLookupByLibrary.simpleMessage("No data"),
    "noHotKey": MessageLookupByLibrary.simpleMessage("No Hotkey"),
    "noIcon": MessageLookupByLibrary.simpleMessage("None"),
    "noInfo": MessageLookupByLibrary.simpleMessage("No info"),
    "noInviteCodes": MessageLookupByLibrary.simpleMessage("No invite codes"),
    "noMoreInfoDesc": MessageLookupByLibrary.simpleMessage("No more info"),
    "noNetwork": MessageLookupByLibrary.simpleMessage("No network"),
    "noNetworkApp": MessageLookupByLibrary.simpleMessage("No network APP"),
    "noProxy": MessageLookupByLibrary.simpleMessage("No proxy"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Please create a profile or add a valid profile",
    ),
    "noResolve": MessageLookupByLibrary.simpleMessage("No resolve IP"),
    "noTrafficLog": MessageLookupByLibrary.simpleMessage("No traffic log"),
    "none": MessageLookupByLibrary.simpleMessage("none"),
    "notSelectedTip": MessageLookupByLibrary.simpleMessage(
      "The current proxy group cannot be selected.",
    ),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage(
      "No profile, Please add a profile",
    ),
    "nullTip": m5,
    "numberTip": m6,
    "oneColumn": MessageLookupByLibrary.simpleMessage("One column"),
    "onlyIcon": MessageLookupByLibrary.simpleMessage("Only Icon"),
    "onlyOtherApps": MessageLookupByLibrary.simpleMessage(
      "Only third-party apps",
    ),
    "onlyStatisticsProxy": MessageLookupByLibrary.simpleMessage(
      "Only statistics proxy",
    ),
    "onlyStatisticsProxyDesc": MessageLookupByLibrary.simpleMessage(
      "When turned on, only statistics proxy traffic",
    ),
    "openInBrowser": MessageLookupByLibrary.simpleMessage("Open in Browser"),
    "options": MessageLookupByLibrary.simpleMessage("Options"),
    "orderCancelled": MessageLookupByLibrary.simpleMessage("Order cancelled"),
    "orderStatus": MessageLookupByLibrary.simpleMessage("Order Status"),
    "orders": MessageLookupByLibrary.simpleMessage("Orders"),
    "other": MessageLookupByLibrary.simpleMessage("Other"),
    "otherContributors": MessageLookupByLibrary.simpleMessage(
      "Other contributors",
    ),
    "outboundMode": MessageLookupByLibrary.simpleMessage("Outbound mode"),
    "override": MessageLookupByLibrary.simpleMessage("Override"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage(
      "Override Proxy related config",
    ),
    "overrideDns": MessageLookupByLibrary.simpleMessage("Override Dns"),
    "overrideDnsDesc": MessageLookupByLibrary.simpleMessage(
      "Turning it on will override the DNS options in the profile",
    ),
    "overrideInvalidTip": MessageLookupByLibrary.simpleMessage(
      "Does not take effect in script mode",
    ),
    "overrideOriginRules": MessageLookupByLibrary.simpleMessage(
      "Override the original rule",
    ),
    "palette": MessageLookupByLibrary.simpleMessage("Palette"),
    "password": MessageLookupByLibrary.simpleMessage("Password"),
    "paste": MessageLookupByLibrary.simpleMessage("Paste"),
    "pay": MessageLookupByLibrary.simpleMessage("Pay"),
    "payNowDeepLink": MessageLookupByLibrary.simpleMessage(
      "Pay Now (Deep Link)",
    ),
    "paymentMethod": MessageLookupByLibrary.simpleMessage("Payment Method"),
    "paymentSuccessful": MessageLookupByLibrary.simpleMessage(
      "Payment successful",
    ),
    "pending": MessageLookupByLibrary.simpleMessage("Pending"),
    "period": MessageLookupByLibrary.simpleMessage("Period"),
    "plan": MessageLookupByLibrary.simpleMessage("Plan"),
    "pleaseBindWebDAV": MessageLookupByLibrary.simpleMessage(
      "Please bind WebDAV",
    ),
    "pleaseEnterScriptName": MessageLookupByLibrary.simpleMessage(
      "Please enter a script name",
    ),
    "pleaseInputAdminPassword": MessageLookupByLibrary.simpleMessage(
      "Please enter the admin password",
    ),
    "pleaseScanQrCode": MessageLookupByLibrary.simpleMessage(
      "Please scan the QR code to pay.",
    ),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage(
      "Please upload file",
    ),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "Please upload a valid QR code",
    ),
    "port": MessageLookupByLibrary.simpleMessage("Port"),
    "portConflictTip": MessageLookupByLibrary.simpleMessage(
      "Please enter a different port",
    ),
    "portTip": m7,
    "preferH3Desc": MessageLookupByLibrary.simpleMessage(
      "Prioritize the use of DOH\'s http/3",
    ),
    "pressKeyboard": MessageLookupByLibrary.simpleMessage("Press keyboard"),
    "preview": MessageLookupByLibrary.simpleMessage("Preview"),
    "price": MessageLookupByLibrary.simpleMessage("Price"),
    "process": MessageLookupByLibrary.simpleMessage("Process"),
    "profile": MessageLookupByLibrary.simpleMessage("Profile"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please input a valid interval time format",
        ),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage(
          "Please enter the auto update interval time",
        ),
    "profileHasUpdate": MessageLookupByLibrary.simpleMessage(
      "The profile has been modified. Do you want to disable auto update?",
    ),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile name",
    ),
    "profileParseErrorDesc": MessageLookupByLibrary.simpleMessage(
      "profile parse error",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input a valid profile URL",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "Please input the profile URL",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("Profiles"),
    "profilesSort": MessageLookupByLibrary.simpleMessage("Profiles sort"),
    "project": MessageLookupByLibrary.simpleMessage("Project"),
    "providers": MessageLookupByLibrary.simpleMessage("Providers"),
    "proxies": MessageLookupByLibrary.simpleMessage("Proxies"),
    "proxiesSetting": MessageLookupByLibrary.simpleMessage("Proxies setting"),
    "proxyChains": MessageLookupByLibrary.simpleMessage("Proxy chains"),
    "proxyGroup": MessageLookupByLibrary.simpleMessage("Proxy group"),
    "proxyNameserver": MessageLookupByLibrary.simpleMessage("Proxy nameserver"),
    "proxyNameserverDesc": MessageLookupByLibrary.simpleMessage(
      "Domain for resolving proxy nodes",
    ),
    "proxyPort": MessageLookupByLibrary.simpleMessage("ProxyPort"),
    "proxyPortDesc": MessageLookupByLibrary.simpleMessage(
      "Set the Clash listening port",
    ),
    "proxyProviders": MessageLookupByLibrary.simpleMessage("Proxy providers"),
    "pureBlackMode": MessageLookupByLibrary.simpleMessage("Pure black mode"),
    "qrcode": MessageLookupByLibrary.simpleMessage("QR code"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage(
      "Scan QR code to obtain profile",
    ),
    "rainbowScheme": MessageLookupByLibrary.simpleMessage("Rainbow"),
    "recovery": MessageLookupByLibrary.simpleMessage("Recovery"),
    "recoveryAll": MessageLookupByLibrary.simpleMessage("Recovery all data"),
    "recoveryProfiles": MessageLookupByLibrary.simpleMessage(
      "Only recovery profiles",
    ),
    "recoveryStrategy": MessageLookupByLibrary.simpleMessage(
      "Recovery strategy",
    ),
    "recoveryStrategy_compatible": MessageLookupByLibrary.simpleMessage(
      "Compatible",
    ),
    "recoveryStrategy_override": MessageLookupByLibrary.simpleMessage(
      "Override",
    ),
    "recoverySuccess": MessageLookupByLibrary.simpleMessage("Recovery success"),
    "redirPort": MessageLookupByLibrary.simpleMessage("Redir Port"),
    "redo": MessageLookupByLibrary.simpleMessage("redo"),
    "regExp": MessageLookupByLibrary.simpleMessage("RegExp"),
    "remote": MessageLookupByLibrary.simpleMessage("Remote"),
    "remoteBackupDesc": MessageLookupByLibrary.simpleMessage(
      "Backup local data to WebDAV",
    ),
    "remoteConfig": MessageLookupByLibrary.simpleMessage("Remote Config"),
    "remoteConfigUrl": MessageLookupByLibrary.simpleMessage(
      "Remote Config URL",
    ),
    "remoteDestination": MessageLookupByLibrary.simpleMessage(
      "Remote destination",
    ),
    "remoteRecoveryDesc": MessageLookupByLibrary.simpleMessage(
      "Recovery data from WebDAV",
    ),
    "remove": MessageLookupByLibrary.simpleMessage("Remove"),
    "rename": MessageLookupByLibrary.simpleMessage("Rename"),
    "request": MessageLookupByLibrary.simpleMessage("Request"),
    "requests": MessageLookupByLibrary.simpleMessage("Requests"),
    "requestsDesc": MessageLookupByLibrary.simpleMessage(
      "View recently request records",
    ),
    "reset": MessageLookupByLibrary.simpleMessage("Reset"),
    "resetSecurity": MessageLookupByLibrary.simpleMessage("Reset Security"),
    "resetTip": MessageLookupByLibrary.simpleMessage("Make sure to reset"),
    "resources": MessageLookupByLibrary.simpleMessage("Resources"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage(
      "External resource related info",
    ),
    "respectRules": MessageLookupByLibrary.simpleMessage("Respect rules"),
    "respectRulesDesc": MessageLookupByLibrary.simpleMessage(
      "DNS connection following rules, need to configure proxy-server-nameserver",
    ),
    "restartCoreTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to restart the core?",
    ),
    "routeAddress": MessageLookupByLibrary.simpleMessage("Route address"),
    "routeAddressDesc": MessageLookupByLibrary.simpleMessage(
      "Config listen route address",
    ),
    "routeMode": MessageLookupByLibrary.simpleMessage("Route mode"),
    "routeMode_bypassPrivate": MessageLookupByLibrary.simpleMessage(
      "Bypass private route address",
    ),
    "routeMode_config": MessageLookupByLibrary.simpleMessage("Use config"),
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("Rule"),
    "ruleName": MessageLookupByLibrary.simpleMessage("Rule name"),
    "ruleProviders": MessageLookupByLibrary.simpleMessage("Rule providers"),
    "ruleTarget": MessageLookupByLibrary.simpleMessage("Rule target"),
    "save": MessageLookupByLibrary.simpleMessage("Save"),
    "saveChanges": MessageLookupByLibrary.simpleMessage(
      "Do you want to save the changes?",
    ),
    "saveTip": MessageLookupByLibrary.simpleMessage(
      "Are you sure you want to save?",
    ),
    "scanToPay": MessageLookupByLibrary.simpleMessage("Scan to Pay"),
    "script": MessageLookupByLibrary.simpleMessage("Script"),
    "search": MessageLookupByLibrary.simpleMessage("Search"),
    "seconds": MessageLookupByLibrary.simpleMessage("Seconds"),
    "selectAll": MessageLookupByLibrary.simpleMessage("Select all"),
    "selected": MessageLookupByLibrary.simpleMessage("Selected"),
    "selectedCountTitle": m8,
    "settings": MessageLookupByLibrary.simpleMessage("Settings"),
    "shop": MessageLookupByLibrary.simpleMessage("Shop"),
    "show": MessageLookupByLibrary.simpleMessage("Show"),
    "shrink": MessageLookupByLibrary.simpleMessage("Shrink"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("SilentLaunch"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage(
      "Start in the background",
    ),
    "size": MessageLookupByLibrary.simpleMessage("Size"),
    "socksPort": MessageLookupByLibrary.simpleMessage("Socks Port"),
    "sort": MessageLookupByLibrary.simpleMessage("Sort"),
    "source": MessageLookupByLibrary.simpleMessage("Source"),
    "sourceIp": MessageLookupByLibrary.simpleMessage("Source IP"),
    "specialProxy": MessageLookupByLibrary.simpleMessage("Special proxy"),
    "specialRules": MessageLookupByLibrary.simpleMessage("special rules"),
    "stackMode": MessageLookupByLibrary.simpleMessage("Stack mode"),
    "standard": MessageLookupByLibrary.simpleMessage("Standard"),
    "start": MessageLookupByLibrary.simpleMessage("Start"),
    "startVpn": MessageLookupByLibrary.simpleMessage("Starting VPN..."),
    "status": MessageLookupByLibrary.simpleMessage("Status"),
    "statusDesc": MessageLookupByLibrary.simpleMessage(
      "System DNS will be used when turned off",
    ),
    "stop": MessageLookupByLibrary.simpleMessage("Stop"),
    "stopVpn": MessageLookupByLibrary.simpleMessage("Stopping VPN..."),
    "style": MessageLookupByLibrary.simpleMessage("Style"),
    "subRule": MessageLookupByLibrary.simpleMessage("Sub rule"),
    "submit": MessageLookupByLibrary.simpleMessage("Submit"),
    "subscribe": MessageLookupByLibrary.simpleMessage("Subscribe"),
    "success": MessageLookupByLibrary.simpleMessage("Success"),
    "sync": MessageLookupByLibrary.simpleMessage("Sync"),
    "system": MessageLookupByLibrary.simpleMessage("System"),
    "systemApp": MessageLookupByLibrary.simpleMessage("System APP"),
    "systemFont": MessageLookupByLibrary.simpleMessage("System font"),
    "systemProxy": MessageLookupByLibrary.simpleMessage("System proxy"),
    "systemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "tab": MessageLookupByLibrary.simpleMessage("Tab"),
    "tabAnimation": MessageLookupByLibrary.simpleMessage("Tab animation"),
    "tabAnimationDesc": MessageLookupByLibrary.simpleMessage(
      "Effective only in mobile view",
    ),
    "tcpConcurrent": MessageLookupByLibrary.simpleMessage("TCP concurrent"),
    "tcpConcurrentDesc": MessageLookupByLibrary.simpleMessage(
      "Enabling it will allow TCP concurrency",
    ),
    "telegram": MessageLookupByLibrary.simpleMessage("Telegram"),
    "testUrl": MessageLookupByLibrary.simpleMessage("Test url"),
    "textScale": MessageLookupByLibrary.simpleMessage("Text Scaling"),
    "theme": MessageLookupByLibrary.simpleMessage("Theme"),
    "themeColor": MessageLookupByLibrary.simpleMessage("Theme color"),
    "themeDesc": MessageLookupByLibrary.simpleMessage(
      "Set dark mode,adjust the color",
    ),
    "themeMode": MessageLookupByLibrary.simpleMessage("Theme mode"),
    "threeColumns": MessageLookupByLibrary.simpleMessage("Three columns"),
    "tianque": MessageLookupByLibrary.simpleMessage("Tianque"),
    "tight": MessageLookupByLibrary.simpleMessage("Tight"),
    "time": MessageLookupByLibrary.simpleMessage("Time"),
    "tip": MessageLookupByLibrary.simpleMessage("tip"),
    "toggle": MessageLookupByLibrary.simpleMessage("Toggle"),
    "tonalSpotScheme": MessageLookupByLibrary.simpleMessage("TonalSpot"),
    "tools": MessageLookupByLibrary.simpleMessage("Tools"),
    "total": MessageLookupByLibrary.simpleMessage("Total"),
    "totalEarned": MessageLookupByLibrary.simpleMessage("Total Earned"),
    "tproxyPort": MessageLookupByLibrary.simpleMessage("Tproxy Port"),
    "traffic": MessageLookupByLibrary.simpleMessage("Traffic"),
    "trafficDetails": MessageLookupByLibrary.simpleMessage("Traffic Details"),
    "trafficLog": MessageLookupByLibrary.simpleMessage("Traffic Log"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("Traffic usage"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage(
      "only effective in administrator mode",
    ),
    "twoColumns": MessageLookupByLibrary.simpleMessage("Two columns"),
    "unableToUpdateCurrentProfileDesc": MessageLookupByLibrary.simpleMessage(
      "unable to update current profile",
    ),
    "undo": MessageLookupByLibrary.simpleMessage("undo"),
    "unifiedDelay": MessageLookupByLibrary.simpleMessage("Unified delay"),
    "unifiedDelayDesc": MessageLookupByLibrary.simpleMessage(
      "Remove extra delays such as handshaking",
    ),
    "unknown": MessageLookupByLibrary.simpleMessage("Unknown"),
    "unknownCheckoutResponse": MessageLookupByLibrary.simpleMessage(
      "Unknown checkout response",
    ),
    "unnamed": MessageLookupByLibrary.simpleMessage("Unnamed"),
    "update": MessageLookupByLibrary.simpleMessage("Update"),
    "upload": MessageLookupByLibrary.simpleMessage("Upload"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage(
      "Obtain profile through URL",
    ),
    "urlTip": m9,
    "useHosts": MessageLookupByLibrary.simpleMessage("Use hosts"),
    "useSystemHosts": MessageLookupByLibrary.simpleMessage("Use system hosts"),
    "user": MessageLookupByLibrary.simpleMessage("Me"),
    "userInfo": MessageLookupByLibrary.simpleMessage("Me"),
    "value": MessageLookupByLibrary.simpleMessage("Value"),
    "vibrantScheme": MessageLookupByLibrary.simpleMessage("Vibrant"),
    "view": MessageLookupByLibrary.simpleMessage("View"),
    "vpnDesc": MessageLookupByLibrary.simpleMessage(
      "Modify VPN related settings",
    ),
    "vpnEnableDesc": MessageLookupByLibrary.simpleMessage(
      "Auto routes all system traffic through VpnService",
    ),
    "vpnSystemProxyDesc": MessageLookupByLibrary.simpleMessage(
      "Attach HTTP proxy to VpnService",
    ),
    "vpnTip": MessageLookupByLibrary.simpleMessage(
      "Changes take effect after restarting the VPN",
    ),
    "waitingForPayment": MessageLookupByLibrary.simpleMessage(
      "Waiting for payment...",
    ),
    "wallet": MessageLookupByLibrary.simpleMessage("Wallet"),
    "webDAVConfiguration": MessageLookupByLibrary.simpleMessage(
      "WebDAV configuration",
    ),
    "websiteUrl": MessageLookupByLibrary.simpleMessage("Website URL"),
    "welcome": MessageLookupByLibrary.simpleMessage("Welcome"),
    "whitelistMode": MessageLookupByLibrary.simpleMessage("Whitelist mode"),
    "years": MessageLookupByLibrary.simpleMessage("Years"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("Simplified Chinese"),
    "zoom": MessageLookupByLibrary.simpleMessage("Zoom"),
  };
}
