import 'dart:io';
import 'package:yaml/yaml.dart';
import 'dart:convert';

void main() {
  final path = 'linux/packaging/deb/make_config.yaml';
  final file = File(path);
  
  if (!file.existsSync()) {
    print('文件不存在: $path');
    return;
  }
  
  print('读取文件: $path');
  final yamlDoc = loadYaml(file.readAsStringSync());
  final map = json.decode(json.encode(yamlDoc)) as Map<String, dynamic>;
  
  print('\n解析后的配置:');
  print('display_name: ${map['display_name']}');
  print('package_name: ${map['package_name']}');
  print('maintainer: ${map['maintainer']}');
  print('maintainer.name: ${map['maintainer']?['name']}');
  print('maintainer.email: ${map['maintainer']?['email']}');
  
  // 模拟 fromJson 的逻辑
  try {
    final displayName = map['display_name'] as String;
    final packageName = map['package_name'] as String;
    final maintainerName = map['maintainer']['name'] as String;
    final maintainerEmail = map['maintainer']['email'] as String;
    final maintainer = "$maintainerName <$maintainerEmail>";
    
    print('\n✅ 配置验证成功!');
    print('displayName: $displayName');
    print('packageName: $packageName');
    print('maintainer: $maintainer');
  } catch (e) {
    print('\n❌ 配置验证失败: $e');
  }
}
