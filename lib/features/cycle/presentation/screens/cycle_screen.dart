import 'dart:async';

import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/domain/entities/user_profile.dart';
import '../../../profile/presentation/providers/profile_controller.dart';
import '../../domain/entities/cycle_models.dart';
import '../providers/cycle_controllers.dart';
import '../widgets/cycle_phase_card.dart';

class CycleScreen extends ConsumerWidget {
  const CycleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(myProfileControllerProvider);
    final today = DateTime.now();
    final from = DateTime(today.year, today.month, today.day - 120);
    final to = DateTime(today.year, today.month, today.day + 1);
    return Scaffold(
      appBar: AppBar(
        leading: const HomeShellMenuButton(),
        title: Text(l10n.cycleTitle),
        actions: [
          IconButton(
            tooltip: l10n.cycleInsightTitle,
            icon: const Icon(Icons.auto_awesome_rounded),
            onPressed: () => unawaited(context.push('/cycle/insight')),
          ),
        ],
      ),
      body: AsyncValueView(
        value: profile,
        onRetry: () => ref.invalidate(myProfileControllerProvider),
        data: (user) {
          if (user.gender != 'Female') {
            return _CycleGate(profile: user);
          }
          return RefreshIndicator(
            color: AppColors.accent,
            onRefresh: () async {
              await ref
                  .read(cycleOverviewControllerProvider.notifier)
                  .refresh();
              ref
                ..invalidate(cycleLogsProvider(from: from, to: to))
                ..invalidate(cycleSettingsProvider);
            },
            child: ListView(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.lg,
                AppSpacing.xl,
              ),
              children: [
                AsyncValueView(
                  value: ref.watch(cycleOverviewControllerProvider),
                  onRetry: () =>
                      ref.invalidate(cycleOverviewControllerProvider),
                  data: (overview) => _OverviewContent(
                    overview: overview,
                    logs: ref.watch(cycleLogsProvider(from: from, to: to)),
                    today: today,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _OverviewContent extends ConsumerWidget {
  const _OverviewContent({
    required this.overview,
    required this.logs,
    required this.today,
  });

  final CycleOverview overview;
  final AsyncValue<List<CycleDailyLog>> logs;
  final DateTime today;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        CyclePhaseCard(
          phase: overview.currentPhase,
          subtitle: overview.needsData
              ? l10n.cycleLogImprovePredictionsMessage
              : _phaseSubtitle(overview, l10n, locale),
          cycleDayLabel: l10n.cycleDayMetricLabel,
          cycleDayValue: overview.cycleDay?.toString() ?? '—',
          untilPeriodLabel: l10n.cycleUntilPeriodMetricLabel,
          untilPeriodValue: overview.daysUntilNextPeriod == null
              ? '—'
              : l10n.cycleDaysValue(overview.daysUntilNextPeriod!),
          confidenceLabel: l10n.cycleConfidenceMetricLabel,
          confidenceValue: overview.confidence,
          lateLabel: overview.daysLate != null && overview.daysLate! > 0
              ? l10n.cycleDaysLateLabel(overview.daysLate!)
              : null,
          needsData: overview.needsData,
          logTodayLabel: l10n.cycleLogTodayButton,
          settingsTooltip: l10n.cycleSettingsTooltip,
          onLogToday: () => unawaited(_openLogSheet(context, ref, today, null)),
          onSettings: () => unawaited(_openSettings(context, ref)),
        ),
        const SizedBox(height: AppSpacing.lg),
        AsyncValueView(
          value: logs,
          onRetry: () => ref.invalidate(cycleLogsProvider),
          data: (items) => XnCardStack(
            children: [
              _CycleMetricGrid(
                metrics: [
                  _CycleMetricData(
                    icon: Icons.calendar_month_outlined,
                    label: l10n.cycleCycleLengthLabel,
                    value: '${overview.effectiveCycleLengthDays}d',
                  ),
                  _CycleMetricData(
                    icon: Icons.event_available_outlined,
                    label: l10n.cyclePeriodLengthLabel,
                    value: '${overview.effectivePeriodLengthDays}d',
                  ),
                  _CycleMetricData(
                    icon: Icons.timeline_rounded,
                    label: l10n.cycleRegularityLabel,
                    value: overview.isRegular
                        ? l10n.cycleRegularLabel
                        : l10n.cycleVariableLabel,
                  ),
                  _CycleMetricData(
                    icon: Icons.monitor_heart_outlined,
                    label: l10n.cycleVariabilityLabel,
                    value: overview.cycleVariabilityDays == null
                        ? '-'
                        : '${overview.cycleVariabilityDays}d',
                  ),
                ],
              ),
              _CycleCalendarCard(
                overview: overview,
                logs: items,
                initialMonth: today,
              ),
              _CycleTrendsCard(logs: items, today: today),
              const _CycleInsightRow(),
              _RecentLogsSection(logs: items),
            ],
          ),
        ),
      ],
    );
  }
}

class _CycleInsightRow extends StatelessWidget {
  const _CycleInsightRow();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnSection(
      onTap: () => unawaited(context.push('/cycle/insight')),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: AppColors.dangerBg,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(
              Icons.auto_awesome_rounded,
              color: AppColors.danger,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.cycleAiInsightTitle,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Text(
                  l10n.cycleAiInsightSubtitle,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ],
            ),
          ),
          const Icon(Icons.chevron_right_rounded),
        ],
      ),
    );
  }
}

class _RecentLogsSection extends StatelessWidget {
  const _RecentLogsSection({required this.logs});

  final List<CycleDailyLog> logs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final recent = logs.reversed.take(6).toList();
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.cycleRecentLogsTitle),
          const SizedBox(height: AppSpacing.sm),
          if (recent.isEmpty)
            Padding(
              padding: const EdgeInsets.symmetric(vertical: AppSpacing.lg),
              child: Text(
                l10n.cycleNoLogsMessage,
                style: const TextStyle(color: AppColors.fg3),
              ),
            )
          else
            XnCardStack(
              children: [for (final log in recent) _LogCard(log: log)],
            ),
        ],
      ),
    );
  }
}

class _CycleCalendarCard extends ConsumerStatefulWidget {
  const _CycleCalendarCard({
    required this.overview,
    required this.logs,
    required this.initialMonth,
  });

  final CycleOverview overview;
  final List<CycleDailyLog> logs;
  final DateTime initialMonth;

  @override
  ConsumerState<_CycleCalendarCard> createState() => _CycleCalendarCardState();
}

class _CycleCalendarCardState extends ConsumerState<_CycleCalendarCard> {
  late DateTime _visibleMonth;

  @override
  void initState() {
    super.initState();
    _visibleMonth = DateTime(
      widget.initialMonth.year,
      widget.initialMonth.month,
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final today = DateTime.now();
    final firstOfMonth = DateTime(_visibleMonth.year, _visibleMonth.month);
    final startOffset = firstOfMonth.weekday - DateTime.monday;
    final firstCell = firstOfMonth.subtract(Duration(days: startOffset));
    final days = List.generate(35, (i) => firstCell.add(Duration(days: i)));
    final loggedPeriodDays = {
      for (final log in widget.logs)
        if (log.flow != null) _dateKey(log.date),
    };
    final loggedByDate = {
      for (final log in widget.logs) _dateKey(log.date): log,
    };

    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  DateFormat.yMMMM(locale).format(_visibleMonth),
                  style: AppTypography.display(22, letterSpacing: 0),
                ),
              ),
              IconButton(
                tooltip: l10n.cyclePreviousMonthTooltip,
                onPressed: () => setState(() {
                  _visibleMonth = DateTime(
                    _visibleMonth.year,
                    _visibleMonth.month - 1,
                  );
                }),
                icon: const Icon(Icons.chevron_left_rounded),
              ),
              TextButton(
                onPressed: () => setState(() {
                  _visibleMonth = DateTime(today.year, today.month);
                }),
                child: Text(l10n.cycleTodayButton),
              ),
              IconButton(
                tooltip: l10n.cycleNextMonthTooltip,
                onPressed: () => setState(() {
                  _visibleMonth = DateTime(
                    _visibleMonth.year,
                    _visibleMonth.month + 1,
                  );
                }),
                icon: const Icon(Icons.chevron_right_rounded),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              _WeekdayLabel(l10n.cycleWeekdayMon),
              _WeekdayLabel(l10n.cycleWeekdayTue),
              _WeekdayLabel(l10n.cycleWeekdayWed),
              _WeekdayLabel(l10n.cycleWeekdayThu),
              _WeekdayLabel(l10n.cycleWeekdayFri),
              _WeekdayLabel(l10n.cycleWeekdaySat),
              _WeekdayLabel(l10n.cycleWeekdaySun),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          GridView.builder(
            itemCount: days.length,
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 7,
              mainAxisSpacing: 6,
              crossAxisSpacing: 6,
              childAspectRatio: 0.98,
            ),
            itemBuilder: (context, index) {
              final date = days[index];
              final dateKey = _dateKey(date);
              final inMonth = date.month == _visibleMonth.month;
              final isPeriod = loggedPeriodDays.contains(dateKey);
              final isPredicted = _isInPredictedPeriod(widget.overview, date);
              final isFertile = _isInFertileWindow(widget.overview, date);
              final isOvulation = widget.overview.ovulationDates.any(
                (d) => _sameDate(d, date),
              );

              return _CalendarDayCell(
                date: date,
                inMonth: inMonth,
                isToday: _sameDate(today, date),
                isPeriod: isPeriod,
                isPredicted: isPredicted,
                isFertile: isFertile,
                isOvulation: isOvulation,
                onTap: () => unawaited(
                  _openLogSheet(context, ref, date, loggedByDate[dateKey]),
                ),
              );
            },
          ),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.md,
            runSpacing: AppSpacing.sm,
            children: [
              _LegendDot(
                label: l10n.cycleLegendPeriod,
                color: _CycleCalendarColors.period,
              ),
              _LegendDot(
                label: l10n.cycleLegendPredicted,
                color: _CycleCalendarColors.predictedPeriod,
              ),
              _LegendDot(
                label: l10n.cycleLegendOvulation,
                color: _CycleCalendarColors.ovulation,
              ),
              _LegendDot(
                label: l10n.cycleLegendFertile,
                color: _CycleCalendarColors.fertile,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _WeekdayLabel extends StatelessWidget {
  const _WeekdayLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Center(
        child: Text(
          label,
          style: const TextStyle(
            color: AppColors.fg1,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

abstract final class _CycleCalendarColors {
  static const period = Color(0xFFC81E1E);
  static const predictedPeriod = Color(0xFFFDE2E2);
  static const predictedPeriodBorder = Color(0xFFF6B5B5);
  static const fertile = Color(0xFFDDF7EC);
  static const fertileBorder = Color(0xFF99E0C2);
  static const ovulation = Color(0xFF047857);
  static const todayBorder = Color(0xFF1F2937);
  static const defaultDay = AppColors.buttonBg;
  static const defaultBorder = AppColors.surfaceBorderSoft;
  static const outOfMonth = Color(0xFFF7F1E9);
  static const textOnPeriod = Colors.white;
}

class _CalendarDayCell extends StatelessWidget {
  const _CalendarDayCell({
    required this.date,
    required this.inMonth,
    required this.isToday,
    required this.isPeriod,
    required this.isPredicted,
    required this.isFertile,
    required this.isOvulation,
    required this.onTap,
  });

  final DateTime date;
  final bool inMonth;
  final bool isToday;
  final bool isPeriod;
  final bool isPredicted;
  final bool isFertile;
  final bool isOvulation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final bg = isPeriod
        ? _CycleCalendarColors.period
        : isPredicted
        ? _CycleCalendarColors.predictedPeriod
        : isFertile
        ? _CycleCalendarColors.fertile
        : _CycleCalendarColors.defaultDay;
    final borderColor = isToday
        ? _CycleCalendarColors.todayBorder
        : isPredicted
        ? _CycleCalendarColors.predictedPeriodBorder
        : isFertile
        ? _CycleCalendarColors.fertileBorder
        : _CycleCalendarColors.defaultBorder;
    final fg = isPeriod ? _CycleCalendarColors.textOnPeriod : AppColors.fg1;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        borderRadius: BorderRadius.circular(AppRadius.md),
        onTap: onTap,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          decoration: BoxDecoration(
            color: inMonth ? bg : _CycleCalendarColors.outOfMonth,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(
              color: borderColor,
              width: isToday ? 1.6 : 1,
            ),
          ),
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '${date.day}',
                style: TextStyle(
                  color: inMonth ? fg : AppColors.fg4,
                  fontWeight: isPeriod || isToday
                      ? FontWeight.w500
                      : FontWeight.w500,
                ),
              ),
              if (isOvulation)
                const Positioned(
                  bottom: 7,
                  child: SizedBox(
                    width: 7,
                    height: 7,
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        color: _CycleCalendarColors.ovulation,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _LegendDot extends StatelessWidget {
  const _LegendDot({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 13,
          height: 13,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 6),
        Text(label, style: const TextStyle(color: AppColors.fg1)),
      ],
    );
  }
}

class _CycleTrendsCard extends StatelessWidget {
  const _CycleTrendsCard({required this.logs, required this.today});

  final List<CycleDailyLog> logs;
  final DateTime today;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final from = DateTime(today.year, today.month, today.day - 60);
    final recent = logs.where((log) => !log.date.isBefore(from)).toList()
      ..sort((a, b) => a.date.compareTo(b.date));
    final symptomCounts = _symptomCounts(recent).entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));

    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.trending_up_rounded, color: AppColors.danger),
              const SizedBox(width: AppSpacing.sm),
              Text(
                l10n.cycleTrendsLast60DaysTitle,
                style: AppTypography.display(20, letterSpacing: 0),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              final wide = constraints.maxWidth >= 720;
              final line = _TrendLineChart(logs: recent, from: from);
              final bars = _SymptomBars(counts: symptomCounts.take(6).toList());
              if (!wide) {
                return Column(
                  children: [
                    SizedBox(height: 240, child: line),
                    const SizedBox(height: AppSpacing.xl),
                    bars,
                  ],
                );
              }
              return Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    flex: 5,
                    child: SizedBox(height: 250, child: line),
                  ),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(flex: 4, child: bars),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

class _TrendLineChart extends StatelessWidget {
  const _TrendLineChart({required this.logs, required this.from});

  final List<CycleDailyLog> logs;
  final DateTime from;

  @override
  Widget build(BuildContext context) {
    if (logs.length < 2) {
      final l10n = AppLocalizations.of(context);
      return Center(
        child: Text(
          l10n.cycleLogMoreDaysTrendMessage,
          style: const TextStyle(color: AppColors.fg3),
        ),
      );
    }

    final locale = Localizations.localeOf(context).toLanguageTag();
    final energySpots = <FlSpot>[];
    final symptomSpots = <FlSpot>[];
    for (final log in logs) {
      final x = log.date.difference(from).inDays.toDouble();
      if (log.energyLevel != null) {
        energySpots.add(FlSpot(x, log.energyLevel!.toDouble()));
      }
      symptomSpots.add(FlSpot(x, log.symptoms.length.clamp(0, 5).toDouble()));
    }

    return LineChart(
      LineChartData(
        minX: 0,
        maxX: 60,
        minY: 0,
        maxY: 5,
        gridData: FlGridData(
          drawVerticalLine: false,
          getDrawingHorizontalLine: (_) => const FlLine(
            color: AppColors.surfaceBorderSoft,
            strokeWidth: 1,
            dashArray: [4, 4],
          ),
        ),
        borderData: FlBorderData(show: false),
        titlesData: FlTitlesData(
          topTitles: const AxisTitles(),
          rightTitles: const AxisTitles(),
          leftTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 28,
              interval: 1,
              getTitlesWidget: (value, _) => Text(
                value.toInt().toString(),
                style: const TextStyle(color: AppColors.fg3, fontSize: 11),
              ),
            ),
          ),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              reservedSize: 32,
              interval: 14,
              getTitlesWidget: (value, _) {
                final date = from.add(Duration(days: value.toInt()));
                return Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    DateFormat.MMMd(locale).format(date),
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 10,
                    ),
                  ),
                );
              },
            ),
          ),
        ),
        lineBarsData: [
          if (symptomSpots.length >= 2)
            LineChartBarData(
              spots: symptomSpots,
              isCurved: true,
              color: AppColors.success,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(),
            ),
          if (energySpots.length >= 2)
            LineChartBarData(
              spots: energySpots,
              isCurved: true,
              color: AppColors.info,
              barWidth: 3,
              dotData: const FlDotData(show: true),
              belowBarData: BarAreaData(),
            ),
        ],
      ),
    );
  }
}

class _SymptomBars extends StatelessWidget {
  const _SymptomBars({required this.counts});

  final List<MapEntry<String, int>> counts;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    if (counts.isEmpty) {
      return Text(
        l10n.cycleNoSymptomsLast60DaysMessage,
        style: const TextStyle(color: AppColors.fg3),
      );
    }

    final max = counts.map((e) => e.value).reduce((a, b) => a > b ? a : b);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.cycleMostFrequentSymptomsTitle,
          style: const TextStyle(
            color: AppColors.fg1,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        for (final (index, entry) in counts.indexed) ...[
          Row(
            children: [
              SizedBox(
                width: 92,
                child: Text(
                  cycleSymptomLabel(entry.key, l10n),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.sm),
                  child: Stack(
                    children: [
                      Container(height: 20, color: AppColors.bg3),
                      FractionallySizedBox(
                        widthFactor: max == 0 ? 0 : entry.value / max,
                        child: Container(
                          height: 20,
                          color: AppColors.dataColor(index),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              SizedBox(
                width: 24,
                child: Text(
                  '${entry.value}',
                  textAlign: TextAlign.right,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _LogCard extends ConsumerWidget {
  const _LogCard({required this.log});

  final CycleDailyLog log;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    return XnSection(
      onTap: () => unawaited(_openLogSheet(context, ref, log.date, log)),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xs,
        vertical: 13,
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: AppColors.bg3,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: Text(
              '${log.date.day}',
              style: AppTypography.display(18),
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _formatDate(log.date, locale),
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  [
                    if (log.flow != null) log.flow!,
                    if (log.mood != null) log.mood!,
                    if (log.energyLevel != null)
                      l10n.cycleEnergyLabel(log.energyLevel.toString()),
                  ].join(' - '),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ],
            ),
          ),
          if (log.symptoms.isNotEmpty)
            XnChip(
              label: l10n.cycleSymptomCountLabel(log.symptoms.length),
              tone: XnChipTone.warn,
              compact: true,
            ),
        ],
      ),
    );
  }
}

class _CycleGate extends StatelessWidget {
  const _CycleGate({required this.profile});

  final UserProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        XnCard(
          child: Column(
            children: [
              const Icon(
                Icons.lock_outline_rounded,
                color: AppColors.fg3,
                size: 40,
              ),
              const SizedBox(height: AppSpacing.md),
              Text(
                l10n.cycleFemaleOnlyTitle,
                textAlign: TextAlign.center,
                style: AppTypography.display(22),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                l10n.cycleFemaleOnlyMessage,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.fg2),
              ),
              const SizedBox(height: AppSpacing.lg),
              XnButton(
                label: l10n.cycleEditProfileButton,
                icon: Icons.edit_outlined,
                onPressed: () => unawaited(
                  context.push('/profile/edit', extra: profile),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CycleMetricData {
  const _CycleMetricData({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;
}

class _CycleMetricGrid extends StatelessWidget {
  const _CycleMetricGrid({required this.metrics});

  final List<_CycleMetricData> metrics;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: LayoutBuilder(
        builder: (context, constraints) {
          const spacing = AppSpacing.xl;
          final width = (constraints.maxWidth - spacing) / 2;
          return Wrap(
            spacing: spacing,
            runSpacing: AppSpacing.xl,
            children: [
              for (final metric in metrics)
                SizedBox(
                  width: width,
                  child: _MetricCard(
                    icon: metric.icon,
                    label: metric.label,
                    value: metric.value,
                  ),
                ),
            ],
          );
        },
      ),
    );
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 34,
          height: 34,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: AppColors.bg3.withValues(alpha: 0.62),
            borderRadius: BorderRadius.circular(AppRadius.md),
          ),
          child: Icon(icon, color: AppColors.fg3, size: 18),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.display(
                  20,
                  weight: FontWeight.w500,
                  letterSpacing: 0,
                  height: 1.08,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _CycleLogSheet extends ConsumerStatefulWidget {
  const _CycleLogSheet({required this.date, this.initial});

  final DateTime date;
  final CycleDailyLog? initial;

  @override
  ConsumerState<_CycleLogSheet> createState() => _CycleLogSheetState();
}

class _CycleLogSheetState extends ConsumerState<_CycleLogSheet> {
  final _notes = TextEditingController();
  String? _flow;
  String? _mood;
  int? _energy;
  late Set<String> _symptoms;

  @override
  void initState() {
    super.initState();
    final initial = widget.initial;
    _flow = initial?.flow;
    _mood = initial?.mood;
    _energy = initial?.energyLevel;
    _symptoms = {...?initial?.symptoms};
    _notes.text = initial?.notes ?? '';
  }

  @override
  void dispose() {
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final locale = Localizations.localeOf(context).toLanguageTag();
    final pending = ref.watch(cycleMutationControllerProvider).isLoading;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        shrinkWrap: true,
        children: [
          Text(
            l10n.cycleLogDateTitle(_formatDate(widget.date, locale)),
            style: AppTypography.display(24),
          ),
          const SizedBox(height: AppSpacing.lg),
          XnDropdown<String>(
            label: l10n.cycleFlowLabel,
            value: _flow,
            options: [
              for (final option in _flowOptions)
                XnDropdownOption(
                  value: option,
                  label: cycleFlowOptionLabel(option, l10n),
                ),
            ],
            onChanged: (value) => setState(() => _flow = value),
          ),
          const SizedBox(height: AppSpacing.md),
          XnDropdown<String>(
            label: l10n.cycleMoodLabel,
            value: _mood,
            options: [
              for (final option in _moodOptions)
                XnDropdownOption(
                  value: option,
                  label: cycleMoodOptionLabel(option, l10n),
                ),
            ],
            onChanged: (value) => setState(() => _mood = value),
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            l10n.cycleEnergyLabel((_energy ?? '-').toString()),
            style: const TextStyle(
              color: AppColors.fg2,
              fontWeight: FontWeight.w500,
            ),
          ),
          Slider(
            min: 1,
            max: 5,
            divisions: 4,
            value: (_energy ?? 3).toDouble(),
            label: '${_energy ?? 3}',
            onChanged: (value) => setState(() => _energy = value.round()),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.cycleSymptomsLabel,
            style: const TextStyle(
              color: AppColors.fg2,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.sm),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final symptom in _symptomOptions)
                FilterChip(
                  label: Text(cycleSymptomLabel(symptom, l10n)),
                  selected: _symptoms.contains(symptom),
                  onSelected: (selected) => setState(() {
                    if (selected) {
                      _symptoms.add(symptom);
                    } else {
                      _symptoms.remove(symptom);
                    }
                  }),
                ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          XnInput(
            label: l10n.cycleNotesLabel,
            controller: _notes,
            textInputAction: TextInputAction.newline,
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              if (widget.initial != null)
                TextButton.icon(
                  onPressed: pending ? null : () => unawaited(_delete()),
                  icon: const Icon(Icons.delete_outline_rounded),
                  label: Text(l10n.cycleDeleteButton),
                ),
              const Spacer(),
              XnButton(
                label: l10n.cycleSaveButton,
                icon: Icons.check_rounded,
                loading: pending,
                onPressed: () => unawaited(_save()),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    await ref
        .read(cycleMutationControllerProvider.notifier)
        .upsertLog(
          date: widget.date,
          flow: _flow,
          symptoms: _symptoms.toList(),
          mood: _mood,
          energyLevel: _energy,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        );
    if (!mounted) return;
    Navigator.pop(context);
  }

  Future<void> _delete() async {
    await ref
        .read(cycleMutationControllerProvider.notifier)
        .deleteLog(
          widget.date,
        );
    if (!mounted) return;
    Navigator.pop(context);
  }
}

class _CycleSettingsSheet extends ConsumerStatefulWidget {
  const _CycleSettingsSheet({required this.initial});

  final CycleSettings initial;

  @override
  ConsumerState<_CycleSettingsSheet> createState() =>
      _CycleSettingsSheetState();
}

class _CycleSettingsSheetState extends ConsumerState<_CycleSettingsSheet> {
  late final TextEditingController _cycleLength;
  late final TextEditingController _periodLength;
  late bool _shareWithCoach;

  @override
  void initState() {
    super.initState();
    _cycleLength = TextEditingController(
      text: widget.initial.averageCycleLengthOverride?.toString() ?? '',
    );
    _periodLength = TextEditingController(
      text: widget.initial.averagePeriodLengthOverride?.toString() ?? '',
    );
    _shareWithCoach = widget.initial.shareWithCoach;
  }

  @override
  void dispose() {
    _cycleLength.dispose();
    _periodLength.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final pending = ref.watch(cycleMutationControllerProvider).isLoading;

    return SafeArea(
      child: ListView(
        padding: EdgeInsets.only(
          left: AppSpacing.lg,
          right: AppSpacing.lg,
          top: AppSpacing.lg,
          bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
        ),
        shrinkWrap: true,
        children: [
          Text(l10n.cycleSettingsTitle, style: AppTypography.display(24)),
          const SizedBox(height: AppSpacing.lg),
          XnInput(
            label: l10n.cycleLengthOverrideLabel,
            hint: l10n.cycleExample28Hint,
            controller: _cycleLength,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: AppSpacing.md),
          XnInput(
            label: l10n.cyclePeriodLengthOverrideLabel,
            hint: l10n.cycleExample5Hint,
            controller: _periodLength,
            keyboardType: TextInputType.number,
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          ),
          const SizedBox(height: AppSpacing.md),
          SwitchListTile(
            value: _shareWithCoach,
            contentPadding: EdgeInsets.zero,
            title: Text(l10n.cycleShareWithCoachTitle),
            subtitle: Text(l10n.cycleShareWithCoachSubtitle),
            onChanged: (value) => setState(() => _shareWithCoach = value),
          ),
          const SizedBox(height: AppSpacing.lg),
          XnButton(
            label: l10n.cycleSaveSettingsButton,
            icon: Icons.check_rounded,
            loading: pending,
            onPressed: () => unawaited(_save()),
          ),
        ],
      ),
    );
  }

  Future<void> _save() async {
    await ref
        .read(cycleMutationControllerProvider.notifier)
        .updateSettings(
          shareWithCoach: _shareWithCoach,
          averageCycleLengthOverride: _parseInt(_cycleLength.text),
          averagePeriodLengthOverride: _parseInt(_periodLength.text),
        );
    if (!mounted) return;
    Navigator.pop(context);
  }
}

Future<void> _openLogSheet(
  BuildContext context,
  WidgetRef ref,
  DateTime date,
  CycleDailyLog? log,
) async {
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bgPage,
    builder: (_) => _CycleLogSheet(date: date, initial: log),
  );
}

Future<void> _openSettings(BuildContext context, WidgetRef ref) async {
  final settings = await ref.read(cycleSettingsProvider.future);
  if (!context.mounted) return;
  await showModalBottomSheet<void>(
    context: context,
    isScrollControlled: true,
    backgroundColor: AppColors.bgPage,
    builder: (_) => _CycleSettingsSheet(initial: settings),
  );
}

String _phaseSubtitle(
  CycleOverview overview,
  AppLocalizations l10n,
  String locale,
) {
  final next = overview.nextPeriodStart;
  if (next == null) {
    return l10n.cycleTrackingCyclesMessage(
      overview.effectiveCycleLengthDays,
    );
  }
  return l10n.cycleNextPredictedPeriodMessage(_formatDate(next, locale));
}

String _formatDate(DateTime date, String locale) =>
    DateFormat.yMMMd(locale).format(date);

String _dateKey(DateTime date) =>
    '${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

bool _sameDate(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

bool _dateInRange(DateTime value, DateTime start, DateTime end) {
  final date = DateTime(value.year, value.month, value.day);
  final from = DateTime(start.year, start.month, start.day);
  final to = DateTime(end.year, end.month, end.day);
  return !date.isBefore(from) && !date.isAfter(to);
}

bool _isInPredictedPeriod(CycleOverview overview, DateTime date) {
  return overview.predictedPeriods.any(
    (period) => _dateInRange(date, period.start, period.end),
  );
}

bool _isInFertileWindow(CycleOverview overview, DateTime date) {
  return overview.fertileWindows.any(
    (window) => _dateInRange(date, window.start, window.end),
  );
}

Map<String, int> _symptomCounts(List<CycleDailyLog> logs) {
  final counts = <String, int>{};
  for (final log in logs) {
    for (final symptom in log.symptoms) {
      counts[symptom] = (counts[symptom] ?? 0) + 1;
    }
  }
  return counts;
}

String _humanize(String value) => value.replaceAllMapped(
  RegExp('([a-z])([A-Z])'),
  (match) => '${match.group(1)} ${match.group(2)}',
);

String cycleFlowOptionLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Spotting' => l10n.cycleFlowSpotting,
      'Light' => l10n.cycleFlowLight,
      'Medium' => l10n.cycleFlowMedium,
      'Heavy' => l10n.cycleFlowHeavy,
      _ => _humanize(value),
    };

String cycleMoodOptionLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Great' => l10n.cycleMoodGreat,
      'Good' => l10n.cycleMoodGood,
      'Neutral' => l10n.cycleMoodNeutral,
      'Low' => l10n.cycleMoodLow,
      'Irritable' => l10n.cycleMoodIrritable,
      _ => _humanize(value),
    };

String cycleSymptomLabel(String value, AppLocalizations l10n) =>
    switch (value) {
      'Cramps' => l10n.cycleSymptomCramps,
      'Headache' => l10n.cycleSymptomHeadache,
      'Bloating' => l10n.cycleSymptomBloating,
      'BreastTenderness' => l10n.cycleSymptomBreastTenderness,
      'Fatigue' => l10n.cycleSymptomFatigue,
      'BackPain' => l10n.cycleSymptomBackPain,
      'Nausea' => l10n.cycleSymptomNausea,
      'Acne' => l10n.cycleSymptomAcne,
      'Cravings' => l10n.cycleSymptomCravings,
      'Insomnia' => l10n.cycleSymptomInsomnia,
      'MoodSwings' => l10n.cycleSymptomMoodSwings,
      _ => _humanize(value),
    };

int? _parseInt(String value) =>
    value.trim().isEmpty ? null : int.tryParse(value.trim());

const _flowOptions = ['Spotting', 'Light', 'Medium', 'Heavy'];
const _moodOptions = ['Great', 'Good', 'Neutral', 'Low', 'Irritable'];
const _symptomOptions = [
  'Cramps',
  'Headache',
  'Bloating',
  'BreastTenderness',
  'Fatigue',
  'BackPain',
  'Nausea',
  'Acne',
  'Cravings',
  'Insomnia',
  'MoodSwings',
];
