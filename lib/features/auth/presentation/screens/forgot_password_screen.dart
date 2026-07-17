import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_controller.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  ConsumerState<ForgotPasswordScreen> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _email = TextEditingController();
  final _code = TextEditingController();
  final _password = TextEditingController();
  bool _codeSent = false;
  bool _loading = false;

  @override
  void dispose() {
    _email.dispose();
    _code.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.authResetPasswordTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          Text(
            _codeSent
                ? l10n.authForgotPasswordCodeSentMessage
                : l10n.authForgotPasswordInitialMessage,
            style: const TextStyle(color: AppColors.fg2, height: 1.4),
          ),
          const SizedBox(height: AppSpacing.lg),
          XnInput(
            controller: _email,
            label: l10n.authEmailLabel,
            keyboardType: TextInputType.emailAddress,
          ),
          if (_codeSent) ...[
            const SizedBox(height: AppSpacing.md),
            XnInput(
              controller: _code,
              label: l10n.authResetCodeLabel,
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: AppSpacing.md),
            XnInput(
              controller: _password,
              label: l10n.authNewPasswordLabel,
              obscureText: true,
            ),
          ],
          const SizedBox(height: AppSpacing.xl),
          XnButton(
            label: _codeSent
                ? l10n.authResetPasswordTitle
                : l10n.authSendResetCodeCta,
            loading: _loading,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    setState(() => _loading = true);
    try {
      final notifier = ref.read(authControllerProvider.notifier);
      final failure = _codeSent
          ? await notifier.resetPasswordWithCode(
              email: _email.text.trim(),
              code: _code.text.trim(),
              newPassword: _password.text,
            )
          : await notifier.sendForgotPasswordCode(_email.text.trim());
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      if (failure != null) {
        _toast(failure.message);
        return;
      }
      if (_codeSent) {
        _toast(l10n.authPasswordResetSuccessSnackbar);
        context.go('/login');
      } else {
        setState(() => _codeSent = true);
        _toast(l10n.authResetCodeSentSnackbar);
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  void _toast(String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}
