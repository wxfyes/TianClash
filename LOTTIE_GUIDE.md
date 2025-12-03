# 自定义连接按钮动画指南

TianClash 支持使用 Lottie 动画来自定义主界面的连接按钮。您可以按照以下步骤替换默认的按钮样式。

## 1. 获取 Lottie 动画文件

您可以从 [LottieFiles](https://lottiefiles.com/) 等网站下载免费的 Lottie 动画。

**推荐搜索关键词：**
- Power Button
- Switch
- Toggle
- VPN Connect

**注意：** 请下载 **Lottie JSON** 格式的文件。

## 2. 准备文件

1. 将下载的 `.json` 文件重命名为 `connect.json`。
2. 确保文件名完全匹配（全小写）。

## 3. 放置文件

将 `connect.json` 文件放入项目的以下目录中：

```
assets/images/
```

完整路径应为：
`[项目根目录]/assets/images/connect.json`

## 4. 重新构建

如果您正在运行应用，请执行 **热重启 (Hot Restart)** 或重新构建应用，即可看到新的动画效果。

## 5. 动画逻辑说明

- **连接中**：动画会循环播放。
- **已连接**：动画会播放并停留在结束状态（进度 1.0）。
- **已断开**：动画会播放并停留在开始状态（进度 0.0）。

## 6. 回退机制

如果您删除了 `connect.json` 文件或文件加载失败，应用会自动回退到默认的图标样式，不会影响正常使用。
