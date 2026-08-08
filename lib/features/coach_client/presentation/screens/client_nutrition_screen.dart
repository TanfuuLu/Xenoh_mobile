import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/error_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../nutrition/data/repositories/nutrition_repository_provider.dart';
import '../../../nutrition/domain/entities/nutrition_summary.dart';

typedef ClientNutritionDateArgs = ({String clientId, DateTime date});
typedef ClientNutritionHistoryArgs = ({
  String clientId,
  DateTime from,
  DateTime to,
  bool enabled,
});

final clientNutritionSummaryProvider = FutureProvider.autoDispose
    .family<NutritionSummary, String>((ref, clientId) {
      return ref.watch(nutritionRepositoryProvider).getClientSummary(clientId);
    });

final clientNutritionDailyLogProvider = FutureProvider.autoDispose
    .family<NutritionDailyLog?, ClientNutritionDateArgs>((ref, args) {
      return ref
          .watch(nutritionRepositoryProvider)
          .getClientDailyLog(args.clientId, args.date);
    });

final clientNutritionHistoryProvider = FutureProvider.autoDispose
    .family<List<NutritionDailyLog>, ClientNutritionHistoryArgs>(
      (ref, args) => args.enabled
          ? ref
                .watch(nutritionRepositoryProvider)
                .getClientHistory(
                  args.clientId,
                  from: args.from,
                  to: args.to,
                )
          : Future.value(const []),
    );

class ClientNutritionScreen extends ConsumerStatefulWidget {
  const ClientNutritionScreen({required this.clientId, super.key});

  static const dailyIntakeKey = ValueKey('client-nutrition-daily-intake');
  static const historyKey = ValueKey('client-nutrition-history');

  final String clientId;

  @override
  ConsumerState<ClientNutritionScreen> createState() =>
      _ClientNutritionScreenState();
}

class _ClientNutritionScreenState extends ConsumerState<ClientNutritionScreen> {
  late DateTime _selectedDate;

  @override
  void initState() {
    super.initState();
    _selectedDate = DateOnly.truncate(DateTime.now());
  }

  DateTime get _historyFrom => _selectedDate.subtract(const Duration(days: 6));

  void _changeDate(int days) {
    setState(() {
      _selectedDate = _selectedDate.add(Duration(days: days));
    });
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(
      clientNutritionSummaryProvider(widget.clientId),
    );
    final dailyArgs = (clientId: widget.clientId, date: _selectedDate);
    final log = ref.watch(clientNutritionDailyLogProvider(dailyArgs));
    final advancedEnabled = summary.value?.canUseAdvancedAnalysis ?? false;
    final historyArgs = (
      clientId: widget.clientId,
      from: _historyFrom,
      to: _selectedDate,
      enabled: advancedEnabled,
    );
    final history = ref.watch(clientNutritionHistoryProvider(historyArgs));

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.coachClientNutritionTitle),
        actions: [
          IconButton(
            tooltip: l10n.nutritionInsightTitle,
            onPressed: () => context.push(
              '/coach/clients/${widget.clientId}/nutrition/insight',
            ),
            icon: const Icon(Icons.auto_awesome_rounded),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          ref
            ..invalidate(clientNutritionSummaryProvider(widget.clientId))
            ..invalidate(clientNutritionDailyLogProvider(dailyArgs))
            ..invalidate(clientNutritionHistoryProvider(historyArgs));
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            _SummaryCard(value: summary),
            const SizedBox(height: AppSpacing.md),
            _DateSelector(
              date: _selectedDate,
              onPrevious: () => _changeDate(-1),
              onNext: () => _changeDate(1),
            ),
            const SizedBox(height: AppSpacing.md),
            _DailyIntakeCard(value: log),
            const SizedBox(height: AppSpacing.md),
            _HistoryCard(
              value: history,
              enabled: advancedEnabled,
              calorieTarget: summary.value?.calculation.calorieTarget,
            ),
            const SizedBox(height: AppSpacing.md),
            Text(
              l10n.coachNutritionReadOnlyMessage,
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.fg3, fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SummaryCard extends StatelessWidget {
  const _SummaryCard({required this.value});

  final AsyncValue<NutritionSummary> value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: switch (value) {
        AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.coachNutritionTitle,
              style: const TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: AppSpacing.md),
            _Metrics(
              values: [
                (l10n.nutritionGoalLabel, _goal(value.profile.goal, l10n)),
                (
                  l10n.nutritionTdeeLabel,
                  _amount(value.calculation.tdee, l10n.nutritionKcalLabel),
                ),
                (
                  l10n.dashboardInsightNutritionTargetTitle,
                  _amount(
                    value.calculation.calorieTarget,
                    l10n.nutritionKcalLabel,
                  ),
                ),
                (
                  l10n.coachProteinLabel,
                  _amount(value.calculation.proteinG, 'g'),
                ),
                (l10n.coachCarbsLabel, _amount(value.calculation.carbsG, 'g')),
                (l10n.coachFatLabel, _amount(value.calculation.fatG, 'g')),
              ],
            ),
          ],
        ),
        AsyncError(:final error) => ErrorView.from(error, context),
        _ => const Center(child: CircularProgressIndicator()),
      },
    );
  }
}

class _DateSelector extends StatelessWidget {
  const _DateSelector({
    required this.date,
    required this.onPrevious,
    required this.onNext,
  });

  final DateTime date;
  final VoidCallback onPrevious;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Row(
      children: [
        IconButton(
          tooltip: l10n.nutritionPreviousDayTooltip,
          onPressed: onPrevious,
          icon: const Icon(Icons.chevron_left_rounded),
        ),
        Expanded(
          child: Text(
            DateOnly.format(date),
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
        ),
        IconButton(
          tooltip: l10n.nutritionNextDayTooltip,
          onPressed: onNext,
          icon: const Icon(Icons.chevron_right_rounded),
        ),
      ],
    );
  }
}

class _DailyIntakeCard extends StatelessWidget {
  const _DailyIntakeCard({required this.value});

  final AsyncValue<NutritionDailyLog?> value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      key: ClientNutritionScreen.dailyIntakeKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.coachNutritionSelectedIntakeTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          switch (value) {
            AsyncData(value: final log?) => _Metrics(
              values: _logMetrics(log, l10n),
            ),
            AsyncData() => Text(
              l10n.coachNutritionNoLogMessage,
              style: const TextStyle(color: AppColors.fg2),
            ),
            AsyncError(:final error) => ErrorView.from(error, context),
            _ => const Center(child: CircularProgressIndicator()),
          },
        ],
      ),
    );
  }
}

class _HistoryCard extends StatelessWidget {
  const _HistoryCard({
    required this.value,
    required this.enabled,
    required this.calorieTarget,
  });

  final AsyncValue<List<NutritionDailyLog>> value;
  final bool enabled;
  final int? calorieTarget;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      key: ClientNutritionScreen.historyKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            l10n.coachNutritionHistoryTitle,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
          ),
          const SizedBox(height: AppSpacing.md),
          if (!enabled)
            Text(
              l10n.coachNutritionNoHistoryMessage,
              style: const TextStyle(color: AppColors.fg2),
            )
          else
            switch (value) {
              AsyncData(:final value) when value.isEmpty => Text(
                l10n.coachNutritionNoHistoryMessage,
                style: const TextStyle(color: AppColors.fg2),
              ),
              AsyncData(:final value) => Column(
                children: [
                  for (final entry in value.reversed)
                    _HistoryRow(entry: entry, calorieTarget: calorieTarget),
                ],
              ),
              AsyncError(:final error) => ErrorView.from(error, context),
              _ => const Center(child: CircularProgressIndicator()),
            },
        ],
      ),
    );
  }
}

class _HistoryRow extends StatelessWidget {
  const _HistoryRow({required this.entry, required this.calorieTarget});

  final NutritionDailyLog entry;
  final int? calorieTarget;

  @override
  Widget build(BuildContext context) {
    final delta = calorieTarget == null
        ? null
        : entry.calories - calorieTarget!;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: AppSpacing.sm),
      child: Row(
        children: [
          Expanded(
            child: Text(
              DateOnly.format(entry.date),
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
          Text('${entry.calories} kcal'),
          if (delta != null) ...[
            const SizedBox(width: AppSpacing.sm),
            Text(
              '${delta > 0 ? '+' : ''}$delta',
              style: TextStyle(
                color: delta.abs() <= 100 ? AppColors.success : AppColors.fg3,
                fontSize: 12,
              ),
            ),
          ],
        ],
      ),
    );
  }
}

class _Metrics extends StatelessWidget {
  const _Metrics({required this.values});

  final List<(String, String)> values;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpacing.md) / 2;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final value in values)
              SizedBox(
                width: width,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      value.$1,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                      ),
                    ),
                    const SizedBox(height: 2),
                    Text(
                      value.$2,
                      style: const TextStyle(fontWeight: FontWeight.w700),
                    ),
                  ],
                ),
              ),
          ],
        );
      },
    );
  }
}

List<(String, String)> _logMetrics(
  NutritionDailyLog log,
  AppLocalizations l10n,
) => [
  (l10n.coachCaloriesLabel, '${log.calories} ${l10n.nutritionKcalLabel}'),
  (l10n.coachProteinLabel, '${_number(log.proteinG)} g'),
  (l10n.coachCarbsLabel, '${_number(log.carbsG)} g'),
  (l10n.coachFatLabel, '${_number(log.fatG)} g'),
];

String _goal(String goal, AppLocalizations l10n) =>
    switch (goal.toLowerCase()) {
      'cut' => l10n.nutritionGoalCut,
      'bulk' => l10n.nutritionGoalBulk,
      _ => l10n.nutritionGoalMaintain,
    };

String _amount(num? value, String unit) =>
    value == null ? '—' : '${_number(value)} $unit';

String _number(num value) =>
    value % 1 == 0 ? value.toInt().toString() : value.toStringAsFixed(1);
