# V2Board 公告模块集成实现

## 概述
成功将 v2board 网站的公告模块添加到应用仪表盘中,并按照要求调整了布局。

## 实现内容

### 1. 数据模型 (lib/models/v2board.dart)
添加了 `Notice` 数据模型,包含以下字段:
- `id`: 公告ID
- `title`: 公告标题
- `content`: 公告内容
- `show`: 显示状态
- `tags`: 标签列表
- `createdAt`: 创建时间
- `updatedAt`: 更新时间

### 2. API 服务 (lib/common/v2board_service.dart)
添加了 `fetchNotices` 方法:
```dart
Future<Map<String, dynamic>?> fetchNotices(
  String baseUrl, 
  String token, 
  {int current = 1, int pageSize = 5}
)
```
- 调用 v2board API: `/api/v1/user/notice/fetch`
- 支持分页参数
- 返回公告列表和总数

### 3. 公告卡片组件 (lib/views/dashboard/widgets/announcement_card.dart)
创建了 `AnnouncementCard` 组件,功能包括:
- 自动从 v2board API 加载公告
- 显示公告标题和图标
- 支持多条公告翻页浏览(左右箭头)
- 点击标题或详情按钮查看完整公告内容
- 显示公告发布日期
- 加载状态指示器
- 无公告时显示"暂无公告"

### 4. 仪表盘布局调整 (lib/views/dashboard/dashboard.dart)
按照要求修改了布局:
- 将网络检测卡片和公告卡片并排显示
- 每个卡片占一半宽度(使用 `Expanded` 包裹)
- 中间间隔 12px

## 布局结构

```
仪表盘
├── 用户信息卡片 (UserInfoCard)
├── 节点选择器 (ProxySelector)
├── Row (并排显示)
│   ├── 网络检测 (NetworkDetection) - 占 50% 宽度
│   └── 网站公告 (AnnouncementCard) - 占 50% 宽度
├── 中央连接按钮 (CentralConnectionButton)
└── 出站模式 (OutboundMode)
```

## 使用说明

### 前提条件
- 用户需要已登录 v2board 账户
- 应用中需要保存 `v2boardUrl` 和 `v2boardToken`

### 公告显示逻辑
1. 组件初始化时自动加载公告
2. 从 `globalState.appController.appState` 获取 v2board 配置
3. 调用 API 获取最新 10 条公告
4. 只显示 `show=1` 的公告(由后端过滤)

### 交互功能
- **单条公告**: 显示详情按钮(i图标)
- **多条公告**: 显示左右箭头和页码(如 "1/5")
- **点击标题**: 弹出对话框显示完整内容和发布日期
- **翻页**: 使用左右箭头切换公告

## 待完成步骤

由于网络问题,需要手动运行以下命令生成代码:

```bash
cd e:\GitHub\TianClash
dart run build_runner build --delete-conflicting-outputs
```

这将生成:
- `lib/models/generated/v2board.freezed.dart` (Notice 模型的 freezed 代码)
- `lib/models/generated/v2board.g.dart` (Notice 模型的 JSON 序列化代码)

## 文件清单

### 新增文件
- `lib/views/dashboard/widgets/announcement_card.dart` - 公告卡片组件

### 修改文件
- `lib/models/v2board.dart` - 添加 Notice 模型
- `lib/common/v2board_service.dart` - 添加 fetchNotices 方法
- `lib/views/dashboard/widgets/widgets.dart` - 导出 announcement_card
- `lib/views/dashboard/dashboard.dart` - 调整布局

## 效果预览

公告卡片样式:
- 左侧: 喇叭图标 (Icons.campaign)
- 中间: 
  - 上方: "网站公告" 标签(灰色小字)
  - 下方: 公告标题(加粗,可点击)
- 右侧: 
  - 多条公告: 左箭头 + 页码 + 右箭头
  - 单条公告: 详情图标

## 注意事项

1. **网络检测卡片高度**: 两个卡片并排后,建议保持相同高度以保证视觉一致性
2. **响应式布局**: 在小屏幕设备上可能需要调整为垂直堆叠
3. **错误处理**: 如果 API 调用失败,会显示"暂无公告"而不是错误信息
4. **性能**: 公告只在组件初始化时加载一次,不会自动刷新

## 后续优化建议

1. 添加下拉刷新功能
2. 支持公告缓存,减少 API 调用
3. 添加未读公告标记
4. 支持公告分类筛选
5. 在小屏幕上自动切换为垂直布局
