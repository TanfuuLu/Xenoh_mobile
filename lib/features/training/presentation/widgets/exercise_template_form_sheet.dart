import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/exercise_template.dart';

/// Backend enum values for muscle groups; kept as literal English strings
/// since they're API values. Use [muscleGroupLabel] for the localized
/// display text.
const muscleGroupOptions = <String>[
  'Chest',
  'Back',
  'Shoulders',
  'Biceps',
  'Triceps',
  'Forearms',
  'Abs',
  'Quads',
  'Hamstrings',
  'Glutes',
  'Calves',
  'FullBody',
  'Cardio',
  'Traps',
  'Neck',
  'Adductors',
  'Abductors',
];

String exerciseKindLabel(String value, AppLocalizations l10n) =>
    value == 'Cardio' ? l10n.trainingCardio : l10n.trainingKindStrength;

String muscleGroupLabel(String value, AppLocalizations l10n) => switch (value) {
  'Chest' => l10n.trainingMuscleChest,
  'Back' => l10n.trainingMuscleBack,
  'Shoulders' => l10n.trainingMuscleShoulders,
  'Biceps' => l10n.trainingMuscleBiceps,
  'Triceps' => l10n.trainingMuscleTriceps,
  'Forearms' => l10n.trainingMuscleForearms,
  'Abs' => l10n.trainingMuscleAbs,
  'Quads' => l10n.trainingMuscleQuads,
  'Hamstrings' => l10n.trainingMuscleHamstrings,
  'Glutes' => l10n.trainingMuscleGlutes,
  'Calves' => l10n.trainingMuscleCalves,
  'FullBody' => l10n.trainingMuscleFullBody,
  'Cardio' => l10n.trainingCardio,
  'Traps' => l10n.trainingMuscleTraps,
  'Neck' => l10n.trainingMuscleNeck,
  'Adductors' => l10n.trainingMuscleAdductors,
  'Abductors' => l10n.trainingMuscleAbductors,
  _ => value,
};

class ExerciseTemplateFormResult {
  const ExerciseTemplateFormResult({
    required this.name,
    required this.primaryMuscleGroup,
    required this.secondaryMuscleGroups,
    required this.exerciseKind,
    this.description,
  });

  final String name;
  final String primaryMuscleGroup;
  final List<String> secondaryMuscleGroups;
  final String exerciseKind;
  final String? description;
}

class ExerciseTemplateFormSheet extends StatefulWidget {
  const ExerciseTemplateFormSheet({
    required this.title,
    required this.submitLabel,
    this.initial,
    super.key,
  });

  final String title;
  final String submitLabel;
  final ExerciseTemplate? initial;

  @override
  State<ExerciseTemplateFormSheet> createState() =>
      _ExerciseTemplateFormSheetState();
}

class _ExerciseTemplateFormSheetState extends State<ExerciseTemplateFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _name;
  late final TextEditingController _description;
  late String _primary;
  late String _kind;
  late Set<String> _secondary;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _name = TextEditingController(text: initial?.name ?? '');
    _description = TextEditingController(text: initial?.description ?? '');
    _primary = initial?.primaryMuscleGroup ?? 'Chest';
    _kind = initial?.exerciseKind ?? 'Strength';
    _secondary = {...?initial?.secondaryMuscleGroups};
  }

  @override
  void dispose() {
    _name.dispose();
    _description.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final description = _description.text.trim();
    Navigator.pop(
      context,
      ExerciseTemplateFormResult(
        name: _name.text.trim(),
        primaryMuscleGroup: _primary,
        secondaryMuscleGroups: _secondary.where((g) => g != _primary).toList(),
        exerciseKind: _kind,
        description: description.isEmpty ? null : description,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SizedBox(
      height: MediaQuery.sizeOf(context).height * 0.88,
      child: Padding(
        padding: EdgeInsets.only(
          left: AppSpacing.xl,
          right: AppSpacing.xl,
          top: AppSpacing.xl,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
        ),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [
              Text(
                widget.title,
                style: AppTypography.display(20, letterSpacing: 0),
              ),
              const SizedBox(height: AppSpacing.lg),
              XnInput(
                label: l10n.trainingExerciseNameLabel,
                controller: _name,
                hint: l10n.trainingExerciseNameHint,
                validator: (v) => (v == null || v.trim().isEmpty)
                    ? l10n.trainingExerciseNameError
                    : null,
              ),
              const SizedBox(height: AppSpacing.lg),
              XnInput(
                label: l10n.trainingDescriptionLabel,
                controller: _description,
                hint: l10n.trainingDescriptionHint,
              ),
              const SizedBox(height: AppSpacing.lg),
              XnDropdown<String>(
                label: l10n.trainingKindLabel,
                value: _kind,
                options: [
                  XnDropdownOption(
                    value: 'Strength',
                    label: l10n.trainingKindStrength,
                  ),
                  XnDropdownOption(value: 'Cardio', label: l10n.trainingCardio),
                ],
                onChanged: (v) => setState(() => _kind = v ?? _kind),
              ),
              const SizedBox(height: AppSpacing.lg),
              XnDropdown<String>(
                label: l10n.trainingPrimaryMuscleGroupLabel,
                value: _primary,
                options: [
                  for (final group in muscleGroupOptions)
                    XnDropdownOption(
                      value: group,
                      label: muscleGroupLabel(group, l10n),
                    ),
                ],
                onChanged: (v) => setState(() => _primary = v ?? _primary),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.trainingSecondaryMuscleGroupsLabel,
                style: const TextStyle(
                  color: AppColors.fg2,
                  fontSize: 13,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: [
                  for (final group in muscleGroupOptions)
                    FilterChip(
                      label: Text(muscleGroupLabel(group, l10n)),
                      selected: _secondary.contains(group),
                      onSelected: group == _primary
                          ? null
                          : (selected) => setState(() {
                              if (selected) {
                                _secondary.add(group);
                              } else {
                                _secondary.remove(group);
                              }
                            }),
                    ),
                ],
              ),
              const SizedBox(height: AppSpacing.xl),
              XnButton(
                label: widget.submitLabel,
                icon: Icons.check_rounded,
                onPressed: _submit,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
