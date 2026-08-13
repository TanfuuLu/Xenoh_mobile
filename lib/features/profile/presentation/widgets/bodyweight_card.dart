import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/bodyweight_log.dart';
import 'bodyweight_chart.dart';

/// Latest bodyweight + trend chart with a "Log" action. Shared by the Profile
/// and Home screens. [history] is sorted oldest -> newest, values in kg.
class BodyweightCard extends StatefulWidget {
  const BodyweightCard({
    required this.history,
    required this.unit,
    required this.onLog,
    this.onShowHistory,
    this.framed = true,
    super.key,
  });

  final AsyncValue<List<BodyweightLog>> history;
  final WeightUnit unit;
  final Future<void> Function(double weightKg) onLog;
  final VoidCallback? onShowHistory;
  final bool framed;

  @override
  State<BodyweightCard> createState() => _BodyweightCardState();
}

class _BodyweightCardState extends State<BodyweightCard> {
  late final TextEditingController _weightController = TextEditingController();
  late final FocusNode _weightFocus = FocusNode();
  final Object _weightInputGroup = Object();
  bool _isEditing = false;
  bool _isSaving = false;
  String? _weightError;
  double? _syncedWeightKg;

  @override
  void initState() {
    super.initState();
    _syncWeightInput();
  }

  @override
  void didUpdateWidget(covariant BodyweightCard oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (!_isEditing &&
        (oldWidget.history.value?.lastOrNull?.weight !=
                widget.history.value?.lastOrNull?.weight ||
            oldWidget.unit != widget.unit)) {
      _syncWeightInput();
    }
  }

  @override
  void dispose() {
    _weightController.dispose();
    _weightFocus.dispose();
    super.dispose();
  }

  void _syncWeightInput() {
    final latest = widget.history.value?.lastOrNull?.weight;
    _syncedWeightKg = latest;
    _weightController.text = latest == null
        ? ''
        : formatWeight(widget.unit.fromKg(latest));
  }

  void _beginEditing() {
    setState(() {
      _isEditing = true;
      _weightError = null;
    });
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (!mounted) return;
      _weightFocus.requestFocus();
      _weightController.selection = TextSelection(
        baseOffset: 0,
        extentOffset: _weightController.text.length,
      );
    });
  }

  void _cancelEditing() {
    if (!_isEditing || _isSaving) return;
    _weightFocus.unfocus();
    setState(() {
      _isEditing = false;
      _weightError = null;
      _syncWeightInput();
    });
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    final entered = double.tryParse(_weightController.text.trim());
    final min = widget.unit.fromKg(20);
    final max = widget.unit.fromKg(500);
    if (entered == null) {
      setState(() {
        _isEditing = true;
        _weightError = l10n.commonEnterNumberError;
      });
      _weightFocus.requestFocus();
      return;
    }
    if (entered < min || entered > max) {
      setState(() {
        _isEditing = true;
        _weightError = l10n.profileWeightRangeWithUnitError(
          formatWeight(min),
          formatWeight(max),
          widget.unit.suffix,
        );
      });
      _weightFocus.requestFocus();
      return;
    }

    setState(() {
      _isSaving = true;
      _weightError = null;
    });
    try {
      final weightKg = widget.unit.toKg(entered);
      await widget.onLog(weightKg);
      if (!mounted) return;
      _syncedWeightKg = weightKg;
      _weightFocus.unfocus();
      setState(() => _isEditing = false);
    } catch (_) {
      // The owner presents the repository error; keep the input open so the
      // user can retry without re-entering their weight.
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final logs = widget.history.value ?? const [];
    final latest = logs.lastOrNull;
    final delta = logs.length >= 2
        ? logs.last.weight - logs[logs.length - 2].weight
        : null;

    final metric = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.profileBodyweightEyebrow, style: _eyebrow),
        const SizedBox(height: 2),
        if (_isEditing || latest == null)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              SizedBox(
                width: 126,
                child: TextField(
                  groupId: _weightInputGroup,
                  controller: _weightController,
                  focusNode: _weightFocus,
                  keyboardType: const TextInputType.numberWithOptions(
                    decimal: true,
                  ),
                  inputFormatters: [
                    FilteringTextInputFormatter.allow(RegExp('[0-9.]')),
                  ],
                  textInputAction: TextInputAction.done,
                  style: AppTypography.display(22, letterSpacing: 0),
                  decoration: InputDecoration(
                    isDense: true,
                    contentPadding: const EdgeInsets.only(bottom: 4),
                    suffixText: widget.unit.suffix,
                    errorText: _weightError,
                    errorMaxLines: 2,
                  ),
                  onChanged: (_) {
                    if (_weightError != null) {
                      setState(() => _weightError = null);
                    }
                  },
                  onTapOutside: (_) => _cancelEditing(),
                  onSubmitted: (_) => _weightFocus.unfocus(),
                ),
              ),
              if (delta != null && delta != 0)
                DeltaChip(delta: delta, unit: widget.unit),
            ],
          )
        else
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              Tooltip(
                message: l10n.profileWeightLabel,
                child: Semantics(
                  button: true,
                  child: InkWell(
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                    onTap: _beginEditing,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 2),
                      child: XnAnimatedNumber(
                        value: widget.unit.fromKg(
                          _syncedWeightKg ?? latest.weight,
                        ),
                        formatter: (value) =>
                            '${formatWeight(value)} ${widget.unit.suffix}',
                        style: AppTypography.display(22, letterSpacing: 0),
                      ),
                    ),
                  ),
                ),
              ),
              if (delta != null && delta != 0)
                DeltaChip(delta: delta, unit: widget.unit),
            ],
          ),
      ],
    );
    final action = TapRegion(
      groupId: _weightInputGroup,
      child: XnButton(
        label: l10n.profileBodyweightLogCta,
        icon: Icons.add_rounded,
        variant: XnButtonVariant.secondary,
        loading: _isSaving,
        onPressed: _submit,
      ),
    );
    final historyAction = widget.onShowHistory == null
        ? null
        : IconButton.outlined(
            tooltip: l10n.profileBodyweightHistoryTitle,
            onPressed: widget.onShowHistory,
            style: IconButton.styleFrom(
              foregroundColor: AppColors.buttonPrimary,
              backgroundColor: AppColors.buttonBg,
              side: const BorderSide(color: AppColors.buttonBorder),
            ),
            icon: const Icon(Icons.history_rounded, size: 19),
          );

    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth < 320) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  metric,
                  const SizedBox(height: AppSpacing.md),
                  Row(
                    children: [
                      Expanded(child: action),
                      if (historyAction != null) ...[
                        const SizedBox(width: AppSpacing.sm),
                        historyAction,
                      ],
                    ],
                  ),
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: metric),
                const SizedBox(width: AppSpacing.md),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    action,
                    if (historyAction != null) ...[
                      const SizedBox(width: AppSpacing.sm),
                      historyAction,
                    ],
                  ],
                ),
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _chart(context),
      ],
    );

    if (!widget.framed) {
      return Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.xl,
        ),
        child: content,
      );
    }

    return XnSectionGroup(children: [content]);
  }

  /// Keeps the last chart visible during a refresh; spinner/error only on the
  /// first load (matches the app-wide async rendering convention).
  Widget _chart(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = widget.history.value;
    if (items == null) {
      if (widget.history.hasError) {
        return SizedBox(
          height: 80,
          child: Center(
            child: Text(
              l10n.profileBodyweightHistoryError,
              style: const TextStyle(color: AppColors.fg3),
            ),
          ),
        );
      }
      return const SizedBox(
        height: 140,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (items.isEmpty) {
      return SizedBox(
        height: 80,
        child: Center(
          child: Text(
            l10n.profileBodyweightTrendPrompt,
            style: const TextStyle(color: AppColors.fg3),
          ),
        ),
      );
    }
    return BodyweightChart(logs: items, unit: widget.unit);
  }
}

class BodyweightHistorySheet extends StatelessWidget {
  const BodyweightHistorySheet({
    required this.logs,
    required this.unit,
    required this.onDelete,
    super.key,
  });

  final List<BodyweightLog> logs;
  final WeightUnit unit;
  final ValueChanged<String> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ordered = logs.reversed.toList();
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          0,
          AppSpacing.lg,
          AppSpacing.lg,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.profileBodyweightHistoryTitle,
              style: AppTypography.display(20, letterSpacing: 0),
            ),
            const SizedBox(height: AppSpacing.sm),
            Flexible(
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: ordered.length,
                separatorBuilder: (_, _) => const Divider(
                  height: 1,
                  color: AppColors.surfaceBorderSoft,
                ),
                itemBuilder: (_, index) {
                  final log = ordered[index];
                  final previous = index + 1 < ordered.length
                      ? ordered[index + 1]
                      : null;
                  final delta = previous == null
                      ? null
                      : log.weight - previous.weight;
                  return Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: AppSpacing.md,
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            DateOnly.format(log.date),
                            style: AppTypography.mono(13, color: AppColors.fg2),
                          ),
                        ),
                        if (delta != null && delta != 0) ...[
                          DeltaChip(delta: delta, unit: unit),
                          const SizedBox(width: AppSpacing.md),
                        ],
                        Text(
                          '${formatWeight(unit.fromKg(log.weight))} ${unit.suffix}',
                          style: AppTypography.mono(
                            14,
                            weight: FontWeight.w500,
                          ),
                        ),
                        IconButton(
                          tooltip: l10n.profileDeleteEntryTooltip,
                          icon: const Icon(Icons.delete_outline_rounded),
                          onPressed: () => onDelete(log.id),
                        ),
                      ],
                    ),
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

/// Up/down weight-change chip (down = green, up = amber). [delta] is in kg.
class DeltaChip extends StatelessWidget {
  const DeltaChip({required this.delta, required this.unit, super.key});

  final double delta;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final down = delta < 0;
    final color = down ? AppColors.success : AppColors.warning;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(
          down ? Icons.arrow_downward_rounded : Icons.arrow_upward_rounded,
          size: 14,
          color: color,
        ),
        XnAnimatedNumber(
          value: unit.fromKg(delta.abs()),
          formatter: (value) => '${formatWeight(value)} ${unit.suffix}',
          style: AppTypography.mono(12, weight: FontWeight.w500, color: color),
        ),
      ],
    );
  }
}

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);
