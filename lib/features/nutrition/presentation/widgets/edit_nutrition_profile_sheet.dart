import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/nutrition_repository_provider.dart';
import '../../domain/entities/nutrition_summary.dart';
import '../providers/nutrition_controller.dart';
import 'nutrition_enums.dart';

/// Bottom sheet to edit the nutrition profile (`PUT /nutrition/profile`).
/// Pops `true` after a successful save.
class EditNutritionProfileSheet extends ConsumerStatefulWidget {
  const EditNutritionProfileSheet({required this.profile, super.key});

  final NutritionProfile profile;

  @override
  ConsumerState<EditNutritionProfileSheet> createState() =>
      _EditNutritionProfileSheetState();
}

class _EditNutritionProfileSheetState
    extends ConsumerState<EditNutritionProfileSheet> {
  final _formKey = GlobalKey<FormState>();
  late String _activity = widget.profile.activityLevel;
  late String _goal = widget.profile.goal;
  late final WeightUnit _unit = ref.read(weightUnitProvider);
  late final _targetWeight = TextEditingController(
    text: widget.profile.targetWeightKg == null
        ? ''
        : _num(_unit.fromKg(widget.profile.targetWeightKg!)),
  );
  late final _calorieTarget = TextEditingController(
    text: widget.profile.customCalorieTarget?.toString() ?? '',
  );
  late final _proteinPerKg = TextEditingController(
    text: _num(widget.profile.proteinPerKg),
  );
  late final _fatPerKg = TextEditingController(
    text: _num(widget.profile.fatPerKg),
  );
  bool _submitting = false;

  @override
  void dispose() {
    _targetWeight.dispose();
    _calorieTarget.dispose();
    _proteinPerKg.dispose();
    _fatPerKg.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _submitting = true);
    final messenger = ScaffoldMessenger.of(context);
    final enteredTargetWeight = double.tryParse(_targetWeight.text.trim());
    try {
      await ref
          .read(nutritionRepositoryProvider)
          .updateProfile(
            activityLevel: _activity,
            goal: _goal,
            targetWeightKg: enteredTargetWeight == null
                ? null
                : _unit.toKg(enteredTargetWeight),
            customCalorieTarget: int.tryParse(_calorieTarget.text.trim()),
            proteinPerKg: double.tryParse(_proteinPerKg.text.trim()),
            fatPerKg: double.tryParse(_fatPerKg.text.trim()),
          );
      ref.invalidate(nutritionControllerProvider);
      if (!mounted) return;
      Navigator.pop(context, true);
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
        child: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                l10n.nutritionProfileTitle,
                style: AppTypography.display(22, letterSpacing: 0),
              ),
              const SizedBox(height: AppSpacing.lg),
              NutritionDropdown(
                label: l10n.nutritionGoalLabel,
                value: _goal,
                options: nutritionGoals,
                onChanged: (v) => setState(() => _goal = v ?? _goal),
              ),
              const SizedBox(height: AppSpacing.lg),
              NutritionDropdown(
                label: l10n.nutritionActivityLevelLabel,
                value: _activity,
                options: activityLevels,
                onChanged: (v) => setState(() => _activity = v ?? _activity),
              ),
              const SizedBox(height: AppSpacing.lg),
              XnInput(
                label: l10n.nutritionTargetWeightLabel(_unit.suffix),
                controller: _targetWeight,
                hint:
                    '${formatWeight(_unit.fromKg(20))}-${formatWeight(_unit.fromKg(400))}',
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),
                inputFormatters: _decimal,
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return null;
                  final n = double.tryParse(t);
                  final min = _unit.fromKg(20);
                  final max = _unit.fromKg(400);
                  if (n == null || n < min || n > max) {
                    return l10n.nutritionRangeError(
                      formatWeight(min),
                      formatWeight(max),
                    );
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              XnInput(
                label: l10n.nutritionCustomCalorieTargetLabel,
                controller: _calorieTarget,
                hint: l10n.nutritionCalorieTargetHint,
                keyboardType: TextInputType.number,
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                validator: (v) {
                  final t = v?.trim() ?? '';
                  if (t.isEmpty) return null;
                  final n = int.tryParse(t);
                  if (n == null) return l10n.commonEnterNumberError;
                  if (n < 800 || n > 8000) {
                    return l10n.nutritionCalorieRangeError;
                  }
                  return null;
                },
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: XnInput(
                      label: l10n.nutritionProteinPerKgLabel,
                      controller: _proteinPerKg,
                      hint: l10n.nutritionProteinPerKgHint,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: _decimal,
                      validator: _range(0.5, 4, l10n),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: XnInput(
                      label: l10n.nutritionFatPerKgLabel,
                      controller: _fatPerKg,
                      hint: l10n.nutritionFatPerKgHint,
                      keyboardType: const TextInputType.numberWithOptions(
                        decimal: true,
                      ),
                      inputFormatters: _decimal,
                      validator: _range(0.2, 2, l10n),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              XnButton(
                label: l10n.nutritionSaveProfileCta,
                loading: _submitting,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

List<TextInputFormatter> get _decimal => [
  FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
];

String _num(double? v) {
  if (v == null) return '';
  return v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toString();
}

String? Function(String?) _range(
  double min,
  double max,
  AppLocalizations l10n,
) => (v) {
  final t = v?.trim() ?? '';
  if (t.isEmpty) return null;
  final n = double.tryParse(t);
  if (n == null) return l10n.commonEnterNumberError;
  if (n < min || n > max) {
    return l10n.nutritionRangeError(_num(min), _num(max));
  }
  return null;
};
