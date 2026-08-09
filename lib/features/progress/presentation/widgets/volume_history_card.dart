import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/domain/entities/volume_history_point.dart';

class VolumeHistoryCard extends StatelessWidget {
  const VolumeHistoryCard({
    required this.points,
    required this.unit,
    required this.months,
    required this.onMonthsChanged,
    super.key,
  });

  final List<VolumeHistoryPoint> points;
  final WeightUnit unit;
  final int months;
  final ValueChanged<int> onMonthsChanged;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final values = points.map((point) => unit.fromKg(point.volumeKg)).toList();
    final hasData = values.any((value) => value > 0);
    final maxValue = values.fold<double>(1, (a, b) => b > a ? b : a);

    return XnSectionGroup(
      children: [
        Row(
          children: [
            const Icon(Icons.trending_up_rounded, color: AppColors.accent),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                l10n.progressVolumeHistoryTitle,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
            DropdownButton<int>(
              value: months,
              underline: const SizedBox.shrink(),
              onChanged: (value) {
                if (value != null) onMonthsChanged(value);
              },
              items: [
                for (final value in const [3, 6, 12, 24])
                  DropdownMenuItem(
                    value: value,
                    child: Text(l10n.progressVolumeMonths(value)),
                  ),
              ],
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.progressVolumeHistorySubtitle(unit.suffix),
          style: const TextStyle(color: AppColors.fg3, fontSize: 12),
        ),
        const SizedBox(height: AppSpacing.lg),
        if (!hasData)
          SizedBox(
            height: 160,
            child: Center(
              child: Text(
                l10n.progressVolumeHistoryEmpty,
                style: const TextStyle(color: AppColors.fg3),
              ),
            ),
          )
        else
          SizedBox(
            height: 190,
            child: BarChart(
              BarChartData(
                maxY: maxValue * 1.15,
                minY: 0,
                borderData: FlBorderData(show: false),
                gridData: const FlGridData(show: false),
                titlesData: FlTitlesData(
                  leftTitles: const AxisTitles(),
                  topTitles: const AxisTitles(),
                  rightTitles: const AxisTitles(),
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        if (index < 0 || index >= points.length) {
                          return const SizedBox.shrink();
                        }
                        final point = points[index];
                        return Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            '${point.month}/${point.year % 100}',
                            style: AppTypography.mono(9, color: AppColors.fg3),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                barGroups: [
                  for (var i = 0; i < values.length; i++)
                    BarChartGroupData(
                      x: i,
                      barRods: [
                        BarChartRodData(
                          toY: values[i],
                          width: values.length > 12 ? 6 : 12,
                          color: AppColors.danger,
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
    );
  }
}
