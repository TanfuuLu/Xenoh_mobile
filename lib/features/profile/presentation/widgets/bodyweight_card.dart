import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_animated_number.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/bodyweight_log.dart';
import 'bodyweight_chart.dart';

/// Latest bodyweight + trend chart with a "Log" action. Shared by the Profile
/// and Home screens. [history] is sorted oldest -> newest, values in kg.
class BodyweightCard extends StatelessWidget {
  const BodyweightCard({
    required this.history,
    required this.unit,
    required this.onLog,
    this.framed = true,
    super.key,
  });

  final AsyncValue<List<BodyweightLog>> history;
  final WeightUnit unit;
  final VoidCallback onLog;
  final bool framed;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final logs = history.value ?? const [];
    final latest = logs.lastOrNull;
    final delta = logs.length >= 2
        ? logs.last.weight - logs[logs.length - 2].weight
        : null;

    final metric = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.profileBodyweightEyebrow, style: _eyebrow),
        const SizedBox(height: 2),
        if (latest != null)
          Wrap(
            crossAxisAlignment: WrapCrossAlignment.center,
            spacing: AppSpacing.sm,
            runSpacing: AppSpacing.xs,
            children: [
              XnAnimatedNumber(
                value: unit.fromKg(latest.weight),
                formatter: (value) => '${formatWeight(value)} ${unit.suffix}',
                style: AppTypography.display(22, letterSpacing: 0),
              ),
              if (delta != null && delta != 0)
                DeltaChip(delta: delta, unit: unit),
            ],
          )
        else
          Text(
            l10n.profileBodyweightNoEntries,
            style: const TextStyle(color: AppColors.fg3),
          ),
      ],
    );
    final action = XnButton(
      label: l10n.profileBodyweightLogCta,
      icon: Icons.add_rounded,
      variant: XnButtonVariant.secondary,
      onPressed: onLog,
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
                  action,
                ],
              );
            }

            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(child: metric),
                const SizedBox(width: AppSpacing.md),
                action,
              ],
            );
          },
        ),
        const SizedBox(height: AppSpacing.md),
        _chart(context),
      ],
    );

    if (!framed) {
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
    final items = history.value;
    if (items == null) {
      if (history.hasError) {
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
    return BodyweightChart(logs: items, unit: unit);
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
