import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/plan.dart';
import '../../domain/entities/weekly_workout.dart';
import '../providers/plan_detail_controller.dart';
import '../providers/plans_controller.dart';
import '../providers/week_analysis_provider.dart';
import '../widgets/create_plan_sheet.dart';

enum _PlanAction {
  analytics,
  balanceCheck,
  designAnalysis,
  comments,
  edit,
  duplicate,
  toggleActive,
  delete,
}

/// Builds a plan-actions menu row in the app idiom: a muted leading icon and an
/// `fg1` label, switching to danger styling for destructive actions.
PopupMenuItem<_PlanAction> _menuItem(
  _PlanAction value,
  IconData icon,
  String label, {
  bool danger = false,
}) {
  final iconColor = danger ? AppColors.danger : AppColors.fg2;
  final textColor = danger ? AppColors.danger : AppColors.fg1;
  return PopupMenuItem<_PlanAction>(
    value: value,
    height: 46,
    child: Row(
      children: [
        Icon(icon, size: 20, color: iconColor),
        const SizedBox(width: AppSpacing.md),
        Text(
          label,
          style: TextStyle(
            color: textColor,
            fontSize: 15,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    ),
  );
}

class PlanDetailScreen extends ConsumerWidget {
  const PlanDetailScreen({required this.planId, super.key});

  final String planId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final plan = ref.watch(planDetailProvider(planId));
    final weeks = ref.watch(weeksControllerProvider(planId));

    return Scaffold(
      appBar: AppBar(
        title: Text(plan.value?.name ?? l10n.trainingPlanFallbackTitle),
        actions: [
          if (plan.value != null)
            PopupMenuButton<_PlanAction>(
              icon: const Icon(Icons.more_vert_rounded),
              tooltip: l10n.trainingPlanActionsTooltip,
              splashRadius: 22,
              menuPadding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
              onSelected: (action) =>
                  _handleAction(context, ref, action, plan.value!),
              itemBuilder: (_) => [
                _menuItem(
                  _PlanAction.analytics,
                  Icons.insights_rounded,
                  l10n.commonAnalytics,
                ),
                _menuItem(
                  _PlanAction.balanceCheck,
                  Icons.balance_rounded,
                  l10n.trainingAiBalanceCheckTitle,
                ),
                _menuItem(
                  _PlanAction.designAnalysis,
                  Icons.architecture_rounded,
                  l10n.trainingDesignAnalysisTitle,
                ),
                _menuItem(
                  _PlanAction.comments,
                  Icons.mode_comment_outlined,
                  l10n.commonComments,
                ),
                _menuItem(
                  _PlanAction.edit,
                  Icons.edit_outlined,
                  l10n.commonEdit,
                ),
                _menuItem(
                  _PlanAction.duplicate,
                  Icons.copy_rounded,
                  l10n.commonDuplicate,
                ),
                _menuItem(
                  _PlanAction.toggleActive,
                  plan.value!.isActive
                      ? Icons.pause_circle_outline_rounded
                      : Icons.play_circle_outline_rounded,
                  plan.value!.isActive
                      ? l10n.commonDeactivate
                      : l10n.commonActivate,
                ),
                const PopupMenuDivider(),
                _menuItem(
                  _PlanAction.delete,
                  Icons.delete_outline_rounded,
                  l10n.commonDelete,
                  danger: true,
                ),
              ],
            ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () =>
            ref.read(weeksControllerProvider(planId).notifier).refresh(),
        child: AsyncValueView(
          value: weeks,
          onRetry: () => ref.invalidate(weeksControllerProvider(planId)),
          data: (items) {
            final currentWeekId = _currentWeekId(items);
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
                    child: _PlanWeeksSummary(
                      plan: plan.value,
                      weeks: items,
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.lg,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: _ListSectionHeader(
                      label: l10n.trainingTrainingWeeksLabel,
                      meta: l10n.trainingTotalCountLabel(items.length),
                    ),
                  ),
                ),
                const SliverToBoxAdapter(
                  child: SizedBox(height: AppSpacing.sm),
                ),
                SliverLayoutBuilder(
                  builder: (context, constraints) {
                    final textScale = MediaQuery.textScalerOf(
                      context,
                    ).scale(1).clamp(1.0, 1.6);
                    final narrow = constraints.crossAxisExtent < 380;
                    final contentHeight =
                        (narrow ? 500.0 : 470.0) +
                        ((textScale - 1) * 180) +
                        (items.any((week) => week.hasWarning) ? 40 : 0);
                    final cardHeight = math.max(
                      contentHeight,
                      constraints.viewportMainAxisExtent -
                          constraints.precedingScrollExtent -
                          AppSpacing.xxl,
                    );
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
                          child: _WeekTimelineCarousel(
                            weeks: items,
                            planId: planId,
                            currentWeekId: currentWeekId,
                            initialIndex: _currentWeekIndex(items),
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

  Future<void> _handleAction(
    BuildContext context,
    WidgetRef ref,
    _PlanAction action,
    Plan plan,
  ) async {
    switch (action) {
      case _PlanAction.analytics:
        unawaited(context.push('/plans/${plan.id}/analytics'));
      case _PlanAction.balanceCheck:
        unawaited(context.push('/plans/${plan.id}/balance-check'));
      case _PlanAction.designAnalysis:
        unawaited(context.push('/plans/${plan.id}/design-analysis'));
      case _PlanAction.comments:
        unawaited(context.push('/plans/${plan.id}/comments'));
      case _PlanAction.edit:
        final saved = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.bgPage,
          builder: (_) => CreatePlanSheet(
            mode: PlanFormMode.edit,
            initialPlan: plan,
          ),
        );
        if ((saved ?? false) && context.mounted) {
          ref.invalidate(planDetailProvider(plan.id));
        }
      case _PlanAction.duplicate:
        final saved = await showModalBottomSheet<bool>(
          context: context,
          isScrollControlled: true,
          backgroundColor: AppColors.bgPage,
          builder: (_) => CreatePlanSheet(
            mode: PlanFormMode.duplicate,
            initialPlan: plan,
          ),
        );
        if ((saved ?? false) && context.mounted) {
          _toast(
            context,
            AppLocalizations.of(context).trainingPlanDuplicatedSnackbar,
          );
        }
      case _PlanAction.toggleActive:
        await _toggleActive(context, ref, plan);
      case _PlanAction.delete:
        final l10n = AppLocalizations.of(context);
        final ok = await showDialog<bool>(
          context: context,
          builder: (ctx) => AlertDialog(
            title: Text(l10n.trainingDeletePlanTitle),
            content: Text(l10n.trainingDeletePlanMessage(plan.name)),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(ctx, false),
                child: Text(l10n.commonCancel),
              ),
              FilledButton(
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.danger,
                ),
                onPressed: () => Navigator.pop(ctx, true),
                child: Text(l10n.commonDelete),
              ),
            ],
          ),
        );
        if (ok != true) return;
        try {
          await ref.read(plansControllerProvider.notifier).deletePlan(plan.id);
          if (!context.mounted) return;
          context.pop();
        } catch (e) {
          if (!context.mounted) return;
          _toast(context, '$e');
        }
    }
  }

  Future<void> _toggleActive(
    BuildContext context,
    WidgetRef ref,
    Plan plan,
  ) async {
    try {
      final notifier = ref.read(plansControllerProvider.notifier);
      if (plan.isActive) {
        await notifier.deactivate(plan.id);
      } else {
        await notifier.activate(plan.id);
      }
      ref.invalidate(planDetailProvider(plan.id));
    } catch (e) {
      if (!context.mounted) return;
      _toast(context, '$e');
    }
  }

  void _toast(BuildContext context, String message) {
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(message)));
  }
}

/// Index of the week containing today, or the first not-yet-completed week.
/// Returns -1 when nothing qualifies (e.g. every week is done).
int _currentWeekIndex(List<WeeklyWorkout> weeks) {
  final today = _dateOnly(DateTime.now());
  final byDate = weeks.indexWhere((week) {
    final start = _dateOnly(week.startDate);
    final end = _dateOnly(week.endDate);
    return !today.isBefore(start) && !today.isAfter(end);
  });
  if (byDate >= 0) return byDate;
  return weeks.indexWhere((week) => !week.isCompleted);
}

String? _currentWeekId(List<WeeklyWorkout> weeks) {
  final index = _currentWeekIndex(weeks);
  return index >= 0 ? weeks[index].id : null;
}

DateTime _dateOnly(DateTime date) => DateTime(date.year, date.month, date.day);

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

/// e.g. `Jan 5 – 11` (same month) or `Jan 28 – Feb 3` (across months).
String _formatWeekRange(DateTime start, DateTime end) {
  final startLabel = '${_monthAbbr[start.month - 1]} ${start.day}';
  final endLabel = start.month == end.month
      ? '${end.day}'
      : '${_monthAbbr[end.month - 1]} ${end.day}';
  return '$startLabel – $endLabel';
}

class _WeekTimelineCarousel extends StatefulWidget {
  const _WeekTimelineCarousel({
    required this.weeks,
    required this.planId,
    required this.currentWeekId,
    required this.initialIndex,
  });

  final List<WeeklyWorkout> weeks;
  final String planId;
  final String? currentWeekId;
  final int initialIndex;

  @override
  State<_WeekTimelineCarousel> createState() => _WeekTimelineCarouselState();
}

class _WeekTimelineCarouselState extends State<_WeekTimelineCarousel> {
  late final PageController _controller;
  late int _activeIndex;

  int get _startIndex =>
      widget.initialIndex >= 0 && widget.initialIndex < widget.weeks.length
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
            itemCount: widget.weeks.length,
            onPageChanged: (index) => setState(() => _activeIndex = index),
            itemBuilder: (context, index) {
              final week = widget.weeks[index];
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
                    child: _WeekCard(
                      week: week,
                      planId: widget.planId,
                      isCurrent: week.id == widget.currentWeekId,
                      isLast: true,
                      expanded: true,
                      onTap: () => context.push('/weeks/${week.id}'),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        _CarouselPositionIndicator(
          count: widget.weeks.length,
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

class _WeekCard extends ConsumerWidget {
  const _WeekCard({
    required this.week,
    required this.planId,
    required this.isCurrent,
    required this.isLast,
    required this.onTap,
    this.expanded = false,
  });

  final WeeklyWorkout week;
  final String planId;
  final bool isCurrent;
  final bool isLast;
  final bool expanded;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final status = week.isCompleted
        ? l10n.trainingWeekComplete
        : isCurrent
        ? l10n.trainingWeekInFocus
        : week.hasWarning
        ? l10n.trainingWeekNeedsCheck
        : l10n.trainingWeekScheduled;
    final statusTone = week.isCompleted
        ? XnChipTone.sage
        : isCurrent
        ? XnChipTone.accent
        : week.hasWarning
        ? XnChipTone.warn
        : XnChipTone.neutral;
    final progress = (week.progressPercent / 100).clamp(0.0, 1.0);
    final accent = week.isCompleted
        ? AppColors.success
        : isCurrent
        ? AppColors.accent
        : week.hasWarning
        ? AppColors.warning
        : AppColors.sage500;
    final surface = isCurrent
        ? AppColors.accentSoft.withValues(alpha: 0.38)
        : week.isCompleted
        ? AppColors.successBg.withValues(alpha: 0.32)
        : AppColors.bg2;
    final cardRadius = BorderRadius.circular(
      expanded ? AppRadius.xxl : AppRadius.lg,
    );
    Widget identity() => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          week.name,
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
          _formatWeekRange(week.startDate, week.endDate),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: AppTypography.mono(
            12,
            color: AppColors.fg3,
            weight: FontWeight.w500,
          ),
        ),
      ],
    );
    Widget actions() => Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        XnChip(label: status, tone: statusTone, compact: true),
        const SizedBox(width: AppSpacing.xs),
        IconButton(
          icon: const Icon(Icons.edit_outlined),
          color: AppColors.fg3,
          tooltip: l10n.trainingRenameWeekTooltip,
          iconSize: 19,
          visualDensity: VisualDensity.compact,
          constraints: const BoxConstraints.tightFor(width: 30, height: 30),
          padding: EdgeInsets.zero,
          onPressed: () => _rename(context, ref),
        ),
      ],
    );
    final content = Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        LayoutBuilder(
          builder: (context, constraints) {
            final mark = _WeekNumberMark(
              number: week.weekNumber,
              color: accent,
              selected: isCurrent,
            );
            if (constraints.maxWidth < 290) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      mark,
                      const SizedBox(width: AppSpacing.md),
                      Expanded(child: identity()),
                    ],
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Align(alignment: Alignment.centerRight, child: actions()),
                ],
              );
            }
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                mark,
                const SizedBox(width: AppSpacing.md),
                Expanded(child: identity()),
                const SizedBox(width: AppSpacing.sm),
                Flexible(child: actions()),
              ],
            );
          },
        ),
        const SizedBox(height: 10),
        _WeekProgressBand(
          value: progress,
          color: accent,
          percent: week.progressPercent,
          label: l10n.trainingDaysCountLabel(
            week.completedDays,
            week.totalDays,
          ),
        ),
        if (week.hasWarning) ...[
          const SizedBox(height: AppSpacing.lg),
          const _WeekWarningLine(),
        ],
        if (expanded) ...[
          const SizedBox(height: AppSpacing.xl),
          _WeekAtGlance(
            weekId: week.id,
            onOpenAnalysis: () => context.push('/weeks/${week.id}/analysis'),
          ),
        ],
      ],
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
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
              color: isCurrent
                  ? AppColors.accent.withValues(alpha: 0.24)
                  : AppColors.surfaceBorderSoft,
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
          child: expanded
              ? LayoutBuilder(
                  builder: (context, constraints) => SingleChildScrollView(
                    primary: false,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(
                        minHeight: constraints.maxHeight,
                      ),
                      child: content,
                    ),
                  ),
                )
              : content,
        ),
      ),
    );
  }

  Future<void> _rename(BuildContext context, WidgetRef ref) async {
    final name = await showDialog<String>(
      context: context,
      builder: (_) => _RenameWeekDialog(initialName: week.name),
    );
    if (name == null || name.length < 2) return;
    try {
      await ref
          .read(weeksControllerProvider(planId).notifier)
          .renameWeek(weeklyWorkoutId: week.id, name: name);
    } catch (e) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}

class _WeekAtGlance extends ConsumerWidget {
  const _WeekAtGlance({required this.weekId, required this.onOpenAnalysis});

  final String weekId;
  final VoidCallback onOpenAnalysis;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final analysis = ref.watch(weekAnalysisProvider(weekId));

    return DecoratedBox(
      decoration: BoxDecoration(
        border: Border(
          top: BorderSide(
            color: AppColors.surfaceBorderSoft.withValues(alpha: 0.86),
          ),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: AppSpacing.xl),
        child: analysis.when(
          loading: () => const SizedBox(
            height: 118,
            child: Center(child: CircularProgressIndicator(strokeWidth: 2)),
          ),
          error: (_, _) => _WeekAtGlanceContent(
            title: l10n.trainingWeekExecutionLabel,
            rows: const [],
            onOpenAnalysis: onOpenAnalysis,
          ),
          data: (data) => _WeekAtGlanceContent(
            title: l10n.trainingWeekExecutionLabel,
            rows: [
              _WeekAtGlanceRow(
                icon: Icons.trending_up_rounded,
                label: l10n.progressVolumeLabel,
                value:
                    '${_formatWeekVolume(context, data.actualVolume)} kg-reps',
              ),
              _WeekAtGlanceRow(
                icon: Icons.layers_outlined,
                label: l10n.progressCompletedSetsLabel,
                value: '${data.completedSets}/${data.totalSets}',
              ),
              _WeekAtGlanceRow(
                icon: Icons.timer_outlined,
                label: l10n.progressTimeTrainedLabel,
                value: _formatWeekDuration(l10n, data.totalDurationSeconds),
              ),
            ],
            onOpenAnalysis: onOpenAnalysis,
          ),
        ),
      ),
    );
  }
}

class _WeekAtGlanceContent extends StatelessWidget {
  const _WeekAtGlanceContent({
    required this.title,
    required this.rows,
    required this.onOpenAnalysis,
  });

  final String title;
  final List<_WeekAtGlanceRow> rows;
  final VoidCallback onOpenAnalysis;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(
              Icons.bar_chart_rounded,
              size: 18,
              color: AppColors.accent,
            ),
            const SizedBox(width: AppSpacing.md),
            Expanded(
              child: Text(
                title,
                style: AppTypography.display(18, weight: FontWeight.w500),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xl),
        if (rows.isEmpty)
          const SizedBox(height: 72)
        else
          for (final row in rows) ...[
            row,
            const SizedBox(height: AppSpacing.lg),
          ],
        const SizedBox(height: AppSpacing.sm),
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

class _WeekAtGlanceRow extends StatelessWidget {
  const _WeekAtGlanceRow({
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
        Flexible(
          child: Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTypography.mono(
              14,
              weight: FontWeight.w500,
              color: AppColors.fg1,
            ),
          ),
        ),
      ],
    );
  }
}

String _formatWeekVolume(BuildContext context, double value) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return intl.NumberFormat.decimalPattern(locale).format(value.round());
}

String _formatWeekDuration(AppLocalizations l10n, int seconds) {
  final minutes = seconds ~/ 60;
  if (minutes < 60) return l10n.progressDurationMinutes(minutes);
  return l10n.progressDurationHoursMinutes(minutes ~/ 60, minutes % 60);
}

class _WeekProgressBand extends StatelessWidget {
  const _WeekProgressBand({
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
                  AppLocalizations.of(context).commonProgress,
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

class _PlanWeeksSummary extends StatelessWidget {
  const _PlanWeeksSummary({required this.plan, required this.weeks});

  final Plan? plan;
  final List<WeeklyWorkout> weeks;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final totalDays =
        plan?.totalDays ??
        weeks.fold<int>(0, (sum, week) => sum + week.totalDays);
    final completedDays =
        plan?.completedDays ??
        weeks.fold<int>(0, (sum, week) => sum + week.completedDays);
    final completedWeeks = weeks.where((week) => week.isCompleted).length;
    final warnings = weeks.where((week) => week.hasWarning).length;
    final progress = totalDays == 0 ? 0.0 : completedDays / totalDays;

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
                  Icons.calendar_view_week_rounded,
                  color: AppColors.accent,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.trainingPlanTimelineLabel,
                      style: AppTypography.display(22, letterSpacing: 0),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      l10n.trainingWeeksSummary(
                        weeks.length,
                        completedDays,
                        totalDays,
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
                child: _SummaryMetric(
                  label: l10n.trainingWeeksDoneLabel,
                  value: '$completedWeeks/${weeks.length}',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _SummaryMetric(
                  label: l10n.commonWarnings,
                  value: '$warnings',
                  tone: warnings > 0 ? XnChipTone.warn : XnChipTone.sage,
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
        Expanded(
          child: Text(
            label,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg1,
              fontSize: 13,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Flexible(
          child: Text(
            meta,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.end,
            style: AppTypography.mono(
              12,
              color: AppColors.fg3,
              weight: FontWeight.w500,
            ),
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
      XnChipTone.warn => (AppColors.warningBg, AppColors.warning),
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

class _WeekNumberMark extends StatelessWidget {
  const _WeekNumberMark({
    required this.number,
    required this.color,
    required this.selected,
  });

  final int number;
  final Color color;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 40, minHeight: 46),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 6),
      decoration: BoxDecoration(
        color: selected
            ? AppColors.bg2.withValues(alpha: 0.82)
            : AppColors.bg3.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: color.withValues(alpha: 0.24)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            '$number',
            style: AppTypography.mono(
              16,
              weight: FontWeight.w500,
              color: color,
            ),
          ),
          const SizedBox(height: 1),
          Text(
            AppLocalizations.of(context).trainingWeekMark,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 8,
              fontWeight: FontWeight.w500,
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

class _WeekWarningLine extends StatelessWidget {
  const _WeekWarningLine();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.lg,
        vertical: AppSpacing.lg,
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
              AppLocalizations.of(context).trainingReviewWeekMessage,
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

/// Owns the [TextEditingController] so its lifecycle is tied to the dialog's
/// element — disposing it in the caller's `whenComplete` races with the route
/// teardown (and IME composing, e.g. Vietnamese input), tripping framework
/// assertions.
class _RenameWeekDialog extends StatefulWidget {
  const _RenameWeekDialog({required this.initialName});

  final String initialName;

  @override
  State<_RenameWeekDialog> createState() => _RenameWeekDialogState();
}

class _RenameWeekDialogState extends State<_RenameWeekDialog> {
  late final TextEditingController _controller = TextEditingController(
    text: widget.initialName,
  );

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _submit() => Navigator.pop(context, _controller.text.trim());

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.trainingRenameWeekTooltip),
      content: TextField(
        controller: _controller,
        autofocus: true,
        decoration: InputDecoration(labelText: l10n.trainingWeekNameLabel),
        textInputAction: TextInputAction.done,
        onSubmitted: (_) => _submit(),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _submit,
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }
}
