import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../nutrition/presentation/providers/nutrition_controller.dart';

/// A glanceable view of today's food intake. The detailed food log and editing
/// workflow remain on `/nutrition`.
class NutritionCard extends ConsumerWidget {
  const NutritionCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(nutritionControllerProvider);
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final logs = ref.watch(foodLogsProvider(today));
    final data = summary.value;

    if (data == null) {
      return XnSection(
        onTap: () => context.go('/nutrition'),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const _FoodHeader(),
            const SizedBox(height: AppSpacing.lg),
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
    final calories = totals?.totalCalories ?? data.todayLog?.calories ?? 0;
    final protein = totals?.totalProteinG ?? data.todayLog?.proteinG ?? 0;
    final carbs = totals?.totalCarbsG ?? data.todayLog?.carbsG ?? 0;
    final fat = totals?.totalFatG ?? data.todayLog?.fatG ?? 0;
    final target = calc.calorieTarget;
    final hasTarget = target != null && target > 0;
    final progress = hasTarget ? (calories / target).clamp(0.0, 1.0) : 0.0;
    final remaining = hasTarget ? target - calories : null;

    return XnSection(
      onTap: () => context.go('/nutrition'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _FoodHeader(),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: Text(
                  hasTarget
                      ? '${_formatInt(calories)}/${_formatInt(target)} kcal'
                      : '${_formatInt(calories)} kcal',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.display(
                    24,
                    weight: FontWeight.w700,
                    letterSpacing: -0.4,
                  ),
                ),
              ),
              if (remaining != null)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.md,
                    vertical: AppSpacing.sm,
                  ),
                  decoration: BoxDecoration(
                    color: remaining >= 0
                        ? AppColors.successBg
                        : AppColors.warningBg,
                    borderRadius: BorderRadius.circular(AppRadius.pill),
                  ),
                  child: Text(
                    remaining >= 0
                        ? l10n.nutritionKcalRemaining(remaining)
                        : l10n.nutritionKcalOverTarget(-remaining),
                    style: const TextStyle(
                      color: AppColors.fg2,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: XnAnimatedLinearProgress(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.bg3,
              color: remaining != null && remaining < 0
                  ? AppColors.warning
                  : AppColors.accent,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _MacroTile(
                  label: l10n.dashboardMacroProtein,
                  value: protein,
                  target: calc.proteinG,
                  color: AppColors.macroProtein,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _MacroTile(
                  label: l10n.dashboardMacroCarbs,
                  value: carbs,
                  target: calc.carbsG,
                  color: AppColors.macroCarbs,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _MacroTile(
                  label: l10n.dashboardMacroFat,
                  value: fat,
                  target: calc.fatG,
                  color: AppColors.macroFat,
                ),
              ),
            ],
          ),
          if (!hasTarget) ...[
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.dashboardSetupNutritionMessage,
              style: const TextStyle(color: AppColors.fg3, fontSize: 12),
            ),
          ],
        ],
      ),
    );
  }
}

class _FoodHeader extends StatelessWidget {
  const _FoodHeader();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.accentSoft,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(
            Icons.restaurant_rounded,
            color: AppColors.accent,
            size: 21,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            l10n.dashboardNutritionTodayEyebrow,
            style: const TextStyle(
              color: AppColors.fg1,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
      ],
    );
  }
}

class _MacroTile extends StatelessWidget {
  const _MacroTile({
    required this.label,
    required this.value,
    required this.target,
    required this.color,
  });

  final String label;
  final double value;
  final double? target;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final ratio = target != null && target! > 0
        ? (value / target!).clamp(0.0, 1.0)
        : 0.0;
    // Deepened macro hue for text, so the tile can carry a saturated tint and
    // still keep label/value contrast on the lighter amber and green.
    final ink = Color.lerp(color, AppColors.ink900, 0.42)!;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.34)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 7,
                height: 7,
                decoration: BoxDecoration(
                  color: color,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 5),
              Expanded(
                child: Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: ink,
                    fontSize: 11,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            target != null
                ? '${value.toStringAsFixed(0)}/${target!.toStringAsFixed(0)}g'
                : '${value.toStringAsFixed(0)}g',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(
              12,
              color: ink,
              weight: FontWeight.w700,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 4,
              backgroundColor: color.withValues(alpha: 0.22),
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ],
      ),
    );
  }
}

String _formatInt(num value) {
  final digits = value.round().toString();
  return digits.replaceAllMapped(
    RegExp(r'\B(?=(\d{3})+(?!\d))'),
    (_) => ',',
  );
}
