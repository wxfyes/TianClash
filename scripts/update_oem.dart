import 'dart:convert';
import 'dart:io';

void main(List<String> args) async {
  print('🚀 开始更新 OEM 配置...');

  String? appName;
  String? packageName;
  String? ossUrl;
  String? imgbbApiKey;
  String? iconPath;

  // 1. 尝试从命令行参数读取 (格式: --appName="Name" --packageName="com.example")
  if (args.isNotEmpty) {
    print('📥 检测到命令行参数,正在解析...');
    final argMap = <String, String>{};
    for (var arg in args) {
      if (arg.startsWith('--')) {
        final parts = arg.substring(2).split('=');
        if (parts.length >= 2) {
          argMap[parts[0]] = parts.sublist(1).join('=');
        }
      }
    }
    appName = argMap['appName'];
    packageName = argMap['packageName'];
    ossUrl = argMap['ossUrl'];
    imgbbApiKey = argMap['imgbbApiKey'];
    iconPath = argMap['iconPath'];
  }

  // 2. 如果参数不全,尝试读取配置文件
  if (appName == null || packageName == null || ossUrl == null || imgbbApiKey == null || iconPath == null) {
    final configFile = File('oem_config.json');
    if (await configFile.exists()) {
      print('📂 读取 oem_config.json 配置文件...');
      final configStr = await configFile.readAsString();
      final Map<String, dynamic> config = jsonDecode(configStr);

      appName ??= config['appName'];
      packageName ??= config['packageName'];
      ossUrl ??= config['ossUrl'];
      imgbbApiKey ??= config['imgbbApiKey'];
      iconPath ??= config['iconPath'];
    }
  }

  // 检查必要参数
  if (appName == null || packageName == null || ossUrl == null || imgbbApiKey == null || iconPath == null) {
    print('❌ 错误: 配置信息不完整。请提供命令行参数或 oem_config.json 文件。');
    print('所需参数: appName, packageName, ossUrl, imgbbApiKey, iconPath');
    exit(1);
  }

  print('📋 配置信息:');
  print('   - 应用名称: $appName');
  print('   - 包名: $packageName');
  print('   - OSS URL: $ossUrl');
  print('   - ImgBB Key: $imgbbApiKey');
  print('   - 图标路径: $iconPath');

  // 3. 如果提供了网络图标URL,先下载图标
  if (iconPath.startsWith('http')) {
    print('⬇️ 检测到网络图标,正在下载...');
    try {
      final request = await HttpClient().getUrl(Uri.parse(iconPath));
      final response = await request.close();
      final localIconPath = 'assets/images/oem_icon.png';
      await response.pipe(File(localIconPath).openWrite());
      iconPath = localIconPath;
      print('✅ 图标下载完成: $localIconPath');
    } catch (e) {
      print('❌ 图标下载失败: $e');
      print('⚠️ 将使用默认图标');
      iconPath = 'assets/images/icon_new.jpg';
    }
  }

  // 4. 执行更新
  await updateAndroidBuildGradle(packageName);
  await updateAndroidManifest(appName);
  await updateWindowsRunnerRc(appName, packageName);
  
  // Parse backup URLs if provided (comma separated)
  List<String>? backupUrlsList;
  if (argMap['backupUrls'] != null && argMap['backupUrls']!.isNotEmpty) {
    backupUrlsList = argMap['backupUrls']!.split(',').map((e) => e.trim()).toList();
  }
  String? fallbackUrl = argMap['fallbackUrl'];

  await updateOssUrl(ossUrl, appName, backupUrls: backupUrlsList, fallbackUrl: fallbackUrl);
  await updateImgBBKey(imgbbApiKey);
  await updateIcons(iconPath);

  print('✅ 所有 OEM 配置更新完成!');
}

Future<void> updateAndroidBuildGradle(String packageName) async {
  print('🔄 更新 Android 包名...');
  final file = File('android/app/build.gradle.kts');
  if (await file.exists()) {
    var content = await file.readAsString();
    // 更新 applicationId
    content = content.replaceAll(
      RegExp(r'applicationId\s*=\s*".*"'),
      'applicationId = "$packageName"',
    );
    // 更新 namespace (可选,但推荐)
    content = content.replaceAll(
      RegExp(r'namespace\s*=\s*".*"'),
      'namespace = "$packageName"',
    );
    await file.writeAsString(content);
  } else {
    print('⚠️ 警告: 找不到 android/app/build.gradle.kts');
  }
}

Future<void> updateAndroidManifest(String appName) async {
  print('🔄 更新 Android 应用名称...');
  final file = File('android/app/src/main/AndroidManifest.xml');
  if (await file.exists()) {
    var content = await file.readAsString();
    content = content.replaceAll(
      RegExp(r'android:label="[^"]*"'),
      'android:label="$appName"',
    );
    await file.writeAsString(content);
  } else {
    print('⚠️ 警告: 找不到 AndroidManifest.xml');
  }
}

Future<void> updateWindowsRunnerRc(String appName, String packageName) async {
  print('🔄 更新 Windows 应用信息...');
  final file = File('windows/runner/Runner.rc');
  if (await file.exists()) {
    var content = await file.readAsString();
    content = content.replaceAll(
      RegExp(r'VALUE "FileDescription", ".*"'),
      'VALUE "FileDescription", "$appName"',
    );
    content = content.replaceAll(
      RegExp(r'VALUE "InternalName", ".*"'),
      'VALUE "InternalName", "$appName"',
    );
    content = content.replaceAll(
      RegExp(r'VALUE "ProductName", ".*"'),
      'VALUE "ProductName", "$appName"',
    );
    // 更新公司名称为包名(通常公司名是包名的前两段,这里简单替换)
    content = content.replaceAll(
      RegExp(r'VALUE "CompanyName", ".*"'),
      'VALUE "CompanyName", "$packageName"',
    );
    // I will first add the logic to replace them if provided in the script args.
    
    // For now, let's just make sure the script *can* replace them if we add the args later.
    // But wait, the user wants them "added to one-click packaging".
    // This means I should add new arguments to the script AND update the workflow file.
    
    await file.writeAsString(content);
  } else {
    print('⚠️ 警告: 找不到 lib/pages/v2board_login_page.dart');
  }
}

Future<void> updateOssUrl(
  String ossUrl, 
  String appName, {
  List<String>? backupUrls,
  String? fallbackUrl,
}) async {
  print('🔄 更新 OSS 接口地址及应用名称...');
  final file = File('lib/pages/v2board_login_page.dart');
  if (await file.exists()) {
    var content = await file.readAsString();
    
    // Update OSS URL
    content = content.replaceAll(
      RegExp(r"const String kOssConfigUrl = '.*';"),
      "const String kOssConfigUrl = '$ossUrl';",
    );

    // Update App Name (Title)
    content = content.replaceAll(
      RegExp(r"'天阙 VPN'"),
      "'$appName'",
    );

    // Update Copyright
    // Dynamically update the year and app name
    final currentYear = DateTime.now().year.toString();
    content = content.replaceAll(
      RegExp(r"'© \d{4} .*? 保留所有权利。'"),
      "'© $currentYear $appName. 保留所有权利。'",
    );

    // Update Backup URLs
    if (backupUrls != null && backupUrls.isNotEmpty) {
      print('🔄 更新备份地址...');
      final backupUrlsString = backupUrls.map((e) => "'$e'").join(',\n  ');
      content = content.replaceAll(
        RegExp(r"const List<String> kBackupUrls = \[\n(.*?)\n\];", dotAll: true),
        "const List<String> kBackupUrls = [\n  $backupUrlsString,\n];",
      );
    }

    // Update Fallback URL
    if (fallbackUrl != null && fallbackUrl.isNotEmpty) {
      print('🔄 更新回退地址...');
      content = content.replaceAll(
        RegExp(r"const String kFallbackUrl = '.*';"),
        "const String kFallbackUrl = '$fallbackUrl';",
      );
    }

    await file.writeAsString(content);
  } else {
    print('⚠️ 警告: 找不到 lib/pages/v2board_login_page.dart');
  }
}

Future<void> updateImgBBKey(String apiKey) async {
  print('🔄 更新 ImgBB API Key...');
  final file = File('lib/common/image_upload_service.dart');
  if (await file.exists()) {
    var content = await file.readAsString();
    content = content.replaceAll(
      RegExp(r"String imgbbApiKey = '.*';"),
      "String imgbbApiKey = '$apiKey';",
    );
    await file.writeAsString(content);
  } else {
    print('⚠️ 警告: 找不到 lib/common/image_upload_service.dart');
  }
}


Future<void> updateIcons(String iconPath) async {
  print('🔄 更新应用图标配置...');
  final file = File('flutter_launcher_icons.yaml');
  if (await file.exists()) {
    var content = await file.readAsString();
    // 更新所有 image_path
    content = content.replaceAll(
      RegExp(r'image_path: ".*"'),
      'image_path: "$iconPath"',
    );
    await file.writeAsString(content);

    print('🎨 生成新图标...');
    final result = await Process.run(
      'dart',
      ['run', 'flutter_launcher_icons'],
      runInShell: true,
    );
    if (result.exitCode == 0) {
      print('✅ 图标生成成功');
    } else {
      print('❌ 图标生成失败: ${result.stderr}');
    }
  } else {
    print('⚠️ 警告: 找不到 flutter_launcher_icons.yaml');
  }
}
