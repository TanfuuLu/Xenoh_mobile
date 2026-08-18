import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../nutrition/domain/entities/meal_plan.dart';
import '../../../nutrition/presentation/providers/nutrition_controller.dart';

class TodayMealPlanCard extends ConsumerWidget {
  const TodayMealPlanCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final today = _todayKey();
    final mealPlan = ref.watch(mealPlanProvider(today));
    final data = mealPlan.value;

    return XnSection(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.xxl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l10n.dashboardMealPlanEyebrow, style: _eyebrow),
              ),
              if (data != null && data.totalItemCount > 0)
                XnChip(
                  label: '${data.checkedItemCount}/${data.totalItemCount}',
                  tone: XnChipTone.sage,
                  compact: true,
                ),
              const SizedBox(width: AppSpacing.md),
              IconButton(
                tooltip: l10n.dashboardOpenNutritionTooltip,
                padding: const EdgeInsets.all(AppSpacing.sm),
                constraints: const BoxConstraints.tightFor(
                  width: 36,
                  height: 36,
                ),
                onPressed: () => context.go('/nutrition'),
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          if (data == null)
            _LoadingOrError(mealPlan: mealPlan)
          else if (data.totalItemCount == 0)
            const _EmptyMealPlan()
          else
            _MealPlanContent(date: today, plan: data),
        ],
      ),
    );
  }

  DateTime _todayKey() {
    final now = DateTime.now();
    return DateTime(now.year, now.month, now.day);
  }
}

class _MealPlanContent extends StatelessWidget {
  const _MealPlanContent({required this.date, required this.plan});

  final DateTime date;
  final MealPlanDay plan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final meals = plan.meals.where((meal) => meal.items.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: XnAnimatedLinearProgress(
            value: plan.progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: AppColors.bg3,
            color: AppColors.sage500,
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            Expanded(
              child: _MacroSummary(
                label: l10n.dashboardMealPlanSummaryPlanned,
                totals: plan.plannedTotals,
              ),
            ),
            const SizedBox(width: AppSpacing.lg),
            Expanded(
              child: _MacroSummary(
                label: l10n.dashboardMealPlanSummaryDone,
                totals: plan.checkedTotals,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        for (final meal in meals) ...[
          _MealSection(date: date, meal: meal),
          if (meal != meals.last) const SizedBox(height: AppSpacing.xxl),
        ],
      ],
    );
  }
}

class _MealSection extends ConsumerWidget {
  const _MealSection({required this.date, required this.meal});

  final DateTime date;
  final MealPlanMeal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final pending = ref.watch(mealPlanActionControllerProvider).isLoading;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          meal.name,
          style: const TextStyle(
            color: AppColors.fg1,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        XnCardStack(
          itemPadding: EdgeInsets.zero,
          children: [
            for (final item in meal.items)
              _MealPlanItemTile(
                item: item,
                pending: pending,
                onChanged: (checked) {
                  if (checked == null) return;
                  unawaited(
                    ref
                        .read(mealPlanActionControllerProvider.notifier)
                        .setChecked(itemId: item.id, checked: checked),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _MealPlanItemTile extends StatelessWidget {
  const _MealPlanItemTile({
    required this.item,
    required this.pending,
    required this.onChanged,
  });

  final MealPlanItem item;
  final bool pending;
  final ValueChanged<bool?> onChanged;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return CheckboxListTile(
      dense: false,
      contentPadding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      minVerticalPadding: AppSpacing.md,
      value: item.isChecked,
      controlAffinity: ListTileControlAffinity.trailing,
      onChanged: pending ? null : onChanged,
      title: Text(
        item.displayNameFor(languageCode),
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: TextStyle(
          color: item.isChecked ? AppColors.fg3 : AppColors.fg1,
          decoration: item.isChecked ? TextDecoration.lineThrough : null,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text(
        '${item.amountLabelFor(languageCode)} - ${item.plannedCalories} kcal - '
        'P ${item.plannedProteinG.toStringAsFixed(0)} - '
        'C ${item.plannedCarbsG.toStringAsFixed(0)} - '
        'F ${item.plannedFatG.toStringAsFixed(0)}',
        maxLines: 2,
        overflow: TextOverflow.ellipsis,
        style: AppTypography.mono(11, color: AppColors.fg3).copyWith(
          height: 1.35,
        ),
      ),
    );
  }
}

class _MacroSummary extends StatelessWidget {
  const _MacroSummary({required this.label, required this.totals});

  final String label;
  final MealPlanTotals totals;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 12),
      decoration: BoxDecoration(
        color: AppColors.bg3,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label.toUpperCase(), style: _eyebrow),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${totals.calories} kcal',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(14, weight: FontWeight.w500),
          ),
          Text(
            'P ${totals.proteinG.toStringAsFixed(0)} - '
            'C ${totals.carbsG.toStringAsFixed(0)} - '
            'F ${totals.fatG.toStringAsFixed(0)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(10, color: AppColors.fg3).copyWith(
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

class _LoadingOrError extends StatelessWidget {
  const _LoadingOrError({required this.mealPlan});

  final AsyncValue<MealPlanDay> mealPlan;

  @override
  Widget build(BuildContext context) {
    if (mealPlan.hasError) {
      return Text(
        AppLocalizations.of(context).dashboardMealPlanLoadError,
        style: const TextStyle(color: AppColors.fg3),
      );
    }

    return const Padding(
      padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}

class _EmptyMealPlan extends StatelessWidget {
  const _EmptyMealPlan();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.dashboardMealPlanEmpty,
          style: const TextStyle(color: AppColors.fg3),
        ),
        const SizedBox(height: AppSpacing.md),
        OutlinedButton.icon(
          onPressed: () => context.go('/nutrition'),
          icon: const Icon(Icons.edit_calendar_rounded, size: 18),
          label: Text(l10n.dashboardMealPlanCreateCta),
        ),
      ],
    );
  }
}

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);
