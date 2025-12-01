import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentPage extends ConsumerStatefulWidget {
  final String tradeNo;

  const PaymentPage({super.key, required this.tradeNo});

  @override
  ConsumerState<PaymentPage> createState() => _PaymentPageState();
}

class _PaymentPageState extends ConsumerState<PaymentPage> {
  final _v2boardService = V2BoardService();
  
  Map<String, dynamic>? _orderDetail;
  List<dynamic>? _paymentMethods;
  int? _selectedMethodId;
  bool _loading = false;
  bool _processing = false;

  @override
  void initState() {
    super.initState();
    _loadPaymentData();
  }

  Future<void> _loadPaymentData() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';

      // 获取订单详情和支付方式
      final orders = await _v2boardService.fetchOrders(baseUrl, currentProfile.jwt!);
      final paymentMethods = await _v2boardService.getPaymentMethods(baseUrl, currentProfile.jwt!);

      if (orders != null) {
        _orderDetail = orders.firstWhere(
          (o) => o['trade_no'] == widget.tradeNo,
          orElse: () => null,
        );
      }

      _paymentMethods = paymentMethods;
      
      // 自动选择第一个支付方式
      if (_paymentMethods != null && _paymentMethods!.isNotEmpty) {
        _selectedMethodId = _paymentMethods![0]['id'] as int;
      }
    } catch (e) {
      print('Error loading payment data: $e');
      if (mounted) {
        context.showNotifier('加载失败: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _processPayment() async {
    if (_selectedMethodId == null) {
      context.showNotifier('请选择支付方式');
      return;
    }

    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _processing = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';

      // 调用checkout API
      final result = await _v2boardService.checkoutOrder(
        baseUrl,
        currentProfile.jwt!,
        widget.tradeNo,
        _selectedMethodId!,
      );

      if (result != null && mounted) {
        print('Checkout result: $result'); // Debug
        final type = result['type'];
        final data = result['data'];
        
        print('Payment type: $type, data: $data'); // Debug

        if (data != null) {
          // 先停止处理状态，避免按钮一直转圈
          setState(() {
            _processing = false;
          });
          
          if (type == 0) {
            // 显示二维码
            print('Showing QR code dialog'); // Debug
            _showQRCodeDialog(data.toString());
          } else if (type == 1) {
            // 显示支付链接和二维码（都在对话框中）
            print('Showing payment URL dialog: ${data.toString()}'); // Debug
            _showPaymentUrlDialog(data.toString());
          } else if (type == -1) {
            // 免费订单
            if (mounted) {
              context.showNotifier('支付成功');
              Navigator.pop(context);
            }
          }
          return; // 提前返回，避免执行finally中的setState
        }
      }
    } catch (e) {
      print('Checkout error: $e');
      if (mounted) {
        String errorMessage = '支付失败';
        if (e is DioException && e.response?.data != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData['message'] != null) {
              errorMessage = '支付失败: ${responseData['message']}';
            }
          } catch (_) {}
        }
        context.showNotifier(errorMessage);
      }
    } finally {
      if (mounted) {
        setState(() {
          _processing = false;
        });
      }
    }
  }

  void _showQRCodeDialog(String qrData) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('扫码支付'),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                qrData,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              const Text('请复制上方链接或在浏览器中打开'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          OutlinedButton(
            onPressed: () async {
              try {
                final url = Uri.parse(qrData);
                if (await canLaunchUrl(url)) {
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                print('Launch URL error: $e');
              }
            },
            child: const Text('打开支付链接'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // 只关闭对话框
              // 返回到之前的页面
              if (mounted) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            child: const Text('已完成支付'),
          ),
        ],
      ),
    );
  }

  void _showPaymentUrlDialog(String paymentUrl) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('完成支付'),
        content: SizedBox(
          width: 300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SelectableText(
                paymentUrl,
                style: const TextStyle(fontSize: 12),
              ),
              const SizedBox(height: 16),
              const Text('支付链接（可复制）'),
              const SizedBox(height: 8),
              const Text('点击下方按钮打开支付页面'),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('取消'),
          ),
          OutlinedButton(
            onPressed: () async {
              try {
                final url = Uri.parse(paymentUrl);
                if (await canLaunchUrl(url)) {
                  // 尝试直接唤醒（如果是alipays://或weixin://）
                  await launchUrl(url, mode: LaunchMode.externalApplication);
                }
              } catch (e) {
                print('Launch URL error: $e');
                if (mounted) {
                  context.showNotifier('无法打开链接: $e');
                }
              }
            },
            child: const Text('打开支付'),
          ),
          FilledButton(
            onPressed: () {
              Navigator.pop(context); // 只关闭对话框
              // 返回到主页面
              if (mounted) {
                Navigator.popUntil(context, (route) => route.isFirst);
              }
            },
            child: const Text('已完成支付'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('支付'),
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 订单信息
                  _buildOrderInfo(),
                  const SizedBox(height: 24),
                  // 支付方式
                  _buildPaymentMethods(),
                  const SizedBox(height: 24),
                  // 支付按钮
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton(
                      onPressed: _processing ? null : _processPayment,
                      child: _processing
                          ? const SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                            )
                          : const Text('去支付'),
                    ),
                  ),
                ],
              ),
            ),
    );
  }

  Widget _buildOrderInfo() {
    if (_orderDetail == null) return const SizedBox();

    final totalAmount = _orderDetail!['total_amount'] ?? 0;
    final planName = _orderDetail!['plan']?['name'] ?? '未知套餐';

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('订单信息', style: context.textTheme.titleMedium),
            const Divider(),
            _buildInfoRow('订单号', widget.tradeNo),
            _buildInfoRow('套餐名称', planName),
            _buildInfoRow('金额', '¥${(totalAmount / 100).toStringAsFixed(2)}', isAmount: true),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isAmount = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label, style: context.textTheme.bodyMedium),
          Text(
            value,
            style: isAmount
                ? context.textTheme.titleLarge?.copyWith(color: context.colorScheme.primary)
                : context.textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildPaymentMethods() {
    if (_paymentMethods == null || _paymentMethods!.isEmpty) {
      return const Card(
        child: Padding(
          padding: EdgeInsets.all(16),
          child: Text('没有可用的支付方式'),
        ),
      );
    }

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('支付方式', style: context.textTheme.titleMedium),
            const Divider(),
            ..._paymentMethods!.map((method) {
              final id = method['id'] as int;
              final name = method['name'] as String;
              
              return RadioListTile<int>(
                title: Text(name),
                value: id,
                groupValue: _selectedMethodId,
                onChanged: (value) {
                  setState(() {
                    _selectedMethodId = value;
                  });
                },
              );
            }),
          ],
        ),
      ),
    );
  }
}
