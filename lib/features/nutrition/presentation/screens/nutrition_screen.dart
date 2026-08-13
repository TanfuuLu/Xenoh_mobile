import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/current_date_provider.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/nutrition_repository_provider.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/nutrition_summary.dart';
import '../providers/nutrition_controller.dart';
import '../widgets/add_food_sheet.dart';
import '../widgets/edit_nutrition_profile_sheet.dart';
import '../widgets/meal_plan_setup_sheet.dart';
import '../widgets/nutrition_enums.dart';

class NutritionScreen extends ConsumerStatefulWidget {
  const NutritionScreen({super.key});

  static const desktopContentKey = ValueKey('nutrition-desktop-content');
  static const mobileContentKey = ValueKey('nutrition-mobile-content');
  static const mobileActionsKey = ValueKey('nutrition-mobile-actions');

  @override
  ConsumerState<NutritionScreen> createState() => _NutritionScreenState();
}

class _NutritionScreenState extends ConsumerState<NutritionScreen> {
  // Null means "follow today" — reactively re-resolves against
  // `currentDateProvider` on every build, so the screen doesn't keep showing
  // yesterday's date/data if the app was left open, or just backgrounded,
  // across midnight. Once the user manually navigates to a specific date,
  // that choice is pinned until they tap back to "Today".
  DateTime? _pinnedDate;

  Future<void> _editProfile(NutritionProfile profile) async {
    await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => EditNutritionProfileSheet(profile: profile),
    );
  }

  Future<void> _addFood(DateTime selectedDate) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => AddFoodSheet(date: selectedDate),
    );
  }

  Future<void> _createMealPlan(
    DateTime selectedDate,
    MealPlanDay? plan,
  ) async {
    final savedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => MealPlanSetupSheet(
        date: selectedDate,
        initialPlan: plan,
      ),
    );
    if (savedDate != null && mounted) {
      setState(() => _pinnedDate = DateOnly.truncate(savedDate));
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              AppLocalizations.of(context).nutritionMealPlanCreatedSnackbar,
            ),
          ),
        );
    }
  }

  Future<void> _deleteLog(DateTime selectedDate, FoodLogItem item) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref
          .read(nutritionRepositoryProvider)
          .deleteFoodLog(date: selectedDate, foodLogId: item.id);
      ref
        ..invalidate(foodLogsProvider(selectedDate))
        ..invalidate(nutritionControllerProvider);
    } catch (e) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final compactActions = MediaQuery.sizeOf(context).width < 560;
    final today = ref.watch(currentDateProvider);
    final selectedDate = _pinnedDate ?? today;
    final summary = ref.watch(nutritionControllerProvider);
    final logs = ref.watch(foodLogsProvider(selectedDate));
    final mealPlan = ref.watch(mealPlanProvider(selectedDate));
    return Scaffold(
      appBar: AppBar(
        leading: const HomeShellMenuButton(),
        title: Text(l10n.nutritionScreenTitle),
        actions: compactActions
            ? [
                PopupMenuButton<_NutritionAction>(
                  key: NutritionScreen.mobileActionsKey,
                  tooltip: MaterialLocalizations.of(context).moreButtonTooltip,
                  icon: const Icon(Icons.more_horiz_rounded),
                  onSelected: (action) {
                    switch (action) {
                      case _NutritionAction.insight:
                        unawaited(context.push('/nutrition/insight'));
                      case _NutritionAction.history:
                        unawaited(context.push('/nutrition/history'));
                      case _NutritionAction.supplements:
                        unawaited(context.push('/supplements'));
                      case _NutritionAction.editProfile:
                        if (summary.value case final data?) {
                          unawaited(_editProfile(data.profile));
                        }
                    }
                  },
                  itemBuilder: (context) => [
                    PopupMenuItem(
                      value: _NutritionAction.insight,
                      child: _MenuActionLabel(
                        icon: Icons.auto_awesome_rounded,
                        label: l10n.nutritionInsightTitle,
                      ),
                    ),
                    PopupMenuItem(
                      value: _NutritionAction.history,
                      child: _MenuActionLabel(
                        icon: Icons.show_chart_rounded,
                        label: l10n.nutritionHistoryTitle,
                      ),
                    ),
                    PopupMenuItem(
                      value: _NutritionAction.supplements,
                      child: _MenuActionLabel(
                        icon: Icons.medication_outlined,
                        label: l10n.supplementsTitle,
                      ),
                    ),
                    if (summary.value != null)
                      PopupMenuItem(
                        value: _NutritionAction.editProfile,
                        child: _MenuActionLabel(
                          icon: Icons.tune_rounded,
                          label: l10n.nutritionEditProfileTooltip,
                        ),
                      ),
                  ],
                ),
              ]
            : [
                IconButton(
                  tooltip: l10n.nutritionInsightTitle,
                  icon: const Icon(Icons.auto_awesome_rounded),
                  onPressed: () =>
                      unawaited(context.push('/nutrition/insight')),
                ),
                IconButton(
                  tooltip: l10n.nutritionHistoryTitle,
                  icon: const Icon(Icons.show_chart_rounded),
                  onPressed: () =>
                      unawaited(context.push('/nutrition/history')),
                ),
                IconButton(
                  tooltip: l10n.supplementsTitle,
                  icon: const Icon(Icons.medication_outlined),
                  onPressed: () => unawaited(context.push('/supplements')),
                ),
                if (summary.value case final data?)
                  IconButton(
                    tooltip: l10n.nutritionEditProfileTooltip,
                    icon: const Icon(Icons.tune_rounded),
                    onPressed: () => _editProfile(data.profile),
                  ),
              ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          await ref.read(nutritionControllerProvider.notifier).refresh();
          ref
            ..invalidate(foodLogsProvider(selectedDate))
            ..invalidate(mealPlanProvider(selectedDate));
        },
        child: _body(
          today,
          selectedDate,
          summary,
          logs,
          mealPlan,
        ),
      ),
    );
  }

  /// Renders from the latest *value* so a refresh (after add/delete/edit) keeps
  /// the populated screen instead of flashing a full-screen spinner. The
  /// spinner/error only show on the very first load (no data yet).
  Widget _body(
    DateTime today,
    DateTime selectedDate,
    AsyncValue<NutritionSummary> summary,
    AsyncValue<FoodLogsForDate> logs,
    AsyncValue<MealPlanDay> mealPlan,
  ) {
    final data = summary.value;
    final l10n = AppLocalizations.of(context);
    if (data == null) {
      if (summary.hasError) {
        return ListView(
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child: ErrorView.from(
                summary.error!,
                context,
                onRetry: () => ref.invalidate(nutritionControllerProvider),
              ),
            ),
          ],
        );
      }
      return const Center(child: CircularProgressIndicator());
    }

    final totals = logs.value?.totals;
    final selectedIsToday = selectedDate == today;
    final weightUnit = ref.watch(weightUnitProvider);
    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.sm,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      children: [
        _Header(
          summary: data,
          unit: weightUnit,
        ),
        const SizedBox(height: AppSpacing.sm),
        _DateSelector(
          date: selectedDate,
          isToday: selectedIsToday,
          onPrevious: () => setState(
            () => _pinnedDate = selectedDate.subtract(
              const Duration(days: 1),
            ),
          ),
          onNext: () => setState(
            () => _pinnedDate = selectedDate.add(const Duration(days: 1)),
          ),
          onToday: selectedIsToday
              ? null
              : () => setState(() => _pinnedDate = null),
          onPick: () => _pickDate(selectedDate),
        ),
        const SizedBox(height: AppSpacing.md),
        LayoutBuilder(
          builder: (context, constraints) {
            final dailyPanel = XnCardStack(
              children: [
                _TodayCard(
                  title: selectedIsToday
                      ? l10n.nutritionTodayEyebrow
                      : DateOnly.format(selectedDate),
                  calc: data.calculation,
                  consumedCalories:
                      totals?.totalCalories ?? data.todayLog?.calories ?? 0,
                  consumedProtein:
                      totals?.totalProteinG ?? data.todayLog?.proteinG ?? 0,
                  consumedCarbs:
                      totals?.totalCarbsG ?? data.todayLog?.carbsG ?? 0,
                  consumedFat: totals?.totalFatG ?? data.todayLog?.fatG ?? 0,
                ),
                _FoodLogCard(
                  title: selectedIsToday
                      ? l10n.nutritionTodaysFoodEyebrow
                      : l10n.nutritionFoodLogEyebrow,
                  logs: logs,
                  onDelete: (item) => _deleteLog(selectedDate, item),
                  onAdd: () => _addFood(selectedDate),
                ),
              ],
            );
            final mealPlanPanel = XnSectionGroup(
              padding: EdgeInsets.zero,
              children: [
                _MealPlanCard(
                  date: selectedDate,
                  mealPlan: mealPlan,
                  onCreate: () => _createMealPlan(selectedDate, mealPlan.value),
                ),
              ],
            );

            if (constraints.maxWidth >= 720) {
              return Row(
                key: NutritionScreen.desktopContentKey,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(child: dailyPanel),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(child: mealPlanPanel),
                ],
              );
            }

            return Column(
              key: NutritionScreen.mobileContentKey,
              children: [
                dailyPanel,
                const SizedBox(height: AppSpacing.md),
                mealPlanPanel,
              ],
            );
          },
        ),
        if (!data.isProfileComplete) ...[
          const SizedBox(height: AppSpacing.md),
          _IncompleteCard(
            missing: data.calculation.missingFields,
            onEdit: () => _editProfile(data.profile),
          ),
        ],
      ],
    );
  }

  Future<void> _pickDate(DateTime selectedDate) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked == null || !mounted) return;
    setState(() => _pinnedDate = DateOnly.truncate(picked));
  }
}

enum _NutritionAction { insight, history, supplements, editProfile }

class _MenuActionLabel extends StatelessWidget {
  const _MenuActionLabel({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.fg2),
        const SizedBox(width: AppSpacing.md),
        Flexible(child: Text(label)),
      ],
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({
    required this.date,
    required this.isToday,
    required this.onPrevious,
    required this.onNext,
    required this.onPick,
    this.onToday,
  });

  final DateTime date;
  final bool isToday;
  final VoidCallback onPrevious;
  final VoidCallback onNext;
  final VoidCallback onPick;
  final VoidCallback? onToday;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
      child: Row(
        children: [
          IconButton(
            tooltip: l10n.nutritionPreviousDayTooltip,
            onPressed: onPrevious,
            icon: const Icon(Icons.chevron_left_rounded),
          ),
          Expanded(
            child: InkWell(
              onTap: onPick,
              borderRadius: BorderRadius.circular(AppRadius.md),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      isToday ? l10n.commonToday : _weekday(date, l10n),
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      DateOnly.format(date),
                      style: AppTypography.mono(
                        15,
                        color: AppColors.fg1,
                        weight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          if (onToday != null)
            TextButton(
              onPressed: onToday,
              child: Text(l10n.commonToday),
            ),
          IconButton(
            tooltip: l10n.nutritionNextDayTooltip,
            onPressed: onNext,
            icon: const Icon(Icons.chevron_right_rounded),
          ),
        ],
      ),
    );
  }

  String _weekday(DateTime date, AppLocalizations l10n) =>
      switch (date.weekday) {
        DateTime.monday => l10n.nutritionWeekdayMonday,
        DateTime.tuesday => l10n.nutritionWeekdayTuesday,
        DateTime.wednesday => l10n.nutritionWeekdayWednesday,
        DateTime.thursday => l10n.nutritionWeekdayThursday,
        DateTime.friday => l10n.nutritionWeekdayFriday,
        DateTime.saturday => l10n.nutritionWeekdaySaturday,
        _ => l10n.nutritionWeekdaySunday,
      };
}

class _MealPlanCard extends ConsumerWidget {
  const _MealPlanCard({
    required this.date,
    required this.mealPlan,
    required this.onCreate,
  });

  final DateTime date;
  final AsyncValue<MealPlanDay> mealPlan;
  final VoidCallback onCreate;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final data = mealPlan.value;
    final plannedMeals =
        data?.meals.where((meal) => meal.items.isNotEmpty).toList() ??
        const <MealPlanMeal>[];
    return XnSection(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(l10n.nutritionMealPlanEyebrow, style: _eyebrow),
              ),
              TextButton.icon(
                onPressed: onCreate,
                icon: const Icon(Icons.edit_calendar_rounded, size: 18),
                label: Text(
                  data == null || data.totalItemCount == 0
                      ? l10n.nutritionMealPlanCreateCta
                      : l10n.nutritionMealPlanEditCta,
                ),
              ),
              const SizedBox(width: AppSpacing.xs),
              if (data != null && data.totalItemCount > 0)
                XnChip(
                  label: '${data.checkedItemCount}/${data.totalItemCount}',
                  tone: XnChipTone.sage,
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          if (data == null)
            if (mealPlan.hasError)
              Text(
                l10n.nutritionMealPlanLoadError,
                style: const TextStyle(color: AppColors.fg3),
              )
            else
              const Padding(
                padding: EdgeInsets.symmetric(vertical: AppSpacing.md),
                child: Center(child: CircularProgressIndicator()),
              )
          else if (data.totalItemCount == 0)
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.nutritionNoMealPlanMessage,
                  style: const TextStyle(color: AppColors.fg3),
                ),
                const SizedBox(height: AppSpacing.md),
                OutlinedButton.icon(
                  onPressed: onCreate,
                  icon: const Icon(Icons.add_rounded, size: 18),
                  label: Text(l10n.nutritionCreateMealPlanTitle),
                ),
              ],
            )
          else ...[
            ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: LinearProgressIndicator(
                value: data.progress.clamp(0.0, 1.0),
                minHeight: 8,
                backgroundColor: AppColors.bg3,
                valueColor: const AlwaysStoppedAnimation(AppColors.sage500),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: _InlineMacro(
                    label: l10n.nutritionPlannedLabel,
                    totals: data.plannedTotals,
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: _InlineMacro(
                    label: l10n.nutritionDoneLabel,
                    totals: data.checkedTotals,
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            for (var index = 0; index < plannedMeals.length; index++) ...[
              _MealSection(date: date, meal: plannedMeals[index]),
              if (index < plannedMeals.length - 1)
                const SizedBox(height: AppSpacing.lg),
            ],
          ],
        ],
      ),
    );
  }
}

class _MealSection extends ConsumerWidget {
  const _MealSection({required this.date, required this.meal});

  final DateTime date;
  final MealPlanMeal meal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (meal.items.isEmpty) return const SizedBox.shrink();
    final languageCode = Localizations.localeOf(context).languageCode;
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
        const SizedBox(height: AppSpacing.sm),
        XnCardStack(
          itemPadding: EdgeInsets.zero,
          children: [
            for (final item in meal.items)
              _MealPlanItemRow(
                item: item,
                languageCode: languageCode,
                enabled: !pending,
                onChanged: (checked) {
                  unawaited(
                    ref
                        .read(mealPlanActionControllerProvider.notifier)
                        .setChecked(
                          date: date,
                          itemId: item.id,
                          checked: checked,
                        ),
                  );
                },
              ),
          ],
        ),
      ],
    );
  }
}

class _MealPlanItemRow extends StatelessWidget {
  const _MealPlanItemRow({
    required this.item,
    required this.languageCode,
    required this.enabled,
    required this.onChanged,
  });

  final MealPlanItem item;
  final String languageCode;
  final bool enabled;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    final isChecked = item.isChecked;
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(AppRadius.sm),
      child: InkWell(
        onTap: enabled ? () => onChanged(!isChecked) : null,
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.sm,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.displayNameFor(languageCode),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: isChecked ? AppColors.fg3 : AppColors.fg1,
                        decoration: isChecked
                            ? TextDecoration.lineThrough
                            : null,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      '${item.amountLabelFor(languageCode)} · '
                      '${item.plannedCalories} kcal · '
                      'P ${item.plannedProteinG.toStringAsFixed(0)} · '
                      'C ${item.plannedCarbsG.toStringAsFixed(0)} · '
                      'F ${item.plannedFatG.toStringAsFixed(0)}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.mono(11, color: AppColors.fg3),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Checkbox(
                value: isChecked,
                onChanged: enabled
                    ? (checked) => onChanged(checked ?? false)
                    : null,
                visualDensity: VisualDensity.compact,
                materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _InlineMacro extends StatelessWidget {
  const _InlineMacro({required this.label, required this.totals});

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
            style: AppTypography.mono(14, weight: FontWeight.w500),
          ),
          Text(
            'P ${totals.proteinG.toStringAsFixed(0)} · '
            'C ${totals.carbsG.toStringAsFixed(0)} · '
            'F ${totals.fatG.toStringAsFixed(0)}',
            style: AppTypography.mono(10, color: AppColors.fg3).copyWith(
              height: 1.3,
            ),
          ),
        ],
      ),
    );
  }
}

List<_CalculationItem> _buildCalculationItems(
  AppLocalizations l10n,
  NutritionCalculation calc,
  WeightUnit unit,
  double? targetWeightKg,
) {
  return [
    if (calc.bmr != null)
      _CalculationItem(l10n.nutritionBmrLabel, '${calc.bmr} kcal'),
    if (calc.tdee != null)
      _CalculationItem(l10n.nutritionTdeeLabel, '${calc.tdee} kcal'),
    if (calc.recommendedCalories != null)
      _CalculationItem(
        l10n.nutritionRecommendedLabel,
        '${calc.recommendedCalories} kcal',
      ),
    if (calc.bodyweightKg != null)
      _CalculationItem(
        l10n.nutritionBodyweightLabel,
        '${formatWeight(unit.fromKg(calc.bodyweightKg!))} ${unit.suffix}',
      ),
    if (calc.age != null)
      _CalculationItem(l10n.nutritionAgeLabel, '${calc.age}'),
    if (targetWeightKg != null)
      _CalculationItem(
        l10n.nutritionTargetWeightStatLabel,
        '${formatWeight(unit.fromKg(targetWeightKg))} ${unit.suffix}',
      ),
  ];
}

class _Header extends StatelessWidget {
  const _Header({required this.summary, required this.unit});

  final NutritionSummary summary;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final calculationItems = _buildCalculationItems(
      l10n,
      summary.calculation,
      unit,
      summary.profile.targetWeightKg,
    );
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 36,
                height: 36,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft.withValues(alpha: 0.58),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: const Icon(
                  Icons.restaurant_rounded,
                  size: 19,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.nutritionScreenTitle.toUpperCase(),
                      style: _eyebrow,
                    ),
                    const SizedBox(height: 3),
                    Text(
                      summary.calculation.calorieTarget != null
                          ? l10n.nutritionCalorieTargetTitle(
                              summary.calculation.calorieTarget!,
                            )
                          : l10n.nutritionDailyTitle,
                      style: AppTypography.display(
                        21,
                        letterSpacing: -0.2,
                        weight: FontWeight.w600,
                        height: 1.2,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              XnChip(label: nutritionEnumLabel(summary.profile.goal, l10n)),
              XnChip(
                label: nutritionEnumLabel(summary.profile.activityLevel, l10n),
                tone: XnChipTone.neutral,
              ),
              if (summary.canUseAdvancedAnalysis)
                XnChip(
                  label: l10n.nutritionProAnalysisChip,
                  tone: XnChipTone.sage,
                ),
            ],
          ),
          if (calculationItems.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            const Divider(height: 1),
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                const Icon(
                  Icons.calculate_outlined,
                  size: 16,
                  color: AppColors.fg3,
                ),
                const SizedBox(width: AppSpacing.md),
                Text(l10n.nutritionCalculationEyebrow, style: _eyebrow),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            _CalculationGrid(items: calculationItems),
          ],
        ],
      ),
    );
  }
}

class _IncompleteCard extends StatelessWidget {
  const _IncompleteCard({required this.missing, required this.onEdit});

  final List<String> missing;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.lg),
      decoration: _panelDecoration,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.info_outline_rounded, color: AppColors.warning),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  l10n.nutritionCompleteProfileTitle,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.nutritionCompleteProfileMessage,
            style: const TextStyle(color: AppColors.fg2),
          ),
          if (missing.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final field in missing)
                  XnChip(
                    label: nutritionEnumLabel(field, l10n),
                    tone: XnChipTone.warn,
                  ),
              ],
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.tune_rounded, size: 18),
              label: Text(l10n.nutritionEditProfileTooltip),
            ),
          ),
        ],
      ),
    );
  }
}

class _TodayCard extends StatelessWidget {
  const _TodayCard({
    required this.title,
    required this.calc,
    required this.consumedCalories,
    required this.consumedProtein,
    required this.consumedCarbs,
    required this.consumedFat,
  });

  final String title;
  final NutritionCalculation calc;
  final int consumedCalories;
  final double consumedProtein;
  final double consumedCarbs;
  final double consumedFat;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final target = calc.calorieTarget;
    final hasTarget = target != null && target > 0;
    final ratio = hasTarget ? (consumedCalories / target).clamp(0.0, 1.0) : 0.0;
    final remaining = hasTarget ? target - consumedCalories : null;

    return XnSection(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: _eyebrow)),
              if (target != null)
                _SoftPill(
                  icon: Icons.local_fire_department_rounded,
                  label: '$target kcal',
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(
                width: 96,
                height: 96,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      width: 96,
                      height: 96,
                      child: CircularProgressIndicator(
                        value: hasTarget ? ratio : 0,
                        strokeWidth: 9,
                        backgroundColor: AppColors.bg3,
                        valueColor: const AlwaysStoppedAnimation(
                          AppColors.accent,
                        ),
                      ),
                    ),
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          '$consumedCalories',
                          style: AppTypography.mono(
                            20,
                            weight: FontWeight.w500,
                          ),
                        ),
                        const Text(
                          'kcal',
                          style: TextStyle(color: AppColors.fg3, fontSize: 10),
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
                      label: l10n.nutritionProteinLabel,
                      logged: consumedProtein,
                      target: calc.proteinG,
                      color: AppColors.macroProtein,
                    ),
                    const SizedBox(height: 12),
                    _MacroBar(
                      label: l10n.nutritionCarbsLabel,
                      logged: consumedCarbs,
                      target: calc.carbsG,
                      color: AppColors.macroCarbs,
                    ),
                    const SizedBox(height: 12),
                    _MacroBar(
                      label: l10n.nutritionFatLabel,
                      logged: consumedFat,
                      target: calc.fatG,
                      color: AppColors.macroFat,
                    ),
                  ],
                ),
              ),
            ],
          ),
          if (remaining != null) ...[
            const SizedBox(height: AppSpacing.lg),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.lg,
                vertical: AppSpacing.md,
              ),
              decoration: BoxDecoration(
                color: remaining >= 0
                    ? AppColors.successBg
                    : AppColors.warningBg,
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              child: Text(
                remaining >= 0
                    ? l10n.nutritionKcalRemaining(remaining)
                    : l10n.nutritionKcalOverTarget(-remaining),
                style: const TextStyle(color: AppColors.fg2, fontSize: 13),
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _FoodLogCard extends StatelessWidget {
  const _FoodLogCard({
    required this.title,
    required this.logs,
    required this.onDelete,
    required this.onAdd,
  });

  final String title;
  final AsyncValue<FoodLogsForDate> logs;
  final ValueChanged<FoodLogItem> onDelete;
  final VoidCallback onAdd;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(title, style: _eyebrow)),
              FilledButton.icon(
                onPressed: onAdd,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.buttonPrimary,
                  foregroundColor: AppColors.fgOnClay,
                  shape: const StadiumBorder(),
                  elevation: 0,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 8,
                  ),
                  minimumSize: Size.zero,
                  tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  textStyle: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                icon: const Icon(Icons.add_rounded, size: 18),
                label: Text(l10n.nutritionAddFoodTitle),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          _content(l10n),
        ],
      ),
    );
  }

  Widget _content(AppLocalizations l10n) {
    final data = logs.value;
    // First load only: spinner / error. Otherwise keep the list during refresh.
    if (data == null) {
      if (logs.hasError) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
          child: Text(
            l10n.nutritionFoodLoadError,
            style: const TextStyle(color: AppColors.fg3),
          ),
        );
      }
      return const Padding(
        padding: EdgeInsets.symmetric(vertical: AppSpacing.lg),
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (data.items.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.md),
        child: Text(
          l10n.nutritionNothingLoggedMessage,
          style: const TextStyle(color: AppColors.fg3),
        ),
      );
    }
    return Column(
      children: [
        for (final item in data.items)
          _FoodLogRow(item: item, onDelete: () => onDelete(item)),
      ],
    );
  }
}

class _FoodLogRow extends StatelessWidget {
  const _FoodLogRow({required this.item, required this.onDelete});

  final FoodLogItem item;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayNameFor(languageCode),
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.amountLabelFor(languageCode)} · P ${item.computedProteinG.toStringAsFixed(0)} · '
                  'C ${item.computedCarbsG.toStringAsFixed(0)} · '
                  'F ${item.computedFatG.toStringAsFixed(0)}',
                  style: AppTypography.mono(11, color: AppColors.fg3),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            '${item.computedCalories}',
            style: AppTypography.mono(14, weight: FontWeight.w500),
          ),
          const Text(
            ' kcal',
            style: TextStyle(color: AppColors.fg3, fontSize: 11),
          ),
          IconButton(
            tooltip: l10n.commonRemove,
            visualDensity: VisualDensity.compact,
            icon: const Icon(
              Icons.close_rounded,
              size: 18,
              color: AppColors.fg3,
            ),
            onPressed: onDelete,
          ),
        ],
      ),
    );
  }
}

class _SoftPill extends StatelessWidget {
  const _SoftPill({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.md,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 15, color: AppColors.accent),
          const SizedBox(width: AppSpacing.sm),
          Text(
            label,
            style: AppTypography.mono(12, color: AppColors.fg2),
          ),
        ],
      ),
    );
  }
}

class _CalculationItem {
  const _CalculationItem(this.label, this.value);

  final String label;
  final String value;
}

/// Compact calculation figures separated by hairlines inside the summary card.
class _CalculationGrid extends StatelessWidget {
  const _CalculationGrid({required this.items});

  final List<_CalculationItem> items;

  @override
  Widget build(BuildContext context) {
    const hairline = AppColors.surfaceBorderSoft;
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.bgPage,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: hairline),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final columns = constraints.maxWidth >= 300 ? 3 : 2;
          final rows = (items.length + columns - 1) ~/ columns;

          return Column(
            children: [
              for (var r = 0; r < rows; r++) ...[
                if (r > 0)
                  const Divider(height: 1, thickness: 1, color: hairline),
                IntrinsicHeight(
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      for (var c = 0; c < columns; c++) ...[
                        if (c > 0 && r * columns + c < items.length)
                          const VerticalDivider(
                            width: 1,
                            thickness: 1,
                            color: hairline,
                          ),
                        Expanded(
                          child: r * columns + c < items.length
                              ? _CalculationStat(
                                  item: items[r * columns + c],
                                )
                              : const SizedBox.shrink(),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}

class _CalculationStat extends StatelessWidget {
  const _CalculationStat({required this.item});

  final _CalculationItem item;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            item.label.toUpperCase(),
            style: _eyebrow,
          ),
          const SizedBox(height: 6),
          Text(
            item.value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(
              16,
              weight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
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
    final trailing = t != null
        ? '${logged.toStringAsFixed(0)}/${t.toStringAsFixed(0)}g'
        : '${logged.toStringAsFixed(0)}g';
    return Row(
      children: [
        SizedBox(
          width: 51,
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 12,
              height: 1.2,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: ratio,
              minHeight: 7,
              backgroundColor: AppColors.bg3,
              valueColor: AlwaysStoppedAnimation(color),
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        SizedBox(
          width: 56,
          child: Text(
            trailing,
            textAlign: TextAlign.right,
            style: AppTypography.mono(11, color: AppColors.fg3),
          ),
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

/// The app's grouped-panel surface (matches [XnSectionGroup]) — a translucent
/// fill with a soft hairline border. Used for the standalone panels on this
/// screen so they read as one system with the grouped section list.
final _panelDecoration = BoxDecoration(
  color: AppColors.bg2.withValues(alpha: 0.92),
  borderRadius: BorderRadius.circular(AppRadius.xl),
  border: Border.all(
    color: AppColors.surfaceBorderSoft.withValues(alpha: 0.46),
  ),
);
