import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/xn_progress.dart';

class WeeklyCompletionDatum {
  const WeeklyCompletionDatum({
    required this.label,
    required this.completed,
    required this.total,
  });

  final String label;
  final int completed;
  final int total;

  double get ratio => total <= 0 ? 0 : (completed / total).clamp(0, 1);
  int get percentage => (ratio * 100).round();
}

/// Compact weekly completion chart where the full track represents the plan
/// and the filled track represents completed training days.
class WeeklyCompletionChart extends StatelessWidget {
  const WeeklyCompletionChart({required this.data, super.key});

  final List<WeeklyCompletionDatum> data;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < data.length; index++) ...[
          _CompletionRow(datum: data[index]),
          if (index != data.length - 1) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _CompletionRow extends StatelessWidget {
  const _CompletionRow({required this.datum});

  final WeeklyCompletionDatum datum;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label:
          '${datum.label}: ${datum.completed}/${datum.total}, ${datum.percentage}%',
      child: Row(
        children: [
          SizedBox(
            width: 30,
            child: Text(
              datum.label,
              style: const TextStyle(
                color: AppColors.fg1,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(AppRadius.pill),
              child: XnAnimatedLinearProgress(
                value: datum.ratio,
                minHeight: 9,
                backgroundColor: AppColors.clay100,
                color: AppColors.sage700,
              ),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          SizedBox(
            width: 28,
            child: Text(
              '${datum.completed}/${datum.total}',
              textAlign: TextAlign.right,
              style: AppTypography.mono(11, color: AppColors.fg2),
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Container(
            width: 42,
            padding: const EdgeInsets.symmetric(vertical: 3),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: datum.ratio >= 1 ? AppColors.successBg : AppColors.bg3,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: Text(
              '${datum.percentage}%',
              style: AppTypography.mono(
                10,
                weight: FontWeight.w600,
                color: datum.ratio >= 1 ? AppColors.success : AppColors.fg2,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
