// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
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
  String get localeName => 'zh';

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
    "about": MessageLookupByLibrary.simpleMessage("关于"),
    "accessControl": MessageLookupByLibrary.simpleMessage("访问控制"),
    "accessControlDesc": MessageLookupByLibrary.simpleMessage("配置应用程序访问代理"),
    "add": MessageLookupByLibrary.simpleMessage("添加"),
    "ago": MessageLookupByLibrary.simpleMessage("前"),
    "allowLan": MessageLookupByLibrary.simpleMessage("允许局域网"),
    "allowLanDesc": MessageLookupByLibrary.simpleMessage("允许通过局域网访问代理"),
    "application": MessageLookupByLibrary.simpleMessage("应用程序"),
    "applicationDesc": MessageLookupByLibrary.simpleMessage("修改应用程序相关设置"),
    "auto": MessageLookupByLibrary.simpleMessage("自动"),
    "autoCheckUpdate": MessageLookupByLibrary.simpleMessage("自动检查更新"),
    "autoCheckUpdateDesc": MessageLookupByLibrary.simpleMessage("应用启动时自动检查更新"),
    "autoLaunch": MessageLookupByLibrary.simpleMessage("自动启动"),
    "autoLaunchDesc": MessageLookupByLibrary.simpleMessage("跟随系统自启动"),
    "autoRun": MessageLookupByLibrary.simpleMessage("自动运行"),
    "autoRunDesc": MessageLookupByLibrary.simpleMessage("打开应用程序时自动运行"),
    "autoUpdate": MessageLookupByLibrary.simpleMessage("自动更新"),
    "autoUpdateInterval": MessageLookupByLibrary.simpleMessage("自动更新间隔（分钟）"),
    "confirm": MessageLookupByLibrary.simpleMessage("确认"),
    "coreInfo": MessageLookupByLibrary.simpleMessage("核心信息"),
    "create": MessageLookupByLibrary.simpleMessage("创建"),
    "dark": MessageLookupByLibrary.simpleMessage("深色"),
    "dashboard": MessageLookupByLibrary.simpleMessage("仪表盘"),
    "days": MessageLookupByLibrary.simpleMessage("天"),
    "defaultSort": MessageLookupByLibrary.simpleMessage("按默认排序"),
    "defaultText": MessageLookupByLibrary.simpleMessage("默认"),
    "delaySort": MessageLookupByLibrary.simpleMessage("按延迟排序"),
    "delete": MessageLookupByLibrary.simpleMessage("删除"),
    "direct": MessageLookupByLibrary.simpleMessage("直连"),
    "doYouWantToPass": MessageLookupByLibrary.simpleMessage("您想要通过"),
    "download": MessageLookupByLibrary.simpleMessage("下载"),
    "edit": MessageLookupByLibrary.simpleMessage("编辑"),
    "en": MessageLookupByLibrary.simpleMessage("English"),
    "file": MessageLookupByLibrary.simpleMessage("文件"),
    "fileDesc": MessageLookupByLibrary.simpleMessage("直接上传配置"),
    "global": MessageLookupByLibrary.simpleMessage("全局"),
    "hours": MessageLookupByLibrary.simpleMessage("小时"),
    "importFromURL": MessageLookupByLibrary.simpleMessage("从URL导入"),
    "ja": MessageLookupByLibrary.simpleMessage("Japanese"),
    "just": MessageLookupByLibrary.simpleMessage("刚刚"),
    "language": MessageLookupByLibrary.simpleMessage("语言"),
    "light": MessageLookupByLibrary.simpleMessage("浅色"),
    "logcat": MessageLookupByLibrary.simpleMessage("日志捕获"),
    "logcatDesc": MessageLookupByLibrary.simpleMessage("禁用将隐藏日志条目"),
    "logs": MessageLookupByLibrary.simpleMessage("日志"),
    "logsDesc": MessageLookupByLibrary.simpleMessage("日志捕获记录"),
    "minimizeOnExit": MessageLookupByLibrary.simpleMessage("退出时最小化"),
    "minimizeOnExitDesc": MessageLookupByLibrary.simpleMessage("修改默认系统退出事件"),
    "minutes": MessageLookupByLibrary.simpleMessage("分钟"),
    "months": MessageLookupByLibrary.simpleMessage("月"),
    "more": MessageLookupByLibrary.simpleMessage("更多"),
    "name": MessageLookupByLibrary.simpleMessage("名称"),
    "nameSort": MessageLookupByLibrary.simpleMessage("按名称排序"),
    "networkDetection": MessageLookupByLibrary.simpleMessage("网络检测"),
    "networkSpeed": MessageLookupByLibrary.simpleMessage("网络速度"),
    "noProxy": MessageLookupByLibrary.simpleMessage("无代理"),
    "noProxyDesc": MessageLookupByLibrary.simpleMessage("请创建配置或添加有效配置"),
    "nullProfileDesc": MessageLookupByLibrary.simpleMessage("无配置，请添加配置"),
    "other": MessageLookupByLibrary.simpleMessage("其他"),
    "outboundMode": MessageLookupByLibrary.simpleMessage("出站模式"),
    "override": MessageLookupByLibrary.simpleMessage("覆盖"),
    "overrideDesc": MessageLookupByLibrary.simpleMessage("覆盖代理相关配置"),
    "pleaseUploadFile": MessageLookupByLibrary.simpleMessage("请上传文件"),
    "pleaseUploadValidQrcode": MessageLookupByLibrary.simpleMessage(
      "请上传有效的二维码",
    ),
    "preview": MessageLookupByLibrary.simpleMessage("预览"),
    "profile": MessageLookupByLibrary.simpleMessage("配置"),
    "profileAutoUpdateIntervalInvalidValidationDesc":
        MessageLookupByLibrary.simpleMessage("请输入有效的间隔时间格式"),
    "profileAutoUpdateIntervalNullValidationDesc":
        MessageLookupByLibrary.simpleMessage("请输入自动更新间隔时间"),
    "profileNameNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "请输入配置名称",
    ),
    "profileUrlInvalidValidationDesc": MessageLookupByLibrary.simpleMessage(
      "请输入有效的配置URL",
    ),
    "profileUrlNullValidationDesc": MessageLookupByLibrary.simpleMessage(
      "请输入配置URL",
    ),
    "profiles": MessageLookupByLibrary.simpleMessage("配置"),
    "proxies": MessageLookupByLibrary.simpleMessage("代理"),
    "qrcode": MessageLookupByLibrary.simpleMessage("二维码"),
    "qrcodeDesc": MessageLookupByLibrary.simpleMessage("扫描二维码获取配置"),
    "resources": MessageLookupByLibrary.simpleMessage("资源"),
    "resourcesDesc": MessageLookupByLibrary.simpleMessage("外部资源相关信息"),
    "ru": MessageLookupByLibrary.simpleMessage("Russian"),
    "rule": MessageLookupByLibrary.simpleMessage("规则"),
    "save": MessageLookupByLibrary.simpleMessage("保存"),
    "seconds": MessageLookupByLibrary.simpleMessage("秒"),
    "settings": MessageLookupByLibrary.simpleMessage("设置"),
    "silentLaunch": MessageLookupByLibrary.simpleMessage("静默启动"),
    "silentLaunchDesc": MessageLookupByLibrary.simpleMessage("在后台启动"),
    "submit": MessageLookupByLibrary.simpleMessage("提交"),
    "theme": MessageLookupByLibrary.simpleMessage("主题"),
    "themeColor": MessageLookupByLibrary.simpleMessage("主题颜色"),
    "themeDesc": MessageLookupByLibrary.simpleMessage("设置深色模式，调整颜色"),
    "themeMode": MessageLookupByLibrary.simpleMessage("主题模式"),
    "tianque": MessageLookupByLibrary.simpleMessage("天阙"),
    "tools": MessageLookupByLibrary.simpleMessage("工具"),
    "trafficUsage": MessageLookupByLibrary.simpleMessage("流量使用"),
    "tun": MessageLookupByLibrary.simpleMessage("TUN"),
    "tunDesc": MessageLookupByLibrary.simpleMessage("仅在管理员模式下有效"),
    "update": MessageLookupByLibrary.simpleMessage("更新"),
    "upload": MessageLookupByLibrary.simpleMessage("上传"),
    "url": MessageLookupByLibrary.simpleMessage("URL"),
    "urlDesc": MessageLookupByLibrary.simpleMessage("通过URL获取配置"),
    "years": MessageLookupByLibrary.simpleMessage("年"),
    "zh_CN": MessageLookupByLibrary.simpleMessage("简体中文"),
  };
}
