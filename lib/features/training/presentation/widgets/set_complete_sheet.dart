import 'package:flutter/material.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/exercise.dart';

/// Result of the set-complete sheet. [actualWeight] is in kg.
class SetCompleteResult {
  const SetCompleteResult({this.actualReps, this.actualWeight, this.rpe});

  final int? actualReps;
  final double? actualWeight;
  final double? rpe;
}

/// Bottom sheet to log actual reps / weight / RPE for a set. Pops a
/// [SetCompleteResult] on confirm. Planned/actual weights are in kg; [unit]
/// only affects what's displayed/typed in between.
class SetCompleteSheet extends StatefulWidget {
  const SetCompleteSheet({
    required this.exercise,
    required this.set,
    required this.unit,
    super.key,
  });

  final Exercise exercise;
  final ExerciseSet set;
  final WeightUnit unit;

  @override
  State<SetCompleteSheet> createState() => _SetCompleteSheetState();
}

class _SetCompleteSheetState extends State<SetCompleteSheet> {
  late final TextEditingController _reps;
  late final TextEditingController _weight;
  late final TextEditingController _rpe;

  @override
  void initState() {
    super.initState();
    final s = widget.set;
    _reps = TextEditingController(
      text: (s.actualReps ?? s.plannedReps).toString(),
    );
    final weightKg =
        s.actualWeight ?? s.plannedWeight ?? widget.exercise.plannedWeight;
    _weight = TextEditingController(
      text: weightKg == null ? '' : formatWeight(widget.unit.fromKg(weightKg)),
    );
    _rpe = TextEditingController(text: s.rpe?.toString() ?? '');
  }

  @override
  void dispose() {
    _reps.dispose();
    _weight.dispose();
    _rpe.dispose();
    super.dispose();
  }

  void _confirm() {
    final enteredWeight = double.tryParse(_weight.text.trim());
    Navigator.pop(
      context,
      SetCompleteResult(
        actualReps: int.tryParse(_reps.text.trim()),
        actualWeight: enteredWeight == null
            ? null
            : widget.unit.toKg(enteredWeight),
        rpe: double.tryParse(_rpe.text.trim()),
      ),
    );
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.trainingSetTitle(widget.set.setNumber, widget.exercise.name),
            style: AppTypography.display(18, letterSpacing: 0),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: XnInput(
                  label: l10n.trainingRepsLabel,
                  controller: _reps,
                  keyboardType: TextInputType.number,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: XnInput(
                  label: l10n.trainingWeightLabel(widget.unit.suffix),
                  controller: _weight,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: XnInput(
                  label: l10n.trainingRpeLabel,
                  controller: _rpe,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          XnButton(
            label: l10n.trainingMarkCompleteCta,
            icon: Icons.check_rounded,
            onPressed: _confirm,
          ),
        ],
      ),
    );
  }
}
