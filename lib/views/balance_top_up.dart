import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:fl_clash/views/payment_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class BalanceTopUpPage extends ConsumerStatefulWidget {
  const BalanceTopUpPage({super.key});

  @override
  ConsumerState<BalanceTopUpPage> createState() => _BalanceTopUpPageState();
}

class _BalanceTopUpPageState extends ConsumerState<BalanceTopUpPage> {
  final _v2boardService = V2BoardService();
  double _balance = 0;
  bool _loading = false;
  bool _submitting = false;
  
  // Preset amounts
  final List<int> _presetAmounts = [50, 100, 200, 300, 400, 500, 600, 800];
  int? _selectedAmount;
  final TextEditingController _customAmountController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadBalance();
    });
    _customAmountController.addListener(() {
      if (_customAmountController.text.isNotEmpty) {
        setState(() {
          _selectedAmount = null;
        });
      }
    });
  }

  @override
  void dispose() {
    _customAmountController.dispose();
    super.dispose();
  }

  Future<void> _loadBalance() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final userInfo = await _v2boardService.getUserInfo(baseUrl, currentProfile.jwt!);
      if (userInfo != null && mounted) {
        setState(() {
          _balance = (userInfo['balance'] ?? 0) / 100.0;
        });
      }
    } catch (e) {
      if (mounted) context.showNotifier('${appLocalizations.error}: $e');
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _submitDeposit() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    int? amount;
    if (_selectedAmount != null) {
      amount = _selectedAmount! * 100; // Convert to cents
    } else {
      final custom = double.tryParse(_customAmountController.text);
      if (custom != null && custom > 0) {
        amount = (custom * 100).toInt();
      }
    }

    if (amount == null || amount <= 0) {
      context.showNotifier('请输入有效的充值金额');
      return;
    }

    setState(() {
      _submitting = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      
      final tradeNo = await _v2boardService.submitDepositOrder(baseUrl, currentProfile.jwt!, amount);
      
      if (tradeNo != null && mounted) {
        // Navigate to PaymentPage
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => PaymentPage(tradeNo: tradeNo),
          ),
        );
      } else {
        if (mounted) context.showNotifier('创建订单失败');
      }
    } catch (e) {
      if (mounted) context.showNotifier(e.toString());
    } finally {
      if (mounted) {
        setState(() {
          _submitting = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '余额充值',
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  _buildWelcomeCard(),
                  const SizedBox(height: 16),
                  _buildBalanceCard(),
                  const SizedBox(height: 16),
                  _buildTopUpCard(),
                ],
              ),
            ),
    );
  }

  Widget _buildWelcomeCard() {
    return Card(
      elevation: 0,
      color: context.colorScheme.surfaceContainerHighest.withOpacity(0.5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('账户充值', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text(
              '在这里您可以轻松地为您的账户充值，选择预设金额或输入自定义金额进行充值。充值后的余额将立即到账并可用于购买我们的服务。',
              style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBalanceCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('账户余额', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                // Auto-renewal switch could go here if implemented
              ],
            ),
            const SizedBox(height: 24),
            Text(
              '¥${_balance.toStringAsFixed(2)}',
              style: context.textTheme.displayMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: context.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 8),
            Text('充值后的余额仅限消费', style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildTopUpCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('充值余额', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: context.colorScheme.primaryContainer.withOpacity(0.3),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(Icons.info_outline, size: 20, color: context.colorScheme.primary),
                  const SizedBox(width: 8),
                  Text('充值后的余额仅限消费，无法提现', style: context.textTheme.bodySmall),
                ],
              ),
            ),
            const SizedBox(height: 24),
            GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, // 4 columns as per screenshot
                childAspectRatio: 2.5,
                crossAxisSpacing: 12,
                mainAxisSpacing: 12,
              ),
              itemCount: _presetAmounts.length,
              itemBuilder: (context, index) {
                final amount = _presetAmounts[index];
                final isSelected = _selectedAmount == amount;
                return InkWell(
                  onTap: () {
                    setState(() {
                      _selectedAmount = amount;
                      _customAmountController.clear();
                    });
                  },
                  borderRadius: BorderRadius.circular(8),
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: isSelected ? context.colorScheme.primary : Colors.grey.withOpacity(0.3),
                        width: isSelected ? 2 : 1,
                      ),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? context.colorScheme.primaryContainer.withOpacity(0.3) : null,
                    ),
                    alignment: Alignment.center,
                    child: Text(
                      '¥$amount',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isSelected ? context.colorScheme.primary : null,
                      ),
                    ),
                  ),
                );
              },
            ),
            const SizedBox(height: 24),
            Text('自定义金额', style: context.textTheme.bodyMedium),
            const SizedBox(height: 8),
            TextField(
              controller: _customAmountController,
              keyboardType: const TextInputType.numberWithOptions(decimal: true),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}')),
              ],
              decoration: const InputDecoration(
                prefixText: '¥ ',
                hintText: '请输入充值金额',
                border: OutlineInputBorder(),
                contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              ),
            ),
            const SizedBox(height: 24),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                onPressed: _submitting ? null : _submitDeposit,
                icon: _submitting 
                  ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white))
                  : const Icon(Icons.shopping_cart),
                label: const Text('立即充值'),
                style: FilledButton.styleFrom(
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
