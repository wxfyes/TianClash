import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:lottie/lottie.dart';

class CentralConnectionButton extends ConsumerStatefulWidget {
  const CentralConnectionButton({super.key});

  @override
  ConsumerState<CentralConnectionButton> createState() =>
      _CentralConnectionButtonState();
}

class _CentralConnectionButtonState
    extends ConsumerState<CentralConnectionButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _handleConnection(
      BuildContext context, WidgetRef ref, CoreStatus displayStatus) async {
    if (displayStatus == CoreStatus.connecting) {
      return;
    }

    final isConnected = displayStatus == CoreStatus.connected;
    globalState.appController.updateStatus(!isConnected);
  }

  @override
  Widget build(BuildContext context) {
    final coreStatus = ref.watch(coreStatusProvider);
    final runTime = ref.watch(runTimeProvider);

    CoreStatus displayStatus;
    if (coreStatus == CoreStatus.connecting) {
      displayStatus = CoreStatus.connecting;
    } else if (runTime != null) {
      displayStatus = CoreStatus.connected;
    } else {
      displayStatus = CoreStatus.disconnected;
    }

    // 根据状态控制动画
    // 注意：这里假设 Lottie 动画是一个开关动画，0.0 是关闭，1.0 是开启
    // 如果是循环动画，可以根据需要调整逻辑
    if (displayStatus == CoreStatus.connecting) {
      if (!_controller.isAnimating) {
        _controller.repeat();
      }
    } else if (displayStatus == CoreStatus.connected) {
      _controller.animateTo(1.0);
    } else {
      _controller.animateTo(0.0);
    }

    return Center(
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: () => _handleConnection(context, ref, displayStatus),
          customBorder: const CircleBorder(),
          child: Lottie.asset(
            'assets/images/connect.json',
            width: 180,
            height: 180,
            controller: _controller,
            errorBuilder: (context, error, stackTrace) {
              return _buildOriginalButton(displayStatus, context);
            },
          ),
        ),
      ),
    );
  }

  Widget _buildOriginalButton(CoreStatus displayStatus, BuildContext context) {
    return Ink(
      width: 120,
      height: 120,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: _getGradient(displayStatus, context),
        boxShadow: [
          BoxShadow(
            color: _getShadowColor(displayStatus, context),
            blurRadius: 20,
            spreadRadius: 2,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildIcon(displayStatus, context),
          const SizedBox(height: 8),
          Text(
            _getStatusText(displayStatus),
            style: context.textTheme.titleMedium?.copyWith(
              color: _getTextColor(displayStatus, context),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildIcon(CoreStatus status, BuildContext context) {
    switch (status) {
      case CoreStatus.connecting:
        return SizedBox(
          width: 48,
          height: 48,
          child: CircularProgressIndicator(
            strokeWidth: 4,
            valueColor: AlwaysStoppedAnimation<Color>(
              _getTextColor(status, context),
            ),
          ),
        );
      case CoreStatus.connected:
        return Icon(
          Icons.power_settings_new,
          size: 48,
          color: _getTextColor(status, context),
        );
      case CoreStatus.disconnected:
        return Icon(
          Icons.power_settings_new,
          size: 48,
          color: _getTextColor(status, context),
        );
    }
  }

  Gradient _getGradient(CoreStatus status, BuildContext context) {
    switch (status) {
      case CoreStatus.connecting:
        return LinearGradient(
          colors: [
            context.colorScheme.primary.withValues(alpha: 0.8),
            context.colorScheme.primaryContainer,
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case CoreStatus.connected:
        return const LinearGradient(
          colors: [
            Color(0xFF4CAF50),
            Color(0xFF81C784),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
      case CoreStatus.disconnected:
        return LinearGradient(
          colors: [
            context.colorScheme.errorContainer,
            context.colorScheme.error.withValues(alpha: 0.6),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        );
    }
  }

  Color _getShadowColor(CoreStatus status, BuildContext context) {
    switch (status) {
      case CoreStatus.connecting:
        return context.colorScheme.primary.withValues(alpha: 0.4);
      case CoreStatus.connected:
        return const Color(0xFF4CAF50).withValues(alpha: 0.4);
      case CoreStatus.disconnected:
        return context.colorScheme.error.withValues(alpha: 0.3);
    }
  }

  Color _getTextColor(CoreStatus status, BuildContext context) {
    switch (status) {
      case CoreStatus.connecting:
      case CoreStatus.connected:
        return Colors.white;
      case CoreStatus.disconnected:
        return context.colorScheme.onErrorContainer;
    }
  }

  String _getStatusText(CoreStatus status) {
    switch (status) {
      case CoreStatus.connecting:
        return appLocalizations.connecting;
      case CoreStatus.connected:
        return appLocalizations.connected;
      case CoreStatus.disconnected:
        return appLocalizations.disconnected;
    }
  }
}
