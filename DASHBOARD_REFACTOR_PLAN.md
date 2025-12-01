# FlClash 仪表盘重构实现计划

## 目标概述

将当前基于网格的仪表盘重构为类似移动端风格的简洁主页，所有核心功能集中在主页，符合以下设计：

- 用户信息卡片（顶部，显示套餐、到期时间、流量）
- 节点选择器（下拉选择，自动测延迟）
- 网络检测信息
- 中央大型连接按钮（未连接/已连接状态）
- 简化模式切换（智能/全局）
- 内网IP显示（保留）
- 移除流量统计卡片

---

## 架构变更总览

### 当前架构
```
dashboard.dart
├── SuperGrid (可编辑网格布局)
├── DashboardWidget (enum定义的卡片)
└── 各种独立卡片组件
```

### 目标架构
```
dashboard.dart (重构)
├── 垂直滚动布局 (SingleChildScrollView)
├── UserInfoCard (紧凑版)
├── ProxySelector (新组件 - 节点选择器)
├── NetworkDetection (精简版)
├── CentralConnectionButton (新组件 - 中央连接按钮)
├── ModeSwitcher (新组件 - 智能/全局切换)
└── IntranetIP (保留)
```

---

## 实施阶段

### 阶段 1: 准备工作 ✅ (已完成)

**任务清单:**
- [x] 调整导航栏
  - 隐藏节点入口 (proxies modes设为空数组)
  - 商店改为套餐 (icon + 中文翻译)
  - 移动Connections、Requests、Tools到More
  - 保留Dashboard、套餐、我的

**涉及文件:**
- `lib/common/navigation.dart` ✅
- `arb/intl_zh_CN.arb` ✅

---

### 阶段 2: 创建核心新组件

#### 2.1 节点选择器 (ProxySelector)

**文件:** `lib/views/dashboard/widgets/proxy_selector.dart`

**功能需求:**
1. 下拉展开显示所有可用节点
2. 显示当前选中节点
3. 点击展开时自动开始测延迟
4. 支持按延迟排序
5. 显示节点延迟状态

**依赖:**
- `providers/providers.dart` (获取节点组)
- `appController.changeProxy()` (切换节点)
- `testDelay()` (测试延迟)

**UI设计:**
```dart
ProxySelector
├── InkWell (可点击区域)
│   ├── Row
│   │   ├── Icon (地球图标)
│   │   ├── Column
│   │   │   ├── Text ("节点选择" / "节点连接")
│   │   │   └── Text (当前节点名称 或 "自动选择")
│   │   └── Icon (下拉箭头 / 刷新图标)
│   └── Badge (显示延迟，如果已测试)
└── BottomSheet / Dialog (展开状态)
    └── ListView (节点列表，带延迟测试)
```

**伪代码:**
```dart
class ProxySelector extends ConsumerStatefulWidget {
  @override
  Widget build(BuildContext context) {
    final groups = ref.watch(groupsProvider);
    final currentGroup = groups.first; // 主代理组
    
    return Card(
      child: ListTile(
        leading: Icon(Icons.public),
        title: Text('节点选择'),
        subtitle: Text(currentGroup.now ?? '自动选择'),
        trailing: IconButton(
          icon: Icon(Icons.expand_more),
          onPressed: () => _showProxySelector(context),
        ),
      ),
    );
  }
  
  void _showProxySelector(BuildContext context) {
    // 1. 展开底部Sheet
    // 2. 自动开始测延迟
    // 3. 显示节点列表，支持点击切换
  }
}
```

---

#### 2.2 中央连接按钮 (CentralConnectionButton)

**文件:** `lib/views/dashboard/widgets/central_connection_button.dart`

**功能需求:**
1. 大型圆形按钮（直径~120dp）
2. 显示三种状态：未连接、连接中、已连接
3. 点击切换连接状态
4. 状态文字和图标动画

**UI设计:**
```dart
CentralConnectionButton
├── GestureDetector
│   └── Container (圆形，渐变背景)
│       ├── AnimatedIcon (开关图标，带旋转动画)
│       └── Column
│           ├── Icon (电源图标)
│           └── Text ("未连接" / "连接中..." / "已连接")
```

**状态逻辑:**
```dart
enum ConnectionStatus { disconnected, connecting, connected }

class CentralConnectionButton extends ConsumerWidget {
  @override
  Widget build(BuildContext context) {
    final coreStatus = ref.watch(coreStatusProvider);
    final status = _mapCoreStatus(coreStatus);
    
    return GestureDetector(
      onTap: () => _toggleConnection(ref),
      child: Container(
        width: 120,
        height: 120,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: _getGradient(status),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(_getIcon(status), size: 48),
            SizedBox(height: 8),
            Text(_getStatusText(status)),
          ],
        ),
      ),
    );
  }
}
```

---

#### 2.3 模式切换器 (ModeSwitcher)

**文件:** `lib/views/dashboard/widgets/mode_switcher.dart`

**功能需求:**
1. 只显示"智能"和"全局"两个选项
2. 智能模式 = Rule模式
3. 全局模式 = Global模式
4. 使用SegmentedButton或ToggleButtons

**UI设计:**
```dart
ModeSwitcher
└── SegmentedButton<Mode>
    ├── Segment (智能 / rule图标)
    └── Segment (全局 / global图标)
```

**实现:**
```dart
class ModeSwitcher extends ConsumerWidget {
  @override
  Widget build(BuildContext context) {
    final mode = ref.watch(modeProvider);
    
    return SegmentedButton<Mode>(
      segments: [
        ButtonSegment(
          value: Mode.rule,
          label: Text('智能'),
          icon: Icon(Icons.playlist_add_check),
        ),
        ButtonSegment(
          value: Mode.global,
          label: Text('全局'),
          icon: Icon(Icons.public),
        ),
      ],
      selected: {mode},
      onSelectionChanged: (newSelection) {
        ref.read(configProvider.notifier).updateMode(newSelection.first);
      },
    );
  }
}
```

---

### 阶段 3: 现有组件调整

#### 3.1 用户信息卡片 (UserInfoCard) - 精简版

**修改:** `lib/views/dashboard/widgets/user_info_card.dart`

**改动点:**
1. 移除流量进度条（已有专门的RemainingTraffic卡片）
2. 只保留：头像、邮箱/套餐名、到期时间、续费按钮
3. 更紧凑的布局 (高度降为1单位)

**建议布局:**
```dart
Row(
  ├── CircleAvatar (头像, 半径16)
  ├── Expanded(
  │     Column(
  │       ├── Text (邮箱/套餐名, titleSmall)
  │       └── Text (到期时间, labelSmall)
  │     )
  │   )
  └── TextButton ('续费')
)
```

---

#### 3.2 网络检测 (NetworkDetection) - 精简版

**修改:** `lib/views/dashboard/widgets/network_detection.dart`

**改动点:**
1. 移除标题栏
2. 只显示：国旗 + IP地址
3. 单行布局

---

#### 3.3 内网IP (IntranetIP) - 保留

**修改:** `lib/views/dashboard/widgets/intranet_ip.dart`

**改动点:**
1. 与网络检测类似，精简布局
2. 图标 + IP地址一行显示

---

### 阶段 4: 仪表盘主页重构

#### 4.1 移除现有Grid系统

**文件:** `lib/views/dashboard/dashboard.dart`

**删除内容:**
- SuperGrid组件及相关逻辑
- 编辑模式相关代码
- 网格拖拽排序功能
- DashboardWidget enum的GridItem配置

**保留内容:**
- AppBar (如果需要)
- 核心状态提供者

---

#### 4.2 创建新布局

**新结构:**
```dart
class DashboardView extends ConsumerWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // 用户信息卡片
              UserInfoCard(),
              SizedBox(height: 12),
              
              // 节点选择器
              ProxySelector(),
              SizedBox(height: 12),
              
              // 网络检测
              NetworkDetection(),
              SizedBox(height: 24),
              
              // 🎯 中央连接按钮
              Center(child: CentralConnectionButton()),
              SizedBox(height: 24),
              
              // 模式切换
              ModeSwitcher(),
              SizedBox(height: 12),
              
              // 内网IP
              IntranetIP(),
            ],
          ),
        ),
      ),
    );
  }
}
```

---

### 阶段 5: 清理与优化

#### 5.1 移除废弃代码

**删除文件:**
- `lib/views/dashboard/widgets/traffic_usage.dart` (流量统计卡片)
- 其他不再使用的dashboard widgets

**修改 `enum.dart`:**
```dart
enum DashboardWidget {
  // 移除不再使用的widget定义
  // trafficUsage, networkSpeed, outboundMode等
}
```

---

#### 5.2 测试清单

**功能测试:**
- [ ] 节点选择器能正确显示所有节点
- [ ] 点击展开自动测延迟
- [ ] 切换节点后连接正常
- [ ] 中央按钮正确切换连接状态
- [ ] 智能/全局模式切换生效
- [ ] 用户信息正确显示
- [ ] 续费按钮功能正常
- [ ] 网络检测显示正确IP
- [ ] 内网IP显示正常

**UI测试:**
- [ ] 移动端响应式布局正常
- [ ] 桌面端显示美观
- [ ] 所有动画流畅
- [ ] 颜色主题适配深色/浅色模式

---

## 分步实施建议

### 第1次会话 ✅
- [x] 导航栏调整
- [x] 创建实施计划文档

### 第2次会话 (建议)
1. 创建 `ProxySelector` 组件
2. 测试节点选择和自动测延迟功能

### 第3次会话 (建议)
1. 创建 `CentralConnectionButton` 组件
2. 创建 `ModeSwitcher` 组件

### 第4次会话 (建议)
1. 精简现有组件 (UserInfoCard, NetworkDetection, IntranetIP)
2. 测试各组件独立功能

### 第5次会话 (建议)
1. 重构 `dashboard.dart` 主文件
2. 组装所有组件
3. 整体测试和调优

---

## 技术注意事项

### 1. 状态管理
- 使用 Riverpod Provider 获取所有状态
- 避免直接调用 globalState, 优先使用 ref.watch/read

### 2. 自动测延迟
```dart
// 伪代码
Future<void> _startDelayTest() async {
  for (var proxy in proxies) {
    final delay = await testDelay(proxy);
    // 更新UI显示延迟
  }
}
```

### 3. 动画优化
- 使用 `AnimatedContainer` 实现平滑过渡
- `FadeTransition` 用于状态切换
- 避免过度动画影响性能

### 4. 响应式设计
```dart
final isMobile = MediaQuery.of(context).size.width < 600;
// 根据屏幕宽度调整布局
```

---

## 依赖组件清单

### Provider 依赖
- `groupsProvider` - 获取节点组
- `coreStatusProvider` - 核心连接状态
- `modeProvider` - 当前模式
- `currentProfileProvider` - 当前配置
- `appController` - 应用控制器

### 工具方法
- `testDelay(proxy)` - 测试节点延迟
- `changeProxy(group, proxy)` - 切换节点
- `updateMode(mode)` - 更新模式

---

## 预期效果

完成后，仪表盘将呈现：
1. ✨ 简洁现代的单页布局
2. 🎯 核心功能一目了然
3. 📱 移动和桌面自适应
4. ⚡ 快速节点切换 + 自动测速
5. 🎨 符合Material Design 3规范

---

## 备注

- 本计划可根据实际开发情况调整
- 每个阶段完成后建议进行测试
- 遇到问题可随时回到此文档查阅
- 建议使用Git分支开发，方便回滚
