import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/nutrition_repository_provider.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/meal_plan.dart';
import '../providers/nutrition_controller.dart';
import 'ai_food_lookup_empty_state.dart';
import 'food_search_result_card.dart';

enum MealPlanSaveScope { day, week }

typedef MealPlanSaveHandler =
    Future<void> Function({
      required DateTime date,
      required List<Map<String, dynamic>> meals,
      String? notes,
    });

typedef MealPlanWeekSaveHandler =
    Future<void> Function({
      required DateTime startDate,
      required DateTime endDate,
      required List<Map<String, dynamic>> meals,
      String? notes,
    });

typedef MealPlanDateRangePicker =
    Future<DateTimeRange?> Function({required DateTimeRange initialRange});

class MealPlanSetupSheet extends ConsumerStatefulWidget {
  const MealPlanSetupSheet({
    required this.date,
    this.initialPlan,
    this.onSave,
    this.onSaveWeek,
    this.pickDateRange,
    super.key,
  });

  final DateTime date;
  final MealPlanDay? initialPlan;

  /// Saves one selected day through a caller-provided endpoint.
  final MealPlanSaveHandler? onSave;

  /// Saves the selected date range atomically when weekly mode is active.
  final MealPlanWeekSaveHandler? onSaveWeek;
  final MealPlanDateRangePicker? pickDateRange;

  static const scopeSelectorKey = Key('meal-plan-scope-selector');
  static const selectedScopeKey = Key('meal-plan-selected-scope');
  static const dateRowKey = Key('meal-plan-date-row');
  static const mealListPanelKey = Key('meal-plan-list-panel');
  static const footerKey = Key('meal-plan-footer');

  @override
  ConsumerState<MealPlanSetupSheet> createState() => _MealPlanSetupSheetState();
}

class _MealPlanSetupSheetState extends ConsumerState<MealPlanSetupSheet> {
  late MealPlanSaveScope _scope = MealPlanSaveScope.day;
  bool _isSaving = false;
  late DateTime _targetDate = DateTime(
    widget.date.year,
    widget.date.month,
    widget.date.day,
  );
  late DateTime _rangeStart = _targetDate.subtract(
    Duration(days: _targetDate.weekday - 1),
  );
  late DateTime _rangeEnd = _rangeStart.add(const Duration(days: 6));
  late final TextEditingController _notes = TextEditingController(
    text: widget.initialPlan?.notes ?? '',
  );
  late final List<_MealDraft> _meals = _initialMeals();

  @override
  void dispose() {
    _notes.dispose();
    for (final meal in _meals) {
      meal.dispose();
    }
    super.dispose();
  }

  List<_MealDraft> _initialMeals() {
    final existing = widget.initialPlan?.meals ?? const <MealPlanMeal>[];
    if (existing.isNotEmpty) {
      final languageCode = Localizations.localeOf(context).languageCode;
      return existing
          .map((meal) => _MealDraft.fromMeal(meal, languageCode))
          .toList();
    }
    final l10n = AppLocalizations.of(context);
    return [
      _MealDraft.empty(l10n.nutritionMealBreakfast),
      _MealDraft.empty(l10n.nutritionMealLunch),
      _MealDraft.empty(l10n.nutritionMealDinner),
      _MealDraft.empty(l10n.nutritionMealSnack),
    ];
  }

  Future<void> _addFood(_MealDraft meal) async {
    final food = await showModalBottomSheet<FoodItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => const _FoodPickerSheet(),
    );
    if (food == null || !mounted) return;

    final item = await showDialog<_MealItemDraft>(
      context: context,
      builder: (_) => _AmountDialog(food: food),
    );
    if (item == null || !mounted) return;
    setState(() => meal.items.add(item));
  }

  Future<void> _save() async {
    final meals = _payload();
    final notes = _notes.text.trim().isEmpty ? null : _notes.text.trim();
    final messenger = ScaffoldMessenger.of(context);

    if (widget.onSave case final onSave?) {
      setState(() => _isSaving = true);
      try {
        final onSaveWeek = widget.onSaveWeek;
        if (_scope == MealPlanSaveScope.week && onSaveWeek != null) {
          await onSaveWeek(
            startDate: _rangeStart,
            endDate: _rangeEnd,
            meals: meals,
            notes: notes,
          );
        } else {
          final dates = _scope == MealPlanSaveScope.day
              ? <DateTime>[_targetDate]
              : List.generate(
                  _rangeEnd.difference(_rangeStart).inDays + 1,
                  (index) => _rangeStart.add(Duration(days: index)),
                );
          for (final date in dates) {
            await onSave(date: date, meals: meals, notes: notes);
          }
        }
      } catch (error) {
        if (!mounted) return;
        setState(() => _isSaving = false);
        messenger
          ..hideCurrentSnackBar()
          ..showSnackBar(SnackBar(content: Text('$error')));
        return;
      }

      if (!mounted) return;
      Navigator.pop(context, _targetDate);
      return;
    }

    final controller = ref.read(mealPlanActionControllerProvider.notifier);
    if (_scope == MealPlanSaveScope.day) {
      await controller.saveDay(date: _targetDate, meals: meals, notes: notes);
    } else {
      await controller.saveRange(
        startDate: _rangeStart,
        endDate: _rangeEnd,
        meals: meals,
        notes: notes,
      );
    }

    final error = ref.read(mealPlanActionControllerProvider).error;
    if (!mounted) return;
    if (error != null) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$error')));
      return;
    }
    Navigator.pop(context, _targetDate);
  }

  Future<void> _pickTargetDate() async {
    final picked = await showDatePicker(
      context: context,
      initialDate: _targetDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2035),
    );
    if (picked == null || !mounted) return;
    setState(() {
      _targetDate = DateTime(picked.year, picked.month, picked.day);
    });
  }

  Future<void> _pickTargetRange() async {
    final initialRange = DateTimeRange(start: _rangeStart, end: _rangeEnd);
    final picked =
        await (widget.pickDateRange?.call(
              initialRange: initialRange,
            ) ??
            showDateRangePicker(
              context: context,
              initialDateRange: initialRange,
              firstDate: DateTime(2020),
              lastDate: DateTime(2035),
            ));
    if (picked == null || !mounted) return;
    setState(() {
      _rangeStart = DateTime(
        picked.start.year,
        picked.start.month,
        picked.start.day,
      );
      _rangeEnd = DateTime(
        picked.end.year,
        picked.end.month,
        picked.end.day,
      );
    });
  }

  List<Map<String, dynamic>> _payload() => [
    for (final (index, meal) in _meals.indexed)
      if (meal.name.text.trim().isNotEmpty)
        {
          'name': meal.name.text.trim(),
          'sortOrder': index,
          'items': [
            for (final (itemIndex, item) in meal.items.indexed)
              {
                'foodItemId': item.foodItemId,
                'sortOrder': itemIndex,
                if (item.hasServingAmount) ...{
                  'servingLabel': item.servingLabel,
                  'servingCount': item.servingCount,
                } else
                  'grams': item.grams,
              },
          ],
        },
  ];

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final saving = widget.onSave == null
        ? ref.watch(mealPlanActionControllerProvider).isLoading
        : _isSaving;
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.md,
          right: AppSpacing.md,
          top: AppSpacing.sm,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.md,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.94,
          minChildSize: 0.64,
          maxChildSize: 0.98,
          builder: (context, controller) => Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          l10n.nutritionCreateMealPlanTitle,
                          style: AppTypography.display(
                            24,
                            weight: FontWeight.w600,
                            letterSpacing: -0.25,
                          ),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    tooltip: l10n.commonClose,
                    onPressed: saving ? null : () => Navigator.pop(context),
                    icon: const Icon(Icons.close_rounded),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.sm),
              _ScopeSelector(
                scope: _scope,
                enabled: !saving,
                onChanged: (scope) => setState(() => _scope = scope),
              ),
              const SizedBox(height: AppSpacing.sm),
              _TargetDatePicker(
                scope: _scope,
                date: _targetDate,
                rangeStart: _rangeStart,
                rangeEnd: _rangeEnd,
                onPick: saving
                    ? null
                    : _scope == MealPlanSaveScope.day
                    ? _pickTargetDate
                    : _pickTargetRange,
              ),
              const SizedBox(height: AppSpacing.sm),
              Expanded(
                child: ListView(
                  controller: controller,
                  keyboardDismissBehavior:
                      ScrollViewKeyboardDismissBehavior.onDrag,
                  children: [
                    Container(
                      key: MealPlanSetupSheet.mealListPanelKey,
                      clipBehavior: Clip.antiAlias,
                      decoration: BoxDecoration(
                        color: AppColors.bg2,
                        borderRadius: BorderRadius.circular(AppRadius.lg),
                        border: Border.all(
                          color: AppColors.surfaceBorderSoft,
                        ),
                      ),
                      child: Column(
                        children: [
                          for (final (index, meal) in _meals.indexed) ...[
                            _MealEditor(
                              index: index,
                              meal: meal,
                              saving: saving,
                              onAddFood: () => _addFood(meal),
                              onRemoveMeal: _meals.length <= 1
                                  ? null
                                  : () => setState(() {
                                      meal.dispose();
                                      _meals.remove(meal);
                                    }),
                              onRemoveItem: (item) =>
                                  setState(() => meal.items.remove(item)),
                            ),
                            if (index != _meals.length - 1)
                              const Divider(height: 1),
                          ],
                        ],
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: TextButton.icon(
                        onPressed: saving
                            ? null
                            : () => setState(
                                () => _meals.add(
                                  _MealDraft.empty(l10n.nutritionMealLabel),
                                ),
                              ),
                        icon: const Icon(Icons.add_rounded, size: 18),
                        label: Text(l10n.nutritionAddMealCta),
                      ),
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    XnInput(
                      label: l10n.nutritionNotesLabel,
                      controller: _notes,
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ),
              ),
              Container(
                key: MealPlanSetupSheet.footerKey,
                padding: const EdgeInsets.only(top: AppSpacing.sm),
                decoration: const BoxDecoration(
                  color: AppColors.bgPage,
                  border: Border(
                    top: BorderSide(color: AppColors.surfaceBorderSoft),
                  ),
                ),
                child: XnButton(
                  label: _scope == MealPlanSaveScope.day
                      ? l10n.nutritionCreateDayCta
                      : l10n.nutritionCreateWeekCta,
                  icon: Icons.check_rounded,
                  loading: saving,
                  onPressed: _save,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ScopeSelector extends StatelessWidget {
  const _ScopeSelector({
    required this.scope,
    required this.enabled,
    required this.onChanged,
  });

  final MealPlanSaveScope scope;
  final bool enabled;
  final ValueChanged<MealPlanSaveScope> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      key: MealPlanSetupSheet.scopeSelectorKey,
      height: 44,
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.72),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ScopeOption(
              label: l10n.nutritionDayCreateSegment,
              icon: Icons.today_rounded,
              selected: scope == MealPlanSaveScope.day,
              enabled: enabled,
              onTap: () => onChanged(MealPlanSaveScope.day),
            ),
          ),
          Expanded(
            child: _ScopeOption(
              label: l10n.nutritionWeeklyCreateSegment,
              icon: Icons.date_range_rounded,
              selected: scope == MealPlanSaveScope.week,
              enabled: enabled,
              onTap: () => onChanged(MealPlanSaveScope.week),
            ),
          ),
        ],
      ),
    );
  }
}

class _ScopeOption extends StatelessWidget {
  const _ScopeOption({
    required this.label,
    required this.icon,
    required this.selected,
    required this.enabled,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool selected;
  final bool enabled;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final foreground = !enabled
        ? AppColors.fg4
        : selected
        ? AppColors.clay900
        : AppColors.fg3;
    return SizedBox.expand(
      child: Semantics(
        button: true,
        selected: selected,
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.sm),
          child: InkWell(
            onTap: enabled ? onTap : null,
            borderRadius: BorderRadius.circular(AppRadius.sm),
            child: AnimatedContainer(
              key: selected ? MealPlanSetupSheet.selectedScopeKey : null,
              duration: AppMotion.fast,
              margin: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                color: selected ? AppColors.accentSoft : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(
                  color: selected ? AppColors.clay200 : Colors.transparent,
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(icon, size: 16, color: foreground),
                  const SizedBox(width: 6),
                  Flexible(
                    child: Text(
                      label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: foreground,
                        fontSize: 13,
                        fontWeight: selected
                            ? FontWeight.w600
                            : FontWeight.w500,
                      ),
                    ),
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

class _TargetDatePicker extends StatelessWidget {
  const _TargetDatePicker({
    required this.scope,
    required this.date,
    required this.rangeStart,
    required this.rangeEnd,
    required this.onPick,
  });

  final MealPlanSaveScope scope;
  final DateTime date;
  final DateTime rangeStart;
  final DateTime rangeEnd;
  final VoidCallback? onPick;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Material(
      key: MealPlanSetupSheet.dateRowKey,
      color: AppColors.accentSoft.withValues(alpha: 0.54),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppRadius.lg),
        side: BorderSide(
          color: AppColors.accent.withValues(alpha: 0.16),
        ),
      ),
      child: InkWell(
        onTap: onPick,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.sm,
          ),
          child: Row(
            children: [
              Container(
                width: 34,
                height: 34,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.bg2,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Icon(
                  scope == MealPlanSaveScope.day
                      ? Icons.today_rounded
                      : Icons.date_range_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      scope == MealPlanSaveScope.day
                          ? l10n.nutritionCreateForLabel
                          : l10n.nutritionWeekLabel,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      scope == MealPlanSaveScope.day
                          ? DateOnly.format(date)
                          : '${DateOnly.format(rangeStart)} - '
                                '${DateOnly.format(rangeEnd)}',
                      style: AppTypography.mono(
                        14,
                        color: AppColors.fg1,
                        weight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              ...[
                Text(
                  scope == MealPlanSaveScope.day
                      ? l10n.nutritionChooseDayCta
                      : l10n.commonEdit,
                  style: const TextStyle(
                    color: AppColors.accent,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(width: AppSpacing.xs),
                const Icon(
                  Icons.chevron_right_rounded,
                  size: 18,
                  color: AppColors.accent,
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _MealEditor extends StatelessWidget {
  const _MealEditor({
    required this.index,
    required this.meal,
    required this.saving,
    required this.onAddFood,
    required this.onRemoveItem,
    this.onRemoveMeal,
  });

  final int index;
  final _MealDraft meal;
  final bool saving;
  final VoidCallback onAddFood;
  final VoidCallback? onRemoveMeal;
  final ValueChanged<_MealItemDraft> onRemoveItem;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                ),
                child: Text(
                  '${index + 1}'.padLeft(2, '0'),
                  style: AppTypography.mono(
                    12,
                    color: AppColors.accent,
                    weight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Semantics(
                  label: '${l10n.nutritionMealLabel} ${index + 1}',
                  textField: true,
                  child: TextField(
                    controller: meal.name,
                    enabled: !saving,
                    textInputAction: TextInputAction.done,
                    style: const TextStyle(
                      color: AppColors.fg1,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                    decoration: InputDecoration(
                      hintText: l10n.nutritionMealLabel,
                      filled: false,
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(vertical: 7),
                      border: InputBorder.none,
                      enabledBorder: InputBorder.none,
                      focusedBorder: const UnderlineInputBorder(
                        borderSide: BorderSide(
                          color: AppColors.accent,
                          width: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              if (onRemoveMeal != null) ...[
                IconButton(
                  tooltip: l10n.nutritionRemoveMealTooltip,
                  onPressed: saving ? null : onRemoveMeal,
                  visualDensity: VisualDensity.compact,
                  icon: const Icon(Icons.delete_outline_rounded, size: 19),
                  color: AppColors.danger,
                ),
              ],
            ],
          ),
          if (meal.items.isEmpty)
            Padding(
              padding: const EdgeInsets.fromLTRB(
                37,
                AppSpacing.xs,
                0,
                AppSpacing.xs,
              ),
              child: Text(
                l10n.nutritionNoFoodsAddedMessage,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 13,
                ),
              ),
            )
          else
            for (final item in meal.items)
              _MealItemRow(
                item: item,
                saving: saving,
                onRemove: () => onRemoveItem(item),
              ),
          Padding(
            padding: const EdgeInsets.only(left: 30),
            child: TextButton.icon(
              onPressed: saving ? null : onAddFood,
              icon: const Icon(Icons.add_rounded, size: 17),
              label: Text(l10n.nutritionAddFoodTitle),
            ),
          ),
        ],
      ),
    );
  }
}

class _MealItemRow extends StatelessWidget {
  const _MealItemRow({
    required this.item,
    required this.saving,
    required this.onRemove,
  });

  final _MealItemDraft item;
  final bool saving;
  final VoidCallback onRemove;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${_g(item.grams)} g - ${item.calories} kcal - '
                  'P ${item.proteinG.toStringAsFixed(0)} - '
                  'C ${item.carbsG.toStringAsFixed(0)} - '
                  'F ${item.fatG.toStringAsFixed(0)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.mono(11, color: AppColors.fg3),
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: l10n.nutritionRemoveFoodTooltip,
            onPressed: saving ? null : onRemove,
            icon: const Icon(Icons.close_rounded, size: 18),
            color: AppColors.fg3,
          ),
        ],
      ),
    );
  }
}

class _FoodPickerSheet extends ConsumerStatefulWidget {
  const _FoodPickerSheet();

  @override
  ConsumerState<_FoodPickerSheet> createState() => _FoodPickerSheetState();
}

class _FoodPickerSheetState extends ConsumerState<_FoodPickerSheet> {
  final _search = TextEditingController();
  String _query = '';
  bool _aiLoading = false;

  @override
  void dispose() {
    _search.dispose();
    super.dispose();
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));

  Future<void> _lookupWithAi() async {
    final l10n = AppLocalizations.of(context);
    final name = _search.text.trim();
    if (name.length < 2) {
      _snack(l10n.nutritionTypeFoodNameFirstMessage);
      return;
    }

    setState(() => _aiLoading = true);
    try {
      final food = await ref
          .read(nutritionRepositoryProvider)
          .resolveFood(
            name: name,
            lang: ref.read(appLocaleProvider)?.languageCode ?? 'en',
          );
      if (!mounted) return;
      Navigator.pop(context, food);
    } on ForbiddenFailure {
      if (!mounted) return;
      setState(() => _aiLoading = false);
      _snack(l10n.nutritionAiProFeatureError);
    } on RateLimitFailure {
      if (!mounted) return;
      setState(() => _aiLoading = false);
      _snack(l10n.nutritionAiLimitReachedError);
    } catch (e) {
      if (!mounted) return;
      setState(() => _aiLoading = false);
      _snack('$e');
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final results = ref.watch(foodSearchProvider(_query));
    return SafeArea(
      top: false,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.nutritionSelectFoodTitle,
              style: AppTypography.display(20, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.md),
            XnInput(
              label: l10n.nutritionSearchFoodsLabel,
              hint: l10n.nutritionSearchFoodsHint,
              controller: _search,
              onChanged: (value) => setState(() => _query = value),
            ),
            const SizedBox(height: AppSpacing.md),
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.42,
              child: results.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(
                  child: Text(
                    '$e',
                    style: const TextStyle(color: AppColors.fg3),
                  ),
                ),
                data: (foods) {
                  if (_query.trim().length < 2) {
                    return _SheetHint(
                      l10n.nutritionTypeAtLeast2CharsShortMessage,
                    );
                  }
                  if (foods.isEmpty) {
                    return AiFoodLookupEmptyState(
                      query: _query,
                      loading: _aiLoading,
                      onLookup: _lookupWithAi,
                    );
                  }
                  return ListView.separated(
                    padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                    itemCount: foods.length,
                    separatorBuilder: (_, _) =>
                        const SizedBox(height: AppSpacing.sm),
                    itemBuilder: (_, index) {
                      final food = foods[index];
                      return FoodSearchResultCard(
                        food: food,
                        languageCode: languageCode,
                        onTap: () => Navigator.pop(context, food),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _AmountDialog extends StatefulWidget {
  const _AmountDialog({required this.food});

  final FoodItem food;

  @override
  State<_AmountDialog> createState() => _AmountDialogState();
}

class _AmountDialogState extends State<_AmountDialog> {
  late FoodServing? _serving = widget.food.servings.isNotEmpty
      ? widget.food.servings.first
      : null;
  late final _amount = TextEditingController(
    text: _serving != null ? '1' : '100',
  );

  @override
  void dispose() {
    _amount.dispose();
    super.dispose();
  }

  double get _grams {
    final amount = double.tryParse(_amount.text.trim()) ?? 0;
    return _serving == null ? amount : amount * _serving!.grams;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    return AlertDialog(
      title: Text(widget.food.displayNameFor(languageCode)),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if (widget.food.servings.isNotEmpty) ...[
            XnDropdown<String>(
              label: l10n.nutritionUnitLabel,
              value: _serving?.id ?? '_grams',
              options: [
                XnDropdownOption(
                  value: '_grams',
                  label: l10n.nutritionGramsOption,
                ),
                for (final serving in widget.food.servings)
                  XnDropdownOption(
                    value: serving.id,
                    label:
                        '${serving.displayLabelFor(languageCode)} (${_g(serving.grams)} g)',
                  ),
              ],
              onChanged: (id) => setState(() {
                _serving = id == '_grams'
                    ? null
                    : widget.food.servings.firstWhere((s) => s.id == id);
                _amount.text = _serving == null ? '100' : '1';
              }),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
          TextField(
            controller: _amount,
            autofocus: true,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
            inputFormatters: [
              FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
            ],
            decoration: InputDecoration(
              labelText: _serving == null
                  ? l10n.nutritionGramsOption
                  : l10n.nutritionServingsLabel,
            ),
            onChanged: (_) => setState(() {}),
            onSubmitted: (_) => _confirm(),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            '${_g(_grams)} g - '
            '${(widget.food.caloriesPer100g * _grams / 100).round()} kcal',
            style: AppTypography.mono(13, color: AppColors.fg2),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _grams > 0 ? _confirm : null,
          child: Text(l10n.commonAdd),
        ),
      ],
    );
  }

  void _confirm() {
    if (_grams <= 0) return;
    Navigator.pop(
      context,
      _MealItemDraft.fromFood(
        food: widget.food,
        grams: _grams,
        languageCode: Localizations.localeOf(context).languageCode,
        serving: _serving,
        servingCount: _serving == null
            ? null
            : double.tryParse(_amount.text.trim()),
      ),
    );
  }
}

class _SheetHint extends StatelessWidget {
  const _SheetHint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Text(
      text,
      textAlign: TextAlign.center,
      style: const TextStyle(color: AppColors.fg3),
    ),
  );
}

class _MealDraft {
  _MealDraft({required String name, required this.items})
    : name = TextEditingController(text: name);

  factory _MealDraft.empty(String name) => _MealDraft(
    name: name,
    items: <_MealItemDraft>[],
  );

  factory _MealDraft.fromMeal(MealPlanMeal meal, String languageCode) =>
      _MealDraft(
        name: meal.name,
        items: meal.items
            .map((item) => _MealItemDraft.fromMealItem(item, languageCode))
            .toList(),
      );

  final TextEditingController name;
  final List<_MealItemDraft> items;

  void dispose() => name.dispose();
}

class _MealItemDraft {
  const _MealItemDraft({
    required this.foodItemId,
    required this.displayName,
    required this.grams,
    required this.calories,
    required this.proteinG,
    required this.carbsG,
    required this.fatG,
    this.servingLabelVi,
    this.servingLabelEn,
    this.servingCount,
  });

  factory _MealItemDraft.fromFood({
    required FoodItem food,
    required double grams,
    required String languageCode,
    FoodServing? serving,
    double? servingCount,
  }) => _MealItemDraft(
    foodItemId: food.id,
    displayName: food.displayNameFor(languageCode),
    grams: grams,
    calories: (food.caloriesPer100g * grams / 100).round(),
    proteinG: food.proteinPer100g * grams / 100,
    carbsG: food.carbsPer100g * grams / 100,
    fatG: food.fatPer100g * grams / 100,
    servingLabelVi: serving?.labelVi,
    servingLabelEn: serving?.labelEn,
    servingCount: servingCount,
  );

  factory _MealItemDraft.fromMealItem(
    MealPlanItem item,
    String languageCode,
  ) => _MealItemDraft(
    foodItemId: item.foodItemId,
    displayName: item.displayNameFor(languageCode),
    grams: item.grams,
    calories: item.plannedCalories,
    proteinG: item.plannedProteinG,
    carbsG: item.plannedCarbsG,
    fatG: item.plannedFatG,
    servingLabelVi: item.servingLabelVi,
    servingLabelEn: item.servingLabelEn,
    servingCount: item.servingCount,
  );

  final String foodItemId;
  final String displayName;
  final double grams;
  final int calories;
  final double proteinG;
  final double carbsG;
  final double fatG;
  final String? servingLabelVi;
  final String? servingLabelEn;
  final double? servingCount;

  String? get servingLabel => servingLabelVi ?? servingLabelEn;

  bool get hasServingAmount =>
      servingLabel?.trim().isNotEmpty == true &&
      servingCount != null &&
      servingCount! > 0;
}

String _g(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(1);
