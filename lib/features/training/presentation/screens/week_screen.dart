import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/profile_controller.dart';
import '../../domain/entities/daily_workout.dart';
import '../../domain/entities/exercise.dart';
import '../providers/cycle_day_markers_provider.dart';
import '../providers/days_controller.dart';
import '../providers/exercises_controller.dart';

enum _DayAction { normal, rest, missed, copy }

const _cyclePremenstrualBg = Color(0xFFEBDDFA);
const _cyclePremenstrualBorder = Color(0xFFD3B2F3);
const _cyclePremenstrualAccent = Color(0xFF8B3FE8);
const _cycleMenstrualBg = Color(0xFFF8D9D4);
const _cycleMenstrualBorder = Color(0xFFF1AAA1);
const _cycleMenstrualAccent = Color(0xFFE5484D);

bool _isSameDate(DateTime a, DateTime b) =>
    a.year == b.year && a.month == b.month && a.day == b.day;

Color? _cycleMarkerSurface(String? marker) => switch (marker) {
  'PreMenstrual' => _cyclePremenstrualBg,
  'Menstrual' => _cycleMenstrualBg,
  _ => null,
};

Color? _cycleMarkerBorder(String? marker) => switch (marker) {
  'PreMenstrual' => _cyclePremenstrualBorder,
  'Menstrual' => _cycleMenstrualBorder,
  _ => null,
};

Color? _cycleMarkerAccent(String? marker) => switch (marker) {
  'PreMenstrual' => _cyclePremenstrualAccent,
  'Menstrual' => _cycleMenstrualAccent,
  _ => null,
};

class WeekScreen extends ConsumerWidget {
  const WeekScreen({required this.weekId, super.key});

  final String weekId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final days = ref.watch(daysControllerProvider(weekId));
    // Cycle-day markers ("Period" / "Pre-menstrual") are a female-only
    // backend feature (see CycleGuard.EnsureFemaleAsync) — only fetch when
    // relevant, mirroring the same gender check `home_shell.dart` uses to
    // show/hide the Cycle tab.
    final isFemale =
        ref.watch(myProfileControllerProvider).value?.gender == 'Female';

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.trainingWeekFallbackTitle),
        actions: [
          IconButton(
            tooltip: l10n.commonAnalytics,
            icon: const Icon(Icons.insights_rounded),
            onPressed: () => context.push('/weeks/$weekId/analysis'),
          ),
          IconButton(
            tooltip: l10n.commonComments,
            icon: const Icon(Icons.mode_comment_outlined),
            onPressed: () => context.push('/weeks/$weekId/comments'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () =>
            ref.read(daysControllerProvider(weekId).notifier).refresh(),
        child: AsyncValueView(
          value: days,
          onRetry: () => ref.invalidate(daysControllerProvider(weekId)),
          data: (items) {
            final markers = isFemale && items.isNotEmpty
                ? ref
                      .watch(
                        cycleDayMarkersProvider((
                          from: items.first.date,
                          to: items.last.date,
                        )),
                      )
                      .value
                : null;
            return CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                    AppSpacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _WeekDaysSummary(days: items),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _ListSectionHeader(
                      label: l10n.trainingTrainingDaysLabel,
                      meta: l10n.trainingTotalCountLabel(items.length),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final cardHeight = math
                        .max(
                          440,
                          constraints.viewportMainAxisExtent -
                              constraints.precedingScrollExtent -
                              AppSpacing.xxl,
                        )
                        .toDouble();
                    return SliverToBoxAdapter(
                      child: SizedBox(
                        height: cardHeight,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(
                            AppSpacing.lg,
                            0,
                            AppSpacing.lg,
                            AppSpacing.xxl,
                          ),
                          child: _DayTimelineList(
                            initialIndex: _todayIndex(items),
                            days: items,
                            weekId: weekId,
                            cycleMarkers: markers,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}

int _todayIndex(List<DailyWorkout> days) {
  final today = DateTime.now();
  final index = days.indexWhere((day) => _isSameDate(day.date, today));
  return index >= 0 ? index : 0;
}

class _DayTimelineList extends StatefulWidget {
  const _DayTimelineList({
    required this.days,
    required this.weekId,
    required this.initialIndex,
    this.cycleMarkers,
  });

  final List<DailyWorkout> days;
  final String weekId;
  final int initialIndex;
  final Map<String, String>? cycleMarkers;

  @override
  State<_DayTimelineList> createState() => _DayTimelineListState();
}

class _DayTimelineListState extends State<_DayTimelineList> {
  late final PageController _controller;
  late int _activeIndex;

  int get _startIndex =>
      widget.initialIndex >= 0 && widget.initialIndex < widget.days.length
      ? widget.initialIndex
      : 0;

  @override
  void initState() {
    super.initState();
    _activeIndex = _startIndex;
    _controller = PageController(
      initialPage: _activeIndex,
      viewportFraction: 0.9,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView.builder(
            controller: _controller,
            itemCount: widget.days.length,
            onPageChanged: (index) => setState(() => _activeIndex = index),
            itemBuilder: (context, index) {
              final day = widget.days[index];
              final selected = index == _activeIndex;
              return AnimatedScale(
                duration: AppMotion.med,
                curve: Curves.easeOutCubic,
                scale: selected ? 1 : 0.96,
                child: AnimatedOpacity(
                  duration: AppMotion.fast,
                  opacity: selected ? 1 : 0.62,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.sm,
                    ),
                    child: _DayCard(
                      day: day,
                      allDays: widget.days,
                      weekId: widget.weekId,
                      isLast: true,
                      expanded: true,
                      onTap: () => context.push('/days/${day.id}'),
                      cycleMarker:
                          widget.cycleMarkers?[DateOnly.format(day.date)],
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _CarouselPositionIndicator(
          count: widget.days.length,
          activeIndex: _activeIndex,
        ),
      ],
    );
  }
}

class _CarouselPositionIndicator extends StatelessWidget {
  const _CarouselPositionIndicator({
    required this.count,
    required this.activeIndex,
  });

  final int count;
  final int activeIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        for (var index = 0; index < count; index++)
          AnimatedContainer(
            duration: AppMotion.fast,
            curve: Curves.easeOutCubic,
            width: index == activeIndex ? 16 : 5,
            height: 5,
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: index == activeIndex ? AppColors.accent : AppColors.bg4,
              borderRadius: BorderRadius.circular(AppRadius.pill),
            ),
          ),
      ],
    );
  }
}

class _DayCard extends ConsumerWidget {
  const _DayCard({
    required this.day,
    required this.allDays,
    required this.weekId,
    required this.isLast,
    required this.onTap,
    this.expanded = false,
    this.cycleMarker,
  });

  final DailyWorkout day;
  final List<DailyWorkout> allDays;
  final String weekId;
  final bool isLast;
  final VoidCallback onTap;
  final bool expanded;

  /// "Menstrual" | "PreMenstrual" | null (no marker for this day).
  final String? cycleMarker;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final isToday = _isSameDate(day.date, DateTime.now());
    final (chipLabel, chipTone) = switch (day) {
      _ when day.isCompleted => (l10n.commonDone, XnChipTone.sage),
      _ when day.isRest => (l10n.commonRest, XnChipTone.neutral),
      _ when day.isMissed => (l10n.commonMissed, XnChipTone.danger),
      _ => ('', XnChipTone.neutral),
    };
    final progress = day.totalExercises == 0
        ? 0.0
        : (day.completedExercises / day.totalExercises).clamp(0.0, 1.0);
    final hasWorkout = !day.isRest && day.totalExercises > 0;
    final cycleSurface = _cycleMarkerSurface(cycleMarker);
    final cycleBorder = _cycleMarkerBorder(cycleMarker);
    final cycleAccent = _cycleMarkerAccent(cycleMarker);
    final statusIcon = day.isRest
        ? Icons.self_improvement_rounded
        : day.isMissed
        ? Icons.event_busy_outlined
        : day.isCompleted
        ? Icons.check_rounded
        : Icons.fitness_center_rounded;
    final accent =
        cycleAccent ??
        (day.isCompleted
            ? AppColors.success
            : day.isMissed
            ? AppColors.danger
            : isToday
            ? AppColors.accent
            : day.isRest
            ? AppColors.sage500
            : AppColors.fg3);
    final surface =
        cycleSurface ??
        (isToday
            ? AppColors.accentSoft.withValues(alpha: 0.38)
            : day.isRest
            ? AppColors.sage100.withValues(alpha: 0.24)
            : day.isCompleted
            ? AppColors.successBg.withValues(alpha: 0.32)
            : AppColors.bg2);
    final cardRadius = BorderRadius.circular(
      expanded ? AppRadius.xxl : AppRadius.lg,
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: day.isRest ? null : onTap,
        borderRadius: cardRadius,
        child: AnimatedContainer(
          duration: AppMotion.fast,
          curve: Curves.easeOutCubic,
          margin: EdgeInsets.only(bottom: isLast ? 0 : AppSpacing.md),
          constraints: expanded ? const BoxConstraints.expand() : null,
          padding: const EdgeInsets.fromLTRB(12, 10, 12, 10),
          decoration: BoxDecoration(
            color: surface,
            borderRadius: cardRadius,
            border: Border.all(
              color:
                  cycleBorder ??
                  (isToday
                      ? AppColors.accent.withValues(alpha: 0.24)
                      : AppColors.surfaceBorderSoft),
              width: expanded ? 1.4 : 1,
            ),
            boxShadow: expanded
                ? const [
                    BoxShadow(
                      color: AppColors.shadow,
                      blurRadius: 18,
                      offset: Offset(0, 8),
                    ),
                  ]
                : null,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _DayMark(
                    date: day.date,
                    icon: statusIcon,
                    color: accent,
                    selected: isToday,
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          day.dayOfWeek,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: AppTypography.display(
                            18,
                            weight: FontWeight.w500,
                            letterSpacing: 0,
                            height: 1.05,
                          ),
                        ),
                        const SizedBox(height: AppSpacing.sm),
                        Text(
                          DateOnly.format(day.date),
                          style: AppTypography.mono(
                            12,
                            color: AppColors.fg3,
                            weight: FontWeight.w500,
                          ),
                        ),
                        if (cycleMarker != null) ...[
                          const SizedBox(height: AppSpacing.md),
                          _CycleMarkerChip(marker: cycleMarker!),
                        ],
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (isToday)
                        XnChip(
                          label: l10n.commonToday,
                          tone: XnChipTone.accent,
                          compact: true,
                        )
                      else if (chipLabel.isNotEmpty)
                        XnChip(
                          label: chipLabel,
                          tone: chipTone,
                          compact: true,
                        ),
                      const SizedBox(width: AppSpacing.xs),
                      PopupMenuButton<_DayAction>(
                        icon: const Icon(
                          Icons.more_vert_rounded,
                          color: AppColors.fg3,
                        ),
                        iconSize: 20,
                        padding: EdgeInsets.zero,
                        tooltip: l10n.trainingDayActionsTooltip,
                        onSelected: (action) =>
                            _handleAction(context, ref, action),
                        itemBuilder: (_) => [
                          PopupMenuItem(
                            value: _DayAction.normal,
                            child: _DayActionMenuItem(
                              icon: Icons.event_available_outlined,
                              label: l10n.trainingMarkNormalCta,
                            ),
                          ),
                          PopupMenuItem(
                            value: _DayAction.rest,
                            child: _DayActionMenuItem(
                              icon: Icons.self_improvement_rounded,
                              label: l10n.trainingMarkRestCta,
                            ),
                          ),
                          PopupMenuItem(
                            value: _DayAction.missed,
                            child: _DayActionMenuItem(
                              icon: Icons.event_busy_outlined,
                              label: l10n.trainingMarkMissedCta,
                            ),
                          ),
                          PopupMenuItem(
                            value: _DayAction.copy,
                            child: _DayActionMenuItem(
                              icon: Icons.copy_rounded,
                              label: l10n.trainingCopyToDayCta,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 10),
              if (day.isRest)
                const _RestLine()
              else
                _DayProgressBand(
                  value: progress,
                  color: day.isCompleted ? AppColors.success : accent,
                  percent: (progress * 100).round(),
                  label: hasWorkout || day.isMissed
                      ? l10n.trainingExercisesCountLabel(
                          day.completedExercises,
                          day.totalExercises,
                        )
                      : l10n.trainingNoExercisesPlannedMessage,
                ),
              if (day.hasWarning) ...[
                const SizedBox(height: AppSpacing.lg),
                const _DayWarningLine(),
              ],
              if (expanded) ...[
                const Spacer(),
                _DayAtGlance(
                  dayId: day.id,
                  onOpenAnalysis: () => context.push('/weeks/$weekId/analysis'),
                ),
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleAction(
    BuildContext context,
    WidgetRef ref,
    _DayAction action,
  ) async {
    final notifier = ref.read(daysControllerProvider(weekId).notifier);
    try {
      switch (action) {
        case _DayAction.normal:
          await notifier.setStatus(day.id, 'Normal');
        case _DayAction.rest:
          await notifier.setStatus(day.id, 'Rest');
        case _DayAction.missed:
          await notifier.setStatus(day.id, 'Missed');
        case _DayAction.copy:
          final target = await _pickTargetDay(context);
          if (target == null) return;
          final copied = await notifier.copyDay(
            sourceDailyWorkoutId: day.id,
            targetDailyWorkoutId: target.id,
          );
          if (!context.mounted) return;
          _toast(
            context,
            AppLocalizations.of(
              context,
            ).trainingExercisesCopiedSnackbar(copied),
          );
      }
    } catch (e) {
      if (!context.mounted) return;
      _toast(context, '$e');
    }
  }

  Future<DailyWorkout?> _pickTargetDay(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final targets = allDays.where((d) => d.id != day.id).toList();
    return showDialog<DailyWorkout>(
      context: context,
      builder: (ctx) => SimpleDialog(
        title: Text(l10n.trainingCopyToDayCta),
        children: [
          if (targets.isEmpty)
            Padding(
              padding: const EdgeInsets.all(AppSpacing.lg),
              child: Text(l10n.trainingNoTargetDaysMessage),
            )
          else
            for (final target in targets)
              SimpleDialogOption(
                onPressed: () => Navigator.pop(ctx, target),
                child: Text(
                  l10n.trainingTargetDayOption(
                    target.dayOfWeek,
                    DateOnly.format(target.date),
                  ),
                ),
              ),
        ],
      ),
    );
  }

  void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

class _DayAtGlance extends ConsumerWidget {
  const _DayAtGlance({
    required this.dayId,
    required this.onOpenAnalysis,
  });

  final String dayId;
  final VoidCallback onOpenAnalysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final exercises = ref.watch(exercisesControllerProvider(dayId));

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.surfaceBorderSoft.withValues(alpha: 0.86),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 16),
        child: exercises.when(
          loading: () => const SizedBox(
            height: 146,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (_, _) => _DayMetricList(
            metrics: const _DayWorkoutMetrics.empty(),
            l10n: l10n,
            onOpenAnalysis: onOpenAnalysis,
          ),
          data: (items) => _DayMetricList(
            metrics: _DayWorkoutMetrics.fromExercises(items),
            l10n: l10n,
            onOpenAnalysis: onOpenAnalysis,
          ),
        ),
      ),
    );
  }
}

class _DayMetricList extends StatelessWidget {
  const _DayMetricList({
    required this.metrics,
    required this.l10n,
    required this.onOpenAnalysis,
  });

  final _DayWorkoutMetrics metrics;
  final AppLocalizations l10n;
  final VoidCallback onOpenAnalysis;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.insights_rounded,
              size: 18,
              color: AppColors.accent,
            ),
            const SizedBox(width: AppSpacing.md),
            Text(
              l10n.trainingWorkoutTitle,
              style: AppTypography.display(18, weight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: 12),
        _DayMetricRow(
          icon: Icons.layers_outlined,
          label: l10n.trainingSetsCountLabel,
          value: '${metrics.totalSets}',
        ),
        const SizedBox(height: 8),
        _DayMetricRow(
          icon: Icons.trending_up_rounded,
          label: l10n.progressVolumeLabel,
          value: '${_formatDayNumber(context, metrics.totalVolume)} kg-reps',
        ),
        const SizedBox(height: 8),
        _DayMetricRow(
          icon: Icons.speed_rounded,
          label: l10n.progressAvgRpeLabel,
          value: metrics.averageRpe?.toStringAsFixed(1) ?? '-',
        ),
        const SizedBox(height: 8),
        _DayMetricRow(
          icon: Icons.timer_outlined,
          label: l10n.progressTimeTrainedLabel,
          value: _formatDayDuration(l10n, metrics.totalDurationSeconds),
        ),
        const SizedBox(height: 8),
        _DayMetricRow(
          icon: Icons.local_fire_department_outlined,
          label: l10n.coachCaloriesLabel,
          value: '${metrics.estimatedCalories} ${l10n.nutritionKcalLabel}',
        ),
        const SizedBox(height: 12),
        SizedBox(
          width: double.infinity,
          child: OutlinedButton.icon(
            onPressed: onOpenAnalysis,
            icon: const Icon(Icons.insights_rounded, size: 18),
            label: Text(l10n.commonAnalytics),
            style: OutlinedButton.styleFrom(
              foregroundColor: AppColors.fg1,
              side: const BorderSide(color: AppColors.surfaceBorderSoft),
              minimumSize: const Size.fromHeight(42),
              padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppRadius.md),
              ),
              textStyle: const TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _DayMetricRow extends StatelessWidget {
  const _DayMetricRow({
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
        Icon(icon, size: 18, color: AppColors.fg3),
        const SizedBox(width: AppSpacing.lg),
        Expanded(
          child: Text(
            label,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.lg),
        Text(
          value,
          style: AppTypography.mono(
            14,
            weight: FontWeight.w500,
            color: AppColors.fg1,
          ),
        ),
      ],
    );
  }
}

class _DayWorkoutMetrics {
  const _DayWorkoutMetrics({
    required this.totalSets,
    required this.totalVolume,
    required this.averageRpe,
    required this.totalDurationSeconds,
    required this.estimatedCalories,
  });

  const _DayWorkoutMetrics.empty()
    : totalSets = 0,
      totalVolume = 0,
      averageRpe = null,
      totalDurationSeconds = 0,
      estimatedCalories = 0;

  factory _DayWorkoutMetrics.fromExercises(List<Exercise> exercises) {
    var totalSets = 0;
    var totalVolume = 0.0;
    var totalDurationSeconds = 0;
    var totalRpe = 0.0;
    var rpeCount = 0;

    for (final exercise in exercises) {
      totalSets += exercise.sets.isEmpty
          ? exercise.plannedSets
          : exercise.sets.length;
      totalDurationSeconds += _exerciseDurationSeconds(exercise);

      for (final set in exercise.sets) {
        if (!set.isCompleted) continue;
        final reps = set.actualReps ?? set.plannedReps;
        final weight =
            set.actualWeight ?? set.plannedWeight ?? exercise.plannedWeight;
        if (weight != null) totalVolume += weight * reps;
        if (set.rpe != null) {
          totalRpe += set.rpe!;
          rpeCount++;
        }
      }
    }

    return _DayWorkoutMetrics(
      totalSets: totalSets,
      totalVolume: totalVolume,
      averageRpe: rpeCount == 0 ? null : totalRpe / rpeCount,
      totalDurationSeconds: totalDurationSeconds,
      estimatedCalories: totalDurationSeconds <= 0
          ? 0
          : math.max(1, (totalDurationSeconds / 10).round()),
    );
  }

  final int totalSets;
  final double totalVolume;
  final double? averageRpe;
  final int totalDurationSeconds;
  final int estimatedCalories;
}

int _exerciseDurationSeconds(Exercise exercise) {
  final explicit = exercise.durationSeconds;
  if (explicit != null && explicit > 0) return explicit;
  final started = exercise.startedAtUtc;
  final ended = exercise.endedAtUtc;
  if (started == null || ended == null || !ended.isAfter(started)) return 0;
  return ended.difference(started).inSeconds;
}

String _formatDayNumber(BuildContext context, double value) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return intl.NumberFormat.decimalPattern(locale).format(value.round());
}

String _formatDayDuration(AppLocalizations l10n, int seconds) {
  final minutes = seconds ~/ 60;
  if (minutes < 60) return l10n.progressDurationMinutes(minutes);
  return l10n.progressDurationHoursMinutes(minutes ~/ 60, minutes % 60);
}

class _DayProgressBand extends StatelessWidget {
  const _DayProgressBand({
    required this.value,
    required this.color,
    required this.percent,
    required this.label,
  });

  final double value;
  final Color color;
  final int percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.md,
        AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.bg2.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: color.withValues(alpha: 0.1)),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                const SizedBox(height: AppSpacing.md),
                _ProgressBar(value: value, color: color),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          _ProgressMeta(percent: percent, label: label),
          const SizedBox(width: AppSpacing.xs),
          Icon(
            Icons.chevron_right_rounded,
            color: AppColors.fg3.withValues(alpha: 0.8),
          ),
        ],
      ),
    );
  }
}

class _WeekDaysSummary extends StatelessWidget {
  const _WeekDaysSummary({required this.days});

  final List<DailyWorkout> days;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final completed = days.where((day) => day.isCompleted).length;
    final rest = days.where((day) => day.isRest).length;
    final missed = days.where((day) => day.isMissed).length;
    final exercises = days.fold<int>(0, (sum, day) => sum + day.totalExercises);
    final completedExercises = days.fold<int>(
      0,
      (sum, day) => sum + day.completedExercises,
    );
    final progress = exercises == 0 ? 0.0 : completedExercises / exercises;

    return XnCard(
      color: AppColors.bg3.withValues(alpha: 0.72),
      border: Border.all(color: AppColors.border1.withValues(alpha: 0.52)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 48,
                height: 48,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: AppColors.bg2,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.surfaceBorderSoft),
                ),
                child: const Icon(
                  Icons.view_day_rounded,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.trainingWeekExecutionLabel,
                      style: AppTypography.display(22, letterSpacing: 0),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.trainingWeekExecutionSummary(
                        completed,
                        days.length,
                        completedExercises,
                        exercises,
                      ),
                      style: const TextStyle(
                        color: AppColors.fg2,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _ProgressBar(
            value: progress.clamp(0.0, 1.0),
            color: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _SummaryMetric(label: l10n.commonRest, value: '$rest'),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _SummaryMetric(
                  label: l10n.commonMissed,
                  value: '$missed',
                  tone: missed > 0 ? XnChipTone.danger : XnChipTone.sage,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _SummaryMetric(
                  label: l10n.commonProgress,
                  value: '${(progress * 100).round()}%',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _ListSectionHeader extends StatelessWidget {
  const _ListSectionHeader({required this.label, required this.meta});

  final String label;
  final String meta;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.fg1,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Spacer(),
        Text(
          meta,
          style: AppTypography.mono(
            12,
            color: AppColors.fg3,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _SummaryMetric extends StatelessWidget {
  const _SummaryMetric({
    required this.label,
    required this.value,
    this.tone = XnChipTone.neutral,
  });

  final String label;
  final String value;
  final XnChipTone tone;

  @override
  Widget build(BuildContext context) {
    final (bg, fg) = switch (tone) {
      XnChipTone.danger => (AppColors.dangerBg, AppColors.danger),
      XnChipTone.sage => (AppColors.successBg, AppColors.success),
      _ => (AppColors.bg2, AppColors.fg2),
    };

    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: fg.withValues(alpha: 0.12)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            value,
            style: AppTypography.mono(16, weight: FontWeight.w500, color: fg),
          ),
          const SizedBox(height: 3),
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
        ],
      ),
    );
  }
}

class _DayMark extends StatelessWidget {
  const _DayMark({
    required this.date,
    required this.icon,
    required this.color,
    required this.selected,
  });

  final DateTime date;
  final IconData icon;
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 46,
      decoration: BoxDecoration(
        color: selected
            ? AppColors.bg2.withValues(alpha: 0.82)
            : AppColors.bg3.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: color, size: 16),
          const SizedBox(height: 2),
          Text(
            '${date.day}',
            style: AppTypography.mono(
              14,
              weight: FontWeight.w500,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}

/// "Period" / "Pre-menstrual" badge for a cycle-aware day (see
/// `cycleDayMarkersProvider`). Reuses the app's existing danger/warn chip
/// tones — the same pairing `cycle_screen.dart` already uses for the
/// Menstrual/Luteal phases — rather than introducing a one-off color.
class _CycleMarkerChip extends StatelessWidget {
  const _CycleMarkerChip({required this.marker});

  final String marker;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (label, bg, fg) = switch (marker) {
      'Menstrual' => (
        l10n.cycleMarkerPeriodLabel,
        _cycleMenstrualBg,
        _cycleMenstrualAccent,
      ),
      'PreMenstrual' => (
        l10n.cycleMarkerPreMenstrualLabel,
        _cyclePremenstrualBg,
        _cyclePremenstrualAccent,
      ),
      _ => (marker, AppColors.bg3, AppColors.fg2),
    };
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: 4,
        ),
        decoration: BoxDecoration(
          color: bg.withValues(alpha: 0.86),
          borderRadius: BorderRadius.circular(AppRadius.sm),
          border: Border.all(color: fg.withValues(alpha: 0.12)),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 7,
              height: 7,
              decoration: BoxDecoration(color: fg, shape: BoxShape.circle),
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: const TextStyle(
                color: AppColors.fg1,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _RestLine extends StatelessWidget {
  const _RestLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
      ),
      decoration: BoxDecoration(
        color: AppColors.sage100.withValues(alpha: 0.44),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.sage500.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.self_improvement_rounded,
            size: 16,
            color: AppColors.sage700,
          ),
          const SizedBox(width: AppSpacing.sm),
          Text(
            AppLocalizations.of(context).trainingRecoveryDayMessage,
            style: const TextStyle(
              color: AppColors.sage700,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _DayWarningLine extends StatelessWidget {
  const _DayWarningLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: 6,
      ),
      decoration: BoxDecoration(
        color: AppColors.warningBg.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.warning.withValues(alpha: 0.12)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.error_outline_rounded,
            size: 16,
            color: AppColors.warning,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              AppLocalizations.of(context).trainingDayNeedsReviewMessage,
              style: const TextStyle(
                color: AppColors.warning,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _DayActionMenuItem extends StatelessWidget {
  const _DayActionMenuItem({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 210,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 20, color: AppColors.fg2),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.fg1,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ProgressMeta extends StatelessWidget {
  const _ProgressMeta({required this.percent, required this.label});

  final int percent;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          '$percent%',
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: AppTypography.mono(
            12,
            color: AppColors.fg1,
            weight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 2),
        Text(
          label,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          textAlign: TextAlign.right,
          style: AppTypography.mono(
            10,
            color: AppColors.fg3,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}

class _ProgressBar extends StatelessWidget {
  const _ProgressBar({required this.value, required this.color});

  final double value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      child: XnAnimatedLinearProgress(
        value: value,
        minHeight: 6,
        backgroundColor: AppColors.bg2.withValues(alpha: 0.82),
        color: color,
      ),
    );
  }
}
