import 'dart:async';

import 'package:dio/dio.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:url_launcher/url_launcher.dart';

class PaymentSheet extends ConsumerStatefulWidget {
  final String tradeNo;
  final double totalAmount;
  final VoidCallback? onPaymentSuccess;

  const PaymentSheet({
    super.key,
    required this.tradeNo,
    required this.totalAmount,
    this.onPaymentSuccess,
  });

  @override
  ConsumerState<PaymentSheet> createState() => _PaymentSheetState();
}

class _PaymentSheetState extends ConsumerState<PaymentSheet> {
  final _v2boardService = V2BoardService();
  List<PaymentMethod> _paymentMethods = [];
  PaymentMethod? _selectedPaymentMethod;
  bool _loadingMethods = false;
  bool _processing = false;
  Timer? _pollTimer;

  @override
  void initState() {
    super.initState();
    _fetchPaymentMethods();
  }

  @override
  void dispose() {
    _pollTimer?.cancel();
    super.dispose();
  }

  Future<void> _fetchPaymentMethods() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loadingMethods = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}';
      final methodsData = await _v2boardService.getPaymentMethods(baseUrl, currentProfile.jwt!);
      
      if (methodsData != null && mounted) {
        setState(() {
          _paymentMethods = methodsData.map((e) => PaymentMethod.fromJson(e)).toList();
          if (_paymentMethods.length == 1) {
            _selectedPaymentMethod = _paymentMethods.first;
          }
        });
      }
    } catch (e) {
      print('Error loading payment methods: $e');
      if (mounted) context.showNotifier('${appLocalizations.error}: 无法加载支付方式');
    } finally {
      if (mounted) {
        setState(() {
          _loadingMethods = false;
        });
      }
    }
  }

  Future<void> _checkout() async {
    if (_selectedPaymentMethod == null) return;
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _processing = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}';
      
      final result = await _v2boardService.checkoutOrder(
        baseUrl,
        currentProfile.jwt!,
        widget.tradeNo,
        _selectedPaymentMethod!.id,
      );

      if (result != null && mounted) {
        String? paymentUrl;
        if (result is String) {
           paymentUrl = result;
        } else if (result is Map) {
           paymentUrl = result['data'] ?? result['url'] ?? result['qrcode'] ?? result['pay_url'];
        } else if (result == true) {
           if (mounted) {
              context.showNotifier(appLocalizations.paymentSuccessful);
              widget.onPaymentSuccess?.call();
              Navigator.pop(context);
              return;
           }
        }

        if (paymentUrl != null) {
          _showPaymentDialog(paymentUrl);
        } else {
           if (mounted) {
             if (result is String && result.isNotEmpty) {
                _showPaymentDialog(result);
             } else {
                context.showNotifier('${appLocalizations.unknownCheckoutResponse}: $result');
             }
           }
        }
      } else if (mounted) {
        context.showNotifier('${appLocalizations.error}: checkout返回空结果');
      }
    } catch (e) {
      print('Checkout error: $e');
      if (mounted) {
        String errorMessage = appLocalizations.checkoutFailed;
        if (e is DioException && e.response?.data != null) {
          try {
            final responseData = e.response!.data;
            if (responseData is Map && responseData['message'] != null) {
              errorMessage = '支付失败: ${responseData['message']}';
            } else if (e.toString().contains('500')) {
              errorMessage = '支付失败: 服务器错误，请联系客服或稍后重试';
            }
          } catch (_) {
            errorMessage = '支付失败: 服务器错误';
          }
        } else if (e.toString().contains('DioException')) {
          errorMessage = '${appLocalizations.error}: 网络请求失败';
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

  void _showPaymentDialog(String url) {
    showDialog(
      context: context,
      barrierDismissible: false,
      builder: (context) => AlertDialog(
        title: Text(appLocalizations.scanToPay),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: 200,
              height: 200,
              child: QrImageView(
                data: url,
                version: QrVersions.auto,
                size: 200.0,
              ),
            ),
            const SizedBox(height: 16),
            Text(appLocalizations.pleaseScanQrCode),
            const SizedBox(height: 8),
            const CircularProgressIndicator(),
            const SizedBox(height: 8),
            Text(appLocalizations.waitingForPayment, style: const TextStyle(fontSize: 12, color: Colors.grey)),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
              },
              child: Text(appLocalizations.openInBrowser),
            ),
            const SizedBox(height: 8),
            TextButton(
              onPressed: () {
                 launchUrl(Uri.parse(url));
              },
              child: Text(appLocalizations.payNowDeepLink),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () {
              _pollTimer?.cancel();
              Navigator.pop(context);
            },
            child: Text(appLocalizations.cancel),
          ),
        ],
      ),
    );
    _startPolling();
  }

  void _startPolling() {
    _pollTimer?.cancel();
    _pollTimer = Timer.periodic(const Duration(seconds: 3), (timer) async {
      final currentProfile = ref.read(currentProfileProvider);
      if (currentProfile == null || currentProfile.jwt == null) return;
      
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}';
      
      final orders = await _v2boardService.fetchOrders(baseUrl, currentProfile.jwt!);
      if (orders != null) {
        final order = orders.firstWhere(
          (o) => o['trade_no'] == widget.tradeNo,
          orElse: () => null,
        );
        
        if (order != null) {
          final status = order['status'];
          if (status == 1 || status == 3) {
            timer.cancel();
            if (mounted) {
              Navigator.pop(context); // Close dialog
              context.showNotifier(appLocalizations.paymentSuccessful);
              widget.onPaymentSuccess?.call();
              Navigator.pop(context); // Close sheet
            }
          } else if (status == 2) {
            timer.cancel();
            if (mounted) {
              Navigator.pop(context); // Close dialog
              context.showNotifier(appLocalizations.orderCancelled);
            }
          }
        }
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(appLocalizations.paymentMethod, style: context.textTheme.titleLarge),
          const SizedBox(height: 16),
          if (_loadingMethods)
            const Center(child: CircularProgressIndicator())
          else if (_paymentMethods.isEmpty)
            Text(appLocalizations.noData)
          else
            Column(
              children: _paymentMethods.map((method) {
                return RadioListTile<PaymentMethod>(
                  title: Text(method.name),
                  value: method,
                  groupValue: _selectedPaymentMethod,
                  onChanged: (value) {
                    setState(() {
                      _selectedPaymentMethod = value;
                    });
                  },
                );
              }).toList(),
            ),
          const SizedBox(height: 24),
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: _selectedPaymentMethod == null || _processing ? null : _checkout,
              child: _processing
                  ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : Text('${appLocalizations.pay} ¥${(widget.totalAmount / 100).toStringAsFixed(2)}'),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}
