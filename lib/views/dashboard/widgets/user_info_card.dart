import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

class UserInfoCard extends ConsumerStatefulWidget {
  const UserInfoCard({super.key});

  @override
  ConsumerState<UserInfoCard> createState() => _UserInfoCardState();
}

class _UserInfoCardState extends ConsumerState<UserInfoCard> {
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

  String _formatDate(int? timestamp) {
    if (timestamp == null || timestamp == 0) return '长期有效';
    final date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final currentProfile = ref.watch(currentProfileProvider);
    final subscriptionInfo = currentProfile?.subscriptionInfo;

    return SizedBox(
      height: getWidgetHeight(2),
      child: CommonCard(
        onPressed: _loading ? null : _loadUserInfo,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              CircleAvatar(
                radius: 20,
                backgroundImage: _userInfo?.avatarUrl != null
                    ? NetworkImage(_userInfo!.avatarUrl!)
                    : null,
                backgroundColor: context.colorScheme.surfaceContainerHighest,
                child: _userInfo?.avatarUrl == null
                    ? Icon(Icons.person,
                        size: 20,
                        color: context.colorScheme.onSurfaceVariant)
                    : null,
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      _userInfo?.email ??
                          currentProfile?.label ??
                          'Unknown',
                      style: context.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    if (_userInfo?.planId != null) ...[
                      const SizedBox(height: 2),
                      Text(
                        'Plan: ${_userInfo!.planId}',
                        style: context.textTheme.labelSmall?.copyWith(
                          color: context.colorScheme.primary,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ],
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  SizedBox(
                    height: 28,
                    child: FilledButton(
                      onPressed: (_baseUrl != null && _userInfo?.planId != null)
                          ? () {
                              _showRenewDialog();
                            }
                          : null,
                      style: FilledButton.styleFrom(
                        padding: const EdgeInsets.symmetric(horizontal: 12),
                        visualDensity: VisualDensity.compact,
                        textStyle: const TextStyle(fontSize: 12),
                      ),
                      child: const Text('续费'),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatDate(_userInfo?.expiredAt ??
                        subscriptionInfo?.expire),
                    style: context.textTheme.labelSmall?.copyWith(
                      color: context.colorScheme.onSurfaceVariant,
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _showRenewDialog() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || _userInfo?.planId == null || _baseUrl == null) return;

    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    try {
      final plansData = await _v2boardService.fetchPlans(_baseUrl!, currentProfile.jwt!);
      if (plansData == null) throw '无法获取套餐信息';

      final plans = plansData.map((e) => Plan.fromJson(e)).toList();
      final currentPlan = plans.firstWhere(
        (p) => p.id == _userInfo!.planId,
        orElse: () => throw '未找到当前套餐信息',
      );

      final periods = <String, int>{};
      if (currentPlan.monthPrice != null) periods['month_price'] = currentPlan.monthPrice!;
      if (currentPlan.quarterPrice != null) periods['quarter_price'] = currentPlan.quarterPrice!;
      if (currentPlan.halfYearPrice != null) periods['half_year_price'] = currentPlan.halfYearPrice!;
      if (currentPlan.yearPrice != null) periods['year_price'] = currentPlan.yearPrice!;
      if (currentPlan.twoYearPrice != null) periods['two_year_price'] = currentPlan.twoYearPrice!;
      if (currentPlan.threeYearPrice != null) periods['three_year_price'] = currentPlan.threeYearPrice!;

      if (periods.isEmpty) throw '当前套餐不可续费';

      if (!mounted) return;

      await showDialog(
        context: context,
        builder: (context) => SimpleDialog(
          title: Text('续费 ${currentPlan.name}'),
          children: periods.entries.map((entry) {
            final label = _getPeriodLabel(entry.key);
            final price = (entry.value / 100).toStringAsFixed(2);
            return SimpleDialogOption(
              onPressed: () {
                Navigator.pop(context);
                _processRenewal(entry.key, currentPlan.id);
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(label),
                    Text('¥$price', style: TextStyle(fontWeight: FontWeight.bold, color: context.colorScheme.primary)),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      );
    } catch (e) {
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

  String _getPeriodLabel(String key) {
    switch (key) {
      case 'month_price': return '月付';
      case 'quarter_price': return '季付';
      case 'half_year_price': return '半年付';
      case 'year_price': return '年付';
      case 'two_year_price': return '两年付';
      case 'three_year_price': return '三年付';
      default: return key;
    }
  }

  Future<void> _processRenewal(String period, int planId) async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || _baseUrl == null) return;

    if (mounted) {
      setState(() {
        _loading = true;
      });
    }

    try {
      final tradeNo = await _v2boardService.submitOrder(
        _baseUrl!,
        currentProfile.jwt!,
        planId,
        period,
      );

      if (tradeNo == null) throw '创建订单失败';

      final methodsData = await _v2boardService.getPaymentMethods(_baseUrl!, currentProfile.jwt!);
      if (methodsData == null || methodsData.isEmpty) throw '无可用支付方式';
      
      final methods = methodsData.map((e) => PaymentMethod.fromJson(e)).toList();

      if (!mounted) return;

      PaymentMethod? selectedMethod;
      if (methods.length == 1) {
        selectedMethod = methods.first;
      } else {
        selectedMethod = await showDialog<PaymentMethod>(
          context: context,
          builder: (context) => SimpleDialog(
            title: const Text('选择支付方式'),
            children: methods.map((m) => SimpleDialogOption(
              onPressed: () => Navigator.pop(context, m),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: Row(
                  children: [
                    if (m.icon != null) ...[
                      const Icon(Icons.payment, size: 20),
                      const SizedBox(width: 12),
                    ],
                    Text(m.name),
                  ],
                ),
              ),
            )).toList(),
          ),
        );
      }

      if (selectedMethod == null) return;

      final checkoutResult = await _v2boardService.checkoutOrder(
        _baseUrl!,
        currentProfile.jwt!,
        tradeNo,
        selectedMethod.id,
      );

      if (checkoutResult != null) {
         String? url;
         if (checkoutResult is String) {
           url = checkoutResult;
         } else if (checkoutResult is Map) {
           if (checkoutResult['data'] is String) {
             url = checkoutResult['data'];
           } else if (checkoutResult['url'] is String) {
             url = checkoutResult['url'];
           }
         }

         if (url != null) {
           _openPaymentUrl(url);
         } else {
           throw '无法获取支付链接，请尝试在网页端支付';
         }
      }

    } catch (e) {
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

  Future<void> _openPaymentUrl(String url) async {
    final res = await globalState.showMessage(
      message: TextSpan(text: url),
      title: '前往支付',
      confirmText: '前往',
    );
    if (res != true) {
      return;
    }
    launchUrl(Uri.parse(url));
  }
}
