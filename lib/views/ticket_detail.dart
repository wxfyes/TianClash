import 'dart:io';

import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

class TicketDetailPage extends ConsumerStatefulWidget {
  final int ticketId;
  final String subject;

  const TicketDetailPage({super.key, required this.ticketId, required this.subject});

  @override
  ConsumerState<TicketDetailPage> createState() => _TicketDetailPageState();
}

class _TicketDetailPageState extends ConsumerState<TicketDetailPage> {
  final _v2boardService = V2BoardService();
  List<dynamic> _messages = [];
  bool _loading = false;
  final _replyController = TextEditingController();
  bool _sending = false;
  final ImagePicker _picker = ImagePicker();
  List<XFile> _selectedImages = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadTicketDetail();
    });
  }

  Future<void> _loadTicketDetail() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _loading = true;
    });

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final details = await _v2boardService.getTicketDetail(baseUrl, currentProfile.jwt!, widget.ticketId);
      if (details != null) {
        if (details is List) {
          setState(() {
            _messages = details;
          });
        } else if (details is Map && details['message'] is List) {
          setState(() {
            _messages = details['message'];
            // Optionally update status if needed
            // if (details['status'] != null) _status = details['status'];
          });
        }
      }
    } catch (e) {
      if (mounted) {
        context.showNotifier('加载工单详情失败: $e');
      }
    } finally {
      if (mounted) {
        setState(() {
          _loading = false;
        });
      }
    }
  }

  Future<void> _reply() async {
    if (_replyController.text.isEmpty && _selectedImages.isEmpty) return;
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    setState(() {
      _sending = true;
    });

    String finalMessage = _replyController.text;

    // Upload images
    if (_selectedImages.isNotEmpty) {
      try {
        for (var image in _selectedImages) {
          final url = await ImageUploadService().uploadImage(File(image.path));
          if (url != null) {
            finalMessage += '\n\n![image]($url)';
          }
        }
      } catch (e) {
        if (mounted) context.showNotifier('图片上传失败: $e');
        setState(() {
          _sending = false;
        });
        return;
      }
    }

    if (finalMessage.isEmpty) {
        setState(() {
          _sending = false;
        });
        return;
    }

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final success = await _v2boardService.replyTicket(
        baseUrl,
        currentProfile.jwt!,
        widget.ticketId,
        finalMessage,
      );

      if (success) {
        _replyController.clear();
        setState(() {
          _selectedImages.clear();
        });
        if (mounted) {
          context.showNotifier('回复已发送');
          _loadTicketDetail();
        }
      } else {
        if (mounted) context.showNotifier('发送回复失败');
      }
    } catch (e) {
      if (mounted) context.showNotifier('回复出错: $e');
    } finally {
      if (mounted) {
        setState(() {
          _sending = false;
        });
      }
    }
  }

  Future<void> _closeTicket() async {
    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null || currentProfile.jwt == null) return;

    // Add confirmation dialog
    final confirm = await showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('关闭工单'),
          content: const Text('确定要关闭这个工单吗？'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(false),
              child: const Text('取消'),
            ),
            TextButton(
              onPressed: () => Navigator.of(context).pop(true),
              child: const Text('确定'),
            ),
          ],
        );
      },
    );

    if (confirm != true) return;

    try {
      final uri = Uri.parse(currentProfile.url);
      final baseUrl = '${uri.scheme}://${uri.host}${uri.hasPort ? ':${uri.port}' : ''}';
      final success = await _v2boardService.closeTicket(baseUrl, currentProfile.jwt!, widget.ticketId);

      if (success) {
        if (mounted) {
          context.showNotifier('工单已关闭');
          Navigator.pop(context);
        }
      } else {
        if (mounted) context.showNotifier('关闭工单失败');
      }
    } catch (e) {
      if (mounted) context.showNotifier('关闭工单出错: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: widget.subject,
      actions: [
        IconButton(
          onPressed: _closeTicket,
          icon: const Icon(Icons.close),
          tooltip: '关闭工单',
        ),
      ],
      body: Column(
        children: [
          Expanded(
            child: _loading
                ? const Center(child: CircularProgressIndicator())
                : ListView.builder(
                    padding: const EdgeInsets.all(16),
                    itemCount: _messages.length,
                    itemBuilder: (context, index) {
                      final message = _messages[index];
                      final isMe = message['is_me'] == true;
                      
                      return Align(
                        alignment: isMe ? Alignment.centerRight : Alignment.centerLeft,
                        child: Container(
                          margin: const EdgeInsets.symmetric(vertical: 8),
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: isMe ? context.colorScheme.primaryContainer : context.colorScheme.surfaceContainerHighest,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          constraints: BoxConstraints(maxWidth: MediaQuery.of(context).size.width * 0.8),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                message['message'] ?? '',
                                style: context.textTheme.bodyMedium,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                DateFormat('MM-dd HH:mm').format(DateTime.fromMillisecondsSinceEpoch(message['created_at'] * 1000)),
                                style: context.textTheme.labelSmall?.copyWith(color: Colors.grey),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
          if (_selectedImages.isNotEmpty)
            Container(
              height: 80,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: _selectedImages.length,
                separatorBuilder: (context, index) => const SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return Stack(
                    children: [
                      Image.file(
                        File(_selectedImages[index].path),
                        width: 80,
                        height: 80,
                        fit: BoxFit.cover,
                      ),
                      Positioned(
                        right: 0,
                        top: 0,
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedImages.removeAt(index);
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
                },
              ),
            ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                IconButton(
                  onPressed: () async {
                    final List<XFile> images = await _picker.pickMultiImage();
                    if (images.isNotEmpty) {
                      setState(() {
                        _selectedImages.addAll(images);
                      });
                    }
                  },
                  icon: const Icon(Icons.image),
                  tooltip: '添加图片',
                ),
                Expanded(
                  child: TextField(
                    controller: _replyController,
                    decoration: const InputDecoration(
                      hintText: '输入回复...',
                      border: OutlineInputBorder(),
                    ),
                    minLines: 1,
                    maxLines: 3,
                  ),
                ),
                const SizedBox(width: 8),
                IconButton.filled(
                  onPressed: _sending ? null : _reply,
                  icon: _sending
                      ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(color: Colors.white, strokeWidth: 2))
                      : const Icon(Icons.send),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
