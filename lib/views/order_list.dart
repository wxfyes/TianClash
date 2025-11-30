import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/models/v2board.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class OrderListPage extends ConsumerStatefulWidget {
  const OrderListPage({super.key});

  @override
  ConsumerState<OrderListPage> createState() => _OrderListPageState();
}

class _OrderListPageState extends ConsumerState<OrderListPage> {
  final _v2boardService = V2BoardService();
  List<Order> _orders = [];
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadOrders();
    });
  }

  Future<void> _loadOrders() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}';
      final ordersData = await _v2boardService.fetchOrders(baseUrl, currentProfile.jwt!);
      if (ordersData != null) {
        setState(() {
          _orders = ordersData.map((e) => Order.fromJson(e)).toList();
          // Sort by created_at desc
          _orders.sort((a, b) => b.createdAt.compareTo(a.createdAt));
        });
      }
    } catch (e) {
      if (mounted) {
        context.showNotifier('${appLocalizations.error}: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _cancelOrder(String tradeNo) async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}';
      final success = await _v2boardService.cancelOrder(baseUrl, currentProfile.jwt!, tradeNo);
      if (success) {
        if (mounted) {
          context.showNotifier(appLocalizations.success);
          _loadOrders();
        }
      } else {
        if (mounted) {
          context.showNotifier(appLocalizations.error);
        }
      }
    } catch (e) {
      if (mounted) {
        context.showNotifier('${appLocalizations.error}: $e');
      }
    }
  }

  Future<void> _openPaymentInBrowser(String tradeNo) async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null) return;

    try {
      final uri = Uri.parse(currentProfile.url);
      final paymentUrl = '${uri.scheme}://${uri.host}/#/order/${tradeNo}';
      final url = Uri.parse(paymentUrl);
      
      if (await canLaunchUrl(url)) {
        await launchUrl(url, mode: LaunchMode.externalApplication);
      } else {
        if (mounted) {
          context.showNotifier('${appLocalizations.error}: 无法打开支付页面');
        }
      }
    } catch (e) {
      print('Error opening payment page: $e');
      if (mounted) {
        context.showNotifier('${appLocalizations.error}: $e');
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.myOrders,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _orders.isEmpty
              ? Center(child: Text(appLocalizations.noData))
              : RefreshIndicator(
                  onRefresh: _loadOrders,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _orders.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final order = _orders[index];
                      return _buildOrderCard(order);
                    },
                  ),
                ),
    );
  }

  Widget _buildOrderCard(Order order) {
    final statusColor = _getStatusColor(order.status);
    final statusText = _getStatusText(order.status);

    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '${appLocalizations.orders} #${order.tradeNo}',
                  style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold),
                ),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: statusColor.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    statusText,
                    style: TextStyle(color: statusColor, fontSize: 12),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              '${appLocalizations.amount}: ${(order.totalAmount / 100).toStringAsFixed(2)} CNY',
              style: context.textTheme.bodyLarge,
            ),
            const SizedBox(height: 4),
            Text(
              '${appLocalizations.creationTime}: ${DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(order.createdAt * 1000))}',
              style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
            if (order.status == 0) ...[
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => _cancelOrder(order.tradeNo),
                    child: Text(appLocalizations.cancelOrder, style: const TextStyle(color: Colors.red)),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        isScrollControlled: true,
                        backgroundColor: Colors.transparent,
                        builder: (context) => PaymentSheet(
                          tradeNo: order.tradeNo,
                          totalAmount: order.totalAmount.toDouble(),
                          onPaymentSuccess: () {
                            _loadOrders();
                          },
                        ),
                      );
                    },
                    child: Text(appLocalizations.pay),
                  ),
                ],
              ),
            ],
          ],
        ),
      ),
    );
  }

  Color _getStatusColor(int status) {
    switch (status) {
      case 0: // Pending
        return Colors.orange;
      case 1: // Paid / Active
        return Colors.green;
      case 2: // Cancelled
        return Colors.grey;
      case 3: // Completed
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  String _getStatusText(int status) {
    switch (status) {
      case 0:
        return appLocalizations.pending;
      case 1:
        return appLocalizations.completed; // Or Active
      case 2:
        return appLocalizations.cancelled;
      case 3:
        return appLocalizations.completed;
      default:
        return appLocalizations.unknown;
    }
  }
}
