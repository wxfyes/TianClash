import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/views/ticket_detail.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TicketListPage extends ConsumerStatefulWidget {
  const TicketListPage({super.key});

  @override
  ConsumerState<TicketListPage> createState() => _TicketListPageState();
}

class _TicketListPageState extends ConsumerState<TicketListPage> {
  final _v2boardService = V2BoardService();
  List<dynamic> _tickets = [];
  bool _loading = false;
  final ImagePicker _picker = ImagePicker();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTickets();
    });
  }

  Future<void> _loadTickets() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}';
      final tickets = await _v2boardService.fetchTickets(baseUrl, currentProfile.jwt!);
      if (tickets != null) {
        setState(() {
          _tickets = tickets;
          // Sort by updated_at desc
          _tickets.sort((a, b) => b['updated_at'].compareTo(a['updated_at']));
        });
      }
    } catch (e) {
      if (mounted) {
        context.showNotifier('加载工单失败: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _createTicket() async {
    final subjectController = TextEditingController();
    final messageController = TextEditingController();
    String level = '2'; // Default: Medium
    List<XFile> selectedImages = [];
    bool uploading = false;

    await showDialog(
      context: context,
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => AlertDialog(
          title: const Text('新建工单'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: subjectController,
                  decoration: const InputDecoration(labelText: '主题'),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: level,
                  decoration: const InputDecoration(labelText: '等级'),
                  items: const [
                    DropdownMenuItem(value: '0', child: Text('低')),
                    DropdownMenuItem(value: '1', child: Text('中')),
                    DropdownMenuItem(value: '2', child: Text('高')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      level = value!;
                    });
                  },
                ),
                const SizedBox(height: 12),
                TextField(
                  controller: messageController,
                  decoration: const InputDecoration(labelText: '消息'),
                  maxLines: 3,
                ),
                const SizedBox(height: 12),
                // Image Picker UI
                Row(
                  children: [
                    IconButton(
                      onPressed: () async {
                        final List<XFile> images = await _picker.pickMultiImage();
                        if (images.isNotEmpty) {
                          setState(() {
                            selectedImages.addAll(images);
                          });
                        }
                      },
                      icon: const Icon(Icons.image),
                      tooltip: '添加图片',
                    ),
                    const Text('添加图片'),
                  ],
                ),
                if (selectedImages.isNotEmpty)
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: selectedImages.asMap().entries.map((entry) {
                      final index = entry.key;
                      final file = entry.value;
                      return Stack(
                        children: [
                          Image.file(
                            File(file.path),
                            width: 60,
                            height: 60,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedImages.removeAt(index);
                                });
                              },
                              child: Container(
                                color: Colors.black54,
                                child: const Icon(Icons.close, size: 16, color: Colors.white),
                              ),
                            ),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                if (uploading)
                  const Padding(
                    padding: EdgeInsets.only(top: 8.0),
                    child: LinearProgressIndicator(),
                  ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: uploading ? null : () => Navigator.pop(context),
              child: const Text('取消'),
            ),
            FilledButton(
              onPressed: uploading
                  ? null
                  : () async {
                      if (subjectController.text.isEmpty || messageController.text.isEmpty) {
                        return;
                      }
                      
                      setState(() {
                        uploading = true;
                      });

                      String finalMessage = messageController.text;

                      // Upload images
                      if (selectedImages.isNotEmpty) {
                        try {
                          for (var image in selectedImages) {
                            // Use ImageUploadService
                            // Note: User needs to configure API key in the service file for this to work
                            final url = await ImageUploadService().uploadImage(File(image.path));
                            if (url != null) {
                              finalMessage += '\n\n![image]($url)';
                            }
                          }
                        } catch (e) {
                          if (context.mounted) {
                             context.showNotifier('图片上传失败: $e');
                          }
                          setState(() {
                            uploading = false;
                          });
                          return;
                        }
                      }

                      final currentProfile = ref.read(currentProfileProvider);
                      if (currentProfile == null || currentProfile.jwt == null) {
                         setState(() {
                            uploading = false;
                          });
                        return;
                      }

                      final uri = Uri.parse(currentProfile.url);
                      final baseUrl = '${uri.scheme}://${uri.host}';
                      final success = await _v2boardService.createTicket(
                        baseUrl,
                        currentProfile.jwt!,
                        subjectController.text,
                        level,
                        finalMessage,
                      );

                      if (success) {
                        if (mounted) {
                          Navigator.pop(context);
                          context.showNotifier('工单已创建');
                          _loadTickets();
                        }
                      } else {
                        if (mounted) context.showNotifier('创建工单失败');
                        setState(() {
                            uploading = false;
                          });
                      }
                    },
              child: const Text('提交'),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '我的工单',
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 16.0),
          child: FilledButton.icon(
            onPressed: _createTicket,
            icon: const Icon(Icons.add, size: 18),
            label: const Text('新建工单'),
          ),
        ),
      ],
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : _tickets.isEmpty
              ? Center(child: Text(appLocalizations.noData))
              : RefreshIndicator(
                  onRefresh: _loadTickets,
                  child: ListView.separated(
                    padding: const EdgeInsets.all(16),
                    itemCount: _tickets.length,
                    separatorBuilder: (context, index) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      final ticket = _tickets[index];
                      final status = ticket['status']; // 0: Pending, 1: Answered, 2: Closed
                      Color statusColor = Colors.grey;
                      String statusText = '未知';
                      if (status == 0) {
                        statusColor = Colors.orange;
                        statusText = '待处理';
                      } else if (status == 1) {
                        statusColor = Colors.green;
                        statusText = '已回复';
                      } else if (status == 2) {
                        statusColor = Colors.grey;
                        statusText = '已关闭';
                      }

                      return Card(
                        elevation: 2,
                        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(12),
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => TicketDetailPage(ticketId: ticket['id'], subject: ticket['subject']),
                              ),
                            ).then((_) => _loadTickets());
                          },
                          child: Padding(
                            padding: const EdgeInsets.all(16),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Expanded(
                                      child: Text(
                                        ticket['subject'] ?? '无主题',
                                        style: context.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                                        overflow: TextOverflow.ellipsis,
                                      ),
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
                                  '最后更新: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(ticket['updated_at'] * 1000))}',
                                  style: context.textTheme.bodySmall?.copyWith(color: Colors.grey),
                                ),
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
    );
  }
}
