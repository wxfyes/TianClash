# FlClash Android 签名配置指南

本指南将帮助你配置FlClash Android应用的签名密钥，以便在GitHub Actions中自动构建和发布。

## 前置要求

1. **Java JDK** - 用于生成keystore文件
   - 下载地址: https://adoptium.net/
   - 确保 `keytool` 命令可用

## 步骤1: 生成Android Keystore

### 方法1: 使用提供的脚本 (推荐)

#### Windows用户:
```bash
# 双击运行
generate_android_key.bat
```

#### Linux/macOS用户:
```bash
# 给脚本执行权限
chmod +x generate_android_key.sh

# 运行脚本
./generate_android_key.sh
```

### 方法2: 手动生成

```bash
keytool -genkey -v \
    -keystore flclash-release-key.jks \
    -keyalg RSA \
    -keysize 2048 \
    -validity 10000 \
    -alias flclash-key \
    -storepass flclash123 \
    -keypass flclash123 \
    -dname "CN=FlClash, OU=Development, O=FlClash, L=City, S=State, C=CN"
```

## 步骤2: 生成Base64编码

### Windows:
```cmd
certutil -encode flclash-release-key.jks temp.b64
type temp.b64
del temp.b64
```

### Linux/macOS:
```bash
base64 -i flclash-release-key.jks | tr -d '\n'
```

**重要**: 复制输出的base64字符串（不包含换行符）

## 步骤3: 配置GitHub Secrets

1. 进入你的GitHub仓库
2. 点击 **Settings** → **Secrets and variables** → **Actions**
3. 点击 **New repository secret**
4. 添加以下4个secrets:

| Secret名称 | 值 | 说明 |
|-----------|----|----|
| `KEYSTORE` | base64编码的keystore文件内容 | 步骤2生成的base64字符串 |
| `KEY_ALIAS` | `flclash-key` | 密钥别名 |
| `STORE_PASSWORD` | `flclash123` | keystore密码 |
| `KEY_PASSWORD` | `flclash123` | 密钥密码 |

## 步骤4: 验证配置

1. 推送一个版本标签来触发构建:
```bash
git tag v1.0.0
git push origin v1.0.0
```

2. 在GitHub仓库的 **Actions** 页面查看构建进度
3. 如果Android构建成功，说明配置正确

## 密钥信息总结

- **Keystore文件**: `flclash-release-key.jks`
- **密钥别名**: `flclash-key`
- **Keystore密码**: `flclash123`
- **密钥密码**: `flclash123`
- **有效期**: 10000天

## 安全注意事项

1. **备份keystore文件**: 这是你应用的唯一签名密钥，丢失后将无法更新应用
2. **保护密码**: 不要将密码提交到代码仓库
3. **定期更新**: 建议定期重新生成密钥

## 故障排除

### 问题1: keytool命令未找到
**解决方案**: 安装Java JDK并确保在PATH中

### 问题2: GitHub Actions构建失败
**解决方案**: 
- 检查所有4个secrets是否正确设置
- 确保base64编码没有换行符
- 检查密钥别名和密码是否匹配

### 问题3: APK签名验证失败
**解决方案**: 
- 确保使用相同的keystore文件
- 检查密钥别名和密码是否正确

## 下一步

配置完成后，你可以:
1. 推送版本标签自动构建
2. 在GitHub Releases中下载签名的APK
3. 发布到Google Play Store（需要额外配置）
