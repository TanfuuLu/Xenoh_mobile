import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
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
  final _confirm = TextEditingController();
  bool _loading = false;
  String? _oldPasswordError;
  String? _newPasswordError;
  String? _confirmPasswordError;

  bool get _canSubmit =>
      !_loading &&
      _old.text.isNotEmpty &&
      _next.text.isNotEmpty &&
      _confirm.text.isNotEmpty;

  @override
  void dispose() {
    _old.dispose();
    _next.dispose();
    _confirm.dispose();
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
          _SecurityHeader(l10n: l10n),
          const SizedBox(height: AppSpacing.xl),
          XnCard(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                XnInput(
                  controller: _old,
                  label: l10n.settingsCurrentPasswordLabel,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  prefix: const Icon(Icons.lock_outline_rounded, size: 18),
                  errorText: _oldPasswordError,
                  onChanged: (_) {
                    setState(() => _oldPasswordError = null);
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                XnInput(
                  controller: _next,
                  label: l10n.settingsNewPasswordLabel,
                  obscureText: true,
                  textInputAction: TextInputAction.next,
                  prefix: const Icon(Icons.lock_outline_rounded, size: 18),
                  errorText: _newPasswordError,
                  onChanged: (_) {
                    setState(() {
                      _newPasswordError = null;
                      _confirmPasswordError = null;
                    });
                  },
                ),
                const SizedBox(height: AppSpacing.lg),
                XnInput(
                  controller: _confirm,
                  label: l10n.settingsConfirmNewPasswordLabel,
                  obscureText: true,
                  textInputAction: TextInputAction.done,
                  prefix: const Icon(Icons.lock_outline_rounded, size: 18),
                  errorText: _confirmPasswordError,
                  onChanged: (_) {
                    setState(() => _confirmPasswordError = null);
                  },
                ),
                const SizedBox(height: AppSpacing.xl),
                Align(
                  alignment: Alignment.centerLeft,
                  child: XnButton(
                    label: l10n.settingsSavePasswordCta,
                    loading: _loading,
                    onPressed: _canSubmit ? _submit : null,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _submit() async {
    if (!_canSubmit) return;
    if (_next.text != _confirm.text) {
      setState(() {
        _confirmPasswordError = AppLocalizations.of(
          context,
        ).settingsPasswordsDoNotMatchError;
      });
      return;
    }
    setState(() {
      _loading = true;
      _oldPasswordError = null;
      _newPasswordError = null;
      _confirmPasswordError = null;
    });
    try {
      final failure = await ref
          .read(authControllerProvider.notifier)
          .changePassword(oldPassword: _old.text, newPassword: _next.text);
      if (!mounted) return;
      if (failure is ValidationFailure) {
        final oldError = _fieldError(
          failure,
          const ['oldpassword', 'currentpassword'],
        );
        final newError = _fieldError(
          failure,
          const ['newpassword'],
        );
        setState(() {
          _oldPasswordError =
              oldError ?? (newError == null ? failure.message : null);
          _newPasswordError = newError;
        });
        return;
      }

      final messenger = ScaffoldMessenger.of(context)..hideCurrentSnackBar();
      if (failure != null) {
        messenger.showSnackBar(SnackBar(content: Text(failure.message)));
        return;
      }

      _old.clear();
      _next.clear();
      _confirm.clear();
      messenger.showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).settingsPasswordUpdatedSnackbar,
          ),
        ),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  String? _fieldError(ValidationFailure failure, List<String> fieldNames) {
    for (final entry in failure.fieldErrors.entries) {
      final normalizedName = entry.key.toLowerCase().replaceAll(
        RegExp('[^a-z]'),
        '',
      );
      if (fieldNames.contains(normalizedName) && entry.value.isNotEmpty) {
        return entry.value.first;
      }
    }
    return null;
  }
}

class _SecurityHeader extends StatelessWidget {
  const _SecurityHeader({required this.l10n});

  final AppLocalizations l10n;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 48,
          height: 48,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.bg2,
            shape: BoxShape.circle,
            border: Border.all(color: AppColors.surfaceBorderSoft),
          ),
          child: const Icon(
            Icons.shield_outlined,
            color: AppColors.accent,
            size: 23,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.settingsSecurityEyebrow,
                style: const TextStyle(
                  color: AppColors.fg2,
                  fontSize: 12,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                l10n.settingsChangePasswordTitle,
                style: AppTypography.display(
                  26,
                  weight: FontWeight.w700,
                  color: AppColors.fg1,
                  letterSpacing: -0.3,
                  height: 1.05,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.settingsChangePasswordSubtitle,
                style: const TextStyle(
                  color: AppColors.fg2,
                  fontSize: 13,
                  height: 1.4,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
