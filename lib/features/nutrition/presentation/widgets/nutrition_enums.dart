import 'package:flutter/material.dart';

import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../l10n/app_localizations.dart';

/// `ActivityLevel` enum names (API ref §2).
const activityLevels = [
  'Sedentary',
  'Light',
  'Moderate',
  'VeryActive',
  'Athlete',
];

/// `NutritionGoal` enum names (API ref §2).
const nutritionGoals = ['Cut', 'Maintain', 'Bulk'];

/// `PascalCase` enum → spaced words (e.g. `VeryActive` → `Very Active`).
/// Fallback for any value not covered by [nutritionEnumLabel].
String humanizeEnum(String value) {
  if (value.isEmpty) return value;
  final spaced = value.replaceAllMapped(
    RegExp('([a-z])([A-Z])'),
    (m) => '${m[1]} ${m[2]}',
  );
  return spaced[0].toUpperCase() + spaced.substring(1);
}

/// Localized display label for an [activityLevels] / [nutritionGoals] value
/// (or any other PascalCase enum from the API), keeping the raw value as the
/// wire format.
String nutritionEnumLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Sedentary' => l10n.nutritionActivitySedentary,
      'Light' => l10n.nutritionActivityLight,
      'Moderate' => l10n.nutritionActivityModerate,
      'VeryActive' => l10n.nutritionActivityVeryActive,
      'Athlete' => l10n.nutritionActivityAthlete,
      'Cut' => l10n.nutritionGoalCut,
      'Maintain' => l10n.nutritionGoalMaintain,
      'Bulk' => l10n.nutritionGoalBulk,
      _ => humanizeEnum(value),
    };

/// Labelled dropdown styled to match the app's text fields.
class NutritionDropdown extends StatelessWidget {
  const NutritionDropdown({
    required this.label,
    required this.value,
    required this.options,
    required this.onChanged,
    super.key,
  });

  final String label;
  final String? value;
  final List<String> options;
  final ValueChanged<String?> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnDropdown<String>(
      label: label,
      value: value,
      options: [
        for (final option in options)
          XnDropdownOption(
            value: option,
            label: nutritionEnumLabel(option, l10n),
          ),
      ],
      onChanged: onChanged,
    );
  }
}
