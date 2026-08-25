import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../l10n/app_localizations.dart';
import '../error/failure.dart';
import '../error/failure_l10n.dart';
import 'xn_button.dart';

/// Full-bleed error state with a retry action. Never a silent empty state.
class ErrorView extends StatelessWidget {
  const ErrorView({required this.message, this.onRetry, super.key});

  /// Build a friendly message from any thrown error ([Failure] or otherwise).
  factory ErrorView.from(
    Object error,
    BuildContext context, {
    VoidCallback? onRetry,
    Key? key,
  }) {
    final l10n = AppLocalizations.of(context);
    final message = error is Failure
        ? localizedFailureMessage(error, l10n)
        : l10n.commonSomethingWentWrong;
    return ErrorView(message: message, onRetry: onRetry, key: key);
  }

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 420),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.bg2,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            border: Border.all(
              color: AppColors.danger.withValues(alpha: 0.18),
            ),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.dangerBg,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.error_outline_rounded,
                  color: AppColors.danger,
                  size: 26,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.fg2, height: 1.45),
              ),
              if (onRetry != null) ...[
                const SizedBox(height: AppSpacing.lg),
                XnButton(
                  label: AppLocalizations.of(context).commonRetry,
                  icon: Icons.refresh_rounded,
                  onPressed: onRetry,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
