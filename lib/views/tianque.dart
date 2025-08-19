import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:math' as math;

class TianqueView extends StatefulWidget {
  const TianqueView({super.key});

  @override
  State<TianqueView> createState() => _TianqueViewState();
}

class _TianqueViewState extends State<TianqueView>
    with TickerProviderStateMixin {
  late AnimationController _colorController;
  late AnimationController _gradientController;
  late Animation<double> _colorAnimation;
  late Animation<double> _gradientAnimation;

  @override
  void initState() {
    super.initState();
    _colorController = AnimationController(
      duration: const Duration(seconds: 3),
      vsync: this,
    )..repeat();
    
    _gradientController = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat();

    _colorAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _colorController,
      curve: Curves.easeInOut,
    ));

    _gradientAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(
      parent: _gradientController,
      curve: Curves.easeInOut,
    ));
  }

  @override
  void dispose() {
    _colorController.dispose();
    _gradientController.dispose();
    super.dispose();
  }

  Future<void> _launchTianqueWebsite() async {
    const url = 'https://www.tianque.cc';
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Color _getAnimatedColor(double value) {
    return Color.lerp(
      const Color(0xFF667eea),
      const Color(0xFF764ba2),
      value,
    )!;
  }

  @override
  Widget build(BuildContext context) {
    return CommonScaffold(
      title: '天阙',
      body: AnimatedBuilder(
        animation: Listenable.merge([_colorController, _gradientController]),
        builder: (context, child) {
          return Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Color.lerp(
                    const Color(0xFF667eea),
                    const Color(0xFF764ba2),
                    _gradientAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFFf093fb),
                    const Color(0xFFf5576c),
                    _gradientAnimation.value,
                  )!,
                  Color.lerp(
                    const Color(0xFF4facfe),
                    const Color(0xFF00f2fe),
                    _gradientAnimation.value,
                  )!,
                ],
                stops: const [0.0, 0.5, 1.0],
              ),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // 动态彩色图标
                  AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (context, child) {
                      return Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              _getAnimatedColor(_colorAnimation.value),
                              _getAnimatedColor(_colorAnimation.value).withOpacity(0.3),
                            ],
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: _getAnimatedColor(_colorAnimation.value).withOpacity(0.3),
                              blurRadius: 20,
                              spreadRadius: 5,
                            ),
                          ],
                        ),
                        child: Icon(
                          Icons.language,
                          size: 80,
                          color: Colors.white,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 32),
                  // 动态彩色标题
                  AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (context, child) {
                      return ShaderMask(
                        shaderCallback: (bounds) => LinearGradient(
                          colors: [
                            _getAnimatedColor(_colorAnimation.value),
                            Color.lerp(
                              const Color(0xFFf093fb),
                              const Color(0xFFf5576c),
                              _colorAnimation.value,
                            )!,
                          ],
                        ).createShader(bounds),
                        child: Text(
                          '天阙官网',
                          style: context.textTheme.headlineMedium?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 32,
                          ),
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 16),
                  // 描述文字
                  Text(
                    '点击下方按钮访问天阙官网',
                    style: context.textTheme.bodyLarge?.copyWith(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 40),
                  // 动态彩色按钮
                  AnimatedBuilder(
                    animation: _colorAnimation,
                    builder: (context, child) {
                      return Container(
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [
                              _getAnimatedColor(_colorAnimation.value),
                              Color.lerp(
                                const Color(0xFFf093fb),
                                const Color(0xFFf5576c),
                                _colorAnimation.value,
                              )!,
                            ],
                          ),
                          borderRadius: BorderRadius.circular(30),
                          boxShadow: [
                            BoxShadow(
                              color: _getAnimatedColor(_colorAnimation.value).withOpacity(0.4),
                              blurRadius: 15,
                              spreadRadius: 2,
                            ),
                          ],
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            onTap: _launchTianqueWebsite,
                            borderRadius: BorderRadius.circular(30),
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 32,
                                vertical: 16,
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.open_in_new,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                  const SizedBox(width: 8),
                                  Text(
                                    '访问官网',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    },
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
