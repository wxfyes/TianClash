import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
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
      SubscriptionInfo? info;
      if (currentProfile.jwt != null) {
        final uri = Uri.parse(currentProfile.url);
        final baseUrl = '${uri.scheme}://${uri.host}';
        print('[RemainingTraffic] Fetching user info from V2Board API: $baseUrl');
        final userInfoMap = await _v2boardService.getUserInfo(
            baseUrl, currentProfile.jwt!);
        if (userInfoMap != null) {
          print('[RemainingTraffic] User info fetched successfully: $userInfoMap');
          final userInfo = UserInfo.fromJson(userInfoMap);
          // Only use API info if it has valid used traffic, or if we haven't tried HEAD yet
          if (userInfo.transferUsed > 0) {
             info = SubscriptionInfo(
              total: userInfo.transferEnable,
              upload: userInfo.transferUsed,
              download: 0,
              expire: userInfo.expiredAt ?? 0,
            );
          } else {
             print('[RemainingTraffic] API returned 0 used traffic, will try HEAD request');
          }
        } else {
          print('[RemainingTraffic] User info is null');
        }
      } 
      
      // Always try HEAD request if info is null (or was rejected due to 0 used)
      if (info == null && currentProfile.url.isNotEmpty) {
        print('[RemainingTraffic] Fetching HEAD response for: ${currentProfile.url}');
        final response =
            await request.getHeadResponseForUrl(currentProfile.url);
        if (response != null) {
          final userinfo = response.headers.value('subscription-userinfo');
          print('[RemainingTraffic] HEAD response headers: ${response.headers}');
          print('[RemainingTraffic] subscription-userinfo: $userinfo');
          if (userinfo != null) {
            info = SubscriptionInfo.formHString(userinfo);
            print('[RemainingTraffic] Parsed SubscriptionInfo: $info');
          }
        } else {
           print('[RemainingTraffic] HEAD response is null');
        }
      }

      if (info != null && mounted) {
        print('[RemainingTraffic] Updating profile with new info');
        ref.read(profilesProvider.notifier).updateProfile(
              currentProfile.id,
              (p) => p.copyWith(subscriptionInfo: info),
            );
      } else {
        print('[RemainingTraffic] No info to update');
      }
    } catch (e) {
      print('[RemainingTraffic] Error: $e');
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
        info: Info(
          label: '剩余流量',
          iconData: Icons.data_usage,
        ),
        onPressed: _loadUserInfo,
        child: _loading && total == 0
            ? const Center(child: CircularProgressIndicator())
            : Padding(
                padding: const EdgeInsets.all(16).copyWith(top: 0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        _formatBytes(remaining),
                        style: context.textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                    const SizedBox(height: 8),
                    LinearProgressIndicator(
                      value: progress,
                      backgroundColor:
                          context.colorScheme.surfaceContainerHighest,
                      borderRadius: BorderRadius.circular(4),
                      minHeight: 8,
                    ),
                    const SizedBox(height: 4),
                    Text(
                      '总计: ${_formatBytes(total)}',
                      style: context.textTheme.bodySmall
                          ?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}
