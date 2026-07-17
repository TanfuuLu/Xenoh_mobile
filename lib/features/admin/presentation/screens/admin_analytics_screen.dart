import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../../subscription/presentation/providers/pricing.dart';

final adminInsightsProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  return ref
      .watch(xenohApiProvider)
      .getObject(
        '/admin/insights?granularity=Month',
      );
});

final adminMarketingProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  return ref
      .watch(xenohApiProvider)
      .getObject(
        '/admin/marketing?granularity=Month',
      );
});

final adminAiUsageProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  return ref.watch(xenohApiProvider).getObject('/admin/ai-usage/summary');
});

class AdminAnalyticsScreen extends StatelessWidget {
  const AdminAnalyticsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _AnalyticsAppBar(),
        body: TabBarView(
          children: [
            _InsightsTab(),
            _MarketingTab(),
            _AiUsageTab(),
          ],
        ),
      ),
    );
  }
}

class _AnalyticsAppBar extends StatelessWidget implements PreferredSizeWidget {
  const _AnalyticsAppBar();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight + 48);

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AppBar(
      title: Text(l10n.adminAnalyticsTitle),
      bottom: TabBar(
        tabs: [
          Tab(text: l10n.adminInsightsTab),
          Tab(text: l10n.adminMarketingTab),
          Tab(text: l10n.adminAiUsageTab),
        ],
      ),
    );
  }
}

class _InsightsTab extends ConsumerWidget {
  const _InsightsTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(adminInsightsProvider);
    return _AnalyticsList(
      value: data,
      onRefresh: () => ref.refresh(adminInsightsProvider.future),
      onRetry: () => ref.invalidate(adminInsightsProvider),
      data: (value) {
        final totals = _object(value, 'totals');
        return [
          FeatureHeader(
            title: l10n.adminPlatformInsightsTitle,
            subtitle: l10n.adminPlatformInsightsSubtitle,
            icon: Icons.bar_chart_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          KeyValueGrid(
            items: {
              l10n.adminTotalUsersLabel: textOf(totals, ['totalUsers']),
              l10n.adminNewUsersLabel: textOf(totals, ['newUsers']),
              l10n.adminActiveUsersLabel: textOf(totals, ['activeUsers']),
              l10n.adminPaidSubsLabel: textOf(
                totals,
                ['activePaidSubscriptions'],
              ),
              l10n.adminRevenueLabel: formatVnd(_numOf(totals, 'revenue')),
              l10n.adminPlansLabel: textOf(totals, ['plansCreated']),
              l10n.adminWorkoutDaysLabel: textOf(
                totals,
                ['completedWorkoutDays'],
              ),
              l10n.adminAiRequestsLabel: textOf(totals, ['aiRequests']),
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          XnSectionList(
            children: [
              _MetricSeries(
                title: l10n.adminUserRegistrationsTitle,
                value: value,
                keyName: 'userRegistrations',
              ),
              _MetricSeries(
                title: l10n.adminRevenueLabel,
                value: value,
                keyName: 'revenue',
              ),
              _MetricSeries(
                title: l10n.adminCommunityActivityTitle,
                value: value,
                keyName: 'communityActivity',
              ),
            ],
          ),
        ];
      },
    );
  }
}

class _MarketingTab extends ConsumerWidget {
  const _MarketingTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(adminMarketingProvider);
    return _AnalyticsList(
      value: data,
      onRefresh: () => ref.refresh(adminMarketingProvider.future),
      onRetry: () => ref.invalidate(adminMarketingProvider),
      data: (value) {
        final totals = _object(value, 'totals');
        return [
          FeatureHeader(
            title: l10n.adminMarketingAnalyticsTitle,
            subtitle: l10n.adminMarketingAnalyticsSubtitle,
            icon: Icons.trending_up_rounded,
          ),
          const SizedBox(height: AppSpacing.lg),
          KeyValueGrid(
            items: {
              l10n.adminPageViewsLabel: textOf(totals, ['pageViews']),
              l10n.adminSessionsLabel: textOf(totals, ['uniqueSessions']),
              l10n.adminKnownUsersLabel: textOf(totals, ['knownUsers']),
              l10n.adminLoginsLabel: textOf(totals, ['logins']),
              l10n.adminRegistrationsLabel: textOf(totals, ['registrations']),
              l10n.adminUsageTimeLabel: _duration(
                _numOf(totals, 'totalUsageSeconds'),
              ),
              l10n.adminOpenBugsLabel: textOf(totals, ['bugReportsOpen']),
              l10n.adminAvgSessionLabel: _duration(
                _numOf(totals, 'averageUsageSecondsPerSession'),
              ),
            },
          ),
          const SizedBox(height: AppSpacing.lg),
          XnSectionList(
            children: [
              _MetricSeries(
                title: l10n.adminTopSourcesTitle,
                value: value,
                keyName: 'topSources',
              ),
              _MetricSeries(
                title: l10n.adminTopCampaignsTitle,
                value: value,
                keyName: 'topCampaigns',
              ),
              _FlowList(value: value),
            ],
          ),
        ];
      },
    );
  }
}

class _AiUsageTab extends ConsumerWidget {
  const _AiUsageTab();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final data = ref.watch(adminAiUsageProvider);
    return _AnalyticsList(
      value: data,
      onRefresh: () => ref.refresh(adminAiUsageProvider.future),
      onRetry: () => ref.invalidate(adminAiUsageProvider),
      data: (value) => [
        FeatureHeader(
          title: l10n.adminAiUsageTitle,
          subtitle: l10n.adminAiUsageSubtitle,
          icon: Icons.smart_toy_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        KeyValueGrid(
          items: {
            l10n.adminPeriodStartLabel: textOf(value, ['periodStart']),
            l10n.adminUsedRequestsLabel: textOf(
              value,
              ['totalUsedRequests'],
            ),
            l10n.adminQuotaUsersLabel: textOf(value, ['activeQuotaUsers']),
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        XnSectionList(
          children: [
            _MetricSeries(
              title: l10n.adminByTierTitle,
              value: value,
              keyName: 'requestsByCurrentTier',
            ),
            _MetricSeries(
              title: l10n.adminByFeatureTitle,
              value: value,
              keyName: 'requestsByFeature',
            ),
            _TopAiUsers(value: value),
          ],
        ),
      ],
    );
  }
}

class _AnalyticsList extends StatelessWidget {
  const _AnalyticsList({
    required this.value,
    required this.onRefresh,
    required this.onRetry,
    required this.data,
  });

  final AsyncValue<JsonMap> value;
  final Future<void> Function() onRefresh;
  final VoidCallback onRetry;
  final List<Widget> Function(JsonMap value) data;

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: onRefresh,
      child: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: switch (value) {
          AsyncData(:final value) => data(value),
          AsyncError(:final error) => [
            FeatureError(error: error, onRetry: onRetry),
          ],
          _ => [const LoadingList()],
        },
      ),
    );
  }
}

class _MetricSeries extends StatelessWidget {
  const _MetricSeries({
    required this.title,
    required this.value,
    this.keyName,
  });

  final String title;
  final JsonMap value;
  final String? keyName;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final items = _list(value, keyName ?? _camel(title));
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(title),
          const SizedBox(height: AppSpacing.sm),
          if (items.isEmpty)
            Text(
              l10n.adminNoDataMessage,
              style: const TextStyle(color: AppColors.fg3),
            )
          else
            for (final item in items.take(6))
              Padding(
                padding: const EdgeInsets.only(bottom: AppSpacing.xs),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        textOf(item, ['label']),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: AppColors.fg2),
                      ),
                    ),
                    Text(
                      textOf(item, ['value']),
                      style: const TextStyle(
                        color: AppColors.fg1,
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

class _FlowList extends StatelessWidget {
  const _FlowList({required this.value});

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final flows = _list(value, 'topFlows');
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.adminTopFlowsTitle),
          const SizedBox(height: AppSpacing.sm),
          if (flows.isEmpty)
            Text(
              l10n.adminNoDataMessage,
              style: const TextStyle(color: AppColors.fg3),
            )
          else
            for (final flow in flows.take(6))
              DataCard(
                title: textOf(flow, ['toPath']),
                subtitle: textOf(flow, ['fromPath']),
                meta: [
                  l10n.adminCountLabel(textOf(flow, ['count'])),
                ],
              ),
        ],
      ),
    );
  }
}

class _TopAiUsers extends StatelessWidget {
  const _TopAiUsers({required this.value});

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final users = _list(value, 'topUsers');
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          XnSectionEyebrow(l10n.adminTopUsersTitle),
          const SizedBox(height: AppSpacing.sm),
          if (users.isEmpty)
            Text(
              l10n.adminNoUsageYetMessage,
              style: const TextStyle(color: AppColors.fg3),
            )
          else
            for (final user in users.take(8))
              DataCard(
                title: textOf(user, ['userName', 'userEmail']),
                subtitle: optionalTextOf(user, ['userEmail']),
                meta: [
                  textOf(user, ['currentTier']),
                  l10n.adminRequestsCountLabel(textOf(user, ['usedRequests'])),
                ],
              ),
        ],
      ),
    );
  }
}

JsonMap _object(JsonMap map, String key) {
  final value = map[key];
  return value is JsonMap ? value : <String, dynamic>{};
}

List<JsonMap> _list(JsonMap map, String key) {
  final value = map[key];
  return value is List<dynamic> ? value.whereType<JsonMap>().toList() : [];
}

num _numOf(JsonMap map, String key) {
  final value = map[key];
  if (value is num) return value;
  return num.tryParse('$value') ?? 0;
}

String _duration(num seconds) {
  final total = seconds.round();
  final hours = total ~/ 3600;
  final minutes = (total % 3600) ~/ 60;
  return hours > 0 ? '${hours}h ${minutes}m' : '${minutes}m';
}

String _camel(String value) {
  final parts = value.split(' ');
  if (parts.isEmpty) return value;
  return parts.first.toLowerCase() +
      parts.skip(1).map((part) {
        if (part.isEmpty) return part;
        return part[0].toUpperCase() + part.substring(1);
      }).join();
}
