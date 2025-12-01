import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/payment_page.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderConfirmPage extends ConsumerStatefulWidget {
  final Plan plan;

  const OrderConfirmPage({super.key, required this.plan});

  @override
  ConsumerState<OrderConfirmPage> createState() => _OrderConfirmPageState();
}

class _OrderConfirmPageState extends ConsumerState<OrderConfirmPage> {
  String? _selectedPeriod;
  String _couponCode = '';
  bool _verifyingCoupon = false;
  Coupon? _appliedCoupon;
  bool _submitting = false;
  final _v2boardService = V2BoardService();

  final Map<String, String> _periodLabels = {
    'month_price': '月付',
    'quarter_price': '季付',
    'half_year_price': '半年付',
    'year_price': '年付',
    'two_year_price': '两年付',
    'three_year_price': '三年付',
    'onetime_price': '一次性',
    'reset_price': '重置流量包',
  };

  Map<String, int> get _availablePrices {
    final prices = <String, int>{};
    if (widget.plan.monthPrice != null) prices['month_price'] = widget.plan.monthPrice!;
    if (widget.plan.quarterPrice != null) prices['quarter_price'] = widget.plan.quarterPrice!;
    if (widget.plan.halfYearPrice != null) prices['half_year_price'] = widget.plan.halfYearPrice!;
    if (widget.plan.yearPrice != null) prices['year_price'] = widget.plan.yearPrice!;
    if (widget.plan.twoYearPrice != null) prices['two_year_price'] = widget.plan.twoYearPrice!;
    if (widget.plan.threeYearPrice != null) prices['three_year_price'] = widget.plan.threeYearPrice!;
    if (widget.plan.onetimePrice != null) prices['onetime_price'] = widget.plan.onetimePrice!;
    if (widget.plan.resetPrice != null) prices['reset_price'] = widget.plan.resetPrice!;
    return prices;
  }

  int get _originalPrice {
    if (_selectedPeriod == null) return 0;
    return _availablePrices[_selectedPeriod] ?? 0;
  }

  int get _discountAmount {
    if (_appliedCoupon == null) return 0;
    if (_appliedCoupon!.type == 1) {
      return _appliedCoupon!.value;
    } else if (_appliedCoupon!.type == 2) {
      return (_originalPrice * (_appliedCoupon!.value / 100)).round();
    }
    return 0;
  }

  int get _finalPrice {
    return (_originalPrice - _discountAmount).clamp(0, double.infinity).toInt();
  }

  Future<void> _verifyCoupon() async {
    if (_couponCode.isEmpty) return;
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _verifyingCoupon = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final result = await _v2boardService.verifyCoupon(
        baseUrl,
        currentProfile.jwt!,
        _couponCode,
        widget.plan.id,
      );

      if (result != null) {
        setState(() {
          _appliedCoupon = Coupon.fromJson(result['data']);
        });
        if (mounted) context.showNotifier('优惠券已使用');
      } else {
        if (mounted) context.showNotifier('无效的优惠券');
      }
    } catch (e) {
      if (mounted) context.showNotifier('验证优惠券失败');
    } finally {
      setState(() {
        _verifyingCoupon = false;
      });
    }
  }

  Future<void> _submitOrder() async {
    if (_selectedPeriod == null) return;
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _submitting = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      
      // Helper function to submit order
      Future<String?> submit() {
        return _v2boardService.submitOrder(
          baseUrl,
          currentProfile.jwt!,
          widget.plan.id,
          _selectedPeriod!,
          couponCode: _appliedCoupon?.code,
        );
      }

      var tradeNo = await submit();

      // If failed, check for pending orders and cancel them
      if (tradeNo == null) {
        final orders = await _v2boardService.fetchOrders(baseUrl, currentProfile.jwt!);
        if (orders != null) {
          final pendingOrders = orders.where((o) => o['status'] == 0).toList();
          if (pendingOrders.isNotEmpty) {
             for (var order in pendingOrders) {
               await _v2boardService.cancelOrder(baseUrl, currentProfile.jwt!, order['trade_no']);
             }
             // Retry submission
             tradeNo = await submit();
          }
        }
      }

      if (tradeNo != null) {
        if (mounted) {
           _showPaymentSheet(tradeNo);
        }
      } else {
        if (mounted) context.showNotifier('创建订单失败，请检查是否有未支付订单。');
      }
    } catch (e) {
      if (mounted) context.showNotifier('提交订单错误: $e');
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  void _showPaymentSheet(String tradeNo) {
    // 跳转到支付页面，传递trade_no
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PaymentPage(tradeNo: tradeNo),
      ),
    );
  }

  void _showQRCodeDialog(String qrData, String tradeNo) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('扫码支付'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            QrImageView(
              data: qrData,
              size: 280,
            ),
            const SizedBox(height: 16),
            const Text('请使用支付宝或微信扫码支付'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Close OrderConfirmPage
            },
            child: const Text('已完成支付'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '确认订单',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              widget.plan.name,
              style: context.textTheme.headlineMedium,
            ),
            const SizedBox(height: 24),
            Text(
              '选择周期',
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _availablePrices.entries.map((entry) {
                final isSelected = _selectedPeriod == entry.key;
                return ChoiceChip(
                  label: Text('${_periodLabels[entry.key] ?? entry.key} - ¥${(entry.value / 100).toStringAsFixed(2)}'),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedPeriod = selected ? entry.key : null;
                    });
                  },
                );
              }).toList(),
            ),
            const SizedBox(height: 24),
            Text(
              '优惠券',
              style: context.textTheme.titleMedium,
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: TextField(
                    decoration: const InputDecoration(
                      labelText: '请输入优惠券代码',
                      border: OutlineInputBorder(),
                    ),
                    onChanged: (value) {
                      _couponCode = value;
                    },
                    enabled: _appliedCoupon == null,
                  ),
                ),
                const SizedBox(width: 12),
                if (_appliedCoupon == null)
                  FilledButton(
                    onPressed: _verifyingCoupon ? null : _verifyCoupon,
                    child: _verifyingCoupon
                        ? const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Text('验证'),
                  )
                else
                  IconButton(
                    onPressed: () {
                      setState(() {
                        _appliedCoupon = null;
                        _couponCode = '';
                      });
                    },
                    icon: const Icon(Icons.close),
                  ),
              ],
            ),
            const SizedBox(height: 24),
            const Divider(),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('小计', style: context.textTheme.bodyLarge),
                Text('¥${(_originalPrice / 100).toStringAsFixed(2)}', style: context.textTheme.bodyLarge),
              ],
            ),
            if (_discountAmount > 0)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('优惠', style: context.textTheme.bodyLarge?.copyWith(color: Colors.green)),
                  Text('-¥${(_discountAmount / 100).toStringAsFixed(2)}', style: context.textTheme.bodyLarge?.copyWith(color: Colors.green)),
                ],
              ),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('总计', style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
                Text('¥${(_finalPrice / 100).toStringAsFixed(2)}', style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold, color: context.colorScheme.primary)),
              ],
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              child: FilledButton(
                onPressed: _selectedPeriod == null || _submitting ? null : _submitOrder,
                child: _submitting
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                      )
                    : const Text('提交订单'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
