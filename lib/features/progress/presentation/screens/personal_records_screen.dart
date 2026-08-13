import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../domain/entities/exercise_pr.dart';
import '../providers/progress_controllers.dart';
import '../widgets/pr_history_sheet.dart';

/// Personal records across all exercises. Tap a record to see its progression
/// and share it.
class PersonalRecordsScreen extends ConsumerWidget {
  const PersonalRecordsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final prs = ref.watch(exercisePrsProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.progressPersonalRecordsTitle)),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.refresh(exercisePrsProvider.future),
        child: AsyncValueView(
          value: prs,
          onRetry: () => ref.invalidate(exercisePrsProvider),
          data: (items) {
            if (items.isEmpty) return const _EmptyPrs();
            return ListView(
              padding: const EdgeInsets.all(AppSpacing.lg),
              children: [
                XnCardStack(
                  children: [
                    for (final item in items)
                      _PrCard(
                        pr: item,
                        onTap: () => _openHistory(context, item),
                      ),
                  ],
                ),
              ],
            );
          },
        ),
      ),
    );
  }

  void _openHistory(BuildContext context, ExercisePr pr) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        backgroundColor: Colors.transparent,
        builder: (_) => PrHistorySheet(pr: pr),
      ),
    );
  }
}

class _PrCard extends StatelessWidget {
  const _PrCard({required this.pr, required this.onTap});

  final ExercisePr pr;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final locale = Localizations.localeOf(context).toLanguageTag();
    return XnSection(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: const BoxDecoration(
              color: AppColors.accentSoft,
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.emoji_events_rounded,
              color: AppColors.accent,
              size: 20,
            ),
          ),
          const SizedBox(width: AppSpacing.md),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  pr.exerciseName,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.display(16, letterSpacing: 0),
                ),
                const SizedBox(height: 2),
                Text(
                  '${pr.reps} rep${pr.reps == 1 ? '' : 's'} - ${_formatDate(pr.achievedAt, locale)}',
                  style: AppTypography.mono(11, color: AppColors.fg3),
                ),
              ],
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                _compact(pr.currentWeight),
                style: AppTypography.display(22),
              ),
              const SizedBox(width: 3),
              const Text(
                'kg',
                style: TextStyle(color: AppColors.fg3, fontSize: 12),
              ),
            ],
          ),
          const SizedBox(width: AppSpacing.xs),
          const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
        ],
      ),
    );
  }
}

class _EmptyPrs extends StatelessWidget {
  const _EmptyPrs();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      children: [
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.7,
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(
                    Icons.emoji_events_outlined,
                    size: 48,
                    color: AppColors.fg4,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.progressNoPersonalRecordsTitle,
                    style: const TextStyle(
                      color: AppColors.fg2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.progressNoPersonalRecordsMessage,
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.fg3),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}

String _compact(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);

String _formatDate(DateTime d, String locale) =>
    DateFormat.yMMMd(locale).format(d.toLocal());
