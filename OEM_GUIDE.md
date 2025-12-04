# OEM 一键修改指南

这个项目包含了一个自动化脚本,可以帮助你快速修改客户端的品牌信息、包名和配置接口,方便打包出售给不同的客户。

## 🚀 快速开始

### 1. 修改配置文件

打开项目根目录下的 `oem_config.json` 文件,修改以下内容:

```json
{
  "appName": "天阙",                    // 客户端名称 (显示在桌面上)
  "packageName": "com.follow.clash",    // 包名 (Android Application ID, 唯一标识)
  "ossUrl": "https://oss.tianque.cc/config.txt", // OSS 接口地址 (用于获取API地址)
  "imgbbApiKey": "your_api_key_here",   // ImgBB 图片上传 Token (用于工单图片上传)
  "iconPath": "assets/images/icon.png"  // 应用图标路径 (请确保图片存在)
}
```

### 2. 运行修改脚本

在终端中运行以下命令:

```bash
dart run scripts/update_oem.dart
```

### 3. 等待完成

脚本会自动执行以下操作:
- ✅ 修改 Android 包名 (`build.gradle.kts`)
- ✅ 修改 Android 应用名称 (`AndroidManifest.xml`)
- ✅ 修改 Windows 应用信息 (`Runner.rc`)
- ✅ 修改 OSS 接口地址 (`v2board_login_page.dart`)
- ✅ 修改 图片上传 Token (`image_upload_service.dart`)
- ✅ 更新并重新生成应用图标 (`flutter_launcher_icons`)

完成后,你就可以直接进行打包了!

## 📦 打包命令

- **Android**: `flutter build apk --release`
- **Windows**: `flutter build windows --release`

## ⚠️ 注意事项

1. **图标文件**: 请确保 `iconPath` 指定的图片文件真实存在,建议使用 1024x1024 的 PNG 图片以获得最佳效果。
2. **包名修改**: 脚本只修改了 `applicationId`,这对于发布新应用是足够的。它不会修改 Java/Kotlin 的源代码目录结构,这通常是不需要的,除非你有特定的代码依赖于包名路径。
3. **备份**: 建议在运行脚本前提交代码到 Git,以便出错时回滚。
