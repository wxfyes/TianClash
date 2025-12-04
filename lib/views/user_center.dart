import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/order_list.dart';
import 'package:fl_clash/views/wallet.dart';
import 'package:fl_clash/views/traffic_details.dart';
import 'package:fl_clash/views/ticket_list.dart';
import 'package:fl_clash/views/invite.dart';
import 'package:fl_clash/views/balance_top_up.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/state.dart';
import 'package:intl/intl.dart';

class UserCenterPage extends ConsumerStatefulWidget {
  const UserCenterPage({super.key});

  @override
  ConsumerState<UserCenterPage> createState() => _UserCenterPageState();
}

class _UserCenterPageState extends ConsumerState<UserCenterPage> {
  final _v2boardService = V2BoardService();
  UserInfo? _userInfo;
  Map<String, dynamic>? _commConfig;
  List<Plan> _plans = [];
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
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl =
          '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final userInfoMap = await _v2boardService.getUserInfo(
        baseUrl,
        currentProfile.jwt!,
      );
      final commConfig = await _v2boardService.getCommConfig(baseUrl);
      final plansMap = await _v2boardService.fetchPlans(
        baseUrl,
        currentProfile.jwt!,
      );

      if (userInfoMap != null) {
        setState(() {
          _userInfo = UserInfo.fromJson(userInfoMap);
          _commConfig = commConfig;
          if (plansMap != null) {
            _plans = plansMap.map((e) => Plan.fromJson(e)).toList();
          }
        });
      }
    } catch (e) {
      if (mounted) {
        context.showNotifier('Failed to load user info: $e');
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

  String _formatDate(int? timestamp) {
    if (timestamp == null || timestamp <= 0) return '永久有效';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return DateFormat('yyyy-MM-dd').format(date);
  }

  String _getPlanName(int? planId) {
    if (planId == null) return 'Free Plan';
    final plan = _plans.firstWhere(
      (p) => p.id == planId,
      orElse: () => Plan(id: -1, name: 'Plan ID: $planId', content: ''),
    );
    return plan.name;
  }

  void _launchUrl(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      if (mounted) context.showNotifier('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.user,
      actions: [
        IconButton(
          onPressed: _loadUserInfo,
          icon: _loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.refresh),
        ),
      ],
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            _buildHeaderCard(context),
            const SizedBox(height: 16),
            _buildRenewButton(context),
            const SizedBox(height: 24),
            _buildMenuSection(context),
          ],
        ),
      ),
    );
  }

  Widget _buildHeaderCard(BuildContext context) {
    final currentProfile = ref.watch(currentProfileProvider);
    final subscriptionInfo = currentProfile?.subscriptionInfo;

    // Use max of _userInfo and subscriptionInfo to avoid 0 used traffic if API fails to update
    final apiTotal = _userInfo?.transferEnable ?? 0;
    final subTotal = subscriptionInfo?.total ?? 0;
    final total = apiTotal > 0 ? apiTotal : subTotal;

    final apiUsed = _userInfo?.transferUsed ?? 0;
    final subUsed =
        (subscriptionInfo?.upload ?? 0) + (subscriptionInfo?.download ?? 0);
    final used = apiUsed > subUsed ? apiUsed : subUsed;

    final progress = total > 0 ? (used / total).clamp(0.0, 1.0) : 0.0;
    final expiredAt = _userInfo?.expiredAt ?? subscriptionInfo?.expire;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 24,
                backgroundColor: context.colorScheme.primaryContainer,
                backgroundImage: _userInfo?.avatarUrl != null
                    ? NetworkImage(_userInfo!.avatarUrl!)
                    : null,
                child: _userInfo?.avatarUrl == null
                    ? Icon(Icons.person, color: context.colorScheme.primary)
                    : null,
              ),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _userInfo?.email ?? currentProfile?.label ?? 'Guest',
                      style: context.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 2,
                      ),
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        _getPlanName(_userInfo?.planId),
                        style: context.textTheme.bodySmall?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: context.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.calendar_today, size: 14),
                    const SizedBox(width: 4),
                    Text(
                      '到期时间\n${_formatDate(expiredAt)}',
                      textAlign: TextAlign.right,
                      style: context.textTheme.bodySmall,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Row(
            children: [
              Icon(
                Icons.data_usage,
                size: 16,
                color: context.colorScheme.primary,
              ),
              const SizedBox(width: 8),
              Text('已用流量', style: context.textTheme.bodyMedium),
              const Spacer(),
              Text(
                '${_formatBytes(used)} / ${_formatBytes(total)}',
                style: context.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          LinearProgressIndicator(
            value: progress,
            backgroundColor: context.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(4),
            minHeight: 8,
          ),
          const SizedBox(height: 8),
          Text(
            '已用流量将在5日后重置', // Placeholder logic
            style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
          ),
        ],
      ),
    );
  }

  Widget _buildRenewButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {
          globalState.appController.toPage(PageLabel.shop);
        },
        icon: const Icon(Icons.autorenew),
        label: const Text('续费套餐'),
        style: FilledButton.styleFrom(
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
      ),
    );
  }

  Widget _buildMenuSection(BuildContext context) {
    final currentProfile = ref.read(currentProfileProvider);
    final uri = currentProfile != null ? Uri.parse(currentProfile.url) : null;
    final baseUrl = uri != null
        ? '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}'
        : '';

    return Container(
      decoration: BoxDecoration(
        color: context.colorScheme.surfaceContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Icon(
                  Icons.headset_mic,
                  size: 20,
                  color: context.colorScheme.primary,
                ),
                const SizedBox(width: 8),
                Text(
                  '帮助与支持',
                  style: context.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          _buildMenuItem(
            context,
            icon: Icons.receipt_long,
            title: '订单记录',
            iconColor: Colors.blue.shade700,
            iconBackgroundColor: Colors.blue.shade50,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const OrderListPage()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.pie_chart_outline,
            title: '流量明细',
            iconColor: Colors.green.shade700,
            iconBackgroundColor: Colors.green.shade50,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const TrafficDetailsPage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.confirmation_number_outlined,
            title: '我的工单',
            iconColor: Colors.orange.shade700,
            iconBackgroundColor: Colors.orange.shade50,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const TicketListPage()),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.account_balance_wallet,
            title: '余额充值',
            iconColor: Colors.purple.shade700,
            iconBackgroundColor: Colors.purple.shade50,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(
                  builder: (context) => const BalanceTopUpPage(),
                ),
              );
            },
          ),
          _buildMenuItem(
            context,
            icon: Icons.language,
            title: '官方网站',
            iconColor: Colors.teal.shade700,
            iconBackgroundColor: Colors.teal.shade50,
            onTap: () {
              if (baseUrl.isNotEmpty) _launchUrl(baseUrl);
            },
          ),
          if (_commConfig != null &&
              _commConfig!['telegram_discuss_link'] != null)
            _buildMenuItem(
              context,
              icon: Icons.group_add,
              title: '加入群组',
              iconColor: Colors.cyan.shade700,
              iconBackgroundColor: Colors.cyan.shade50,
              onTap: () => _launchUrl(_commConfig!['telegram_discuss_link']),
            ),
          _buildMenuItem(
            context,
            icon: Icons.person_add_alt,
            title: '邀请管理',
            iconColor: Colors.pink.shade700,
            iconBackgroundColor: Colors.pink.shade50,
            onTap: () {
              Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => const InvitePage()),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildMenuItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Color? iconColor,
    Color? iconBackgroundColor,
  }) {
    // 如果没有指定颜色,使用默认灰色
    final bgColor = iconBackgroundColor ?? Colors.grey.withOpacity(0.1);
    final fgColor = iconColor ?? Colors.grey;

    return InkWell(
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: bgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 22, color: fgColor),
            ),
            const SizedBox(width: 16),
            Expanded(child: Text(title, style: context.textTheme.bodyLarge)),
            const Icon(Icons.chevron_right, color: Colors.grey),
          ],
        ),
      ),
    );
  }
}
