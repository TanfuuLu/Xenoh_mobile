import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/current_date_provider.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/nutrition_summary.dart';
import '../providers/nutrition_controller.dart';

class NutritionHistoryScreen extends ConsumerStatefulWidget {
  const NutritionHistoryScreen({super.key});

  static const contentKey = Key('nutrition-history-content');

  @override
  ConsumerState<NutritionHistoryScreen> createState() =>
      _NutritionHistoryScreenState();
}

class _NutritionHistoryScreenState
    extends ConsumerState<NutritionHistoryScreen> {
  DateTimeRange? _range;

  @override
  Widget build(BuildContext context) {
    final today = ref.watch(currentDateProvider);
    final range =
        _range ??
        DateTimeRange(
          start: today.subtract(const Duration(days: 29)),
          end: today,
        );
    final history = ref.watch(
      nutritionHistoryProvider((from: range.start, to: range.end)),
    );
    final l10n = AppLocalizations.of(context);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.nutritionHistoryTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.refresh(
          nutritionHistoryProvider((from: range.start, to: range.end)).future,
        ),
        child: ListView(
          key: NutritionHistoryScreen.contentKey,
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            OutlinedButton.icon(
              onPressed: () => _pickRange(range, today),
              icon: const Icon(Icons.date_range_outlined),
              label: Text(
                '${DateOnly.format(range.start)} — ${DateOnly.format(range.end)}',
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            switch (history) {
              AsyncData(:final value) when value.isEmpty => XnSectionGroup(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(AppSpacing.lg),
                    child: Text(
                      l10n.nutritionHistoryEmpty,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.fg3),
                    ),
                  ),
                ],
              ),
              AsyncData(:final value) => _HistoryContent(logs: value),
              AsyncError(:final error) => SizedBox(
                height: 420,
                child: ErrorView.from(
                  error,
                  context,
                  onRetry: () => ref.invalidate(
                    nutritionHistoryProvider((
                      from: range.start,
                      to: range.end,
                    )),
                  ),
                ),
              ),
              _ => const SizedBox(
                height: 320,
                child: Center(child: CircularProgressIndicator()),
              ),
            },
          ],
        ),
      ),
    );
  }

  Future<void> _pickRange(DateTimeRange current, DateTime today) async {
    final selected = await showDateRangePicker(
      context: context,
      initialDateRange: current,
      firstDate: DateTime(2020),
      lastDate: today,
    );
    if (selected == null || !mounted) return;
    setState(
      () => _range = DateTimeRange(
        start: DateOnly.truncate(selected.start),
        end: DateOnly.truncate(selected.end),
      ),
    );
  }
}

class _HistoryContent extends StatelessWidget {
  const _HistoryContent({required this.logs});

  final List<NutritionDailyLog> logs;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final ordered = [...logs]..sort((a, b) => a.date.compareTo(b.date));
    final average =
        ordered.fold<int>(0, (sum, log) => sum + log.calories) / ordered.length;
    final maximum = ordered
        .map((log) => log.calories)
        .fold<int>(1, (current, value) => value > current ? value : current);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        XnSectionGroup(
          children: [
            Text(
              l10n.nutritionHistoryAverage,
              style: const TextStyle(color: AppColors.fg3),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${average.round()} kcal',
              style: AppTypography.mono(24, weight: FontWeight.w600),
            ),
            const SizedBox(height: AppSpacing.lg),
            SizedBox(
              height: 190,
              child: BarChart(
                BarChartData(
                  maxY: maximum * 1.15,
                  minY: 0,
                  borderData: FlBorderData(show: false),
                  gridData: const FlGridData(show: false),
                  titlesData: const FlTitlesData(
                    leftTitles: AxisTitles(),
                    topTitles: AxisTitles(),
                    rightTitles: AxisTitles(),
                    bottomTitles: AxisTitles(),
                  ),
                  barGroups: [
                    for (var i = 0; i < ordered.length; i++)
                      BarChartGroupData(
                        x: i,
                        barRods: [
                          BarChartRodData(
                            toY: ordered[i].calories.toDouble(),
                            width: ordered.length > 20 ? 5 : 10,
                            color: AppColors.accent,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        XnCardStack(
          children: [
            for (final log in ordered.reversed)
              XnSection(
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            DateOnly.format(log.date),
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'P ${log.proteinG.round()}g  ·  C ${log.carbsG.round()}g  ·  F ${log.fatG.round()}g',
                            style: const TextStyle(
                              color: AppColors.fg3,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Text(
                      '${log.calories} kcal',
                      style: AppTypography.mono(14, weight: FontWeight.w600),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ],
    );
  }
}
