import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_controller.dart';

enum _VerificationState { loading, success, failure }

/// Public destination for the one-time account deletion link sent by email.
class AccountDeletionVerifyScreen extends ConsumerStatefulWidget {
  const AccountDeletionVerifyScreen({this.token, super.key});

  static const successKey = Key('account-deletion-success');
  static const failureKey = Key('account-deletion-failure');

  final String? token;

  @override
  ConsumerState<AccountDeletionVerifyScreen> createState() =>
      _AccountDeletionVerifyScreenState();
}

class _AccountDeletionVerifyScreenState
    extends ConsumerState<AccountDeletionVerifyScreen> {
  var _state = _VerificationState.loading;

  @override
  void initState() {
    super.initState();
    unawaited(_verify());
  }

  Future<void> _verify() async {
    final token = widget.token?.trim();
    if (token == null || token.isEmpty) {
      if (mounted) setState(() => _state = _VerificationState.failure);
      return;
    }

    final failure = await ref
        .read(authControllerProvider.notifier)
        .verifyAccountDeletion(token);
    if (!mounted) return;
    setState(
      () => _state = failure == null
          ? _VerificationState.success
          : _VerificationState.failure,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final loading = _state == _VerificationState.loading;
    final success = _state == _VerificationState.success;

    return Scaffold(
      appBar: AppBar(title: Text(l10n.accountDeletionAppBarTitle)),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 520),
              child: XnSectionGroup(
                children: [
                  if (loading)
                    const Center(child: CircularProgressIndicator())
                  else
                    Icon(
                      success
                          ? Icons.check_circle_outline
                          : Icons.error_outline,
                      key: success
                          ? AccountDeletionVerifyScreen.successKey
                          : AccountDeletionVerifyScreen.failureKey,
                      size: 44,
                      color: success ? AppColors.success : AppColors.danger,
                    ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    loading
                        ? l10n.accountDeletionVerifyingTitle
                        : success
                        ? l10n.accountDeletionCompleteTitle
                        : l10n.accountDeletionFailedTitle,
                    textAlign: TextAlign.center,
                    style: AppTypography.display(28),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    loading
                        ? l10n.accountDeletionVerifyingBody
                        : success
                        ? l10n.accountDeletionCompleteBody
                        : l10n.accountDeletionFailedBody,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.fg2, height: 1.45),
                  ),
                  if (!loading) ...[
                    const SizedBox(height: AppSpacing.xl),
                    XnButton(
                      label: l10n.accountDeletionBackLabel,
                      variant: XnButtonVariant.secondary,
                      onPressed: () => context.go('/account-deletion'),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
