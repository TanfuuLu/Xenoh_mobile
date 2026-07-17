import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../nutrition/presentation/providers/nutrition_controller.dart';

/// Today's nutrition: a calorie ring + macro bars. Prompts to complete the
/// profile when targets aren't set.
///
/// Reads the same source of truth as the Nutrition screen — the nutrition
/// summary (targets) plus today's food logs (consumed totals) — so the two
/// screens always show identical numbers. Logging or deleting food on the
/// Nutrition screen invalidates these providers, and this card updates with it.
class NutritionCard extends ConsumerWidget {
  const NutritionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(nutritionControllerProvider);
    // Date-only key; equal DateTime values reuse the same provider instance.
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final logs = ref.watch(foodLogsProvider(today));

    // Render from the latest value so a refresh keeps the populated card
    // instead of flashing a spinner (matches the app-wide async convention).
    final data = summary.value;
    if (data == null) {
      return XnSection(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(l10n.dashboardNutritionTodayEyebrow, style: _eyebrow),
            const SizedBox(height: AppSpacing.md),
            if (summary.hasError)
              Text(
                l10n.dashboardNutritionLoadError,
                style: const TextStyle(color: AppColors.fg3, fontSize: 13),
              )
            else
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                ),
              ),
          ],
        ),
      );
    }

    final calc = data.calculation;
    final totals = logs.value?.totals;
    final loggedCalories =
        totals?.totalCalories ?? data.todayLog?.calories ?? 0;
    final loggedProtein = totals?.totalProteinG ?? data.todayLog?.proteinG ?? 0;
    final loggedCarbs = totals?.totalCarbsG ?? data.todayLog?.carbsG ?? 0;
    final loggedFat = totals?.totalFatG ?? data.todayLog?.fatG ?? 0;

    final target = calc.calorieTarget;
    final hasTarget = target != null && target > 0;
    final ratio = hasTarget ? (loggedCalories / target).clamp(0.0, 1.0) : 0.0;

    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(l10n.dashboardNutritionTodayEyebrow, style: _eyebrow),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              SizedBox(
                width: 72,
                height: 72,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 72,
                      height: 72,
                      child: XnAnimatedCircularProgress(
                        value: hasTarget ? ratio : null,
                        indeterminate: !hasTarget,
                        strokeWidth: 7,
                        backgroundColor: AppColors.bg3,
                        color: AppColors.accent,
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        XnAnimatedNumber(
                          value: loggedCalories.toDouble(),
                          formatter: formatAnimatedInt,
                          style: AppTypography.mono(
                            16,
                            weight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'kcal',
                          style: TextStyle(
                            color: AppColors.fg3,
                            fontSize: 10,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.lg),
              Expanded(
                child: Column(
                  children: [
                    _MacroBar(
                      label: l10n.dashboardMacroProtein,
                      logged: loggedProtein,
                      target: calc.proteinG,
                      color: AppColors.sage500,
                    ),
                    _MacroBar(
                      label: l10n.dashboardMacroCarbs,
                      logged: loggedCarbs,
                      target: calc.carbsG,
                      color: AppColors.warning,
                    ),
                    _MacroBar(
                      label: l10n.dashboardMacroFat,
                      logged: loggedFat,
                      target: calc.fatG,
                      color: AppColors.info,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (hasTarget) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              '$loggedCalories/$target kcal',
              style: AppTypography.mono(
                13,
                weight: FontWeight.w500,
                color: AppColors.fg2,
              ),
            ),
          ] else ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.dashboardSetupNutritionMessage,
              style: const TextStyle(color: AppColors.fg3, fontSize: 13),
            ),
          ],
        ],
      ),
    );
  }

  static const _eyebrow = TextStyle(
    color: AppColors.fg3,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.6,
  );
}

class _MacroBar extends StatelessWidget {
  const _MacroBar({
    required this.label,
    required this.logged,
    required this.target,
    required this.color,
  });

  final String label;
  final double logged;
  final double? target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final t = target;
    final ratio = (t != null && t > 0) ? (logged / t).clamp(0.0, 1.0) : 0.0;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          SizedBox(
            width: 52,
            child: Text(
              label,
              style: const TextStyle(color: AppColors.fg2, fontSize: 12),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: XnAnimatedLinearProgress(
                value: ratio,
                minHeight: 6,
                backgroundColor: AppColors.bg3,
                color: color,
              ),
            ),
          ),
          const SizedBox(width: 8),
          SizedBox(
            width: 64,
            child: XnAnimatedNumber(
              value: logged,
              formatter: (value) => t != null
                  ? '${value.toStringAsFixed(0)}/${t.toStringAsFixed(0)}g'
                  : '${value.toStringAsFixed(0)}g',
              textAlign: TextAlign.right,
              style: AppTypography.mono(11, color: AppColors.fg3),
            ),
          ),
        ],
      ),
    );
  }
}
