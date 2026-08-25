import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/ai_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

String _goalLabel(String value, AppLocalizations l10n) => switch (value) {
  'Build muscle' => l10n.trainingGoalBuildMuscle,
  'Gain strength' => l10n.trainingGoalGainStrength,
  'Lose fat' => l10n.trainingGoalLoseFat,
  'General fitness' => l10n.trainingGoalGeneralFitness,
  _ => value,
};

String _experienceLabel(String value, AppLocalizations l10n) => switch (value) {
  'Beginner' => l10n.trainingExperienceBeginner,
  'Intermediate' => l10n.trainingExperienceIntermediate,
  'Advanced' => l10n.trainingExperienceAdvanced,
  _ => value,
};

String _splitLabel(String value, AppLocalizations l10n) => switch (value) {
  'full_body' => l10n.trainingSplitFullBody,
  'upper_lower' => l10n.trainingSplitUpperLower,
  'push_pull_legs' => l10n.trainingSplitPushPullLegs,
  'bro_split' => l10n.trainingSplitBroSplit,
  _ => value,
};

/// Collects a `CreateAiStarterPlanCommand` and calls `POST /plans/starter-ai`
/// (Pro, rate:ai). Pops the new plan id on success so the caller can open it.
class AiStarterPlanSheet extends ConsumerStatefulWidget {
  const AiStarterPlanSheet({super.key});

  @override
  ConsumerState<AiStarterPlanSheet> createState() => _AiStarterPlanSheetState();
}

class _AiStarterPlanSheetState extends ConsumerState<AiStarterPlanSheet> {
  final _formKey = GlobalKey<FormState>();
  final _equipment = TextEditingController();
  final _name = TextEditingController();

  String _goal = 'Build muscle';
  String _experience = 'Beginner';
  String _split = 'full_body';
  int _daysPerWeek = 3;
  int _sessionMinutes = 60;
  DateTime? _start;
  DateTime? _end;
  bool _submitting = false;
  String? _error;

  static const _goals = [
    'Build muscle',
    'Gain strength',
    'Lose fat',
    'General fitness',
  ];
  static const _experiences = ['Beginner', 'Intermediate', 'Advanced'];
  static const _splits = [
    'full_body',
    'upper_lower',
    'push_pull_legs',
    'bro_split',
  ];

  @override
  void initState() {
    super.initState();
    final now = DateTime.now();
    _start = now;
    _end = now.add(const Duration(days: 7 * 8)); // 8-week default block.
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    // Prefilled in the user's language; localizations are only available once
    // dependencies are resolved, so this cannot live in initState.
    if (_equipment.text.isEmpty) {
      _equipment.text = AppLocalizations.of(context).trainingEquipmentDefault;
    }
  }

  @override
  void dispose() {
    _equipment.dispose();
    _name.dispose();
    super.dispose();
  }

  Future<void> _pick({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart ? (_start ?? now) : (_end ?? _start ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );
    if (picked != null) {
      setState(() => isStart ? _start = picked : _end = picked);
    }
  }

  Future<void> _submit() async {
    if (!_formKey.currentState!.validate()) return;
    final l10n = AppLocalizations.of(context);
    if (_start == null || _end == null || _end!.isBefore(_start!)) {
      setState(() => _error = l10n.trainingPickValidDatesError);
      return;
    }
    setState(() {
      _submitting = true;
      _error = null;
    });
    try {
      final response = await ref.read(xenohApiProvider).postObject(
        '/plans/starter-ai',
        {
          'goal': _goal,
          'experience': _experience,
          'daysPerWeek': _daysPerWeek,
          'splitPreference': _split,
          'sessionLengthMinutes': _sessionMinutes,
          'equipment': _equipment.text.trim(),
          'startDate': DateOnly.format(_start!),
          'endDate': DateOnly.format(_end!),
          'name': ?(_name.text.trim().isEmpty ? null : _name.text.trim()),
          'language': ref.read(appLocaleProvider)?.languageCode ?? 'en',
        },
      );
      if (!mounted) return;
      Navigator.pop(context, response['id']?.toString());
    } catch (e) {
      if (!mounted) return;
      final gate = aiGate(e);
      setState(() {
        _submitting = false;
        _error = gate.isPro
            ? l10n.trainingAiProFeatureError
            : gate.isQuota
            ? l10n.trainingAiLimitReachedError
            : apiErrorMessage(e, context);
      });
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
              Row(
                children: [
                  const Icon(
                    Icons.auto_awesome_rounded,
                    color: AppColors.accent,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      l10n.trainingAiGeneratePlanTitle,
                      style: AppTypography.display(20, letterSpacing: 0),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                l10n.trainingAiGeneratePlanSubtitle,
                style: const TextStyle(color: AppColors.fg3, fontSize: 13),
              ),
              const SizedBox(height: AppSpacing.lg),
              _Dropdown(
                label: l10n.trainingGoalLabel,
                value: _goal,
                items: _goals,
                displayText: (v) => _goalLabel(v, l10n),
                onChanged: (v) => setState(() => _goal = v),
              ),
              const SizedBox(height: AppSpacing.md),
              _Dropdown(
                label: l10n.trainingExperienceLabel,
                value: _experience,
                items: _experiences,
                displayText: (v) => _experienceLabel(v, l10n),
                onChanged: (v) => setState(() => _experience = v),
              ),
              const SizedBox(height: AppSpacing.md),
              _Dropdown(
                label: l10n.trainingSplitPreferenceLabel,
                value: _split,
                items: _splits,
                displayText: (v) => _splitLabel(v, l10n),
                onChanged: (v) => setState(() => _split = v),
              ),
              const SizedBox(height: AppSpacing.lg),
              _Stepper(
                label: l10n.trainingDaysPerWeekLabel,
                value: _daysPerWeek,
                min: 2,
                max: 5,
                onChanged: (v) => setState(() => _daysPerWeek = v),
              ),
              const SizedBox(height: AppSpacing.md),
              _Stepper(
                label: l10n.trainingSessionLengthLabel,
                value: _sessionMinutes,
                min: 30,
                max: 90,
                step: 15,
                onChanged: (v) => setState(() => _sessionMinutes = v),
              ),
              const SizedBox(height: AppSpacing.lg),
              XnInput(
                label: l10n.trainingEquipmentLabel,
                controller: _equipment,
                hint: l10n.trainingEquipmentHint,
                validator: (v) => (v == null || v.trim().length < 2)
                    ? l10n.trainingEquipmentError
                    : null,
              ),
              const SizedBox(height: AppSpacing.md),
              XnInput(
                label: l10n.trainingPlanNameOptionalLabel,
                controller: _name,
                hint: l10n.trainingPlanNameOptionalHint,
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _DateField(
                      label: l10n.trainingStartLabel,
                      value: _start,
                      onTap: () => _pick(isStart: true),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _DateField(
                      label: l10n.trainingEndLabel,
                      value: _end,
                      onTap: () => _pick(isStart: false),
                    ),
                  ),
                ],
              ),
              if (_error != null) ...[
                const SizedBox(height: AppSpacing.md),
                Text(
                  _error!,
                  style: const TextStyle(color: AppColors.danger),
                ),
              ],
              const SizedBox(height: AppSpacing.xl),
              XnButton(
                label: l10n.trainingGeneratePlanCta,
                icon: Icons.auto_awesome_rounded,
                loading: _submitting,
                onPressed: _submit,
              ),
              if (_submitting) ...[
                const SizedBox(height: AppSpacing.sm),
                Text(
                  l10n.trainingAiDesigningMessage,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }
}

class _Dropdown extends StatelessWidget {
  const _Dropdown({
    required this.label,
    required this.value,
    required this.items,
    required this.displayText,
    required this.onChanged,
  });

  final String label;
  final String value;
  final List<String> items;
  final String Function(String value) displayText;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return XnDropdown<String>(
      label: label,
      value: value,
      options: [
        for (final item in items)
          XnDropdownOption(value: item, label: displayText(item)),
      ],
      onChanged: (v) {
        if (v != null) onChanged(v);
      },
    );
  }
}

class _Stepper extends StatelessWidget {
  const _Stepper({
    required this.label,
    required this.value,
    required this.min,
    required this.max,
    required this.onChanged,
    this.step = 1,
  });

  final String label;
  final int value;
  final int min;
  final int max;
  final int step;
  final ValueChanged<int> onChanged;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.remove_circle_outline_rounded),
          onPressed: value > min ? () => onChanged(value - step) : null,
        ),
        SizedBox(
          width: 36,
          child: Text(
            '$value',
            textAlign: TextAlign.center,
            style: AppTypography.mono(16, weight: FontWeight.w500),
          ),
        ),
        IconButton(
          icon: const Icon(Icons.add_circle_outline_rounded),
          onPressed: value < max ? () => onChanged(value + step) : null,
        ),
      ],
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.fg2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        OutlinedButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.calendar_today_rounded, size: 16),
          label: Text(
            value == null
                ? AppLocalizations.of(context).trainingPickDateCta
                : DateOnly.format(value!),
          ),
        ),
      ],
    );
  }
}
