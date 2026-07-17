import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/config/app_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../domain/entities/exercise_pr.dart';
import '../providers/progress_controllers.dart';
import 'pr_line_chart.dart';

/// Bottom sheet showing the PR progression for one exercise, with a share
/// action that copies the public PR link to the clipboard.
class PrHistorySheet extends ConsumerWidget {
  const PrHistorySheet({required this.pr, super.key});

  final ExercisePr pr;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(exercisePrHistoryProvider(pr.exerciseTemplateId));

    return DraggableScrollableSheet(
      expand: false,
      initialChildSize: 0.7,
      maxChildSize: 0.92,
      builder: (context, scrollController) => Container(
        decoration: const BoxDecoration(
          color: AppColors.bgPage,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppRadius.xl),
          ),
        ),
        child: ListView(
          controller: scrollController,
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            Center(
              child: Container(
                width: 36,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.border1,
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
              ),
            ),
            const SizedBox(height: AppSpacing.lg),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        pr.exerciseName,
                        style: AppTypography.display(20, letterSpacing: 0),
                      ),
                      const SizedBox(height: 4),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.baseline,
                        textBaseline: TextBaseline.alphabetic,
                        children: [
                          Text(
                            _compact(pr.currentWeight),
                            style: AppTypography.display(28),
                          ),
                          const SizedBox(width: 4),
                          const Text(
                            'kg',
                            style: TextStyle(color: AppColors.fg3),
                          ),
                          const SizedBox(width: AppSpacing.sm),
                          Text(
                            '× ${pr.reps}',
                            style: AppTypography.mono(14, color: AppColors.fg3),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                IconButton.filledTonal(
                  tooltip: AppLocalizations.of(context).progressSharePrTooltip,
                  icon: const Icon(Icons.ios_share_rounded),
                  onPressed: () => _share(context, ref),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.lg),
            _historySection(context, history),
          ],
        ),
      ),
    );
  }

  Widget _historySection(
    BuildContext context,
    AsyncValue<List<ExercisePrPoint>> history,
  ) {
    final l10n = AppLocalizations.of(context);
    final points = history.value;
    if (points == null) {
      if (history.hasError) {
        return SizedBox(
          height: 120,
          child: Center(
            child: Text(
              l10n.progressHistoryLoadError,
              style: const TextStyle(color: AppColors.fg3),
            ),
          ),
        );
      }
      return const SizedBox(
        height: 160,
        child: Center(child: CircularProgressIndicator()),
      );
    }
    if (points.length < 2) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xl),
        child: Center(
          child: Text(
            l10n.progressKeepLoggingTrend,
            style: const TextStyle(color: AppColors.fg3),
          ),
        ),
      );
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(l10n.progressProgressionTitle, style: _eyebrow),
        const SizedBox(height: AppSpacing.md),
        PrLineChart(points: points),
        const SizedBox(height: AppSpacing.lg),
        for (final p in points.reversed) _HistoryRow(point: p),
      ],
    );
  }

  Future<void> _share(BuildContext context, WidgetRef ref) async {
    final userId = ref.read(authControllerProvider).sessionOrNull?.user.id;
    if (userId == null) return;

    final api = Uri.parse(AppConfig.apiBaseUrl);
    final origin = '${api.scheme}://${api.authority}';
    final link = '$origin/api/share/pr/$userId/${pr.exerciseTemplateId}';

    await Clipboard.setData(ClipboardData(text: link));
    if (!context.mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).progressPrCopiedSnackbar),
        ),
      );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.point});

  final ExercisePrPoint point;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          const Icon(
            Icons.emoji_events_outlined,
            size: 18,
            color: AppColors.accent2,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              '${_compact(point.weight)} kg × ${point.reps}',
              style: AppTypography.mono(13),
            ),
          ),
          Text(
            _formatDate(point.achievedAt, locale),
            style: AppTypography.mono(12, color: AppColors.fg3),
          ),
        ],
      ),
    );
  }
}

const _eyebrow = TextStyle(
  color: AppColors.fg3,
  fontSize: 11,
  fontWeight: FontWeight.w500,
  letterSpacing: 0.7,
);

String _compact(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

String _formatDate(DateTime d, String locale) =>
    DateFormat.yMMMd(locale).format(d.toLocal());
