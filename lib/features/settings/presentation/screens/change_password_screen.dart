import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';

class ChangePasswordScreen extends ConsumerStatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  ConsumerState<ChangePasswordScreen> createState() =>
      _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends ConsumerState<ChangePasswordScreen> {
  final _old = TextEditingController();
  final _next = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _old.dispose();
    _next.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.settingsChangePasswordTitle)),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          XnInput(
            controller: _old,
            label: l10n.settingsCurrentPasswordLabel,
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.md),
          XnInput(
            controller: _next,
            label: l10n.settingsNewPasswordLabel,
            obscureText: true,
          ),
          const SizedBox(height: AppSpacing.xl),
          XnButton(
            label: l10n.settingsSavePasswordCta,
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
      final failure = await ref
          .read(authControllerProvider.notifier)
          .changePassword(oldPassword: _old.text, newPassword: _next.text);
      if (!mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              failure?.message ??
                  AppLocalizations.of(context).settingsPasswordUpdatedSnackbar,
            ),
          ),
        );
      if (failure == null) _old.clear();
      if (failure == null) _next.clear();
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
