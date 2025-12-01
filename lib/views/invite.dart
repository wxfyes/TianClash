import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

class InvitePage extends ConsumerStatefulWidget {
  const InvitePage({super.key});

  @override
  ConsumerState<InvitePage> createState() => _InvitePageState();
}

class _InvitePageState extends ConsumerState<InvitePage> {
  final _v2boardService = V2BoardService();
  Map<String, dynamic>? _inviteData;
  Map<String, dynamic>? _inviteDetails;
  bool _loading = false;
  bool _generating = false;
  bool _transferring = false;
  bool _withdrawing = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadData();
    });
  }

  Future<void> _loadData() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      
      final inviteData = await _v2boardService.getInviteData(baseUrl, currentProfile.jwt!);
      final inviteDetails = await _v2boardService.getInviteDetails(baseUrl, currentProfile.jwt!);
      
      if (mounted) {
        setState(() {
          _inviteData = inviteData;
          _inviteDetails = inviteDetails;
        });
      }
    } catch (e) {
      print('Error loading invite data: $e');
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

  Future<void> _generateCode() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _generating = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final success = await _v2boardService.generateInviteCode(baseUrl, currentProfile.jwt!);
      if (success) {
        if (mounted) {
          context.showNotifier(appLocalizations.inviteCodeGenerated);
          _loadData();
        }
      } else {
        if (mounted) context.showNotifier(appLocalizations.failedToGenerateInviteCode);
      }
    } catch (e) {
      if (mounted) context.showNotifier('${appLocalizations.error}: $e');
    } finally {
      if (mounted) {
        setState(() {
          _generating = false;
        });
      }
    }
  }

  Future<void> _transferCommission(double amount) async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _transferring = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final success = await _v2boardService.transferCommission(baseUrl, currentProfile.jwt!, amount);
      if (success) {
        if (mounted) {
          context.showNotifier('划转成功');
          Navigator.pop(context);
          _loadData();
        }
      } else {
        if (mounted) context.showNotifier('划转失败');
      }
    } catch (e) {
      if (mounted) context.showNotifier('${appLocalizations.error}: $e');
    } finally {
      if (mounted) {
        setState(() {
          _transferring = false;
        });
      }
    }
  }

  Future<void> _withdrawCommission(double amount, String method, String account) async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _withdrawing = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final success = await _v2boardService.withdrawCommission(baseUrl, currentProfile.jwt!, amount, method, account);
      if (success) {
        if (mounted) {
          context.showNotifier('提现申请已提交');
          Navigator.pop(context);
          _loadData();
        }
      } else {
        if (mounted) context.showNotifier('提现申请失败');
      }
    } catch (e) {
      if (mounted) context.showNotifier('${appLocalizations.error}: $e');
    } finally {
      if (mounted) {
        setState(() {
          _withdrawing = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.inviteManagement,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _loadData,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildStatsGrid(),
                    const SizedBox(height: 24),
                    _buildRulesCard(),
                    const SizedBox(height: 24),
                    _buildBalanceCard(),
                    const SizedBox(height: 24),
                    _buildInviteLinkCard(),
                    const SizedBox(height: 24),
                    _buildRecordsCard(),
                  ],
                ),
              ),
            ),
    );
  }

  Widget _buildStatsGrid() {
    final stat = _inviteData?['stat'];
    // 兼容不同API返回格式
    final commissionRate = stat is Map ? (stat['commission_rate'] ?? stat['commissionRate'] ?? 0) : 0;
    final pending = stat is Map ? (stat['unpaid_commission'] ?? stat['pending'] ?? 0) : 0;
    final available = stat is Map ? (stat['commission_balance'] ?? stat['available'] ?? 0) : 0;
    // 注册用户数通常在details里或者stat里
    final userCount = _inviteDetails != null ? (_inviteDetails!['count'] ?? 0) : 0;

    return GridView.count(
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      childAspectRatio: 1.5,
      children: [
        _buildStatCard(Icons.people, userCount.toString(), '注册用户数'),
        _buildStatCard(Icons.pending_actions, '¥$pending', '待确认佣金'),
        _buildStatCard(Icons.account_balance_wallet, '¥$available', '可用佣金'),
        _buildStatCard(Icons.percent, '$commissionRate%', '佣金比例'),
      ],
    );
  }

  Widget _buildStatCard(IconData icon, String value, String label) {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32, color: context.colorScheme.primary),
            const SizedBox(height: 8),
            Text(value, style: context.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold)),
            Text(label, style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
          ],
        ),
      ),
    );
  }

  Widget _buildRulesCard() {
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('返佣规则', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 8),
            _buildRuleItem(Icons.share, '1. 分享', '分享您的邀请链接给好友'),
            _buildRuleItem(Icons.person_add, '2. 注册', '好友通过链接注册账号'),
            _buildRuleItem(Icons.shopping_cart, '3. 购买', '好友购买订阅套餐'),
            _buildRuleItem(Icons.monetization_on, '4. 返佣', '获得现金奖励'),
          ],
        ),
      ),
    );
  }

  Widget _buildRuleItem(IconData icon, String title, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: context.colorScheme.primaryContainer,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20, color: context.colorScheme.primary),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: context.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.bold)),
                Text(desc, style: context.textTheme.bodySmall),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBalanceCard() {
    final stat = _inviteData?['stat'];
    final available = stat is Map ? (stat['commission_balance'] ?? stat['available'] ?? 0) : 0;

    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('佣金余额', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('可用余额', style: context.textTheme.bodyMedium),
                    Text('¥$available', style: context.textTheme.headlineMedium?.copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.bold)),
                  ],
                ),
                Row(
                  children: [
                    FilledButton.icon(
                      onPressed: () => _showTransferDialog(available.toDouble()),
                      icon: const Icon(Icons.swap_horiz),
                      label: const Text('划转'),
                    ),
                    const SizedBox(width: 8),
                    OutlinedButton.icon(
                      onPressed: () => _showWithdrawDialog(available.toDouble()),
                      icon: const Icon(Icons.account_balance),
                      label: const Text('提现'),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTransferDialog(double maxAmount) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('划转到余额'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('将佣金划转到账户余额用于购买套餐'),
            const SizedBox(height: 16),
            TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: '划转金额',
                prefixText: '¥',
                helperText: '最大可划转: ¥$maxAmount',
                border: const OutlineInputBorder(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
          FilledButton(
            onPressed: () {
              final amount = double.tryParse(controller.text);
              if (amount != null && amount > 0 && amount <= maxAmount) {
                _transferCommission(amount);
              } else {
                context.showNotifier('请输入有效的金额');
              }
            },
            child: const Text('确认划转'),
          ),
        ],
      ),
    );
  }

  void _showWithdrawDialog(double maxAmount) {
    final amountController = TextEditingController();
    final accountController = TextEditingController();
    String method = 'alipay'; // 默认支付宝

    showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('申请提现'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                value: method,
                decoration: const InputDecoration(labelText: '提现方式', border: OutlineInputBorder()),
                items: const [
                  DropdownMenuItem(value: 'alipay', child: Text('支付宝')),
                  DropdownMenuItem(value: 'usdt', child: Text('USDT')),
                ],
                onChanged: (value) => setState(() => method = value!),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: accountController,
                decoration: const InputDecoration(
                  labelText: '提现账号',
                  border: OutlineInputBorder(),
                ),
              ),
              const SizedBox(height: 16),
              TextField(
                controller: amountController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: '提现金额',
                  prefixText: '¥',
                  helperText: '最大可提现: ¥$maxAmount',
                  border: const OutlineInputBorder(),
                ),
              ),
            ],
          ),
          actions: [
            TextButton(onPressed: () => Navigator.pop(context), child: const Text('取消')),
            FilledButton(
              onPressed: () {
                final amount = double.tryParse(amountController.text);
                if (amount != null && amount > 0 && amount <= maxAmount && accountController.text.isNotEmpty) {
                  _withdrawCommission(amount, method, accountController.text);
                } else {
                  context.showNotifier('请填写完整信息');
                }
              },
              child: const Text('确认提现'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInviteLinkCard() {
    final codes = _inviteData?['codes'] as List? ?? [];
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('邀请链接', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: _generating ? null : _generateCode,
                  icon: _generating 
                    ? const SizedBox(width: 16, height: 16, child: CircularProgressIndicator(strokeWidth: 2))
                    : const Icon(Icons.add),
                  tooltip: '生成新邀请码',
                ),
              ],
            ),
            const Divider(),
            if (codes.isEmpty)
              const Padding(
                padding: EdgeInsets.all(16),
                child: Center(child: Text('暂无邀请码，点击右上角生成')),
              )
            else ...[
              // 这里简化处理，只显示最新的一个邀请码，或者做一个简单的列表
              // 为了更好的体验，可以做一个PageView，但这里先用ListTile展示
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: codes.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final code = codes[index];
                  final codeStr = code['code'] ?? '';
                  
                  // 动态获取域名
                  final currentProfile = ref.read(currentProfileProvider);
                  String domain = 'https://example.com';
                  if (currentProfile != null) {
                    final uri = Uri.parse(currentProfile.url);
                    domain = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
                  }
                  
                  final inviteUrl = '$domain/#/register?code=$codeStr';
                  
                  return ListTile(
                    title: Text('邀请码: $codeStr', style: const TextStyle(fontWeight: FontWeight.bold)),
                    subtitle: Text(inviteUrl, maxLines: 1, overflow: TextOverflow.ellipsis),
                    trailing: IconButton(
                      icon: const Icon(Icons.copy),
                      onPressed: () {
                        Clipboard.setData(ClipboardData(text: inviteUrl));
                        context.showNotifier('链接已复制');
                      },
                    ),
                  );
                },
              ),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildRecordsCard() {
    // 假设 _inviteDetails 返回的是分页数据或列表
    // V2Board API通常返回 { data: [...], total: 100 } 或直接 [...]
    // 这里需要根据实际API响应调整
    final records = _inviteDetails?['data'] as List? ?? [];
    
    return Card(
      elevation: 2,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('返佣记录', style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold)),
            const Divider(),
            if (records.isEmpty)
              const Padding(
                padding: EdgeInsets.all(32),
                child: Center(child: Text('暂无记录')),
              )
            else
              ListView.separated(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: records.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, index) {
                  final record = records[index];
                  final amount = record['get_amount'] ?? 0;
                  final status = record['status'] ?? 0; // 0: 待确认, 1: 已到账
                  final time = DateTime.fromMillisecondsSinceEpoch((record['created_at'] ?? 0) * 1000);
                  
                  return ListTile(
                    leading: Icon(
                      status == 1 ? Icons.check_circle : Icons.schedule,
                      color: status == 1 ? Colors.green : Colors.orange,
                    ),
                    title: Text('返佣: ¥$amount'),
                    subtitle: Text(DateFormat('yyyy-MM-dd HH:mm').format(time)),
                    trailing: Text(
                      status == 1 ? '已到账' : '待确认',
                      style: TextStyle(
                        color: status == 1 ? Colors.green : Colors.orange,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
              ),
          ],
        ),
      ),
    );
  }
}
