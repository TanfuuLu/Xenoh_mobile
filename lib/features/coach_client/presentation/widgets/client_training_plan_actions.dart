import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';

/// A compact action group for the coach-facing client training plan panel.
class ClientTrainingPlanActions extends StatelessWidget {
  const ClientTrainingPlanActions({
    required this.onCreatePlan,
    super.key,
  });

  static const createPlanKey = ValueKey('client-training-create-plan');

  final VoidCallback onCreatePlan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return DecoratedBox(
      decoration: BoxDecoration(
        color: AppColors.buttonBg,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.buttonBorder),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            _TrainingPlanActionRow(
              key: createPlanKey,
              icon: Icons.add_rounded,
              label: l10n.trainingCreatePlanCta,
              backgroundColor: AppColors.buttonBg,
              iconBackgroundColor: AppColors.buttonHover,
              iconColor: AppColors.buttonText,
              onTap: onCreatePlan,
            ),
          ],
        ),
      ),
    );
  }
}

class _TrainingPlanActionRow extends StatelessWidget {
  const _TrainingPlanActionRow({
    required this.icon,
    required this.label,
    required this.backgroundColor,
    required this.iconBackgroundColor,
    required this.iconColor,
    required this.onTap,
    super.key,
  });

  final IconData icon;
  final String label;
  final Color backgroundColor;
  final Color iconBackgroundColor;
  final Color iconColor;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      button: true,
      child: Material(
        color: backgroundColor,
        child: InkWell(
          onTap: onTap,
          child: ConstrainedBox(
            constraints: const BoxConstraints(minHeight: 53),
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.md,
                vertical: AppSpacing.sm,
              ),
              child: Row(
                children: [
                  Container(
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      color: iconBackgroundColor,
                      borderRadius: BorderRadius.circular(AppRadius.md),
                    ),
                    alignment: Alignment.center,
                    child: Icon(icon, size: 18, color: iconColor),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.fg1,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  const Icon(
                    Icons.arrow_forward_rounded,
                    size: 17,
                    color: AppColors.fg3,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
