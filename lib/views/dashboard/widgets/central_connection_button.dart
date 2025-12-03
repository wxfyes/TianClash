import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CentralConnectionButton extends ConsumerWidget {
  const CentralConnectionButton({super.key});

  Future<void> _handleConnection(
      BuildContext context, WidgetRef ref, CoreStatus displayStatus) async {
    if (displayStatus == CoreStatus.connecting) {
      return;
    }

    final isConnected = displayStatus == CoreStatus.connected;

    // 如果已连接，点击则断开；如果未连接，点击则连接
    globalState.appController.updateStatus(!isConnected);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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

    return Material(
      color: Colors.transparent,
      child: Ink(
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
        child: InkWell(
          onTap: () => _handleConnection(context, ref, displayStatus),
          customBorder: const CircleBorder(),
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
        ),
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
