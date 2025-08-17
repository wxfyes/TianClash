import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class TianqueView extends StatelessWidget {
  const TianqueView({super.key});

  Future<void> _launchTianqueWebsite() async {
    const url = 'https://www.tianque.cc';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '天阙',
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.web,
              size: 80,
              color: context.colorScheme.primary,
            ),
            const SizedBox(height: 24),
            Text(
              '天阙官网',
              style: context.textTheme.headlineMedium?.copyWith(
                color: context.colorScheme.onSurface,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              '点击下方按钮访问天阙官网',
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 32),
            ElevatedButton.icon(
              onPressed: _launchTianqueWebsite,
              icon: const Icon(Icons.open_in_new),
              label: const Text('访问官网'),
              style: ElevatedButton.styleFrom(
                padding: const EdgeInsets.symmetric(
                  horizontal: 24,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
