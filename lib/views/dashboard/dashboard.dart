import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/central_connection_button.dart';
import 'widgets/network_detection.dart';
import 'widgets/outbound_mode.dart';
import 'widgets/proxy_selector.dart';
import 'widgets/user_info_card.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: appLocalizations.dashboard,
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16).copyWith(bottom: 88),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const UserInfoCard(),
            const SizedBox(height: 16),
            const ProxySelector(),
            const SizedBox(height: 16),
            const NetworkDetection(),
            const SizedBox(height: 48),
            const Center(child: CentralConnectionButton()),
            const SizedBox(height: 48),
            const OutboundMode(),
          ],
        ),
      ),
    );
  }
}
