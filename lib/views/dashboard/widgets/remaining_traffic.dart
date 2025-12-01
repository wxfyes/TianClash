import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RemainingTraffic extends ConsumerStatefulWidget {
  const RemainingTraffic({super.key});

  @override
  ConsumerState<RemainingTraffic> createState() => _RemainingTrafficState();
}

class _RemainingTrafficState extends ConsumerState<RemainingTraffic> {
  final _v2boardService = V2BoardService();
  bool _loading = false;

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
      // 1. Update Profile (Download latest config)
      await globalState.appController.updateProfile(currentProfile);
      
      // 2. Fetch traffic info (existing logic)
      SubscriptionInfo? info;
      if (currentProfile.jwt != null) {
        final uri = Uri.parse(currentProfile.url);
        final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
        final userInfoMap = await _v2boardService.getUserInfo(
            baseUrl, currentProfile.jwt!);
        if (userInfoMap != null) {
          final userInfo = UserInfo.fromJson(userInfoMap);
          if (userInfo.transferUsed > 0) {
             info = SubscriptionInfo(
              total: userInfo.transferEnable,
              upload: userInfo.transferUsed,
              download: 0,
              expire: userInfo.expiredAt ?? 0,
            );
          }
        }
      } 
      
      if (info == null && currentProfile.url.isNotEmpty) {
        final response =
            await request.getHeadResponseForUrl(currentProfile.url);
        if (response != null) {
          final userinfo = response.headers.value('subscription-userinfo');
          if (userinfo != null) {
            info = SubscriptionInfo.formHString(userinfo);
          }
        }
      }

      if (info != null && mounted) {
        ref.read(profilesProvider.notifier).updateProfile(
              currentProfile.id,
              (p) => p.copyWith(subscriptionInfo: info),
            );
      }
    } catch (e) {
      print('[RemainingTraffic] Error: $e');
      if (mounted) {
        context.showNotifier(e.toString());
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0.00 B';
    const suffixes = ['B', 'KB', 'MB', 'GB', 'TB'];
    var i = 0;
    double size = bytes.toDouble();
    while (size >= 1024 && i < suffixes.length - 1) {
      size /= 1024;
      i++;
    }
    return '${size.toStringAsFixed(2)} ${suffixes[i]}';
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = ref.watch(currentProfileProvider);
    final subscriptionInfo = currentProfile?.subscriptionInfo;

    final total = subscriptionInfo?.total ?? 0;
    final used =
        (subscriptionInfo?.upload ?? 0) + (subscriptionInfo?.download ?? 0);
    final remaining = total > used ? total - used : 0;
    final progress = total > 0 ? (remaining / total).clamp(0.0, 1.0) : 0.0;

    return SizedBox(
      height: getWidgetHeight(2),
      child: CommonCard(
        onPressed: _loading ? null : _loadUserInfo,
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  if (_loading)
                    const SizedBox(
                      width: 16,
                      height: 16,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  else
                    Icon(
                      Icons.data_usage,
                      size: 16,
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  const SizedBox(width: 8),
                  Text(
                    '剩余流量',
                    style: context.textTheme.titleSmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  _formatBytes(remaining),
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
              const SizedBox(height: 2),
              LinearProgressIndicator(
                value: progress,
                backgroundColor:
                    context.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(4),
                minHeight: 6,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
