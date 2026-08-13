import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';
import 'xn_button.dart';

/// Upgrade prompt shown when a Pro-gated endpoint returns 403. Reused by
/// analytics and (later) the AI features. Never a broken/empty screen.
class ProLockedView extends StatelessWidget {
  const ProLockedView({
    required this.title,
    required this.message,
    this.onUpgrade,
    super.key,
  });

  final String title;
  final String message;

  /// Optional CTA (e.g. open the subscription screen). Hidden when null.
  final VoidCallback? onUpgrade;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xl),
        child: Container(
          constraints: const BoxConstraints(maxWidth: 430),
          padding: const EdgeInsets.all(AppSpacing.xl),
          decoration: BoxDecoration(
            color: AppColors.ink900,
            borderRadius: BorderRadius.circular(AppRadius.xxl),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowDeep,
                blurRadius: 24,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 49,
                height: 49,
                decoration: BoxDecoration(
                  color: AppColors.paperAlt,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.workspace_premium_rounded,
                  color: AppColors.ink900,
                  size: 27,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                title,
                textAlign: TextAlign.center,
                style: AppTypography.display(
                  24,
                  weight: FontWeight.w600,
                  color: AppColors.fgOnClay,
                  letterSpacing: -0.25,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                message,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  color: AppColors.ink300,
                  height: 1.45,
                ),
              ),
              if (onUpgrade != null) ...[
                const SizedBox(height: AppSpacing.xl),
                SizedBox(
                  width: double.infinity,
                  child: XnButton(
                    label: AppLocalizations.of(context).commonUpgradeToPro,
                    icon: Icons.bolt_rounded,
                    onPressed: onUpgrade,
                  ),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}
