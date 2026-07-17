import 'package:flutter/material.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';

/// Planned metrics captured by [ExerciseFormSheet]. [plannedWeight] is in kg.
class ExerciseFormResult {
  const ExerciseFormResult({
    required this.plannedSets,
    required this.plannedReps,
    this.plannedWeight,
    this.notes,
  });

  final int plannedSets;
  final int plannedReps;
  final double? plannedWeight;
  final String? notes;
}

/// Bottom sheet to capture an exercise's planned sets / reps / weight / notes.
/// Used both when adding (after a template is chosen) and when editing. Pops an
/// [ExerciseFormResult] on confirm. [initialWeight] is in kg; [unit] only
/// affects what's displayed/typed in between.
class ExerciseFormSheet extends StatefulWidget {
  const ExerciseFormSheet({
    required this.title,
    required this.submitLabel,
    required this.unit,
    this.initialSets,
    this.initialReps,
    this.initialWeight,
    this.initialNotes,
    super.key,
  });

  final String title;
  final String submitLabel;
  final WeightUnit unit;
  final int? initialSets;
  final int? initialReps;
  final double? initialWeight;
  final String? initialNotes;

  @override
  State<ExerciseFormSheet> createState() => _ExerciseFormSheetState();
}

class _ExerciseFormSheetState extends State<ExerciseFormSheet> {
  final _formKey = GlobalKey<FormState>();
  late final TextEditingController _sets;
  late final TextEditingController _reps;
  late final TextEditingController _weight;
  late final TextEditingController _notes;

  @override
  void initState() {
    super.initState();
    _sets = TextEditingController(text: widget.initialSets?.toString() ?? '3');
    _reps = TextEditingController(text: widget.initialReps?.toString() ?? '10');
    _weight = TextEditingController(
      text: widget.initialWeight == null
          ? ''
          : formatWeight(widget.unit.fromKg(widget.initialWeight!)),
    );
    _notes = TextEditingController(text: widget.initialNotes ?? '');
  }

  @override
  void dispose() {
    _sets.dispose();
    _reps.dispose();
    _weight.dispose();
    _notes.dispose();
    super.dispose();
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final notes = _notes.text.trim();
    final enteredWeight = double.tryParse(_weight.text.trim());
    Navigator.pop(
      context,
      ExerciseFormResult(
        plannedSets: int.parse(_sets.text.trim()),
        plannedReps: int.parse(_reps.text.trim()),
        plannedWeight: enteredWeight == null
            ? null
            : widget.unit.toKg(enteredWeight),
        notes: notes.isEmpty ? null : notes,
      ),
    );
  }

  String? _validateInt(
    String? v, {
    required int min,
    required int max,
    required AppLocalizations l10n,
  }) {
    final n = int.tryParse((v ?? '').trim());
    if (n == null) return l10n.commonRequiredError;
    if (n < min || n > max) {
      return l10n.trainingIntRangeError(min.toString(), max.toString());
    }
    return null;
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
              widget.title,
              style: AppTypography.display(18, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              children: [
                Expanded(
                  child: XnInput(
                    label: l10n.trainingSetsLabel,
                    controller: _sets,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        _validateInt(v, min: 1, max: 100, l10n: l10n),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: XnInput(
                    label: l10n.trainingRepsLabel,
                    controller: _reps,
                    keyboardType: TextInputType.number,
                    validator: (v) =>
                        _validateInt(v, min: 1, max: 1000, l10n: l10n),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: XnInput(
                    label: l10n.trainingWeightLabel(widget.unit.suffix),
                    controller: _weight,
                    hint: l10n.trainingOptionalHint,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    validator: (v) {
                      final t = (v ?? '').trim();
                      if (t.isEmpty) return null;
                      final w = double.tryParse(t);
                      final max = widget.unit.fromKg(10000);
                      if (w == null || w < 0 || w > max) {
                        return l10n.trainingWeightRangeError(formatWeight(max));
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            XnInput(
              label: l10n.trainingNotesLabel,
              controller: _notes,
              hint: l10n.trainingNotesHint,
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
    );
  }
}
