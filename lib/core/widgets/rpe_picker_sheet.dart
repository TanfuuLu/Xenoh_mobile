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
    return SafeArea(
      top: false,
      child: Padding(
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
            // Two rows of five flexible cells rather than a Wrap of fixed-width
            // ones: the block stays a tidy 5x2 at every width instead of
            // breaking ragged, and it cannot overflow a narrow screen.
            _RpeRow(from: 1, to: 5, initial: initial),
            const SizedBox(height: AppSpacing.sm),
            _RpeRow(from: 6, to: 10, initial: initial),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: Text(
                    l10n.trainingRpeScaleLightLabel,
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                Text(
                  l10n.trainingRpeScaleMaxLabel,
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 11,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class _RpeRow extends StatelessWidget {
  const _RpeRow({required this.from, required this.to, required this.initial});

  final int from;
  final int to;
  final double? initial;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var rpe = from; rpe <= to; rpe++) ...[
          if (rpe > from) const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: _RpeCell(
              value: rpe,
              selected: initial == rpe.toDouble(),
              onTap: () => Navigator.pop(context, rpe.toDouble()),
            ),
          ),
        ],
      ],
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
    // Warm ramp across the scale so 1 reads as light and 10 as maximal.
    final intensity = (value - 1) / 9;
    final fill = Color.lerp(
      AppColors.buttonBg,
      AppColors.accentSoft,
      intensity,
    )!;
    final border = Color.lerp(
      AppColors.buttonBorder,
      AppColors.accent.withValues(alpha: 0.45),
      intensity,
    )!;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: Container(
        height: 52,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: selected ? AppColors.accent : fill,
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(
            color: selected ? AppColors.accent : border,
            width: selected ? 2 : 1,
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
