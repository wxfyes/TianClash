import 'dart:math' as math;
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/enum/enum.dart';
import 'package:fl_clash/models/models.dart';
import 'package:fl_clash/providers/providers.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CentralConnectionButton extends ConsumerStatefulWidget {
  const CentralConnectionButton({super.key});

  @override
  ConsumerState<CentralConnectionButton> createState() =>
      _CentralConnectionButtonState();
}

class _CentralConnectionButtonState extends ConsumerState<CentralConnectionButton>
    with TickerProviderStateMixin {
  late AnimationController _rippleController;
  late AnimationController _rotateController;
  late AnimationController _scaleController;

  @override
  void initState() {
    super.initState();
    _rippleController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _rotateController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    )..repeat();

    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
      lowerBound: 0.95,
      upperBound: 1.0,
    );
  }

  @override
  void dispose() {
    _rippleController.dispose();
    _rotateController.dispose();
    _scaleController.dispose();
    super.dispose();
  }

  void _handleConnection(
      BuildContext context, WidgetRef ref, CoreStatus status) async {
    _scaleController.forward().then((_) => _scaleController.reverse());

    final currentProfile = ref.read(currentProfileProvider);
    if (currentProfile == null) {
      globalState.showMessage(
        title: appLocalizations.tip,
        message: const TextSpan(text: '请先选择或者创建一个配置'),
      );
      return;
    }

    if (status == CoreStatus.connected) {
      globalState.appController.stopSystemProxy();
    } else {
      globalState.appController.startSystemProxy();
    }
  }

  String _getStatusText(CoreStatus status) {
    switch (status) {
      case CoreStatus.connected:
        return '已连接';
      case CoreStatus.connecting:
        return '连接中...';
      default:
        return '点击连接';
    }
  }

  Color _getStatusColor(CoreStatus status, BuildContext context) {
    switch (status) {
      case CoreStatus.connected:
        return const Color(0xFF4CAF50); // Green
      case CoreStatus.connecting:
        return const Color(0xFFFF9800); // Orange
      default:
        return context.colorScheme.primary; // Blue
    }
  }

  List<Color> _getGradientColors(CoreStatus status, BuildContext context) {
    switch (status) {
      case CoreStatus.connected:
        return [
          const Color(0xFF43A047),
          const Color(0xFF66BB6A),
        ];
      case CoreStatus.connecting:
        return [
          const Color(0xFFF57C00),
          const Color(0xFFFFB74D),
        ];
      default:
        return [
          context.colorScheme.primary,
          context.colorScheme.primary.withOpacity(0.8),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final status = ref.watch(coreStatusProvider).value ?? CoreStatus.disconnected;
    final isConnected = status == CoreStatus.connected;
    final isConnecting = status == CoreStatus.connecting;

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        GestureDetector(
          onTap: () => _handleConnection(context, ref, status),
          onTapDown: (_) => _scaleController.reverse(),
          onTapUp: (_) => _scaleController.forward(),
          onTapCancel: () => _scaleController.forward(),
          child: ScaleTransition(
            scale: _scaleController,
            child: SizedBox(
              width: 200,
              height: 200,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  // Ripples for connected state
                  if (isConnected)
                    ...List.generate(3, (index) {
                      return AnimatedBuilder(
                        animation: _rippleController,
                        builder: (context, child) {
                          final value = (_rippleController.value + index * 0.33) % 1.0;
                          return Opacity(
                            opacity: (1 - value) * 0.5,
                            child: Transform.scale(
                              scale: 1.0 + (value * 0.5),
                              child: Container(
                                width: 140,
                                height: 140,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: _getStatusColor(status, context)
                                      .withOpacity(0.3),
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    }),

                  // Rotating border for connecting state
                  if (isConnecting)
                    AnimatedBuilder(
                      animation: _rotateController,
                      builder: (context, child) {
                        return Transform.rotate(
                          angle: _rotateController.value * 2 * math.pi,
                          child: Container(
                            width: 150,
                            height: 150,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: SweepGradient(
                                colors: [
                                  Colors.transparent,
                                  _getStatusColor(status, context),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.5, 1.0],
                              ),
                            ),
                          ),
                        );
                      },
                    ),

                  // Main Button
                  Container(
                    width: 140,
                    height: 140,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: isConnected || isConnecting
                            ? _getGradientColors(status, context)
                            : [
                                context.colorScheme.surfaceContainerHighest,
                                context.colorScheme.surface,
                              ],
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: (isConnected || isConnecting
                                  ? _getStatusColor(status, context)
                                  : Colors.black)
                              .withOpacity(0.3),
                          blurRadius: 20,
                          offset: const Offset(0, 10),
                        ),
                        if (!isConnected && !isConnecting)
                          const BoxShadow(
                            color: Colors.white,
                            blurRadius: 20,
                            offset: Offset(-5, -5),
                            blurStyle: BlurStyle.inner,
                          ),
                      ],
                    ),
                    child: Center(
                      child: Icon(
                        Icons.power_settings_new_rounded,
                        size: 64,
                        color: isConnected || isConnecting
                            ? Colors.white
                            : context.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 16),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _getStatusText(status),
            key: ValueKey(status),
            style: context.textTheme.titleMedium?.copyWith(
              color: isConnected || isConnecting
                  ? _getStatusColor(status, context)
                  : context.colorScheme.onSurfaceVariant,
              fontWeight: FontWeight.bold,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ],
    );
  }
}
