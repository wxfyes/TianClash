# TianClash 仓库迁移指南

## 步骤 1: 在GitHub上创建新仓库

请前往 GitHub 网站手动创建仓库：

1. 访问：https://github.com/new
2. 仓库名称：`TianClash`
3. 描述（可选）：`基于FlClash的重构版本，采用简洁的移动端风格设计`
4. 可见性：选择 Public 或 Private
5. **重要：不要** 勾选 "Initialize this repository with a README"
6. 点击 "Create repository"

## 步骤 2: 在本地创建新的Git分支

完成后，请告诉我您的GitHub用户名，我会为您生成具体的命令。

或者您可以直接执行以下命令：

```bash
# 1. 进入项目目录
cd e:\GitHub\FlClash

# 2. 创建一个新的分支用于重构
git checkout -b tianclash-refactor

# 3. 添加新的远程仓库（请替换 YOUR_USERNAME）
git remote add tianclash https://github.com/YOUR_USERNAME/TianClash.git

# 4. 提交当前的改动
git add .
git commit -m "feat: 初始化TianClash - 导航栏重构完成"

# 5. 推送到新仓库
git push -u tianclash tianclash-refactor:main
```

## 步骤 3: 更新项目元信息

推送后，建议更新以下文件：

### 更新 `README.md`
```markdown
# TianClash

基于 [FlClash](https://github.com/chen08209/FlClash) 的重构版本

## ✨ 主要改进

- 🎨 重新设计的简洁仪表盘
- 📱 移动端风格的主页布局
- ⚡ 快速节点选择与自动测延迟
- 🎯 一键连接大型按钮
- 🔀 简化的智能/全局模式切换

## 🚀 开发进度

- [x] 导航栏重构
- [ ] 节点选择器组件
- [ ] 中央连接按钮
- [ ] 模式切换器
- [ ] 仪表盘主页重构

## 📖 文档

详见 [DASHBOARD_REFACTOR_PLAN.md](DASHBOARD_REFACTOR_PLAN.md)

## 🙏 致谢

本项目基于 [FlClash](https://github.com/chen08209/FlClash) 开发
```

### 更新 `pubspec.yaml`
```yaml
name: tianclash
description: A refactored version of FlClash with modern UI design
```

## 步骤 4: 后续开发流程

### 日常开发
```bash
# 在 tianclash-refactor 分支上工作
git checkout tianclash-refactor

# 提交改动
git add .
git commit -m "描述您的改动"

# 推送到TianClash仓库
git push tianclash tianclash-refactor:main
```

### 保持与原FlClash同步（如果需要）
```bash
# 添加原仓库为upstream
git remote add upstream https://github.com/chen08209/FlClash.git

# 获取原仓库更新
git fetch upstream

# 合并特定的改动（谨慎操作）
git cherry-pick <commit-hash>
```

## 注意事项

⚠️ **重要提醒：**
1. TianClash是基于FlClash的fork，请遵守原项目的GPLv3许可证
2. 在README中明确标注这是fork版本
3. 保留原作者的版权声明
4. 如果公开发布，建议在显著位置注明基于FlClash

## 推荐的.gitignore补充

确保这些文件不被提交：
```
# IDE
.vscode/
.idea/

# Build artifacts  
build/
*.log

# Flutter
.dart_tool/
.flutter-plugins
.flutter-plugins-dependencies
.packages
.pub-cache/
.pub/
```

---

准备好后告诉我您的GitHub用户名，我会生成具体的命令！
