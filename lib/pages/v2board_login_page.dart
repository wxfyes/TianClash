import 'dart:io';
import 'package:dio/dio.dart';
import 'package:dio/io.dart';
import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/state.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'package:fl_clash/l10n/l10n.dart';
import 'home.dart';

// TODO: Replace with actual OSS URL
const String kOssConfigUrl = 'https://oss.tianque.cc/oss_config.txt';
const List<String> kBackupUrls = [
  'https://154.219.96.225:8443',
  'https://154.219.96.225:2621',
  'https://150.241.207.176:8443',
];
const String kFallbackUrl = 'https://150.241.207.176:8443';

enum LoginMode { login, register, forgotPassword }

class V2BoardLoginPage extends StatefulWidget {
  const V2BoardLoginPage({super.key});

  @override
  State<V2BoardLoginPage> createState() => _V2BoardLoginPageState();
}

class _V2BoardLoginPageState extends State<V2BoardLoginPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _verifyCodeController = TextEditingController();
  final _inviteCodeController = TextEditingController();
  
  bool _loading = false;
  bool _rememberMe = false;
  bool _autoLogin = false;
  LoginMode _loginMode = LoginMode.login;

  Future<String> _fetchBaseUrl() async {
    // Try OSS Config first
    try {
      final dio = Dio();
      print('Fetching OSS config from: $kOssConfigUrl');
      final response = await dio.get(
        kOssConfigUrl,
        options: Options(
          responseType: ResponseType.plain,
          sendTimeout: const Duration(seconds: 5),
          receiveTimeout: const Duration(seconds: 5),
        ),
      );

      print('OSS Config Response: ${response.statusCode}');
      if (response.statusCode == 200 &&
          response.data != null &&
          response.data.toString().isNotEmpty) {
        
        print('OSS Config Content: ${response.data}');
        final lines = response.data.toString()
            .split(RegExp(r'\r?\n'))
            .map((e) => e.trim())
            .where((e) => e.isNotEmpty && e.startsWith('http'))
            .toList();

        if (lines.isNotEmpty) {
          for (final url in lines) {
            if (await _checkUrlAvailability(url)) {
              print('Found available URL from OSS: $url');
              return url;
            }
          }
        }
      }
    } catch (e) {
      debugPrint('Failed to fetch OSS URL: $e');
    }

    // Try Backup URLs if OSS fails
    print('OSS fetch failed or no valid URLs. Trying backup URLs...');
    for (final url in kBackupUrls) {
      if (await _checkUrlAvailability(url)) {
        print('Found available backup URL: $url');
        return url;
      }
    }

    return kFallbackUrl;
  }

  Future<bool> _checkUrlAvailability(String baseUrl) async {
    try {
      final dio = Dio();
      (dio.httpClientAdapter as IOHttpClientAdapter).createHttpClient = () {
        final client = HttpClient();
        client.badCertificateCallback = (X509Certificate cert, String host, int port) => true;
        return client;
      };
      
      print('Checking availability for: $baseUrl');
      // Try to fetch comm config as a health check
      final response = await dio.get(
        '$baseUrl/api/v1/guest/comm/config',
        options: Options(
          sendTimeout: const Duration(seconds: 3),
          receiveTimeout: const Duration(seconds: 3),
        ),
      );
      print('Response for $baseUrl: ${response.statusCode}');
      return response.statusCode == 200;
    } catch (e) {
      print('Error checking $baseUrl: $e');
      return false;
    }
  }

  Future<void> _sendVerifyCode() async {
    if (_emailController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).enterEmail)),
      );
      return;
    }

    setState(() {
      _loading = true;
    });

    final baseUrl = await _fetchBaseUrl();
    final service = V2BoardService();
    final success = await service.sendEmailVerify(baseUrl, _emailController.text);

    setState(() {
      _loading = false;
    });

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(success ? '验证码已发送' : '发送失败'),
        ),
      );
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    final baseUrl = await _fetchBaseUrl();
    final service = V2BoardService();

    if (_loginMode == LoginMode.login) {
      final result = await service.loginAndGetSubscribeUrl(
        baseUrl,
        _emailController.text,
        _passwordController.text,
      );
      _handleLoginResult(result);
    } else if (_loginMode == LoginMode.register) {
      final result = await service.register(
        baseUrl,
        _emailController.text,
        _passwordController.text,
        _verifyCodeController.text,
        inviteCode: _inviteCodeController.text,
      );
      _handleLoginResult(result);
    } else if (_loginMode == LoginMode.forgotPassword) {
      final success = await service.forgetPassword(
        baseUrl,
        _emailController.text,
        _passwordController.text,
        _verifyCodeController.text,
      );
      setState(() {
        _loading = false;
      });
      if (success && mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('密码重置成功，请登录')),
        );
        setState(() {
          _loginMode = LoginMode.login;
        });
      } else if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('操作失败')),
        );
      }
    }
  }

  Future<void> _handleLoginResult(({String token, String url})? result) async {
    setState(() {
      _loading = false;
    });

    if (result != null && mounted) {
      await globalState.appController
          .addProfileFormURL(result.url, jwt: result.token);
      if (mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const HomePage()),
        );
      }
    } else if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(AppLocalizations.of(context).loginFailed)),
      );
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Row(
        children: [
          // ... (keep left side)
          Expanded(
            flex: 1,
            child: Container(
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Color(0xFF1a237e), // Deep Blue
                    Color(0xFF000000), // Black
                  ],
                ),
              ),
              child: Stack(
                children: [
                  Positioned(
                    bottom: 40,
                    left: 40,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Text(
                          'OpenClash',
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 48,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Text(
                          '安全高效的网络管理工具',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.8),
                            fontSize: 24,
                          ),
                        ),
                        const SizedBox(height: 40),
                        Text(
                          '© 2025 OpenClash. 保留所有权利。',
                          style: TextStyle(
                            color: Colors.white.withOpacity(0.6),
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          // Right Side - Form
          Expanded(
            flex: 1,
            child: Center(
              child: SingleChildScrollView(
                child: Container(
                  constraints: const BoxConstraints(maxWidth: 400),
                  padding: const EdgeInsets.all(40),
                  child: Form(
                    key: _formKey,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          _loginMode == LoginMode.login
                              ? '登录'
                              : _loginMode == LoginMode.register
                                  ? '注册账号'
                                  : '找回密码',
                          style: const TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1565C0),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          _loginMode == LoginMode.login
                              ? '欢迎回来，请登录您的账号'
                              : _loginMode == LoginMode.register
                                  ? '创建一个新账号'
                                  : '重置您的密码',
                          style: const TextStyle(
                            color: Colors.grey,
                            fontSize: 16,
                          ),
                        ),
                        const SizedBox(height: 40),
                        const Text('邮箱', style: TextStyle(fontWeight: FontWeight.bold)),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _emailController,
                          decoration: const InputDecoration(
                            hintText: '请输入邮箱',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.email_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).enterEmail;
                            }
                            return null;
                          },
                        ),
                        const SizedBox(height: 24),
                        if (_loginMode != LoginMode.login) ...[
                          const Text('验证码', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Expanded(
                                child: TextFormField(
                                  controller: _verifyCodeController,
                                  decoration: const InputDecoration(
                                    hintText: '请输入验证码',
                                    border: OutlineInputBorder(),
                                    prefixIcon: Icon(Icons.verified_user_outlined),
                                  ),
                                  validator: (value) {
                                    if (value == null || value.isEmpty) {
                                      return '请输入验证码';
                                    }
                                    return null;
                                  },
                                ),
                              ),
                              const SizedBox(width: 16),
                              OutlinedButton(
                                onPressed: _loading ? null : _sendVerifyCode,
                                style: OutlinedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
                                ),
                                child: const Text('发送'),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                        ],
                        Text(
                          _loginMode == LoginMode.forgotPassword ? '新密码' : '密码',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        const SizedBox(height: 8),
                        TextFormField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: _loginMode == LoginMode.forgotPassword ? '请输入新密码' : '请输入密码',
                            border: const OutlineInputBorder(),
                            prefixIcon: const Icon(Icons.lock_outline),
                            suffixIcon: const Icon(Icons.visibility_outlined),
                          ),
                          validator: (value) {
                            if (value == null || value.isEmpty) {
                              return AppLocalizations.of(context).enterPassword;
                            }
                            return null;
                          },
                        ),
                        if (_loginMode == LoginMode.register) ...[
                          const SizedBox(height: 24),
                          const Text('确认密码', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _confirmPasswordController,
                            obscureText: true,
                            decoration: const InputDecoration(
                              hintText: '请再次输入密码',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.lock_outline),
                              suffixIcon: Icon(Icons.visibility_outlined),
                            ),
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return '请确认密码';
                              }
                              if (value != _passwordController.text) {
                                return '两次输入的密码不一致';
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 24),
                          const Text('邀请码 (可选)', style: TextStyle(fontWeight: FontWeight.bold)),
                          const SizedBox(height: 8),
                          TextFormField(
                            controller: _inviteCodeController,
                            decoration: const InputDecoration(
                              hintText: '请输入邀请码',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.card_giftcard),
                            ),
                          ),
                        ],
                        if (_loginMode == LoginMode.login) ...[
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Checkbox(
                                value: _rememberMe,
                                onChanged: (value) {
                                  setState(() {
                                    _rememberMe = value ?? false;
                                  });
                                },
                              ),
                              const Text('记住我'),
                              const Spacer(),
                              Checkbox(
                                value: _autoLogin,
                                onChanged: (value) {
                                  setState(() {
                                    _autoLogin = value ?? false;
                                  });
                                },
                              ),
                              const Text('自动登录'),
                            ],
                          ),
                        ],
                        const SizedBox(height: 32),
                        FilledButton(
                          onPressed: _loading ? null : _submit,
                          style: FilledButton.styleFrom(
                            backgroundColor: const Color(0xFF0D47A1),
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          child: _loading
                              ? const SizedBox(
                                  width: 20,
                                  height: 20,
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                    color: Colors.white,
                                  ),
                                )
                              : Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      _loginMode == LoginMode.login
                                          ? AppLocalizations.of(context).loginAndImport
                                          : _loginMode == LoginMode.register
                                              ? '注册'
                                              : '重置密码',
                                      style: const TextStyle(fontSize: 16),
                                    ),
                                    const SizedBox(width: 8),
                                    const Icon(Icons.arrow_forward, size: 20),
                                  ],
                                ),
                        ),
                        const SizedBox(height: 24),
                        if (_loginMode == LoginMode.login)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton.icon(
                                onPressed: () {
                                  _formKey.currentState?.reset();
                                  setState(() {
                                    _loginMode = LoginMode.register;
                                  });
                                },
                                icon: const Icon(Icons.person_add_outlined),
                                label: const Text('注册账号'),
                              ),
                              TextButton.icon(
                                onPressed: () {
                                  _formKey.currentState?.reset();
                                  setState(() {
                                    _loginMode = LoginMode.forgotPassword;
                                  });
                                },
                                icon: const Icon(Icons.help_outline),
                                label: const Text('忘记密码'),
                              ),
                            ],
                          )
                        else
                          Center(
                            child: TextButton.icon(
                              onPressed: () {
                                _formKey.currentState?.reset();
                                setState(() {
                                  _loginMode = LoginMode.login;
                                });
                              },
                              icon: const Icon(Icons.arrow_back),
                              label: const Text('返回登录'),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
