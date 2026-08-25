import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart' as intl;

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_labels.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../progress/presentation/widgets/grouped_bar_chart.dart';
import '../providers/week_analysis_provider.dart';

class WeekAnalysisScreen extends ConsumerWidget {
  const WeekAnalysisScreen({required this.weekId, super.key});

  final String weekId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final analysis = ref.watch(weekAnalysisProvider(weekId));
    return Scaffold(
      appBar: AppBar(
        title: Text(_t(context, 'Week analysis', 'Phân tích tuần')),
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async => ref.invalidate(weekAnalysisProvider(weekId)),
        child: AsyncValueView(
          value: analysis,
          onRetry: () => ref.invalidate(weekAnalysisProvider(weekId)),
          data: (data) => _PrefsScope(
            unit: ref.watch(weightUnitProvider),
            trackRpe: ref.watch(trackRpeProvider),
            child: _WeekAnalysisBody(analysis: data),
          ),
        ),
      ),
    );
  }
}

/// Carries the user's training preferences down to this screen's private
/// widgets, which are plain [StatelessWidget]s several levels below the `ref`.
/// Volume arrives from the API in kg and is converted at render time, and the
/// RPE rows disappear when the user does not track RPE — so flipping either
/// preference updates the whole screen.
class _PrefsScope extends InheritedWidget {
  const _PrefsScope({
    required this.unit,
    required this.trackRpe,
    required super.child,
  });

  final WeightUnit unit;
  final bool trackRpe;

  static _PrefsScope? _maybeOf(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_PrefsScope>();

  static WeightUnit unitOf(BuildContext context) =>
      _maybeOf(context)?.unit ?? WeightUnit.kg;

  static bool trackRpeOf(BuildContext context) =>
      _maybeOf(context)?.trackRpe ?? true;

  @override
  bool updateShouldNotify(_PrefsScope oldWidget) =>
      oldWidget.unit != unit || oldWidget.trackRpe != trackRpe;
}

class _WeekAnalysisBody extends StatelessWidget {
  const _WeekAnalysisBody({required this.analysis});

  final WeekAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    final volumeRate = analysis.volumeRate.clamp(0.0, 1.0);
    final completionRate = analysis.completionRate.clamp(0.0, 1.0);
    final dateRange = _dateRange(analysis);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        if (analysis.totalDays < 0) _HeaderCard(dateRange: dateRange),
        _MobileSummaryCard(
          analysis: analysis,
          dateRange: dateRange,
          completionRate: completionRate,
          volumeRate: volumeRate,
        ),
        const SizedBox(height: AppSpacing.lg),
        _CompactStatsCard(analysis: analysis),
        const SizedBox(height: AppSpacing.lg),
        if (analysis.totalDays < 0)
          _MetricGrid(
            cards: [
              _MetricData(
                icon: Icons.calendar_month_rounded,
                iconBg: const Color(0xFFDCE8FF),
                title: _t(context, 'Completed days', 'Ngày hoàn thành'),
                value: '${analysis.completedDays} / ${analysis.totalDays}',
                subtitle: _t(
                  context,
                  '${(analysis.completionRate * 100).round()}% complete',
                  '${(analysis.completionRate * 100).round()}% hoàn thành',
                ),
              ),
              _MetricData(
                icon: Icons.trending_up_rounded,
                iconBg: AppColors.successBg,
                title: _t(context, 'Actual volume', 'Khối lượng thực'),
                value: _formatVolume(context, analysis.actualVolume),
                subtitle: _volumeUnitCaption(context, separator: ' · '),
              ),
              _MetricData(
                icon: Icons.bolt_rounded,
                iconBg: const Color(0xFFE7D8FF),
                title: _t(context, 'Volume vs plan', 'KL so kế hoạch'),
                value: '${(analysis.volumeRate * 100).round()}%',
                subtitle: _t(
                  context,
                  'vs ${_formatVolume(context, analysis.plannedVolume)} planned',
                  'so với ${_formatVolume(context, analysis.plannedVolume)} kế hoạch',
                ),
              ),
              _MetricData(
                icon: Icons.local_fire_department_outlined,
                iconBg: const Color(0xFFFFE2D6),
                title: _t(context, 'Estimated calories', 'Calo ước tính'),
                value: _number(context, analysis.estimatedCalories),
                subtitle: _t(context, 'kcal this week', 'kcal tuần này'),
              ),
              _MetricData(
                icon: Icons.timer_outlined,
                iconBg: AppColors.infoBg,
                title: _t(context, 'Total time', 'Tổng thời gian'),
                value: _formatDuration(context, analysis.totalDurationSeconds),
                subtitle: _t(context, 'tracked exercise', 'bài tập tính giờ'),
              ),
              if (_PrefsScope.trackRpeOf(context))
                _MetricData(
                  icon: Icons.monitor_heart_outlined,
                  iconBg: const Color(0xFFFFD8EA),
                  title: _t(context, 'Average RPE', 'RPE trung bình'),
                  value: analysis.averageRpe?.toStringAsFixed(1) ?? '—',
                  subtitle: _t(context, 'perceived effort', 'mức độ cảm nhận'),
                ),
              _MetricData(
                icon: Icons.warning_amber_rounded,
                iconBg: AppColors.warningBg,
                title: _t(context, 'Below target', 'Dưới mục tiêu'),
                value: '${analysis.warningDays}',
                subtitle: _t(context, 'warning days', 'ngày có cảnh báo'),
              ),
              _MetricData(
                icon: Icons.self_improvement_rounded,
                iconBg: AppColors.infoBg,
                title: _t(context, 'Rest days', 'Ngày nghỉ'),
                value: '${analysis.restDays}',
                subtitle: _t(context, 'planned recovery', 'nghỉ có chủ đích'),
              ),
              _MetricData(
                icon: Icons.cancel_outlined,
                iconBg: AppColors.dangerBg,
                title: _t(context, 'Missed days', 'Ngày bỏ lỡ'),
                value: '${analysis.missedDays}',
                subtitle: _t(context, 'missed training', 'ngày bỏ lỡ'),
              ),
            ],
          ),
        if (analysis.totalDays < 0)
          _CompletionCard(
            completionRate: completionRate,
            volumeRate: volumeRate,
            actualVolume: analysis.actualVolume,
            plannedVolume: analysis.plannedVolume,
          ),
        const SizedBox(height: AppSpacing.lg),
        XnCardStack(
          children: [
            _RecommendationsCard(recommendations: analysis.recommendations),
            _VolumePerDayCard(days: analysis.daily),
            _CaloriesPerDayCard(days: analysis.daily),
            _MuscleFocusCard(points: analysis.muscleFocus),
            _DailyVolumeCard(days: analysis.daily),
          ],
        ),
      ],
    );
  }
}

class _MobileSummaryCard extends StatelessWidget {
  const _MobileSummaryCard({
    required this.analysis,
    required this.dateRange,
    required this.completionRate,
    required this.volumeRate,
  });

  final WeekAnalysis analysis;
  final String dateRange;
  final double completionRate;
  final double volumeRate;

  @override
  Widget build(BuildContext context) {
    final completionPercent = (completionRate * 100).round();
    final volumePercent = (analysis.volumeRate * 100).round();
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 46,
                height: 46,
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                ),
                child: const Icon(
                  Icons.insights_rounded,
                  color: AppColors.accent,
                  size: 25,
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _t(context, 'Week analysis', 'Phân tích tuần'),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.display(
                        21,
                        color: AppColors.fg1,
                        weight: FontWeight.w700,
                        letterSpacing: 0,
                        height: 1.08,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      dateRange,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              _SummaryScore(
                value: '$completionPercent%',
                label: _t(context, 'Done', 'Xong'),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Expanded(
                child: _HeroNumber(
                  label: _t(context, 'Completed days', 'Ngày hoàn thành'),
                  value: '${analysis.completedDays}/${analysis.totalDays}',
                ),
              ),
              const SizedBox(width: AppSpacing.xl),
              Expanded(
                child: _HeroNumber(
                  label: _t(context, 'Actual volume', 'Khối lượng thực'),
                  value: _formatVolume(context, analysis.actualVolume),
                  suffix: _volumeUnitCaption(context, separator: ' '),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          _SummaryProgressLine(
            label: _t(context, 'Week completion', 'Tiến độ tuần'),
            value: completionRate,
            trailing: '$completionPercent%',
            color: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          _SummaryProgressLine(
            label: _t(context, 'Volume vs plan', 'KL so kế hoạch'),
            value: volumeRate,
            trailing: '$volumePercent%',
            color: AppColors.sage500,
          ),
        ],
      ),
    );
  }
}

class _SummaryScore extends StatelessWidget {
  const _SummaryScore({required this.value, required this.label});

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        children: [
          Text(
            value,
            style: AppTypography.mono(
              16,
              color: AppColors.fg1,
              weight: FontWeight.w500,
            ),
          ),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}

class _HeroNumber extends StatelessWidget {
  const _HeroNumber({required this.label, required this.value, this.suffix});

  final String label;
  final String value;
  final String? suffix;

  @override
  Widget build(BuildContext context) {
    return Column(
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
        const SizedBox(height: 2),
        Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Flexible(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                alignment: Alignment.centerLeft,
                child: Text(
                  value,
                  style: AppTypography.mono(
                    25,
                    color: AppColors.fg1,
                    weight: FontWeight.w500,
                  ),
                ),
              ),
            ),
            if (suffix != null) ...[
              const SizedBox(width: AppSpacing.sm),
              Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Text(
                  suffix!,
                  style: const TextStyle(
                    color: AppColors.fg3,
                    fontSize: 10,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ],
        ),
      ],
    );
  }
}

class _SummaryProgressLine extends StatelessWidget {
  const _SummaryProgressLine({
    required this.label,
    required this.value,
    required this.trailing,
    required this.color,
  });

  final String label;
  final double value;
  final String trailing;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: 116,
          child: Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: XnAnimatedLinearProgress(
              value: value.clamp(0.0, 1.0),
              minHeight: 8,
              backgroundColor: AppColors.bg3,
              color: color,
            ),
          ),
        ),
        const SizedBox(width: AppSpacing.sm),
        SizedBox(
          width: 36,
          child: Text(
            trailing,
            textAlign: TextAlign.right,
            style: AppTypography.mono(
              11,
              color: AppColors.fg1,
              weight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

class _CompactStatsCard extends StatelessWidget {
  const _CompactStatsCard({required this.analysis});

  final WeekAnalysis analysis;

  @override
  Widget build(BuildContext context) {
    return XnCardStack(
      children: [
        _CompactStatRow(
          icon: Icons.bolt_rounded,
          iconBg: const Color(0xFFE7D8FF),
          label: _t(context, 'Volume vs plan', 'KL so kế hoạch'),
          value: '${(analysis.volumeRate * 100).round()}%',
          detail: _t(
            context,
            '${_formatVolume(context, analysis.actualVolume)} / ${_formatVolume(context, analysis.plannedVolume)}',
            '${_formatVolume(context, analysis.actualVolume)} / ${_formatVolume(context, analysis.plannedVolume)}',
          ),
        ),
        _CompactStatRow(
          icon: Icons.timer_outlined,
          iconBg: AppColors.infoBg,
          label: _t(context, 'Time', 'Thời gian'),
          value: _formatDuration(context, analysis.totalDurationSeconds),
          detail: _t(context, 'Tracked exercise time', 'Thời gian đã tính'),
        ),
        if (_PrefsScope.trackRpeOf(context))
          _CompactStatRow(
            icon: Icons.monitor_heart_outlined,
            iconBg: const Color(0xFFFFD8EA),
            label: _t(context, 'Average RPE', 'RPE trung bình'),
            value: analysis.averageRpe?.toStringAsFixed(1) ?? '-',
            detail: _t(context, 'Perceived effort', 'Mức cảm nhận'),
          ),
        _CompactStatRow(
          icon: Icons.local_fire_department_outlined,
          iconBg: const Color(0xFFFFE2D6),
          label: _t(context, 'Calories', 'Calo'),
          value: _number(context, analysis.estimatedCalories),
          detail: _t(context, 'Estimated kcal', 'kcal ước tính'),
        ),
        Row(
          children: [
            Expanded(
              child: _MiniStatus(
                label: _t(context, 'Rest', 'Nghỉ'),
                value: '${analysis.restDays}',
                color: AppColors.info,
              ),
            ),
            Expanded(
              child: _MiniStatus(
                label: _t(context, 'Warnings', 'Cảnh báo'),
                value: '${analysis.warningDays}',
                color: analysis.warningDays > 0
                    ? AppColors.warning
                    : AppColors.success,
              ),
            ),
            Expanded(
              child: _MiniStatus(
                label: _t(context, 'Missed', 'Bỏ lỡ'),
                value: '${analysis.missedDays}',
                color: analysis.missedDays > 0
                    ? AppColors.danger
                    : AppColors.success,
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class _CompactStatRow extends StatelessWidget {
  const _CompactStatRow({
    required this.icon,
    required this.iconBg,
    required this.label,
    required this.value,
    required this.detail,
  });

  final IconData icon;
  final Color iconBg;
  final String label;
  final String value;
  final String detail;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      child: Row(
        children: [
          Container(
            width: 34,
            height: 34,
            decoration: BoxDecoration(
              color: iconBg,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(icon, color: AppColors.fg1, size: 19),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  detail,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 11),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Text(
            value,
            style: AppTypography.mono(17, weight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _MiniStatus extends StatelessWidget {
  const _MiniStatus({
    required this.label,
    required this.value,
    required this.color,
  });

  final String label;
  final String value;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: AppSpacing.sm,
          vertical: AppSpacing.md,
        ),
        decoration: BoxDecoration(
          color: color.withValues(alpha: 0.1),
          borderRadius: BorderRadius.circular(AppRadius.md),
        ),
        child: Column(
          children: [
            Text(
              value,
              style: AppTypography.mono(
                16,
                color: color,
                weight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.fg3,
                fontSize: 10,
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeaderCard extends StatelessWidget {
  const _HeaderCard({required this.dateRange});

  final String dateRange;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      color: AppColors.bg3.withValues(alpha: 0.74),
      border: Border.all(color: AppColors.border1.withValues(alpha: 0.45)),
      child: Row(
        children: [
          Container(
            width: 46,
            height: 46,
            decoration: BoxDecoration(
              color: AppColors.accent,
              borderRadius: BorderRadius.circular(AppRadius.lg),
            ),
            child: const Icon(
              Icons.insights_rounded,
              color: AppColors.fgOnClay,
              size: 28,
            ),
          ),
          const SizedBox(width: AppSpacing.xl),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _t(context, 'Week analysis', 'Phân tích tuần'),
                  style: AppTypography.display(
                    22,
                    weight: FontWeight.w500,
                    letterSpacing: 0,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: AppSpacing.sm),
                Text(
                  dateRange,
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
    );
  }
}

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.cards});

  final List<_MetricData> cards;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: cards.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: AppSpacing.lg,
        crossAxisSpacing: AppSpacing.lg,
        childAspectRatio: 1.18,
      ),
      itemBuilder: (_, index) => _MetricCard(data: cards[index]),
    );
  }
}

class _MetricData {
  const _MetricData({
    required this.icon,
    required this.iconBg,
    required this.title,
    required this.value,
    required this.subtitle,
  });

  final IconData icon;
  final Color iconBg;
  final String title;
  final String value;
  final String subtitle;
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({required this.data});

  final _MetricData data;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: data.iconBg,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Icon(data.icon, size: 22, color: AppColors.fg1),
          ),
          const Spacer(),
          Text(
            data.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            alignment: Alignment.centerLeft,
            child: Text(
              data.value,
              style: AppTypography.mono(20, weight: FontWeight.w500),
            ),
          ),
          const SizedBox(height: 2),
          Text(
            data.subtitle,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(color: AppColors.fg3, fontSize: 11),
          ),
        ],
      ),
    );
  }
}

class _RecommendationsCard extends StatelessWidget {
  const _RecommendationsCard({required this.recommendations});

  final List<WeekRecommendation> recommendations;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.offline_bolt_outlined,
            title: AppLocalizations.of(
              context,
            ).trainingWeekRecommendationsTitle,
          ),
          const SizedBox(height: AppSpacing.md),
          for (final recommendation in recommendations) ...[
            _RecommendationTile(recommendation: recommendation),
            if (recommendation != recommendations.last)
              const SizedBox(height: AppSpacing.md),
          ],
        ],
      ),
    );
  }
}

class _RecommendationTile extends StatelessWidget {
  const _RecommendationTile({required this.recommendation});

  final WeekRecommendation recommendation;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final (bg, border, iconColor, icon) = switch (recommendation.tone) {
      WeekRecommendationTone.danger => (
        AppColors.dangerBg,
        AppColors.danger.withValues(alpha: 0.28),
        AppColors.danger,
        Icons.warning_amber_rounded,
      ),
      WeekRecommendationTone.warning => (
        AppColors.warningBg,
        AppColors.warning.withValues(alpha: 0.24),
        AppColors.warning,
        Icons.error_outline_rounded,
      ),
      WeekRecommendationTone.info => (
        AppColors.successBg,
        AppColors.success.withValues(alpha: 0.18),
        AppColors.success,
        Icons.check_circle_outline_rounded,
      ),
    };

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: bg.withValues(alpha: 0.58),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(icon, color: iconColor, size: 20),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Text(
                  _recommendationTitle(recommendation, l10n),
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            _recommendationBody(recommendation, l10n),
            style: const TextStyle(color: AppColors.fg2, height: 1.35),
          ),
          const SizedBox(height: AppSpacing.md),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(
              horizontal: AppSpacing.md,
              vertical: AppSpacing.sm,
            ),
            decoration: BoxDecoration(
              color: AppColors.bg2.withValues(alpha: 0.72),
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Text(
              _recommendationDetail(recommendation, l10n),
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

String _recommendationTitle(
  WeekRecommendation recommendation,
  AppLocalizations l10n,
) => switch (recommendation.type) {
  WeekRecommendationType.lowCompletion => l10n.trainingWeekLowCompletionTitle,
  WeekRecommendationType.lowVolume => l10n.trainingWeekLowVolumeTitle,
  WeekRecommendationType.highEffort => l10n.trainingWeekHighEffortTitle,
  WeekRecommendationType.missedDays => l10n.trainingWeekMissedDaysTitle,
  WeekRecommendationType.onTrack => l10n.trainingWeekOnTrackTitle,
};

String _recommendationBody(
  WeekRecommendation recommendation,
  AppLocalizations l10n,
) => switch (recommendation.type) {
  WeekRecommendationType.lowCompletion => l10n.trainingWeekLowCompletionBody,
  WeekRecommendationType.lowVolume => l10n.trainingWeekLowVolumeBody,
  WeekRecommendationType.highEffort => l10n.trainingWeekHighEffortBody,
  WeekRecommendationType.missedDays => l10n.trainingWeekMissedDaysBody,
  WeekRecommendationType.onTrack => l10n.trainingWeekOnTrackBody,
};

String _recommendationDetail(
  WeekRecommendation recommendation,
  AppLocalizations l10n,
) => switch (recommendation.type) {
  WeekRecommendationType.lowCompletion => l10n.trainingWeekCompletionDetail(
    recommendation.percent ?? 0,
  ),
  WeekRecommendationType.lowVolume => l10n.trainingWeekVolumeDetail(
    recommendation.percent ?? 0,
  ),
  WeekRecommendationType.highEffort => l10n.trainingWeekAverageRpeDetail(
    (recommendation.rpe ?? 0).toStringAsFixed(1),
  ),
  WeekRecommendationType.missedDays => l10n.trainingWeekMissedDaysDetail(
    recommendation.count ?? 0,
  ),
  WeekRecommendationType.onTrack => l10n.trainingWeekNoMajorWarningDetail,
};

class _CompletionCard extends StatelessWidget {
  const _CompletionCard({
    required this.completionRate,
    required this.volumeRate,
    required this.actualVolume,
    required this.plannedVolume,
  });

  final double completionRate;
  final double volumeRate;
  final double actualVolume;
  final double plannedVolume;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.donut_large_rounded,
            title: _t(context, 'Completion', 'Hoàn thành'),
          ),
          const SizedBox(height: AppSpacing.xl),
          Center(
            child: SizedBox(
              width: 136,
              height: 136,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox.expand(
                    child: CircularProgressIndicator(
                      value: completionRate,
                      strokeWidth: 16,
                      backgroundColor: AppColors.bg3.withValues(alpha: 0.42),
                      color: AppColors.accent,
                    ),
                  ),
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        '${(completionRate * 100).round()}%',
                        style: AppTypography.mono(
                          29,
                          weight: FontWeight.w500,
                        ),
                      ),
                      Text(
                        _t(context, 'Complete', 'Hoàn thành'),
                        style: const TextStyle(
                          color: AppColors.fg2,
                          fontSize: 11,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          _VolumeLine(
            label: _t(context, 'Actual', 'Thực tế'),
            value: _formatVolume(context, actualVolume),
            percent: volumeRate,
            color: AppColors.accent,
          ),
          const SizedBox(height: AppSpacing.md),
          _VolumeLine(
            label: _t(context, 'Plan', 'Kế hoạch'),
            value: _formatVolume(context, plannedVolume),
            percent: plannedVolume <= 0 ? 0 : 1,
            color: AppColors.bg4,
          ),
        ],
      ),
    );
  }
}

class _VolumeLine extends StatelessWidget {
  const _VolumeLine({
    required this.label,
    required this.value,
    required this.percent,
    required this.color,
  });

  final String label;
  final String value;
  final double percent;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              label,
              style: const TextStyle(
                color: AppColors.fg1,
                fontWeight: FontWeight.w500,
              ),
            ),
            const Spacer(),
            Text(
              value,
              style: AppTypography.mono(12, weight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: XnAnimatedLinearProgress(
            value: percent.clamp(0.0, 1.0),
            minHeight: 10,
            backgroundColor: AppColors.bg3.withValues(alpha: 0.38),
            color: color,
          ),
        ),
      ],
    );
  }
}

class _VolumePerDayCard extends StatelessWidget {
  const _VolumePerDayCard({required this.days});

  final List<DayAnalysis> days;

  @override
  Widget build(BuildContext context) {
    final actual = days.fold<double>(0, (sum, day) => sum + day.actualVolume);
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _SectionTitle(
                  icon: Icons.stacked_bar_chart_rounded,
                  title: _t(
                    context,
                    'Volume per day (${_volumeUnitCaption(context, separator: ' · ')})',
                    'Khối lượng mỗi ngày (${_volumeUnitCaption(context, separator: ' · ')})',
                  ),
                ),
              ),
              Text(
                _t(
                  context,
                  'Actual: ${_formatVolume(context, actual)}',
                  'Thực tế: ${_formatVolume(context, actual)}',
                ),
                style: AppTypography.mono(
                  11,
                  color: AppColors.fg1,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          GroupedBarChart(
            seriesALabel: _t(context, 'Planned', 'Kế hoạch'),
            seriesBLabel: _t(context, 'Actual', 'Thực tế'),
            seriesAColor: AppColors.bg4.withValues(alpha: 0.42),
            seriesBColor: AppColors.accent,
            height: 176,
            data: [
              for (final day in days)
                GroupedBarDatum(
                  label: _dayChartLabel(context, day),
                  valueA: day.plannedVolume,
                  valueB: day.actualVolume,
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CaloriesPerDayCard extends StatelessWidget {
  const _CaloriesPerDayCard({required this.days});

  final List<DayAnalysis> days;

  @override
  Widget build(BuildContext context) {
    final total = days.fold<int>(
      0,
      (sum, day) => sum + day.estimatedCalories,
    );
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: _SectionTitle(
                  icon: Icons.local_fire_department_outlined,
                  title: _t(
                    context,
                    'Estimated calories per day',
                    'Calo ước tính mỗi ngày',
                  ),
                ),
              ),
              Text(
                _t(
                  context,
                  '${_number(context, total)} kcal',
                  '${_number(context, total)} kcal',
                ),
                style: AppTypography.mono(
                  11,
                  color: AppColors.fg1,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          _SingleSeriesBarChart(
            bars: [
              for (final day in days)
                _SingleBarDatum(
                  label: _dayChartLabel(context, day),
                  value: day.estimatedCalories.toDouble(),
                ),
            ],
            color: AppColors.bg4,
          ),
        ],
      ),
    );
  }
}

class _MuscleFocusCard extends StatelessWidget {
  const _MuscleFocusCard({required this.points});

  final List<MuscleFocusPoint> points;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.fitness_center_rounded,
            title: _t(context, 'Muscle group focus', 'Nhóm cơ trọng tâm'),
          ),
          const SizedBox(height: AppSpacing.md),
          if (points.isEmpty)
            Text(
              _t(
                context,
                'No planned volume for muscle groups yet.',
                'Chưa có khối lượng theo nhóm cơ.',
              ),
              style: const TextStyle(color: AppColors.fg3),
            )
          else
            for (final (index, point) in points.indexed) ...[
              _MuscleFocusRow(point: point, color: _muscleColor(index)),
              if (point != points.last) const SizedBox(height: AppSpacing.md),
            ],
          if (points.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.xl),
            Wrap(
              spacing: AppSpacing.sm,
              runSpacing: AppSpacing.sm,
              children: [
                for (final (index, point) in points.indexed)
                  _MusclePill(
                    label: point.muscleGroup,
                    color: _muscleColor(index),
                  ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _MuscleFocusRow extends StatelessWidget {
  const _MuscleFocusRow({required this.point, required this.color});

  final MuscleFocusPoint point;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                point.muscleGroup,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '${point.percentOfTotal.round()}%',
              style: AppTypography.mono(12, weight: FontWeight.w500),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: XnAnimatedLinearProgress(
            value: (point.percentOfTotal / 100).clamp(0.0, 1.0),
            minHeight: 7,
            backgroundColor: AppColors.bg3.withValues(alpha: 0.22),
            color: color,
          ),
        ),
      ],
    );
  }
}

class _MusclePill extends StatelessWidget {
  const _MusclePill({required this.label, required this.color});

  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: AppColors.fg1,
          fontSize: 12,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SingleBarDatum {
  const _SingleBarDatum({required this.label, required this.value});

  final String label;
  final double value;
}

class _SingleSeriesBarChart extends StatelessWidget {
  const _SingleSeriesBarChart({required this.bars, required this.color});

  final List<_SingleBarDatum> bars;
  final Color color;

  @override
  Widget build(BuildContext context) {
    if (bars.isEmpty) {
      return SizedBox(
        height: 160,
        child: Center(
          child: Text(
            _t(context, 'No data yet', 'Chưa có dữ liệu'),
            style: const TextStyle(color: AppColors.fg3),
          ),
        ),
      );
    }

    return LayoutBuilder(
      builder: (context, constraints) {
        final slot = constraints.maxWidth / bars.length;
        final scrollable = slot < 48;
        final width = scrollable ? bars.length * 48.0 : constraints.maxWidth;
        final chart = SizedBox(
          width: width,
          height: 176,
          child: CustomPaint(painter: _SingleBarPainter(bars, color)),
        );
        if (!scrollable) return chart;
        return SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          physics: const BouncingScrollPhysics(),
          child: chart,
        );
      },
    );
  }
}

class _SingleBarPainter extends CustomPainter {
  _SingleBarPainter(this.bars, this.color);

  final List<_SingleBarDatum> bars;
  final Color color;

  static const _labelArea = 20.0;
  static const _topArea = 12.0;

  @override
  void paint(Canvas canvas, Size size) {
    final maxValue = bars.fold<double>(
      0,
      (max, bar) => bar.value > max ? bar.value : max,
    );
    final plotHeight = size.height - _labelArea - _topArea;
    final slot = size.width / bars.length;
    final baseline = _topArea + plotHeight;
    final gridPaint = Paint()
      ..color = AppColors.surfaceBorderSoft.withValues(alpha: 0.58)
      ..strokeWidth = 1;

    for (var i = 0; i <= 3; i++) {
      final y = _topArea + plotHeight * i / 3;
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final barPaint = Paint()..color = color;
    for (var i = 0; i < bars.length; i++) {
      final bar = bars[i];
      final ratio = maxValue <= 0 ? 0.0 : bar.value / maxValue;
      final barHeight = plotHeight * ratio;
      final width = (slot * 0.34).clamp(8.0, 28.0);
      final left = slot * i + (slot - width) / 2;
      if (barHeight > 0) {
        canvas.drawRRect(
          RRect.fromLTRBR(
            left,
            baseline - barHeight,
            left + width,
            baseline,
            Radius.circular(width / 2),
          ),
          barPaint,
        );
      }
      _paintText(canvas, bar.label, slot * i + slot / 2, baseline + 4, slot);
    }
  }

  void _paintText(
    Canvas canvas,
    String text,
    double centerX,
    double top,
    double maxWidth,
  ) {
    final painter = TextPainter(
      text: TextSpan(
        text: text,
        style: AppTypography.mono(10, color: AppColors.fg3),
      ),
      textAlign: TextAlign.center,
      textDirection: TextDirection.ltr,
      maxLines: 1,
      ellipsis: '...',
    )..layout(maxWidth: maxWidth);
    painter.paint(canvas, Offset(centerX - painter.width / 2, top));
  }

  @override
  bool shouldRepaint(_SingleBarPainter oldDelegate) =>
      oldDelegate.bars != bars || oldDelegate.color != color;
}

class _DailyVolumeCard extends StatelessWidget {
  const _DailyVolumeCard({required this.days});

  final List<DayAnalysis> days;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _SectionTitle(
            icon: Icons.bar_chart_rounded,
            title: _t(context, 'Daily volume', 'Khối lượng mỗi ngày'),
          ),
          const SizedBox(height: AppSpacing.md),
          if (days.isEmpty)
            Text(
              _t(
                context,
                'No days in this week.',
                'Tuần này chưa có ngày tập.',
              ),
              style: const TextStyle(color: AppColors.fg3),
            )
          else
            for (final day in days) ...[
              _DailyVolumeTile(day: day),
              if (day != days.last) const SizedBox(height: AppSpacing.sm),
            ],
        ],
      ),
    );
  }
}

class _DailyVolumeTile extends StatelessWidget {
  const _DailyVolumeTile({required this.day});

  final DayAnalysis day;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toString();
    final rate = day.volumeRate.clamp(0.0, 1.0);
    final borderColor = day.day.hasWarning
        ? AppColors.warning.withValues(alpha: 0.45)
        : AppColors.surfaceBorderSoft;
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg2.withValues(alpha: 0.78),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: borderColor),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  '${DateLabels.weekday(day.day.date, locale)} '
                  '${day.day.date.day}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontSize: 15,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                _t(
                  context,
                  'Plan: ${_formatVolume(context, day.plannedVolume)}',
                  'Kế hoạch: ${_formatVolume(context, day.plannedVolume)}',
                ),
                style: AppTypography.mono(
                  11,
                  color: AppColors.fg2,
                  weight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: 2),
          Text(
            day.day.isRest
                ? _t(context, 'Rest day', 'Ngày nghỉ')
                : DateOnly.format(day.day.date),
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                  child: XnAnimatedLinearProgress(
                    value: rate,
                    minHeight: 11,
                    backgroundColor: AppColors.bg3.withValues(alpha: 0.38),
                    color: day.day.isCompleted
                        ? AppColors.success
                        : AppColors.accent,
                  ),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Text(
                '${(day.volumeRate * 100).round()}%',
                style: AppTypography.mono(13, weight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: _MiniStat(
                  label: _t(context, 'Actual', 'Thực tế'),
                  value: _formatVolume(context, day.actualVolume),
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              _MiniStat(
                label: _t(context, 'Done', 'Hoàn t.'),
                value: '${(day.completionRate * 100).round()}%',
              ),
              if (_PrefsScope.trackRpeOf(context)) ...[
                const SizedBox(width: AppSpacing.sm),
                _MiniStat(
                  label: 'RPE',
                  value: day.averageRpe?.toStringAsFixed(1) ?? '—',
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniStat extends StatelessWidget {
  const _MiniStat({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: const BoxConstraints(minWidth: 62),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.bgPage.withValues(alpha: 0.48),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Column(
        children: [
          Text(
            label,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 10,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 2),
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              value,
              style: AppTypography.mono(12, weight: FontWeight.w500),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.icon, required this.title});

  final IconData icon;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, color: AppColors.accent, size: 18),
        const SizedBox(width: AppSpacing.sm),
        Expanded(
          child: Text(
            title,
            style: const TextStyle(
              color: AppColors.fg1,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

String _t(BuildContext context, String en, String vi) =>
    Localizations.localeOf(context).languageCode == 'vi' ? vi : en;

String _dateRange(WeekAnalysis analysis) {
  final start = analysis.startDate;
  final end = analysis.endDate;
  if (start == null || end == null) return '';
  return '${DateOnly.format(start)} – ${DateOnly.format(end)}';
}

String _dayChartLabel(BuildContext context, DayAnalysis day) {
  final locale = Localizations.localeOf(context).toString();
  return '${DateLabels.weekdayShort(day.day.date, locale)} '
      '${day.day.date.day}';
}

Color _muscleColor(int index) {
  const colors = [
    Color(0xFF6D5DF6),
    Color(0xFFE68A00),
    Color(0xFF18BDAA),
    Color(0xFF22B96E),
    Color(0xFFA9836D),
    Color(0xFF0DAAC1),
    Color(0xFF8E735C),
    Color(0xFFD92355),
    Color(0xFFE84798),
    Color(0xFF8855E7),
  ];
  return colors[index % colors.length];
}

/// "kg · reps" / "lb · lần" — volume is weight × reps, so the unit half
/// follows the preference while the reps half follows the language.
String _volumeUnitCaption(BuildContext context, {required String separator}) {
  final unit = _PrefsScope.unitOf(context).suffix;
  return '$unit$separator${_t(context, 'reps', 'lần')}';
}

String _formatVolume(BuildContext context, double value) =>
    _number(context, _PrefsScope.unitOf(context).fromKg(value).round());

String _number(BuildContext context, num value) {
  final locale = Localizations.localeOf(context).toLanguageTag();
  return intl.NumberFormat.decimalPattern(locale).format(value);
}

String _formatDuration(BuildContext context, int seconds) {
  if (seconds < 60) return '${seconds}s';
  final minutes = seconds ~/ 60;
  final rest = seconds % 60;
  if (minutes < 60) return rest == 0 ? '${minutes}m' : '${minutes}m ${rest}s';
  final hours = minutes ~/ 60;
  final minuteRest = minutes % 60;
  return minuteRest == 0 ? '${hours}h' : '${hours}h ${minuteRest}m';
}
