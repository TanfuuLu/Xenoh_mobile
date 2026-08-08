import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../app/theme/app_typography.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/challenge_models.dart';
import 'challenge_providers.dart';

class ChallengesScreen extends ConsumerWidget {
  const ChallengesScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: Text(l10n.challengesTitle),
          actions: [
            IconButton(
              tooltip: l10n.challengesCreate,
              onPressed: () =>
                  unawaited(context.push('/community/challenges/create')),
              icon: const Icon(Icons.add_rounded),
            ),
          ],
          bottom: TabBar(
            tabs: [
              Tab(text: l10n.challengesMineTab),
              Tab(text: l10n.challengesDiscoverTab),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            _ChallengeList<Challenge>(
              value: ref.watch(myChallengesProvider),
              onRetry: () => ref.invalidate(myChallengesProvider),
            ),
            _ChallengeList<ChallengeSummary>(
              value: ref.watch(discoverChallengesProvider),
              onRetry: () => ref.invalidate(discoverChallengesProvider),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChallengeList<T extends ChallengeSummary> extends StatelessWidget {
  const _ChallengeList({required this.value, required this.onRetry});

  final AsyncValue<List<T>> value;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AsyncValueView(
      value: value,
      onRetry: onRetry,
      data: (items) => RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async => onRetry(),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: items.isEmpty
              ? [
                  SizedBox(
                    height: 360,
                    child: Center(child: Text(l10n.challengesEmpty)),
                  ),
                ]
              : [
                  for (final challenge in items) ...[
                    _ChallengeCard(challenge: challenge),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
        ),
      ),
    );
  }
}

class _ChallengeCard extends StatelessWidget {
  const _ChallengeCard({required this.challenge});

  final ChallengeSummary challenge;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      onTap: () => context.push('/community/challenges/${challenge.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  challenge.title,
                  style: AppTypography.display(20, letterSpacing: 0),
                ),
              ),
              Chip(label: Text(challenge.status)),
            ],
          ),
          if (challenge.description.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              challenge.description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: AppColors.fg2),
            ),
          ],
          const SizedBox(height: AppSpacing.md),
          Text(
            '${challenge.metricType} · ${challenge.accessType} · '
            '${challenge.acceptedCount}/${challenge.capacity}',
            style: const TextStyle(color: AppColors.fg3, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
