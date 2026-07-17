import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/plan_analytics.dart';
import 'line_series_chart.dart';

/// Powerlifting tab body, rendered in the app's dashboard-style grouped-panel
/// layout: a Big-3 panel of divided lift sections, then a single panel whose
/// divided sections hold the key metrics, the estimated-1RM trend, the PR
/// timeline and DOTS over time — no standalone cards. Mirrors the website
/// `PowerliftingPanel`.
class PowerliftingPanel extends StatelessWidget {
  const PowerliftingPanel({
    required this.section,
    required this.unit,
    super.key,
  });

  final PowerliftingSection section;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final analysis = _PowerliftingAnalysis.from(section, unit, l10n);
    final allPrs =
        (section.lifts
            .expand(
              (l) => l.prTimeline.map((pr) => (lift: l.lift, event: pr)),
            )
            .toList()
          ..sort((a, b) => b.event.date.compareTo(a.event.date)));

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Big-3 lift panel.
        XnSectionGroup(
          children: [
            for (var i = 0; i < section.lifts.length; i++) ...[
              if (i > 0) const XnSectionDivider(),
              _LiftSection(lift: section.lifts[i], unit: unit),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        XnSectionGroup(
          children: [
            _AnalysisSection(analysis: analysis),
            const XnSectionDivider(),
            _E1rmTrendSection(section: section, unit: unit),
            const XnSectionDivider(),
            _PrTimelineSection(prs: allPrs, unit: unit),
            const XnSectionDivider(),
            _DotsSection(dots: section.dots),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }
}

/// One lift's current e1RM + training max as a divided section, with the lift
/// accent colour and a plateau chip when flagged.
class _LiftSection extends StatelessWidget {
  const _LiftSection({required this.lift, required this.unit});

  final LiftSeries lift;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accent = _liftColor(lift.lift);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.fitness_center_rounded, size: 18, color: accent),
              const SizedBox(width: AppSpacing.sm),
              Text(
                _liftName(lift.lift, l10n),
                style: TextStyle(
                  color: accent,
                  fontWeight: FontWeight.w500,
                  fontSize: 13,
                ),
              ),
              const Spacer(),
              if (lift.isPlateau)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8,
                    vertical: 3,
                  ),
                  decoration: BoxDecoration(
                    color: AppColors.dangerBg,
                    borderRadius: BorderRadius.circular(AppRadius.sm),
                  ),
                  child: Text(
                    l10n.powerliftingPlateauLabel,
                    style: AppTypography.mono(10, color: AppColors.danger),
                  ),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                lift.currentE1Rm == null
                    ? '—'
                    : formatWeight(unit.fromKg(lift.currentE1Rm!)),
                style: AppTypography.display(26, letterSpacing: 0),
              ),
              const SizedBox(width: 4),
              Text(
                l10n.powerliftingE1rmUnitLabel(unit.suffix),
                style: const TextStyle(color: AppColors.fg3, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            lift.currentTrainingMax == null
                ? l10n.powerliftingTrainingMaxUnknownLabel
                : l10n.powerliftingTrainingMaxLabel(
                    formatWeight(unit.fromKg(lift.currentTrainingMax!)),
                    unit.suffix,
                  ),
            style: const TextStyle(color: AppColors.fg3, fontSize: 12),
          ),
        ],
      ),
    );
  }
}

/// The derived powerlifting metrics as a two-column grid of plain label/value
/// tiles inside a divided section.
class _AnalysisSection extends StatelessWidget {
  const _AnalysisSection({required this.analysis});

  final _PowerliftingAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final tiles = <(String, String)>[
      (l10n.powerliftingEstimatedTotalLabel, analysis.estimatedTotal),
      (l10n.powerliftingTrainingMaxTotalLabel, analysis.trainingMaxTotal),
      (l10n.powerliftingBenchSquatRatioLabel, analysis.benchSquatRatio),
      (l10n.powerliftingDeadliftSquatRatioLabel, analysis.deadliftSquatRatio),
      (l10n.powerliftingPrsLast30Label, analysis.prsLast30),
      (l10n.powerliftingLatestPrLabel, analysis.latestPr),
      (l10n.powerliftingPlateauLiftsLabel, analysis.plateauLifts),
      (l10n.powerliftingBodyweightDotsLabel, analysis.dotsBodyweight),
    ];

    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.powerliftingAnalysisTitle),
          const SizedBox(height: AppSpacing.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              const spacing = AppSpacing.lg;
              final width = (constraints.maxWidth - spacing) / 2;
              return Wrap(
                spacing: spacing,
                runSpacing: AppSpacing.xl,
                children: [
                  for (final (label, value) in tiles)
                    SizedBox(
                      width: width,
                      child: _StatTile(label: label, value: value),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _StatTile extends StatelessWidget {
  const _StatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label.toUpperCase(),
          style: const TextStyle(
            color: AppColors.fg3,
            fontSize: 11,
            fontWeight: FontWeight.w500,
            letterSpacing: 0.6,
          ),
        ),
        const SizedBox(height: 6),
        Text(
          value,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.display(20, letterSpacing: 0),
        ),
      ],
    );
  }
}

/// Estimated-1RM trend line chart inside a divided section.
class _E1rmTrendSection extends StatelessWidget {
  const _E1rmTrendSection({required this.section, required this.unit});

  final PowerliftingSection section;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.powerliftingE1rmTrendTitle),
          const SizedBox(height: AppSpacing.lg),
          if (section.lifts.every((l) => l.e1Rm.isEmpty))
            _EmptyHint(l10n.powerliftingLogLiftsHintMessage)
          else
            LineSeriesChart(
              yLabel: (v) => '${unit.fromKg(v).round()}',
              series: [
                for (final l in section.lifts)
                  LineSeries(
                    name: _liftName(l.lift, l10n),
                    color: _liftColor(l.lift),
                    points: [
                      for (final p in l.e1Rm)
                        (x: p.weekStart, y: unit.fromKg(p.e1Rm)),
                    ],
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

/// PR timeline as plain lift-tagged rows inside a divided section.
class _PrTimelineSection extends StatelessWidget {
  const _PrTimelineSection({required this.prs, required this.unit});

  final List<({CompetitionLift lift, LiftPrEvent event})> prs;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final shown = prs.take(12).toList();
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.powerliftingPrTimelineTitle),
          const SizedBox(height: AppSpacing.md),
          if (shown.isEmpty)
            _EmptyHint(l10n.powerliftingNoPrsMessage)
          else
            for (var i = 0; i < shown.length; i++) ...[
              if (i > 0) const SizedBox(height: AppSpacing.md),
              _PrRow(lift: shown[i].lift, event: shown[i].event, unit: unit),
            ],
        ],
      ),
    );
  }
}

class _PrRow extends StatelessWidget {
  const _PrRow({required this.lift, required this.event, required this.unit});

  final CompetitionLift lift;
  final LiftPrEvent event;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final accent = _liftColor(lift);
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
          decoration: BoxDecoration(
            color: accent.withValues(alpha: 0.16),
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          child: Text(
            _liftName(lift, l10n),
            style: AppTypography.mono(10, color: accent),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Text(
            '${formatWeight(unit.fromKg(event.weight))} ${unit.suffix} × ${event.reps}',
            style: const TextStyle(color: AppColors.fg1, fontSize: 13),
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              '${formatWeight(unit.fromKg(event.e1Rm))} ${unit.suffix}',
              style: const TextStyle(
                color: AppColors.fg1,
                fontWeight: FontWeight.w500,
                fontSize: 13,
              ),
            ),
            Text(
              l10n.powerliftingE1rmPrefixLabel(_formatDate(event.date)),
              style: AppTypography.mono(10, color: AppColors.fg3),
            ),
          ],
        ),
      ],
    );
  }
}

/// DOTS-over-time line chart inside a divided section.
class _DotsSection extends StatelessWidget {
  const _DotsSection({required this.dots});

  final List<DotsPoint> dots;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.powerliftingDotsOverTimeTitle),
          const SizedBox(height: AppSpacing.lg),
          if (dots.isEmpty)
            _EmptyHint(l10n.powerliftingDotsHintMessage)
          else
            LineSeriesChart(
              yLabel: (v) => v.toStringAsFixed(0),
              series: [
                LineSeries(
                  name: l10n.powerliftingDotsLabel,
                  color: AppColors.info,
                  points: [for (final p in dots) (x: p.weekStart, y: p.dots)],
                ),
              ],
            ),
        ],
      ),
    );
  }
}

class _EmptyHint extends StatelessWidget {
  const _EmptyHint(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(color: AppColors.fg3, fontSize: 13, height: 1.35),
    );
  }
}

/// Derived powerlifting summary numbers, mirroring the website analysis.
class _PowerliftingAnalysis {
  const _PowerliftingAnalysis({
    required this.estimatedTotal,
    required this.trainingMaxTotal,
    required this.benchSquatRatio,
    required this.deadliftSquatRatio,
    required this.prsLast30,
    required this.latestPr,
    required this.plateauLifts,
    required this.dotsBodyweight,
  });

  factory _PowerliftingAnalysis.from(
    PowerliftingSection s,
    WeightUnit unit,
    AppLocalizations l10n,
  ) {
    double sumPresent(Iterable<double?> values) =>
        values.fold(0, (sum, v) => sum + (v ?? 0));

    String? ratio(double? value, double? baseline) {
      if (value == null || baseline == null || baseline == 0) return null;
      return '${(value / baseline * 100).round()}%';
    }

    String weight(double v) =>
        v > 0 ? '${formatWeight(unit.fromKg(v))} ${unit.suffix}' : '—';

    final allPrs =
        (s.lifts
            .expand((l) => l.prTimeline.map((pr) => (lift: l.lift, event: pr)))
            .toList()
          ..sort((a, b) => b.event.date.compareTo(a.event.date)));
    final cutoff = DateTime.now().subtract(const Duration(days: 30));
    final prsLast30 = allPrs
        .where((pr) => pr.event.date.isAfter(cutoff))
        .length;
    final latest = allPrs.isEmpty ? null : allPrs.first;
    final plateau = s.lifts
        .where((l) => l.isPlateau)
        .map((l) => _liftName(l.lift, l10n))
        .toList();
    final latestDots = s.dots.isEmpty ? null : s.dots.last;

    return _PowerliftingAnalysis(
      estimatedTotal: weight(sumPresent(s.lifts.map((l) => l.currentE1Rm))),
      trainingMaxTotal: weight(
        sumPresent(s.lifts.map((l) => l.currentTrainingMax)),
      ),
      benchSquatRatio: ratio(s.bench.currentE1Rm, s.squat.currentE1Rm) ?? '—',
      deadliftSquatRatio:
          ratio(s.deadlift.currentE1Rm, s.squat.currentE1Rm) ?? '—',
      prsLast30: '$prsLast30',
      latestPr: latest == null
          ? l10n.powerliftingNoPrsYetMessage
          : '${_liftName(latest.lift, l10n)} '
                '${formatWeight(unit.fromKg(latest.event.e1Rm))} ${unit.suffix}',
      plateauLifts: plateau.isEmpty
          ? l10n.powerliftingNoneLabel
          : plateau.join(', '),
      dotsBodyweight: latestDots == null
          ? '—'
          : '${formatWeight(unit.fromKg(latestDots.bodyweightKg))} ${unit.suffix}',
    );
  }

  final String estimatedTotal;
  final String trainingMaxTotal;
  final String benchSquatRatio;
  final String deadliftSquatRatio;
  final String prsLast30;
  final String latestPr;
  final String plateauLifts;
  final String dotsBodyweight;
}

String _liftName(CompetitionLift lift, AppLocalizations l10n) => switch (lift) {
  CompetitionLift.squat => l10n.powerliftingLiftSquat,
  CompetitionLift.bench => l10n.powerliftingLiftBench,
  CompetitionLift.deadlift => l10n.powerliftingLiftDeadlift,
};

Color _liftColor(CompetitionLift lift) => switch (lift) {
  CompetitionLift.squat => AppColors.accent,
  CompetitionLift.bench => AppColors.warning,
  CompetitionLift.deadlift => AppColors.success,
};

const _monthAbbr = [
  'Jan',
  'Feb',
  'Mar',
  'Apr',
  'May',
  'Jun',
  'Jul',
  'Aug',
  'Sep',
  'Oct',
  'Nov',
  'Dec',
];

String _formatDate(DateTime d) {
  final local = d.toLocal();
  return '${_monthAbbr[local.month - 1]} ${local.day}';
}
