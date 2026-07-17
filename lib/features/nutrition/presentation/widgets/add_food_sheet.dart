import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/nutrition_repository_provider.dart';
import '../../domain/entities/food.dart';
import '../providers/nutrition_controller.dart';
import 'ai_food_lookup_empty_state.dart';

/// Search + log a food for [date]. Invalidates the day's logs + summary on a
/// successful add, then pops.
class AddFoodSheet extends ConsumerStatefulWidget {
  const AddFoodSheet({required this.date, super.key});

  final DateTime date;

  @override
  ConsumerState<AddFoodSheet> createState() => _AddFoodSheetState();
}

class _AddFoodSheetState extends ConsumerState<AddFoodSheet> {
  final _searchController = TextEditingController();
  String _query = '';
  bool _aiLoading = false;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  void _snack(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));

  /// AI macro estimation: resolve the typed name into a food, then confirm the
  /// amount (and macros) before logging. Pro-gated + rate-limited.
  Future<void> _estimateWithAi() async {
    final l10n = AppLocalizations.of(context);
    final name = _searchController.text.trim();
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
      setState(() => _aiLoading = false);
      await _logFood(food);
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

  Future<void> _logFood(FoodItem food) async {
    final messenger = ScaffoldMessenger.of(context);
    final grams = await showDialog<double>(
      context: context,
      builder: (_) => _AmountDialog(food: food),
    );
    if (grams == null) return;
    try {
      await ref
          .read(nutritionRepositoryProvider)
          .addFoodLog(date: widget.date, foodItemId: food.id, grams: grams);
      ref
        ..invalidate(foodLogsProvider(widget.date))
        ..invalidate(nutritionControllerProvider);
      if (!mounted) return;
      final languageCode = Localizations.localeOf(context).languageCode;
      final message = AppLocalizations.of(
        context,
      ).nutritionLoggedSnackbar(food.displayNameFor(languageCode));
      Navigator.pop(context);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(message)));
    } catch (e) {
      if (!mounted) return;
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$e')));
    }
  }

  Future<void> _createCustom() async {
    final food = await showModalBottomSheet<FoodItem>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => const _CustomFoodSheet(),
    );
    if (food != null) await _logFood(food);
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final results = ref.watch(foodSearchProvider(_query));

    return Padding(
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
          Wrap(
            alignment: WrapAlignment.spaceBetween,
            crossAxisAlignment: WrapCrossAlignment.center,
            runSpacing: AppSpacing.xs,
            children: [
              Text(
                l10n.nutritionAddFoodTitle,
                style: AppTypography.display(20, letterSpacing: 0),
              ),
              Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  TextButton.icon(
                    onPressed: _aiLoading ? null : _estimateWithAi,
                    icon: _aiLoading
                        ? const SizedBox(
                            width: 16,
                            height: 16,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : const Icon(Icons.auto_awesome_rounded, size: 18),
                    label: Text(l10n.nutritionAiEstimateCta),
                  ),
                  TextButton.icon(
                    onPressed: _createCustom,
                    icon: const Icon(Icons.add_rounded, size: 18),
                    label: Text(l10n.nutritionCustomCta),
                  ),
                ],
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          XnInput(
            label: l10n.nutritionSearchFoodsLabel,
            hint: l10n.nutritionSearchFoodsHint,
            controller: _searchController,
            onChanged: (v) => setState(() => _query = v),
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
                  return _Hint(l10n.nutritionTypeAtLeast2CharsMessage);
                }
                if (foods.isEmpty) {
                  return AiFoodLookupEmptyState(
                    query: _query,
                    loading: _aiLoading,
                    onLookup: _estimateWithAi,
                  );
                }
                return ListView.separated(
                  itemCount: foods.length,
                  separatorBuilder: (_, _) => const Divider(
                    height: 1,
                    color: AppColors.surfaceBorderSoft,
                  ),
                  itemBuilder: (_, i) {
                    final food = foods[i];
                    return ListTile(
                      contentPadding: EdgeInsets.zero,
                      title: Text(
                        food.displayNameFor(languageCode),
                        style: const TextStyle(fontWeight: FontWeight.w500),
                      ),
                      subtitle: Text(
                        '${food.caloriesPer100g.toStringAsFixed(0)} kcal · '
                        'P ${food.proteinPer100g.toStringAsFixed(0)} · '
                        'C ${food.carbsPer100g.toStringAsFixed(0)} · '
                        'F ${food.fatPer100g.toStringAsFixed(0)} /100g',
                        style: AppTypography.mono(11, color: AppColors.fg3),
                      ),
                      trailing: const Icon(Icons.add_circle_outline_rounded),
                      onTap: () => _logFood(food),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _Hint extends StatelessWidget {
  const _Hint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Text(
        text,
        textAlign: TextAlign.center,
        style: const TextStyle(color: AppColors.fg3),
      ),
    ),
  );
}

/// Picks an amount (grams, or a serving × count) and returns the resolved
/// grams. Logging always uses grams so it doesn't depend on label matching.
class _AmountDialog extends StatefulWidget {
  const _AmountDialog({required this.food});

  final FoodItem food;

  @override
  State<_AmountDialog> createState() => _AmountDialogState();
}

class _AmountDialogState extends State<_AmountDialog> {
  // null = grams; otherwise the selected serving.
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
    final amt = double.tryParse(_amount.text.trim()) ?? 0;
    return _serving == null ? amt : amt * _serving!.grams;
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final languageCode = Localizations.localeOf(context).languageCode;
    final kcal = widget.food.caloriesPer100g * _grams / 100;
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
                for (final s in widget.food.servings)
                  XnDropdownOption(
                    value: s.id,
                    label:
                        '${s.displayLabelFor(languageCode)} (${_g(s.grams)} g)',
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
            '${_g(_grams)} g · ${kcal.toStringAsFixed(0)} kcal',
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
    Navigator.pop(context, _grams);
  }
}

/// Create a custom food, returning the created [FoodItem].
class _CustomFoodSheet extends ConsumerStatefulWidget {
  const _CustomFoodSheet();

  @override
  ConsumerState<_CustomFoodSheet> createState() => _CustomFoodSheetState();
}

class _CustomFoodSheetState extends ConsumerState<_CustomFoodSheet> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _calories = TextEditingController();
  final _protein = TextEditingController();
  final _carbs = TextEditingController();
  final _fat = TextEditingController();
  bool _submitting = false;

  @override
  void dispose() {
    _name.dispose();
    _calories.dispose();
    _protein.dispose();
    _carbs.dispose();
    _fat.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final messenger = ScaffoldMessenger.of(context);
    try {
      final food = await ref
          .read(nutritionRepositoryProvider)
          .createCustomFood(
            nameVi: _name.text.trim(),
            nameEn: _name.text.trim(),
            caloriesPer100g: double.parse(_calories.text.trim()),
            proteinPer100g: double.parse(_protein.text.trim()),
            carbsPer100g: double.parse(_carbs.text.trim()),
            fatPer100g: double.parse(_fat.text.trim()),
          );
      if (!mounted) return;
      Navigator.pop(context, food);
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$e')));
    }
  }

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
      child: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.nutritionCustomFoodTitle,
              style: AppTypography.display(20, letterSpacing: 0),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.nutritionValuesPer100gMessage,
              style: const TextStyle(color: AppColors.fg3, fontSize: 13),
            ),
            const SizedBox(height: AppSpacing.lg),
            XnInput(
              label: l10n.nutritionNameLabel,
              controller: _name,
              validator: (v) => (v == null || v.trim().length < 2)
                  ? l10n.nutritionEnterNameError
                  : null,
            ),
            const SizedBox(height: AppSpacing.lg),
            XnInput(
              label: l10n.nutritionCaloriesPer100gLabel,
              controller: _calories,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              inputFormatters: _decimal,
              validator: (v) => _required(v, l10n),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: XnInput(
                    label: l10n.nutritionProteinLabel,
                    controller: _protein,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: _decimal,
                    validator: (v) => _required(v, l10n),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: XnInput(
                    label: l10n.nutritionCarbsLabel,
                    controller: _carbs,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: _decimal,
                    validator: (v) => _required(v, l10n),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Expanded(
                  child: XnInput(
                    label: l10n.nutritionFatLabel,
                    controller: _fat,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    inputFormatters: _decimal,
                    validator: (v) => _required(v, l10n),
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.xl),
            XnButton(
              label: l10n.nutritionCreateAndLogCta,
              loading: _submitting,
              onPressed: _submit,
            ),
          ],
        ),
      ),
    );
  }
}

List<TextInputFormatter> get _decimal => [
  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
];

String? _required(String? v, AppLocalizations l10n) {
  final t = v?.trim() ?? '';
  if (t.isEmpty) return l10n.commonRequiredError;
  if (double.tryParse(t) == null) return l10n.nutritionNumberError;
  return null;
}

String _g(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
