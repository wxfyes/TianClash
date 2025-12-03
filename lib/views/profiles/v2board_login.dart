import 'package:fl_clash/common/common.dart';
import 'package:fl_clash/common/v2board_service.dart';
import 'package:fl_clash/widgets/widgets.dart';
import 'package:flutter/material.dart';

class V2BoardLoginDialog extends StatefulWidget {
  const V2BoardLoginDialog({super.key});

  @override
  State<V2BoardLoginDialog> createState() => _V2BoardLoginDialogState();
}

class _V2BoardLoginDialogState extends State<V2BoardLoginDialog> {
  final _formKey = GlobalKey<FormState>();
  final _urlController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _loading = true;
    });

    final service = V2BoardService();
    final result = await service.loginAndGetSubscribeUrl(
      _urlController.text,
      _emailController.text,
      _passwordController.text,
    );

    setState(() {
      _loading = false;
    });

    if (result != null && mounted) {
      Navigator.of(context).pop(result.url);
    } else if (mounted) {
      // Show error
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Login failed or no subscription found')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return CommonDialog(
      title: 'Import from V2Board',
      actions: [
        TextButton(
          onPressed: _loading ? null : _submit,
          child: _loading
              ? const SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(appLocalizations.submit),
        )
      ],
      child: SizedBox(
        width: 300,
        child: Form(
          key: _formKey,
          child: Wrap(
            runSpacing: 16,
            children: [
              TextFormField(
                controller: _urlController,
                decoration: const InputDecoration(
                  labelText: 'Website URL',
                  border: OutlineInputBorder(),
                  hintText: 'https://example.com',
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter URL';
                  }
                  if (!value.startsWith('http')) {
                    return 'Invalid URL';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _emailController,
                decoration: const InputDecoration(
                  labelText: 'Email',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter email';
                  }
                  return null;
                },
              ),
              TextFormField(
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  labelText: 'Password',
                  border: OutlineInputBorder(),
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter password';
                  }
                  return null;
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
