import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

class TrafficDetailsPage extends ConsumerStatefulWidget {
  const TrafficDetailsPage({super.key});

  @override
  ConsumerState<TrafficDetailsPage> createState() => _TrafficDetailsPageState();
}

class _TrafficDetailsPageState extends ConsumerState<TrafficDetailsPage> {
  final _v2boardService = V2BoardService();
  List<dynamic>? _trafficLog;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTrafficLog();
    });
  }

  Future<void> _loadTrafficLog() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final log = await _v2boardService.getTrafficLog(baseUrl, currentProfile.jwt!);
      print('Traffic Log Response: $log'); // Debug log
      if (log != null && log is List) {
        setState(() {
          _trafficLog = log;
          // Sort by record_at desc
          _trafficLog!.sort((a, b) => (b['record_at'] ?? 0).compareTo(a['record_at'] ?? 0));
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

  String _formatBytes(int bytes) {
    if (bytes <= 0) return '0 B';
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
    return CommonScaffold(
      title: appLocalizations.trafficDetails,
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _trafficLog == null || _trafficLog!.isEmpty
              ? Center(child: Text(appLocalizations.noData))
              : ListView.separated(
                  padding: const EdgeInsets.all(16),
                  itemCount: _trafficLog!.length,
                  separatorBuilder: (context, index) => const SizedBox(height: 12),
                  itemBuilder: (context, index) {
                    final item = _trafficLog![index];
                    final recordAt = item['record_at'] ?? 0;
                    final upload = item['u'] ?? 0;
                    final download = item['d'] ?? 0;
                    final total = upload + download;

                    return Card(
                      elevation: 2,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.fromMillisecondsSinceEpoch(recordAt * 1000)),
                              style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 12),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(appLocalizations.upload, style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                                    Text(_formatBytes(upload), style: context.textTheme.bodyLarge),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(appLocalizations.download, style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                                    Text(_formatBytes(download), style: context.textTheme.bodyLarge),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(appLocalizations.total, style: context.textTheme.bodySmall?.copyWith(color: Colors.grey)),
                                    Text(_formatBytes(total), style: context.textTheme.bodyLarge?.copyWith(color: context.colorScheme.primary)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
    );
  }
}
