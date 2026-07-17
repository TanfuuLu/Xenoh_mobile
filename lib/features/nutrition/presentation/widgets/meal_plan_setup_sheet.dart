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

enum MealPlanSaveScope { day, week }

typedef MealPlanSaveHandler =
    Future<void> Function({
      required DateTime date,
      required List<Map<String, dynamic>> meals,
      String? notes,
    });

class MealPlanSetupSheet extends ConsumerStatefulWidget {
  const MealPlanSetupSheet({
    required this.date,
    this.initialPlan,
    this.onSave,
    super.key,
  });

  final DateTime date;
  final MealPlanDay? initialPlan;

  /// When supplied, saves each selected date through the caller's endpoint.
  /// This lets coaches use the same editor for a client's meal plan.
  final MealPlanSaveHandler? onSave;

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
  late final TextEditingController _notes = TextEditingController(
    text: widget.initialPlan?.notes ?? '',
  );
  late final List<_MealDraft> _meals = _initialMeals();

  DateTime get _weekStart =>
      _targetDate.subtract(Duration(days: _targetDate.weekday - 1));

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
        final dates = _scope == MealPlanSaveScope.day
            ? <DateTime>[_targetDate]
            : List.generate(
                7,
                (index) => _weekStart.add(Duration(days: index)),
              );
        for (final date in dates) {
          await onSave(date: date, meals: meals, notes: notes);
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
      await controller.saveWeek(
        weekStart: _weekStart,
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
                'grams': item.grams,
                'sortOrder': itemIndex,
                if (item.servingLabel != null)
                  'servingLabel': item.servingLabel,
                if (item.servingLabelVi != null)
                  'servingLabelVi': item.servingLabelVi,
                if (item.servingLabelEn != null)
                  'servingLabelEn': item.servingLabelEn,
                if (item.servingCount != null)
                  'servingCount': item.servingCount,
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
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        child: DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.92,
          minChildSize: 0.64,
          maxChildSize: 0.96,
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
                            22,
                            weight: FontWeight.w500,
                            letterSpacing: 0,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          _scope == MealPlanSaveScope.day
                              ? DateOnly.format(_targetDate)
                              : '${DateOnly.format(_weekStart)} - '
                                    '${DateOnly.format(_weekStart.add(const Duration(days: 6)))}',
                          style: const TextStyle(
                            color: AppColors.fg3,
                            fontSize: 13,
                            fontWeight: FontWeight.w500,
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
              const SizedBox(height: AppSpacing.md),
              SegmentedButton<MealPlanSaveScope>(
                segments: [
                  ButtonSegment(
                    value: MealPlanSaveScope.day,
                    icon: const Icon(Icons.today_rounded),
                    label: Text(l10n.nutritionDayCreateSegment),
                  ),
                  ButtonSegment(
                    value: MealPlanSaveScope.week,
                    icon: const Icon(Icons.date_range_rounded),
                    label: Text(l10n.nutritionWeeklyCreateSegment),
                  ),
                ],
                selected: {_scope},
                onSelectionChanged: saving
                    ? null
                    : (value) => setState(() => _scope = value.first),
              ),
              const SizedBox(height: AppSpacing.md),
              _TargetDatePicker(
                scope: _scope,
                date: _targetDate,
                weekStart: _weekStart,
                onPickDate: saving ? null : _pickTargetDate,
              ),
              const SizedBox(height: AppSpacing.md),
              Expanded(
                child: ListView(
                  controller: controller,
                  children: [
                    for (final meal in _meals)
                      _MealEditor(
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
                    OutlinedButton.icon(
                      onPressed: saving
                          ? null
                          : () => setState(
                              () => _meals.add(
                                _MealDraft.empty(l10n.nutritionMealLabel),
                              ),
                            ),
                      icon: const Icon(Icons.add_rounded),
                      label: Text(l10n.nutritionAddMealCta),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    XnInput(
                      label: l10n.nutritionNotesLabel,
                      controller: _notes,
                    ),
                    const SizedBox(height: AppSpacing.lg),
                  ],
                ),
              ),
              XnButton(
                label: _scope == MealPlanSaveScope.day
                    ? l10n.nutritionCreateDayCta
                    : l10n.nutritionWeeklyCreateSegment,
                icon: Icons.check_rounded,
                loading: saving,
                onPressed: _save,
              ),
            ],
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
    required this.weekStart,
    required this.onPickDate,
  });

  final MealPlanSaveScope scope;
  final DateTime date;
  final DateTime weekStart;
  final VoidCallback? onPickDate;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final weekEnd = weekStart.add(const Duration(days: 6));
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        children: [
          Icon(
            scope == MealPlanSaveScope.day
                ? Icons.today_rounded
                : Icons.date_range_rounded,
            color: AppColors.fg2,
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
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  scope == MealPlanSaveScope.day
                      ? DateOnly.format(date)
                      : '${DateOnly.format(weekStart)} - '
                            '${DateOnly.format(weekEnd)}',
                  style: AppTypography.mono(
                    14,
                    color: AppColors.fg1,
                    weight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
          if (scope == MealPlanSaveScope.day)
            TextButton.icon(
              onPressed: onPickDate,
              icon: const Icon(Icons.edit_calendar_rounded, size: 18),
              label: Text(l10n.nutritionChooseDayCta),
            ),
        ],
      ),
    );
  }
}

class _MealEditor extends StatelessWidget {
  const _MealEditor({
    required this.meal,
    required this.saving,
    required this.onAddFood,
    required this.onRemoveItem,
    this.onRemoveMeal,
  });

  final _MealDraft meal;
  final bool saving;
  final VoidCallback onAddFood;
  final VoidCallback? onRemoveMeal;
  final ValueChanged<_MealItemDraft> onRemoveItem;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.md),
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: XnInput(
                  label: l10n.nutritionMealLabel,
                  controller: meal.name,
                  enabled: !saving,
                ),
              ),
              if (onRemoveMeal != null) ...[
                const SizedBox(width: AppSpacing.sm),
                IconButton(
                  tooltip: l10n.nutritionRemoveMealTooltip,
                  onPressed: saving ? null : onRemoveMeal,
                  icon: const Icon(Icons.delete_outline_rounded),
                  color: AppColors.danger,
                ),
              ],
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          if (meal.items.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              child: Text(
                l10n.nutritionNoFoodsAddedMessage,
                style: const TextStyle(color: AppColors.fg3),
              ),
            )
          else
            for (final item in meal.items)
              _MealItemRow(
                item: item,
                saving: saving,
                onRemove: () => onRemoveItem(item),
              ),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: OutlinedButton.icon(
              onPressed: saving ? null : onAddFood,
              icon: const Icon(Icons.add_rounded, size: 18),
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
                    itemCount: foods.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      color: AppColors.surfaceBorderSoft,
                    ),
                    itemBuilder: (_, index) {
                      final food = foods[index];
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        title: Text(
                          food.displayNameFor(languageCode),
                          style: const TextStyle(fontWeight: FontWeight.w500),
                        ),
                        subtitle: Text(
                          '${food.caloriesPer100g.toStringAsFixed(0)} kcal - '
                          'P ${food.proteinPer100g.toStringAsFixed(0)} - '
                          'C ${food.carbsPer100g.toStringAsFixed(0)} - '
                          'F ${food.fatPer100g.toStringAsFixed(0)} /100g',
                          style: AppTypography.mono(
                            11,
                            color: AppColors.fg3,
                          ),
                        ),
                        trailing: const Icon(Icons.chevron_right_rounded),
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
}

String _g(double value) => value == value.roundToDouble()
    ? value.toStringAsFixed(0)
    : value.toStringAsFixed(1);
