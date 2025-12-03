import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class MobileDashboardView extends ConsumerStatefulWidget {
  const MobileDashboardView({super.key});

  @override
  ConsumerState<MobileDashboardView> createState() => _MobileDashboardViewState();
}

class _MobileDashboardViewState extends ConsumerState<MobileDashboardView> {
  final _v2boardService = V2BoardService();
  bool _loading = false;
  UserInfo? _userInfo;
  String? _baseUrl;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserInfo();
    });
  }

  Future<void> _loadUserInfo() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null) return;

    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    try {
      await globalState.appController.updateProfile(currentProfile);

      if (currentProfile.jwt != null) {
        final uri = Uri.parse(currentProfile.url);
        final baseUrl =
            '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
        if (mounted) {
          setState(() {
            _baseUrl = baseUrl;
          });
        }
        final userInfoMap =
            await _v2boardService.getUserInfo(baseUrl, currentProfile.jwt!);
        if (userInfoMap != null) {
          if (mounted) {
            setState(() {
              _userInfo = UserInfo.fromJson(userInfoMap);
            });
          }
        }
      }
    } catch (e) {
      // Silent failure for dashboard
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0.00 GB';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }

  String _formatDate(int? timestamp) {
    if (timestamp == null || timestamp == 0) return '长期有效';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = ref.watch(currentProfileProvider);
    final subscriptionInfo = currentProfile?.subscriptionInfo;
    final coreStatus = ref.watch(coreStatusProvider);

    final total = subscriptionInfo?.total ?? 0;
    final used = (subscriptionInfo?.upload ?? 0) + (subscriptionInfo?.download ?? 0);
    final remaining = total > used ? total - used : 0;

    return Scaffold(
      appBar: AppBar(
        title: Text(appLocalizations.dashboard),
        centerTitle: false,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: _loadUserInfo,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // User Info Card
            Container(
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest.withOpacity(0.5),
                borderRadius: BorderRadius.circular(16),
              ),
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // User & Expiry
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.person, size: 16, color: context.colorScheme.onSurfaceVariant),
                          const SizedBox(width: 8),
                          Text(
                            _userInfo?.email ?? currentProfile?.label ?? 'Unknown',
                            style: context.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: context.colorScheme.surfaceContainerHigh,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          _formatDate(_userInfo?.expiredAt ?? subscriptionInfo?.expire),
                          style: context.textTheme.labelSmall,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),
                  // Plan & Traffic
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.verified, size: 16, color: context.colorScheme.primary),
                          const SizedBox(width: 8),
                          Text(
                            _userInfo?.planId != null ? 'Plan: ${_userInfo!.planId}' : 'Standard Plan',
                            style: context.textTheme.bodySmall,
                          ),
                        ],
                      ),
                      Text(
                        '${_formatBytes(used)} / ${_formatBytes(total)}',
                        style: context.textTheme.bodySmall,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  // Reset Info
                  Row(
                    children: [
                      Icon(Icons.schedule, size: 14, color: context.colorScheme.onSurfaceVariant),
                      const SizedBox(width: 8),
                      Text(
                        '0 天后重置', // Placeholder as logic for reset day is complex
                        style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant),
                      ),
                    ],
                  ),
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 12),
                    child: Divider(height: 1),
                  ),
                  // Actions
                  _buildActionTile(
                    context,
                    icon: Icons.language,
                    title: '节点选择',
                    subtitle: '自动选择',
                    onTap: () {
                      globalState.appController.toPage(PageLabel.proxies);
                    },
                  ),
                  const SizedBox(height: 8),
                  _buildActionTile(
                    context,
                    icon: Icons.speed,
                    title: '网络检测',
                    trailing: IconButton(
                      icon: const Icon(Icons.refresh, size: 18),
                      onPressed: () {
                        // Trigger speed test logic
                        globalState.appController.updateGroupsDebounce();
                      },
                    ),
                    onTap: () {},
                  ),
                ],
              ),
            ),
            
            const SizedBox(height: 48),

            // Big Switch Button
            GestureDetector(
              onTap: () {
                globalState.appController.restartCore();
              },
              child: Container(
                width: 160,
                height: 160,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: coreStatus == CoreStatus.connected
                      ? context.colorScheme.primaryContainer
                      : context.colorScheme.surfaceContainerHighest,
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.1),
                      blurRadius: 20,
                      offset: const Offset(0, 10),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.power_settings_new,
                      size: 64,
                      color: coreStatus == CoreStatus.connected
                          ? context.colorScheme.primary
                          : context.colorScheme.onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),
            Text(
              coreStatus == CoreStatus.connected ? '已连接' : '未连接',
              style: context.textTheme.titleLarge,
            ),
            Text(
              coreStatus == CoreStatus.connected ? '点击停止连接' : '点击开始连接',
              style: context.textTheme.bodyMedium?.copyWith(color: context.colorScheme.onSurfaceVariant),
            ),

            const SizedBox(height: 48),

            // Mode Switch
            Container(
              padding: const EdgeInsets.all(4),
              decoration: BoxDecoration(
                color: context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(24),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  _buildModeButton(context, '智能', Mode.rule),
                  _buildModeButton(context, '全局', Mode.global),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildActionTile(BuildContext context, {
    required IconData icon,
    required String title,
    String? subtitle,
    Widget? trailing,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 4),
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: context.colorScheme.surface,
                borderRadius: BorderRadius.circular(8),
              ),
              child: Icon(icon, size: 20, color: context.colorScheme.primary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: context.textTheme.bodyMedium),
                  if (subtitle != null)
                    Text(subtitle, style: context.textTheme.labelSmall?.copyWith(color: context.colorScheme.onSurfaceVariant)),
                ],
              ),
            ),
            if (trailing != null) trailing else const Icon(Icons.chevron_right, size: 20, color: Colors.grey),
          ],
        ),
      ),
    );
  }

  Widget _buildModeButton(BuildContext context, String label, Mode mode) {
    final currentMode = ref.watch(patchClashConfigProvider.select((value) => value.mode));
    final isSelected = currentMode == mode;

    return GestureDetector(
      onTap: () {
        globalState.appController.changeMode(mode);
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
        decoration: BoxDecoration(
          color: isSelected ? context.colorScheme.primary : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: isSelected ? context.colorScheme.onPrimary : context.colorScheme.onSurfaceVariant,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
