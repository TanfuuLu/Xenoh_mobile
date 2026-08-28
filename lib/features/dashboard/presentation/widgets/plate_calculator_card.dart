import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';

class PlateCalculatorButton extends StatelessWidget {
  const PlateCalculatorButton({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      onTap: () => _openPlateCalculator(context),
      padding: const EdgeInsets.all(AppSpacing.md),
      color: AppColors.bg2,
      child: Row(
        children: [
          Container(
            width: 42,
            height: 42,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.accentSoft,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: const Icon(
              Icons.fitness_center_rounded,
              color: AppColors.clay900,
              size: 21,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.dashboardPlateCalculatorTitle,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  l10n.dashboardPlateCalculatorSubtitle,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
        ],
      ),
    );
  }

  Future<void> _openPlateCalculator(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.ink900.withValues(alpha: 0.26),
      builder: (context) {
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg + bottomInset,
          ),
          child: const SingleChildScrollView(
            child: PlateCalculatorCard(),
          ),
        );
      },
    );
  }
}

/// The bars and plates a gym actually racks, per unit.
///
/// These are equipment, not converted numbers: a lb gym has 45/35/25 lb
/// plates, not 20 kg plates relabelled, so each unit gets its own
/// denominations and its own sensible defaults.
enum _PlateEquipment {
  kg(
    bars: [20, 15, 25],
    plates: [25, 20, 10, 5, 2.5],
    alternativePlates: [20, 10, 5, 2.5],
    defaultTarget: 100,
    step: 2.5,
  ),
  lb(
    bars: [45, 35, 55],
    plates: [55, 45, 35, 25, 10, 5, 2.5],
    alternativePlates: [45, 35, 25, 10, 5, 2.5],
    defaultTarget: 135,
    step: 5,
  );

  const _PlateEquipment({
    required this.bars,
    required this.plates,
    required this.alternativePlates,
    required this.defaultTarget,
    required this.step,
  });

  /// Selectable bar weights; the first is the default.
  final List<double> bars;

  /// Plate denominations, heaviest first.
  final List<double> plates;

  /// The same set without its heaviest plate — the "or" combination offered
  /// for gyms that don't stock the big plate.
  final List<double> alternativePlates;

  final double defaultTarget;

  /// Increment of the target-weight stepper (one pair of the smallest plate).
  final double step;

  double get smallestPlate => plates.last;

  static _PlateEquipment of(WeightUnit unit) => unit == WeightUnit.lb ? lb : kg;
}

class PlateCalculatorCard extends StatefulWidget {
  const PlateCalculatorCard({this.unit = WeightUnit.kg, super.key});

  /// The user's weight-unit preference. Everything on the card — bar options,
  /// plate denominations, suffixes — follows it.
  final WeightUnit unit;

  static const barbellVisualKey = Key('plate-calculator-barbell-visual');

  @override
  State<PlateCalculatorCard> createState() => _PlateCalculatorCardState();
}

class _PlateCalculatorCardState extends State<PlateCalculatorCard> {
  late final TextEditingController _targetController;
  Map<double, TextEditingController>? _countControllers;

  var _mode = _PlateCalculatorMode.target;
  late double _target;
  late double _barWeight;
  late Map<double, int> _plateCounts;

  _PlateEquipment get _equipment => _PlateEquipment.of(widget.unit);
  List<double> get _plates => _equipment.plates;
  List<double> get _barOptions => _equipment.bars;

  @override
  void initState() {
    super.initState();
    _target = _equipment.defaultTarget;
    _barWeight = _equipment.bars.first;
    _plateCounts = {for (final plate in _plates) plate: 0};
    _targetController = TextEditingController(text: formatWeight(_target));
    _countControllers = _createCountControllers();
  }

  @override
  void didUpdateWidget(PlateCalculatorCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    // A different unit means different physical plates, so the loaded bar and
    // the target start over rather than carrying kg numbers into a lb rack.
    if (oldWidget.unit != widget.unit) _reset();
  }

  @override
  void dispose() {
    _targetController.dispose();
    final countControllers = _countControllers;
    if (countControllers != null) {
      for (final controller in countControllers.values) {
        controller.dispose();
      }
    }
    super.dispose();
  }

  Map<double, TextEditingController> get _resolvedCountControllers {
    return _countControllers ??= _createCountControllers();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final result = _mode == _PlateCalculatorMode.target
        ? _calculatePlates(
            target: _target,
            barWeight: _barWeight,
            plates: _plates,
          )
        : _calculateFromCounts(
            counts: _plateCounts,
            barWeight: _barWeight,
            plates: _plates,
          );

    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.xxl),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final compact = constraints.maxWidth < 360;
          final horizontalPadding = compact ? AppSpacing.md : AppSpacing.lg;
          return Padding(
            padding: EdgeInsets.fromLTRB(
              horizontalPadding,
              AppSpacing.sm,
              horizontalPadding,
              AppSpacing.lg,
            ),
            child: AnimatedSize(
              duration: AppMotion.med,
              curve: Curves.easeOutCubic,
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Container(
                      width: 44,
                      height: 4,
                      decoration: BoxDecoration(
                        color: AppColors.bg4,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                      ),
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  _CalculatorHeader(onReset: _reset),
                  const SizedBox(height: AppSpacing.md),
                  _ModeSwitch(
                    mode: _mode,
                    onChanged: (mode) => setState(() => _mode = mode),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _BarbellStage(
                    platesPerSide: result.platesPerSide,
                    unit: widget.unit,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _CalculatorPanel(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        if (_mode == _PlateCalculatorMode.target)
                          _TargetModeInput(
                            controller: _targetController,
                            unit: widget.unit,
                            step: _equipment.step,
                            onChanged: _setTargetFromText,
                            onStep: _stepTarget,
                          )
                        else
                          _CountModeInput(
                            plates: _plates,
                            counts: _plateCounts,
                            controllers: _resolvedCountControllers,
                            unit: widget.unit,
                            onChanged: _setPlateCount,
                            onStep: _stepPlateCount,
                          ),
                        const SizedBox(height: AppSpacing.md),
                        Wrap(
                          spacing: AppSpacing.sm,
                          runSpacing: AppSpacing.xs,
                          children: [
                            for (final bar in _barOptions)
                              _BarOption(
                                label: l10n.dashboardPlateBarWeightLabel(
                                  formatWeight(bar),
                                  widget.unit.suffix,
                                ),
                                selected: _barWeight == bar,
                                onTap: () => setState(() => _barWeight = bar),
                              ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: AppSpacing.md),
                  _CalculatorPanel(
                    emphasized: true,
                    child: _PlateResultView(
                      mode: _mode,
                      target: _target,
                      barWeight: _barWeight,
                      result: result,
                      unit: widget.unit,
                      equipment: _equipment,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _setTargetFromText(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) {
      setState(() => _target = 0);
      return;
    }
    setState(() => _target = parsed.clamp(0, 9999).toDouble());
  }

  void _stepTarget(double delta) {
    final next = (_target + delta).clamp(0, 9999).toDouble();
    setState(() {
      _target = next;
      _targetController.text = formatWeight(next);
      _targetController.selection = TextSelection.collapsed(
        offset: _targetController.text.length,
      );
    });
  }

  void _setPlateCount(double plate, String value) {
    final parsed = int.tryParse(value);
    final next = (parsed ?? 0).clamp(0, 99);
    setState(() {
      _plateCounts = {..._plateCounts, plate: next};
    });
  }

  void _stepPlateCount(double plate, int delta) {
    final next = ((_plateCounts[plate] ?? 0) + delta).clamp(0, 99);
    setState(() {
      _plateCounts = {..._plateCounts, plate: next};
      final controller = _resolvedCountControllers[plate];
      if (controller == null) return;
      controller
        ..text = next.toString()
        ..selection = TextSelection.collapsed(offset: controller.text.length);
    });
  }

  void _reset() {
    setState(() {
      _mode = _PlateCalculatorMode.target;
      _target = _equipment.defaultTarget;
      _barWeight = _equipment.bars.first;
      _plateCounts = {
        for (final plate in _plates) plate: 0,
      };
      _targetController.text = formatWeight(_target);
      _targetController.selection = TextSelection.collapsed(
        offset: _targetController.text.length,
      );
      // The plate set itself changes with the unit, so the count controllers
      // are rebuilt rather than reused.
      for (final controller in _resolvedCountControllers.values) {
        controller.dispose();
      }
      _countControllers = _createCountControllers();
    });
  }

  Map<double, TextEditingController> _createCountControllers() {
    return {
      for (final plate in _plates)
        plate: TextEditingController(
          text: (_plateCounts[plate] ?? 0).toString(),
        ),
    };
  }

  static _PlateCalculation _calculatePlates({
    required double target,
    required double barWeight,
    required List<double> plates,
  }) {
    final availableLoad = target - barWeight;
    if (availableLoad <= 0) {
      return _PlateCalculation(
        platesPerSide: const [],
        loadableTotal: barWeight,
        remainderPerSide: 0,
      );
    }

    var remainingPerSide = availableLoad / 2;
    final platesPerSide = <double>[];

    for (final plate in plates) {
      while (remainingPerSide + 0.001 >= plate) {
        platesPerSide.add(plate);
        remainingPerSide -= plate;
      }
    }

    final loadedPerSide = platesPerSide.fold<double>(
      0,
      (sum, plate) => sum + plate,
    );

    return _PlateCalculation(
      platesPerSide: platesPerSide,
      loadableTotal: barWeight + (loadedPerSide * 2),
      remainderPerSide: remainingPerSide < 0.001 ? 0 : remainingPerSide,
    );
  }

  static _PlateCalculation _calculateFromCounts({
    required Map<double, int> counts,
    required double barWeight,
    required List<double> plates,
  }) {
    final platesPerSide = <double>[];
    for (final plate in plates) {
      final count = counts[plate] ?? 0;
      for (var i = 0; i < count; i++) {
        platesPerSide.add(plate);
      }
    }

    final loadedPerSide = platesPerSide.fold<double>(
      0,
      (sum, plate) => sum + plate,
    );

    return _PlateCalculation(
      platesPerSide: platesPerSide,
      loadableTotal: barWeight + (loadedPerSide * 2),
      remainderPerSide: 0,
    );
  }
}

class _CalculatorHeader extends StatelessWidget {
  const _CalculatorHeader({required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        Container(
          width: 40,
          height: 40,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.clay100,
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: const Icon(
            Icons.fitness_center_rounded,
            color: AppColors.clay900,
            size: 20,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                l10n.dashboardPlateCalculatorTitle,
                style: AppTypography.display(
                  18,
                  weight: FontWeight.w600,
                  letterSpacing: -0.15,
                ),
              ),
              const SizedBox(height: 1),
              Text(
                l10n.dashboardPlateCalculatorSubtitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 11,
                  height: 1.3,
                ),
              ),
            ],
          ),
        ),
        IconButton(
          tooltip: l10n.commonReset,
          onPressed: onReset,
          style: IconButton.styleFrom(
            foregroundColor: AppColors.fg2,
            backgroundColor: AppColors.bg3,
            minimumSize: const Size.square(40),
            maximumSize: const Size.square(40),
          ),
          icon: const Icon(Icons.restart_alt_rounded, size: 20),
        ),
      ],
    );
  }
}

class _BarbellStage extends StatelessWidget {
  const _BarbellStage({required this.platesPerSide, required this.unit});

  final List<double> platesPerSide;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.sm,
        AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: AppColors.clay050,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Stack(
        children: [
          _BarbellVisual(platesPerSide: platesPerSide, unit: unit),
          Positioned(
            right: AppSpacing.xs,
            top: AppSpacing.xs,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 3),
              decoration: BoxDecoration(
                color: AppColors.bg2.withValues(alpha: 0.88),
                borderRadius: BorderRadius.circular(AppRadius.pill),
                border: Border.all(color: AppColors.surfaceBorderSoft),
              ),
              child: Text(
                unit.suffix,
                style: AppTypography.mono(
                  10,
                  weight: FontWeight.w600,
                  color: AppColors.fg3,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _CalculatorPanel extends StatelessWidget {
  const _CalculatorPanel({required this.child, this.emphasized = false});

  final Widget child;
  final bool emphasized;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: emphasized ? AppColors.clay050 : AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: emphasized
              ? AppColors.buttonBorder
              : AppColors.surfaceBorderSoft,
        ),
      ),
      child: child,
    );
  }
}

enum _PlateCalculatorMode { target, count }

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({required this.mode, required this.onChanged});

  final _PlateCalculatorMode mode;
  final ValueChanged<_PlateCalculatorMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.xs),
      decoration: BoxDecoration(
        color: AppColors.bg3,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        children: [
          Expanded(
            child: _ModeOption(
              label: l10n.dashboardPlateModeCalculate,
              selected: mode == _PlateCalculatorMode.target,
              onTap: () => onChanged(_PlateCalculatorMode.target),
            ),
          ),
          Expanded(
            child: _ModeOption(
              label: l10n.dashboardPlateModeSumPlates,
              selected: mode == _PlateCalculatorMode.count,
              onTap: () => onChanged(_PlateCalculatorMode.count),
            ),
          ),
        ],
      ),
    );
  }
}

class _ModeOption extends StatelessWidget {
  const _ModeOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 9),
          decoration: BoxDecoration(
            color: selected ? AppColors.bg2 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: selected ? AppColors.buttonBorder : Colors.transparent,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.clay900 : AppColors.fg3,
              fontSize: 13,
              fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _BarOption extends StatelessWidget {
  const _BarOption({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: selected ? AppColors.buttonPrimary : AppColors.buttonBg,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected
                  ? AppColors.buttonPrimary
                  : AppColors.buttonBorder,
            ),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.fgOnClay : AppColors.fg2,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }
}

class _TargetModeInput extends StatelessWidget {
  const _TargetModeInput({
    required this.controller,
    required this.unit,
    required this.step,
    required this.onChanged,
    required this.onStep,
  });

  final TextEditingController controller;
  final WeightUnit unit;

  /// One pair of the smallest plate in this unit's set.
  final double step;
  final ValueChanged<String> onChanged;
  final ValueChanged<double> onStep;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: _TargetWeightField(
            controller: controller,
            unit: unit,
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _StepButton(
          icon: Icons.remove_rounded,
          onTap: () => onStep(-step),
        ),
        const SizedBox(width: AppSpacing.xs),
        _StepButton(
          icon: Icons.add_rounded,
          onTap: () => onStep(step),
        ),
      ],
    );
  }
}

class _TargetWeightField extends StatelessWidget {
  const _TargetWeightField({
    required this.controller,
    required this.unit,
    required this.onChanged,
  });

  final TextEditingController controller;
  final WeightUnit unit;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          AppLocalizations.of(context).dashboardPlateTargetWeightLabel,
          style: const TextStyle(
            color: AppColors.fg2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        TextField(
          controller: controller,
          keyboardType: const TextInputType.numberWithOptions(decimal: true),
          textInputAction: TextInputAction.done,
          onChanged: onChanged,
          style: AppTypography.mono(17),
          decoration: InputDecoration(
            hintText: formatWeight(_PlateEquipment.of(unit).defaultTarget),
            suffixText: unit.suffix,
          ),
        ),
      ],
    );
  }
}

class _CountModeInput extends StatelessWidget {
  const _CountModeInput({
    required this.plates,
    required this.counts,
    required this.controllers,
    required this.unit,
    required this.onChanged,
    required this.onStep,
  });

  final List<double> plates;
  final Map<double, int> counts;
  final Map<double, TextEditingController> controllers;
  final WeightUnit unit;
  final void Function(double plate, String value) onChanged;
  final void Function(double plate, int delta) onStep;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: AppSpacing.xs),
          child: Text(
            AppLocalizations.of(context).dashboardPlatesPerSideLabel,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const Divider(height: 1),
        for (final plate in plates) ...[
          _PlateCountRow(
            plate: plate,
            count: counts[plate] ?? 0,
            controller: controllers[plate]!,
            unit: unit,
            onChanged: (value) => onChanged(plate, value),
            onStep: (delta) => onStep(plate, delta),
          ),
          if (plate != plates.last) const Divider(height: 1),
        ],
      ],
    );
  }
}

class _PlateCountRow extends StatelessWidget {
  const _PlateCountRow({
    required this.plate,
    required this.count,
    required this.controller,
    required this.unit,
    required this.onChanged,
    required this.onStep,
  });

  final double plate;
  final int count;
  final TextEditingController controller;
  final WeightUnit unit;
  final ValueChanged<String> onChanged;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: AppMotion.fast,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: count > 0 ? AppColors.accentSoft : Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          _PlateDot(weight: plate, unit: unit),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${formatWeight(plate)} ${unit.suffix}',
              style: const TextStyle(
                color: AppColors.fg1,
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          _SmallStepButton(
            icon: Icons.remove_rounded,
            onTap: () => onStep(-1),
          ),
          SizedBox(
            width: 46,
            height: 38,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              onChanged: onChanged,
              decoration: const InputDecoration(
                filled: false,
                isDense: true,
                contentPadding: EdgeInsets.symmetric(vertical: 8),
                border: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.surfaceBorderSoft),
                ),
                enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.surfaceBorderSoft),
                ),
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: AppColors.accent, width: 2),
                ),
              ),
              style: AppTypography.mono(
                14,
                weight: FontWeight.w500,
              ),
            ),
          ),
          _SmallStepButton(
            icon: Icons.add_rounded,
            onTap: () => onStep(1),
          ),
        ],
      ),
    );
  }
}

class _StepButton extends StatelessWidget {
  const _StepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 44,
      height: 48,
      child: IconButton.filledTonal(
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(
          foregroundColor: AppColors.sage700,
          backgroundColor: AppColors.sage100,
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 20),
      ),
    );
  }
}

class _SmallStepButton extends StatelessWidget {
  const _SmallStepButton({required this.icon, required this.onTap});

  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox.square(
      dimension: 36,
      child: IconButton(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
        style: IconButton.styleFrom(
          minimumSize: const Size.square(36),
          maximumSize: const Size.square(36),
          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
        onPressed: onTap,
        icon: Icon(icon, size: 18),
      ),
    );
  }
}

class _PlateResultView extends StatelessWidget {
  const _PlateResultView({
    required this.mode,
    required this.target,
    required this.barWeight,
    required this.result,
    required this.unit,
    required this.equipment,
  });

  final _PlateCalculatorMode mode;
  final double target;
  final double barWeight;
  final _PlateCalculation result;
  final WeightUnit unit;
  final _PlateEquipment equipment;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (mode == _PlateCalculatorMode.target && target <= 0) {
      return _PlateEmptyState(message: l10n.dashboardPlateEnterTargetMessage);
    }

    final loadedPerSide = (result.loadableTotal - barWeight) / 2;
    final primaryCounts = _plateCounts(result.platesPerSide);
    // The same load without the heaviest plate, for racks that don't have it.
    final alternativeCounts = mode == _PlateCalculatorMode.target
        ? _calculateCountsForPlates(
            loadedPerSide: loadedPerSide,
            plates: equipment.alternativePlates,
          )
        : null;
    final showAlternative =
        alternativeCounts != null &&
        !_samePlateCounts(primaryCounts, alternativeCounts);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _ResultHeadline(
          totalLabel: mode == _PlateCalculatorMode.target
              ? l10n.dashboardPlateLoadableLabel
              : l10n.dashboardPlateCurrentLabel,
          totalWeight: result.loadableTotal,
          barWeight: barWeight,
          unit: unit,
        ),
        const SizedBox(height: AppSpacing.sm),
        Container(
          decoration: const BoxDecoration(
            border: Border.symmetric(
              horizontal: BorderSide(color: AppColors.surfaceBorderSoft),
            ),
          ),
          child: IntrinsicHeight(
            child: Row(
              children: [
                _LoadSummary(
                  label: l10n.dashboardPlatePerSideLabel,
                  value: loadedPerSide,
                  formatter: (value) => '${formatWeight(value)} ${unit.suffix}',
                  emphasis: true,
                ),
                const VerticalDivider(width: 1),
                _LoadSummary(
                  label: l10n.dashboardPlatesPerSideLabel,
                  value: result.platesPerSide.length.toDouble(),
                  formatter: formatWeight,
                ),
              ],
            ),
          ),
        ),
        if (mode == _PlateCalculatorMode.target && target <= barWeight) ...[
          const SizedBox(height: AppSpacing.sm),
          _PlateEmptyState(
            message: l10n.dashboardPlateUseBarOnlyMessage(
              formatWeight(barWeight),
              unit.suffix,
            ),
          ),
        ] else if (!result.exact) ...[
          const SizedBox(height: AppSpacing.sm),
          _PlateNotice(
            message: l10n.dashboardPlateNotExactMessage(
              formatWeight(target),
              unit.suffix,
              formatWeight(equipment.smallestPlate),
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.sm),
        if (result.platesPerSide.isEmpty)
          _PlateEmptyState(
            message: mode == _PlateCalculatorMode.target
                ? l10n.dashboardPlateNoPlatesNeededMessage
                : l10n.dashboardPlateBarOnlyMessage,
          )
        else
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            crossAxisAlignment: WrapCrossAlignment.center,
            children: [
              for (final entry in primaryCounts.entries)
                _PlateBreakdownChip(
                  weight: entry.key,
                  count: entry.value,
                  unit: unit,
                ),
              if (showAlternative) ...[
                Text(
                  l10n.dashboardPlateAltSetLabel,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                for (final entry in alternativeCounts.entries)
                  _PlateBreakdownChip(
                    weight: entry.key,
                    count: entry.value,
                    unit: unit,
                    muted: true,
                  ),
              ],
            ],
          ),
      ],
    );
  }
}

/// Standard plate colors, shared by the barbell drawing, breakdown chips, and
/// count-mode dots so the same weight always reads as the same color.
///
/// The denominations overlap between units (25 kg is red, 25 lb is green), so
/// the unit decides which chart applies.
Color _plateColor(double weight, WeightUnit unit) =>
    unit == WeightUnit.lb ? _lbPlateColor(weight) : _kgPlateColor(weight);

Color _kgPlateColor(double weight) => switch (weight) {
  25.0 || 2.5 => AppColors.plateRed,
  20.0 || 2.0 => AppColors.plateBlue,
  15.0 || 1.5 => AppColors.plateYellow,
  10.0 || 1.0 => AppColors.plateGreen,
  5.0 => AppColors.plateWhite,
  _ => AppColors.ink300,
};

Color _lbPlateColor(double weight) => switch (weight) {
  55.0 => AppColors.plateRed,
  45.0 => AppColors.plateBlue,
  35.0 => AppColors.plateYellow,
  25.0 => AppColors.plateGreen,
  10.0 => AppColors.plateWhite,
  5.0 => AppColors.plateRed,
  2.5 => AppColors.plateGreen,
  _ => AppColors.ink300,
};

class _BarbellVisual extends StatelessWidget {
  const _BarbellVisual({required this.platesPerSide, required this.unit});

  final List<double> platesPerSide;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      key: PlateCalculatorCard.barbellVisualKey,
      width: double.infinity,
      height: 92,
      child: CustomPaint(
        size: Size.infinite,
        painter: _BarbellPainter(
          platesPerSide: platesPerSide,
          unit: unit,
        ),
      ),
    );
  }
}

class _ResultHeadline extends StatelessWidget {
  const _ResultHeadline({
    required this.totalLabel,
    required this.totalWeight,
    required this.barWeight,
    required this.unit,
  });

  final String totalLabel;
  final double totalWeight;
  final double barWeight;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(totalLabel.toUpperCase(), style: _eyebrow),
              const SizedBox(height: 2),
              // A Wrap, not a Row: a Row hands its children unbounded width,
              // which stops the big number from wrapping and overflows narrow
              // phones. This lets the kg note drop to its own line instead.
              Wrap(
                spacing: AppSpacing.sm,
                crossAxisAlignment: WrapCrossAlignment.end,
                children: [
                  XnAnimatedNumber(
                    value: totalWeight,
                    formatter: (value) =>
                        '${formatWeight(value)} ${unit.suffix}',
                    style: AppTypography.mono(27, weight: FontWeight.w500),
                  ),
                  // Plates are loaded in lb but training data is stored and
                  // discussed in kg, so the metric equivalent rides along.
                  if (unit == WeightUnit.lb)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 4),
                      child: Text(
                        l10n.dashboardPlateApproxKgNote(
                          formatWeight(
                            (WeightUnit.lb.toKg(totalWeight) * 10).round() / 10,
                          ),
                        ),
                        style: AppTypography.mono(12, color: AppColors.fg3),
                      ),
                    ),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: 4),
          child: Text(
            l10n.dashboardPlateBarWeightLabel(
              formatWeight(barWeight),
              unit.suffix,
            ),
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

/// Flat side-view barbell illustration. Every plate sits directly on the
/// sleeve, followed by a clamp, so the loading order is physically readable.
class _BarbellPainter extends CustomPainter {
  _BarbellPainter({required this.platesPerSide, required this.unit});

  /// Per-side plates in descending weight order (innermost first).
  final List<double> platesPerSide;
  final WeightUnit unit;

  static double _plateHeight(double weight, WeightUnit unit) {
    if (unit == WeightUnit.lb) {
      return switch (weight) {
        55.0 => 78.0,
        45.0 => 74.0,
        35.0 => 66.0,
        25.0 => 58.0,
        10.0 => 48.0,
        5.0 => 40.0,
        _ => 33.0,
      };
    }
    return switch (weight) {
      25.0 => 78.0,
      20.0 => 72.0,
      15.0 => 66.0,
      10.0 => 60.0,
      5.0 => 50.0,
      2.5 => 42.0,
      2.0 => 39.0,
      1.5 => 36.0,
      _ => 33.0,
    };
  }

  static double _plateWidth(double weight, WeightUnit unit) {
    if (unit == WeightUnit.lb) {
      return switch (weight) {
        55.0 => 10.0,
        45.0 => 9.5,
        35.0 => 9.0,
        25.0 => 8.0,
        10.0 => 6.5,
        5.0 => 5.5,
        _ => 4.5,
      };
    }
    return switch (weight) {
      25.0 => 10.0,
      20.0 => 9.5,
      15.0 => 9.0,
      10.0 => 8.0,
      5.0 => 7.0,
      2.5 => 6.0,
      2.0 => 5.5,
      1.5 => 5.0,
      _ => 4.5,
    };
  }

  static const _shaftMinW = 90.0;
  static const _shaftH = 5.5;
  static const _plateGap = 1.0;
  static const _collarW = 8.0;
  static const _collarH = 32.0;
  static const _collarInset = 3.0;
  static const _sleeveH = 10.0;
  static const _lockGap = 2.0;
  static const _lockW = 6.0;
  static const _lockH = 25.0;
  static const _sleeveExposed = 12.0;
  static const _endCapW = 5.0;
  static const _endCapH = 15.0;

  @override
  void paint(Canvas canvas, Size size) {
    final stackW =
        platesPerSide.fold<double>(
          0,
          (sum, p) => sum + _plateWidth(p, unit),
        ) +
        (platesPerSide.isEmpty ? 0 : _plateGap * (platesPerSide.length - 1));
    final sleeveLen =
        _collarInset +
        stackW +
        (platesPerSide.isEmpty ? 0 : _lockGap + _lockW) +
        _sleeveExposed;
    final sideW = _collarW + sleeveLen + _endCapW;

    var shaftW = size.width - sideW * 2;
    var scale = 1.0;
    if (shaftW < _shaftMinW) {
      shaftW = _shaftMinW;
      scale = size.width / (shaftW + sideW * 2);
    }

    canvas
      ..save()
      ..translate(size.width / 2, size.height * 0.5)
      ..scale(scale);

    _paintShaft(canvas, shaftW);
    for (final sign in const [-1.0, 1.0]) {
      _paintSide(canvas, sign: sign, shaftW: shaftW, sleeveLen: sleeveLen);
    }

    canvas.restore();
  }

  void _paintShaft(Canvas canvas, double shaftW) {
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: shaftW + _collarW * 2,
      height: _shaftH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(2.5)),
      Paint()..color = AppColors.ink300,
    );

    // Knurl bands: fine tick marks at the grip positions and bar center.
    final tick = Paint()..color = AppColors.ink900.withValues(alpha: 0.16);
    for (final band in [-shaftW * 0.3, 0.0, shaftW * 0.3]) {
      final ticks = band == 0 ? 3 : 6;
      for (var i = 0; i < ticks; i++) {
        final x = band + (i - (ticks - 1) / 2) * 3.0;
        canvas.drawRect(
          Rect.fromCenter(center: Offset(x, 0), width: 1.2, height: _shaftH),
          tick,
        );
      }
    }
  }

  void _paintSide(
    Canvas canvas, {
    required double sign,
    required double shaftW,
    required double sleeveLen,
  }) {
    final collarInner = sign * (shaftW / 2);
    final sleeveStart = collarInner + sign * _collarW;
    final sleeveEnd = sleeveStart + sign * sleeveLen;

    // Sleeve (under the plates), with its end cap.
    final sleeveRect = Rect.fromLTRB(
      sleeveStart < sleeveEnd ? sleeveStart : sleeveEnd,
      -_sleeveH / 2,
      sleeveStart < sleeveEnd ? sleeveEnd : sleeveStart,
      _sleeveH / 2,
    );
    final capRect = Rect.fromCenter(
      center: Offset(sleeveEnd + sign * (_endCapW / 2 - 1), 0),
      width: _endCapW,
      height: _endCapH,
    );
    canvas
      ..drawRRect(
        RRect.fromRectAndRadius(sleeveRect, const Radius.circular(3)),
        Paint()..color = AppColors.ink300,
      )
      ..drawRRect(
        RRect.fromRectAndRadius(capRect, const Radius.circular(2)),
        Paint()..color = AppColors.ink500,
      );

    // Collar between the shaft and the sleeve.
    final collarRect = Rect.fromCenter(
      center: Offset(collarInner + sign * (_collarW / 2), 0),
      width: _collarW,
      height: _collarH,
    );
    final collarRRect = RRect.fromRectAndRadius(
      collarRect,
      const Radius.circular(2.5),
    );
    canvas
      ..drawRRect(collarRRect, Paint()..color = AppColors.ink300)
      ..drawRRect(
        collarRRect,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = AppColors.ink500.withValues(alpha: 0.4),
      );

    // Plates sit flush on the sleeve, heaviest against the inner collar.
    var x = sleeveStart + sign * _collarInset;
    for (final plate in platesPerSide) {
      final width = _plateWidth(plate, unit);
      final centerX = x + sign * width / 2;
      _paintPlate(
        canvas,
        center: Offset(centerX, 0),
        width: width,
        height: _plateHeight(plate, unit),
        color: _plateColor(plate, unit),
      );
      x += sign * (width + _plateGap);
    }

    if (platesPerSide.isNotEmpty) {
      final lockCenterX = x + sign * (_lockGap + _lockW / 2);
      final lockRect = Rect.fromCenter(
        center: Offset(lockCenterX, 0),
        width: _lockW,
        height: _lockH,
      );
      canvas
        ..drawRRect(
          RRect.fromRectAndRadius(lockRect, const Radius.circular(2)),
          Paint()..color = AppColors.ink300,
        )
        ..drawRRect(
          RRect.fromRectAndRadius(lockRect, const Radius.circular(2)),
          Paint()
            ..style = PaintingStyle.stroke
            ..strokeWidth = 0.8
            ..color = AppColors.ink500.withValues(alpha: 0.58),
        );
    }
  }

  void _paintPlate(
    Canvas canvas, {
    required Offset center,
    required double width,
    required double height,
    required Color color,
  }) {
    final rect = Rect.fromCenter(
      center: center,
      width: width,
      height: height,
    );
    final plate = RRect.fromRectAndRadius(rect, const Radius.circular(3));
    final edgeColor = Color.lerp(color, AppColors.ink900, 0.28)!;
    canvas
      ..drawRRect(plate, Paint()..color = color)
      ..drawRRect(
        plate,
        Paint()
          ..style = PaintingStyle.stroke
          ..strokeWidth = 1
          ..color = edgeColor.withValues(alpha: 0.72),
      );
  }

  @override
  bool shouldRepaint(_BarbellPainter oldDelegate) {
    return !listEquals(oldDelegate.platesPerSide, platesPerSide);
  }
}

class _LoadSummary extends StatelessWidget {
  const _LoadSummary({
    required this.label,
    required this.value,
    required this.formatter,
    this.emphasis = false,
  });

  final String label;
  final double value;
  final XnNumberFormatter formatter;
  final bool emphasis;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.sm,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(label.toUpperCase(), style: _eyebrow),
            const SizedBox(height: 2),
            XnAnimatedNumber(
              value: value,
              formatter: formatter,
              style: AppTypography.mono(
                17,
                weight: FontWeight.w500,
                color: emphasis ? AppColors.clay900 : AppColors.fg1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _PlateBreakdownChip extends StatelessWidget {
  const _PlateBreakdownChip({
    required this.weight,
    required this.count,
    required this.unit,
    this.muted = false,
  });

  final double weight;
  final int count;
  final WeightUnit unit;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final color = _plateColor(weight, unit);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: muted ? Colors.transparent : AppColors.buttonBg,
        borderRadius: BorderRadius.circular(AppRadius.pill),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 10,
            height: 10,
            decoration: BoxDecoration(
              color: color,
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.lerp(
                  color,
                  AppColors.ink900,
                  0.3,
                )!.withValues(alpha: 0.4),
              ),
            ),
          ),
          const SizedBox(width: 6),
          Text(
            '$count × ${formatWeight(weight)}',
            style: AppTypography.mono(
              13,
              color: muted ? AppColors.fg3 : AppColors.fg1,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateDot extends StatelessWidget {
  const _PlateDot({
    required this.weight,
    required this.unit,
  });

  final double weight;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final size = unit == WeightUnit.lb
        ? switch (weight) {
            55.0 => 30.0,
            45.0 => 29.0,
            35.0 => 27.0,
            25.0 => 24.0,
            10.0 => 21.0,
            _ => 18.0,
          }
        : switch (weight) {
            25.0 => 30.0,
            20.0 => 28.0,
            10.0 => 25.0,
            5.0 => 21.0,
            _ => 18.0,
          };

    return SizedBox(
      width: 34,
      height: 34,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Container(
            key: Key('plate-dot-${formatWeight(weight)}-${unit.suffix}'),
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: _plateColor(weight, unit),
              shape: BoxShape.circle,
              border: Border.all(
                color: Color.lerp(
                  _plateColor(weight, unit),
                  AppColors.ink900,
                  0.35,
                )!.withValues(alpha: 0.52),
              ),
            ),
          ),
          Container(
            width: 7,
            height: 7,
            decoration: const BoxDecoration(
              color: AppColors.bg2,
              shape: BoxShape.circle,
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateNotice extends StatelessWidget {
  const _PlateNotice({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningBg,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.info_outline_rounded,
            color: AppColors.warning,
            size: 16,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.warning,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PlateEmptyState extends StatelessWidget {
  const _PlateEmptyState({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.52),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Text(message, style: const TextStyle(color: AppColors.fg3)),
    );
  }
}

class _PlateCalculation {
  const _PlateCalculation({
    required this.platesPerSide,
    required this.loadableTotal,
    required this.remainderPerSide,
  });

  final List<double> platesPerSide;
  final double loadableTotal;
  final double remainderPerSide;

  bool get exact => remainderPerSide == 0;
}

Map<double, int> _plateCounts(List<double> plates) {
  final counts = <double, int>{};
  for (final plate in plates) {
    counts.update(plate, (count) => count + 1, ifAbsent: () => 1);
  }
  return counts;
}

Map<double, int> _calculateCountsForPlates({
  required double loadedPerSide,
  required List<double> plates,
}) {
  var remaining = loadedPerSide;
  final counts = <double, int>{};

  for (final plate in plates) {
    while (remaining + 0.001 >= plate) {
      counts.update(plate, (count) => count + 1, ifAbsent: () => 1);
      remaining -= plate;
    }
  }

  return counts;
}

bool _samePlateCounts(Map<double, int> left, Map<double, int> right) {
  final keys = {...left.keys, ...right.keys};
  for (final key in keys) {
    if ((left[key] ?? 0) != (right[key] ?? 0)) return false;
  }
  return true;
}

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);
