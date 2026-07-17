import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../app/theme/app_typography.dart';
import '../../l10n/app_localizations.dart';

/// Bottom sheet that asks the lifter to rate a set's RPE (1–10) when they tick
/// it complete. Pops the chosen value (as a double) or null if dismissed.
class RpePickerSheet extends StatelessWidget {
  const RpePickerSheet({required this.setNumber, this.initial, super.key});

  final int setNumber;
  final double? initial;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.trainingRpePickerTitle(setNumber),
            style: AppTypography.display(18, letterSpacing: 0),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            l10n.trainingRpePickerSubtitle,
            style: const TextStyle(color: AppColors.fg3, fontSize: 13),
          ),
          const SizedBox(height: AppSpacing.lg),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (var rpe = 1; rpe <= 10; rpe++)
                _RpeCell(
                  value: rpe,
                  selected: initial == rpe.toDouble(),
                  onTap: () => Navigator.pop(context, rpe.toDouble()),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _RpeCell extends StatelessWidget {
  const _RpeCell({
    required this.value,
    required this.selected,
    required this.onTap,
  });

  final int value;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        width: 52,
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : AppColors.bg2,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? AppColors.accent : AppColors.border1,
          ),
        ),
        child: Text(
          '$value',
          style: AppTypography.mono(
            18,
            weight: FontWeight.w500,
            color: selected ? AppColors.fgOnClay : AppColors.fg1,
          ),
        ),
      ),
    );
  }
}
