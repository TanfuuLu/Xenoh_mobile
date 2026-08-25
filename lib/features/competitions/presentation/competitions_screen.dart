import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_card.dart';
import '../../../l10n/app_localizations.dart';
import 'competition_labels.dart';
import 'competition_providers.dart';

class CompetitionsScreen extends ConsumerStatefulWidget {
  const CompetitionsScreen({super.key});
  @override
  ConsumerState<CompetitionsScreen> createState() => _CompetitionsScreenState();
}

class _CompetitionsScreenState extends ConsumerState<CompetitionsScreen> {
  String? _discipline;
  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(competitionsProvider(_discipline));
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.competitionsTitle),
        actions: [
          IconButton(
            tooltip: l10n.competitionsMine,
            onPressed: () => context.push('/competitions/mine'),
            icon: const Icon(Icons.assignment_ind_outlined),
          ),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: SegmentedButton<String?>(
              segments: [
                ButtonSegment(value: null, label: Text(l10n.commonAll)),
                ButtonSegment(
                  value: 'Powerlifting',
                  label: Text(l10n.competitionDisciplinePowerlifting),
                ),
                ButtonSegment(
                  value: 'Bodybuilding',
                  label: Text(l10n.competitionDisciplineBodybuilding),
                ),
              ],
              selected: {_discipline},
              onSelectionChanged: (value) =>
                  setState(() => _discipline = value.first),
            ),
          ),
          Expanded(
            child: AsyncValueView(
              value: data,
              onRetry: () => ref.invalidate(competitionsProvider(_discipline)),
              data: (events) => RefreshIndicator(
                color: AppColors.accent,
                onRefresh: () =>
                    ref.refresh(competitionsProvider(_discipline).future),
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: events.isEmpty
                      ? [
                          SizedBox(
                            height: 320,
                            child: Center(child: Text(l10n.competitionsEmpty)),
                          ),
                        ]
                      : [
                          for (final event in events) ...[
                            XnCard(
                              onTap: () =>
                                  context.push('/competitions/${event.slug}'),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Expanded(
                                        child: Text(
                                          event.title,
                                          style: Theme.of(
                                            context,
                                          ).textTheme.titleLarge,
                                        ),
                                      ),
                                      Chip(
                                        label: Text(
                                          competitionEventStatusLabel(
                                            l10n,
                                            event.status,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  const SizedBox(height: AppSpacing.sm),
                                  Text(
                                    '${competitionDisciplineLabel(l10n, event.discipline)} · ${event.venueName}',
                                  ),
                                  const SizedBox(height: AppSpacing.xs),
                                  Text(
                                    '${event.confirmedCount}/${event.capacity} · ${event.registrationFee.toStringAsFixed(0)} ${event.currency}',
                                    style: const TextStyle(
                                      color: AppColors.fg3,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: AppSpacing.md),
                          ],
                        ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
