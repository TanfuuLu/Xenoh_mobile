import 'package:flutter/foundation.dart' show listEquals;
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart' show formatWeight;
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

class PlateCalculatorCard extends StatefulWidget {
  const PlateCalculatorCard({super.key});

  @override
  State<PlateCalculatorCard> createState() => _PlateCalculatorCardState();
}

class _PlateCalculatorCardState extends State<PlateCalculatorCard> {
  static const _plates = [25.0, 20.0, 10.0, 5.0, 2.5];
  static const _barOptions = [20.0, 15.0, 25.0];

  final _targetController = TextEditingController(text: '100');
  Map<double, TextEditingController>? _countControllers;

  var _mode = _PlateCalculatorMode.target;
  var _target = 100.0;
  var _barWeight = 20.0;
  var _plateCounts = <double, int>{
    25.0: 0,
    20.0: 0,
    10.0: 0,
    5.0: 0,
    2.5: 0,
  };

  @override
  void initState() {
    super.initState();
    _countControllers = _createCountControllers();
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
        ? _calculatePlates(target: _target, barWeight: _barWeight)
        : _calculateFromCounts(
            counts: _plateCounts,
            barWeight: _barWeight,
          );

    return XnCard(
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
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.dashboardPlateCalculatorEyebrow,
                  style: _eyebrow,
                ),
              ),
              IconButton(
                tooltip: l10n.commonReset,
                visualDensity: VisualDensity.compact,
                onPressed: _reset,
                icon: const Icon(Icons.restart_alt_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _ModeSwitch(
            mode: _mode,
            onChanged: (mode) => setState(() => _mode = mode),
          ),
          const SizedBox(height: AppSpacing.md),
          if (_mode == _PlateCalculatorMode.target)
            _TargetModeInput(
              controller: _targetController,
              onChanged: _setTargetFromText,
              onStep: _stepTarget,
            )
          else
            _CountModeInput(
              plates: _plates,
              counts: _plateCounts,
              controllers: _resolvedCountControllers,
              onChanged: _setPlateCount,
              onStep: _stepPlateCount,
            ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.sm,
            children: [
              for (final bar in _barOptions)
                _BarOption(
                  label: l10n.dashboardPlateBarWeightLabel(formatWeight(bar)),
                  selected: _barWeight == bar,
                  onTap: () => setState(() => _barWeight = bar),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _PlateResultView(
            mode: _mode,
            target: _target,
            barWeight: _barWeight,
            result: result,
          ),
        ],
      ),
    );
  }

  void _setTargetFromText(String value) {
    final parsed = double.tryParse(value);
    if (parsed == null) {
      setState(() => _target = 0);
      return;
    }
    setState(() => _target = parsed.clamp(0, 999).toDouble());
  }

  void _stepTarget(double delta) {
    final next = (_target + delta).clamp(0, 999).toDouble();
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
      _target = 100;
      _barWeight = 20;
      _plateCounts = {
        for (final plate in _plates) plate: 0,
      };
      _targetController.text = '100';
      _targetController.selection = const TextSelection.collapsed(offset: 3);
      for (final controller in _resolvedCountControllers.values) {
        controller
          ..text = '0'
          ..selection = const TextSelection.collapsed(offset: 1);
      }
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

    for (final plate in _plates) {
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
  }) {
    final platesPerSide = <double>[];
    for (final plate in _plates) {
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

enum _PlateCalculatorMode { target, count }

class _ModeSwitch extends StatelessWidget {
  const _ModeSwitch({required this.mode, required this.onChanged});

  final _PlateCalculatorMode mode;
  final ValueChanged<_PlateCalculatorMode> onChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(3),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
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
        borderRadius: BorderRadius.circular(AppRadius.sm),
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          alignment: Alignment.center,
          padding: const EdgeInsets.symmetric(vertical: 9),
          decoration: BoxDecoration(
            color: selected ? AppColors.bg2 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.fg1 : AppColors.fg3,
              fontSize: 13,
              fontWeight: FontWeight.w500,
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
          padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.accent : AppColors.buttonBg,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            border: Border.all(
              color: selected ? AppColors.accent : AppColors.buttonBorder,
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
    required this.onChanged,
    required this.onStep,
  });

  final TextEditingController controller;
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
            onChanged: onChanged,
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        _StepButton(
          icon: Icons.remove_rounded,
          onTap: () => onStep(-2.5),
        ),
        const SizedBox(width: AppSpacing.xs),
        _StepButton(
          icon: Icons.add_rounded,
          onTap: () => onStep(2.5),
        ),
      ],
    );
  }
}

class _TargetWeightField extends StatelessWidget {
  const _TargetWeightField({
    required this.controller,
    required this.onChanged,
  });

  final TextEditingController controller;
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
          decoration: const InputDecoration(
            hintText: '100',
            suffixText: 'kg',
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
    required this.onChanged,
    required this.onStep,
  });

  final List<double> plates;
  final Map<double, int> counts;
  final Map<double, TextEditingController> controllers;
  final void Function(double plate, String value) onChanged;
  final void Function(double plate, int delta) onStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.36),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(4, 2, 4, AppSpacing.sm),
            child: Text(
              AppLocalizations.of(context).dashboardPlatesPerSideLabel,
              style: const TextStyle(
                color: AppColors.fg2,
                fontSize: 13,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          for (final plate in plates) ...[
            _PlateCountRow(
              plate: plate,
              count: counts[plate] ?? 0,
              controller: controllers[plate]!,
              onChanged: (value) => onChanged(plate, value),
              onStep: (delta) => onStep(plate, delta),
            ),
            if (plate != plates.last) const SizedBox(height: AppSpacing.sm),
          ],
        ],
      ),
    );
  }
}

class _PlateCountRow extends StatelessWidget {
  const _PlateCountRow({
    required this.plate,
    required this.count,
    required this.controller,
    required this.onChanged,
    required this.onStep,
  });

  final double plate;
  final int count;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final ValueChanged<int> onStep;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          _PlateDot(weight: plate, count: count),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${formatWeight(plate)} kg',
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
          const SizedBox(width: AppSpacing.xs),
          SizedBox(
            width: 52,
            height: 42,
            child: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              textAlign: TextAlign.center,
              textInputAction: TextInputAction.done,
              onChanged: onChanged,
              decoration: const InputDecoration(
                contentPadding: EdgeInsets.symmetric(vertical: 10),
              ),
              style: AppTypography.mono(
                14,
                weight: FontWeight.w500,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.xs),
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
      dimension: 34,
      child: IconButton.filledTonal(
        padding: EdgeInsets.zero,
        visualDensity: VisualDensity.compact,
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
  });

  final _PlateCalculatorMode mode;
  final double target;
  final double barWeight;
  final _PlateCalculation result;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (mode == _PlateCalculatorMode.target && target <= 0) {
      return _PlateEmptyState(message: l10n.dashboardPlateEnterTargetMessage);
    }

    final loadedPerSide = (result.loadableTotal - barWeight) / 2;
    final primaryCounts = _plateCounts(result.platesPerSide);
    final alternative20KgCounts = mode == _PlateCalculatorMode.target
        ? _calculateCountsForPlates(
            loadedPerSide: loadedPerSide,
            plates: const [20.0, 10.0, 5.0, 2.5],
          )
        : null;
    final showAlternative =
        alternative20KgCounts != null &&
        !_samePlateCounts(primaryCounts, alternative20KgCounts);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _BarbellVisual(
          totalLabel: mode == _PlateCalculatorMode.target
              ? l10n.dashboardPlateLoadableLabel
              : l10n.dashboardPlateCurrentLabel,
          totalWeight: result.loadableTotal,
          barWeight: barWeight,
          platesPerSide: result.platesPerSide,
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            _LoadSummary(
              label: l10n.dashboardPlatePerSideLabel,
              value: loadedPerSide,
              formatter: (value) => '${formatWeight(value)} kg',
              emphasis: true,
            ),
            const SizedBox(width: AppSpacing.sm),
            _LoadSummary(
              label: l10n.dashboardPlatesPerSideLabel,
              value: result.platesPerSide.length.toDouble(),
              formatter: formatWeight,
            ),
          ],
        ),
        if (mode == _PlateCalculatorMode.target && target <= barWeight) ...[
          const SizedBox(height: AppSpacing.sm),
          _PlateEmptyState(
            message: l10n.dashboardPlateUseBarOnlyMessage(
              formatWeight(barWeight),
            ),
          ),
        ] else if (!result.exact) ...[
          const SizedBox(height: AppSpacing.sm),
          _PlateNotice(
            message: l10n.dashboardPlateNotExactMessage(formatWeight(target)),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
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
                _PlateBreakdownChip(weight: entry.key, count: entry.value),
              if (showAlternative) ...[
                Text(
                  l10n.dashboardPlateAltSetLabel,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                for (final entry in alternative20KgCounts.entries)
                  _PlateBreakdownChip(
                    weight: entry.key,
                    count: entry.value,
                    muted: true,
                  ),
              ],
            ],
          ),
      ],
    );
  }
}

/// Side-on plate colors, shared by the barbell drawing, the breakdown chips,
/// and the count-mode dots so the same weight always reads as the same color.
Color _plateColor(double weight) => switch (weight) {
  25.0 => AppColors.clay800,
  20.0 => AppColors.clay200,
  10.0 => AppColors.sage500,
  5.0 => AppColors.sage100,
  _ => AppColors.ink300,
};

class _BarbellVisual extends StatelessWidget {
  const _BarbellVisual({
    required this.totalLabel,
    required this.totalWeight,
    required this.barWeight,
    required this.platesPerSide,
  });

  final String totalLabel;
  final double totalWeight;
  final double barWeight;
  final List<double> platesPerSide;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.md,
        AppSpacing.xl,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [AppColors.bg2, AppColors.clay050],
        ),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        children: [
          Text(totalLabel.toUpperCase(), style: _eyebrow),
          const SizedBox(height: 2),
          XnAnimatedNumber(
            value: totalWeight,
            formatter: (value) => '${formatWeight(value)} kg',
            style: AppTypography.mono(27, weight: FontWeight.w500),
          ),
          Text(
            l10n.dashboardPlateBarWeightLabel(formatWeight(barWeight)),
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.lg),
          SizedBox(
            height: 96,
            width: double.infinity,
            child: CustomPaint(
              size: Size.infinite,
              painter: _BarbellPainter(platesPerSide: platesPerSide),
            ),
          ),
        ],
      ),
    );
  }
}

/// Side-view barbell: a long thin shaft with knurl marks stretching the full
/// card width, collars, sleeves running through the plate stacks with exposed
/// ends, and a soft ground shadow. Plates are ordered heaviest-innermost, the
/// way a bar is actually loaded.
class _BarbellPainter extends CustomPainter {
  _BarbellPainter({required this.platesPerSide});

  /// Per-side plates in descending weight order (innermost first).
  final List<double> platesPerSide;

  static double _plateHeight(double weight) => switch (weight) {
    25.0 => 78.0,
    20.0 => 70.0,
    10.0 => 58.0,
    5.0 => 46.0,
    _ => 36.0,
  };

  static double _plateWidth(double weight) => switch (weight) {
    25.0 => 14.0,
    20.0 => 13.0,
    10.0 => 11.0,
    5.0 => 9.0,
    _ => 7.5,
  };

  static const _shaftMinW = 90.0;
  static const _shaftH = 5.0;
  static const _plateGap = 2.0;
  static const _collarW = 7.0;
  static const _collarH = 30.0;
  static const _collarInset = 2.0;
  static const _sleeveH = 9.0;
  static const _sleeveExposed = 12.0;
  static const _endCapW = 4.0;
  static const _endCapH = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    final stackW =
        platesPerSide.fold<double>(0, (sum, p) => sum + _plateWidth(p)) +
        (platesPerSide.isEmpty ? 0 : _plateGap * (platesPerSide.length - 1));
    final sleeveLen =
        _collarInset +
        stackW +
        (platesPerSide.isEmpty ? 0 : _plateGap) +
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
      ..translate(size.width / 2, size.height * 0.44)
      ..scale(scale);

    _paintGroundShadow(canvas, shaftW / 2 + sideW);
    _paintShaft(canvas, shaftW);
    for (final sign in const [-1.0, 1.0]) {
      _paintSide(canvas, sign: sign, shaftW: shaftW, sleeveLen: sleeveLen);
    }

    canvas.restore();
  }

  void _paintGroundShadow(Canvas canvas, double halfWidth) {
    final rect = Rect.fromCenter(
      center: Offset(0, _plateHeight(25) / 2 + 9),
      width: halfWidth * 1.5,
      height: 9,
    );
    canvas.drawOval(
      rect,
      Paint()
        ..color = AppColors.clay900.withValues(alpha: 0.1)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 4),
    );
  }

  void _paintShaft(Canvas canvas, double shaftW) {
    final rect = Rect.fromCenter(
      center: Offset.zero,
      width: shaftW + _collarW * 2,
      height: _shaftH,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(rect, const Radius.circular(2.5)),
      Paint()..shader = _metalShader(rect, dark: true),
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
        Paint()..shader = _metalShader(sleeveRect),
      )
      ..drawRRect(
        RRect.fromRectAndRadius(capRect, const Radius.circular(2)),
        Paint()..shader = _metalShader(capRect, dark: true),
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
      ..drawRRect(collarRRect, Paint()..shader = _metalShader(collarRect))
      ..drawRRect(
        collarRRect,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = AppColors.ink500.withValues(alpha: 0.4),
      );

    // Plates, heaviest against the collar.
    var x = sleeveStart + sign * _collarInset;
    for (final plate in platesPerSide) {
      final w = _plateWidth(plate);
      final rect = Rect.fromCenter(
        center: Offset(x + sign * (w / 2), 0),
        width: w,
        height: _plateHeight(plate),
      );
      _paintPlate(canvas, rect, _plateColor(plate));
      x += sign * (w + _plateGap);
    }
  }

  void _paintPlate(Canvas canvas, Rect rect, Color color) {
    final rrect = RRect.fromRectAndRadius(rect, const Radius.circular(3));
    canvas
      ..drawRRect(
        rrect,
        Paint()
          ..shader = LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color.lerp(color, Colors.white, 0.25)!,
              color,
              Color.lerp(color, AppColors.ink900, 0.12)!,
            ],
          ).createShader(rect),
      )
      ..drawRRect(
        rrect,
        Paint()
          ..style = PaintingStyle.stroke
          ..color = Color.lerp(
            color,
            AppColors.ink900,
            0.3,
          )!.withValues(alpha: 0.45),
      );
  }

  Shader _metalShader(Rect rect, {bool dark = false}) {
    return LinearGradient(
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
      colors: dark
          ? [
              AppColors.ink300.withValues(alpha: 0.85),
              AppColors.ink500.withValues(alpha: 0.75),
            ]
          : [AppColors.ink050, AppColors.ink300.withValues(alpha: 0.85)],
    ).createShader(rect);
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
      child: Container(
        padding: const EdgeInsets.all(AppSpacing.sm),
        decoration: BoxDecoration(
          color: emphasis
              ? AppColors.accentSoft
              : AppColors.bg3.withValues(alpha: 0.55),
          borderRadius: BorderRadius.circular(AppRadius.md),
          border: Border.all(color: AppColors.surfaceBorderSoft),
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
    this.muted = false,
  });

  final double weight;
  final int count;
  final bool muted;

  @override
  Widget build(BuildContext context) {
    final color = _plateColor(weight);
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
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
  const _PlateDot({required this.weight, required this.count});

  final double weight;
  final int count;

  @override
  Widget build(BuildContext context) {
    final size = switch (weight) {
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
            width: size,
            height: size,
            decoration: BoxDecoration(
              color: count > 0 ? _plateColor(weight) : AppColors.bg3,
              shape: BoxShape.circle,
              border: Border.all(color: AppColors.surfaceBorderSoft),
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
