import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/utils/text_bullets.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/bullet_list.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../nutrition/data/dtos/meal_plan_dto.dart';
import '../../../nutrition/domain/entities/meal_plan.dart';
import '../../../nutrition/presentation/widgets/meal_plan_setup_sheet.dart';
import '../../../profile/data/dtos/bodyweight_log_dto.dart';
import '../../../profile/domain/entities/bodyweight_log.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/widgets/bodyweight_chart.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../../training/presentation/widgets/create_plan_sheet.dart';

final clientProfileProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, clientId) {
      return ref
          .watch(xenohApiProvider)
          .getObject('/community/users/$clientId');
    });

final clientPlansProvider = FutureProvider.autoDispose
    .family<List<JsonMap>, String>((ref, clientId) async {
      final api = ref.watch(xenohApiProvider);
      final plans = await api.getList(
        '/plans/coach-overview?pageNumber=1&pageSize=100',
      );
      return _coachCreatedClientPlans(plans, clientId);
    });

final clientAiInsightProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, clientId) {
      final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
      return ref
          .watch(xenohApiProvider)
          .getObject('/coach-client/clients/$clientId/ai-brief?lang=$lang');
    });

final clientBodyweightHistoryProvider = FutureProvider.autoDispose
    .family<List<BodyweightLog>, String>((ref, clientId) async {
      final raw = await ref
          .watch(xenohApiProvider)
          .getList(
            '/users/$clientId/bodyweight',
          );
      final logs =
          raw.map((item) => BodyweightLogDto.fromJson(item).toEntity()).toList()
            ..sort((a, b) => a.date.compareTo(b.date));
      return logs;
    });

final clientNutritionProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, clientId) {
      return ref
          .watch(xenohApiProvider)
          .getObject('/nutrition/clients/$clientId/summary');
    });

/// Null means the backend answered 404: the client isn't sharing cycle data,
/// isn't female, or has nothing tracked yet (API ref §10) — an expected state,
/// not a failure.
final clientCycleProvider = FutureProvider.autoDispose.family<JsonMap?, String>(
  (ref, clientId) async {
    try {
      return await ref
          .watch(xenohApiProvider)
          .getObject('/cycle/clients/$clientId/overview');
    } on DioException catch (e) {
      if (e.response?.statusCode == 404) return null;
      rethrow;
    }
  },
);

typedef ClientMealPlanArgs = ({String clientId, DateTime date});

final clientMealPlanProvider = FutureProvider.autoDispose
    .family<MealPlanDay, ClientMealPlanArgs>((ref, args) async {
      final data = await ref
          .watch(xenohApiProvider)
          .getObject(
            '/nutrition/clients/${args.clientId}/meal-plans/'
            '${DateOnly.format(args.date)}',
          );
      return MealPlanDayDto.fromJson(data).toEntity();
    });

class ClientDetailScreen extends ConsumerWidget {
  const ClientDetailScreen({required this.clientId, super.key});

  final String clientId;

  Future<void> _createClientPlan(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      builder: (_) => CreatePlanSheet(
        onCreate:
            ({required name, required startDate, required endDate}) async {
              await ref.read(xenohApiProvider).postObject('/plans/for-user', {
                'userId': clientId,
                'name': name,
                'startDate': DateOnly.format(startDate),
                'endDate': DateOnly.format(endDate),
              });
            },
      ),
    );
    if (created != true || !context.mounted) return;

    ref.invalidate(clientPlansProvider(clientId));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).trainingPlanCreatedSnackbar,
          ),
        ),
      );
  }

  Future<void> _editMealPlan(
    BuildContext context,
    WidgetRef ref, {
    required DateTime date,
    MealPlanDay? initialPlan,
  }) async {
    final savedDate = await showModalBottomSheet<DateTime>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => MealPlanSetupSheet(
        date: date,
        initialPlan: initialPlan,
        onSave: ({required date, required meals, notes}) {
          return ref.read(xenohApiProvider).putObject(
            '/nutrition/clients/$clientId/meal-plans/${DateOnly.format(date)}',
            {
              'date': DateOnly.format(date),
              'notes': notes,
              'meals': meals,
            },
          );
        },
      ),
    );
    if (savedDate == null || !context.mounted) return;

    ref.invalidate(clientMealPlanProvider((clientId: clientId, date: date)));
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).nutritionMealPlanCreatedSnackbar,
          ),
        ),
      );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(clientProfileProvider(clientId));
    final clientPlans = ref.watch(clientPlansProvider(clientId));
    final bodyweightHistory = ref.watch(
      clientBodyweightHistoryProvider(clientId),
    );
    final nutrition = ref.watch(clientNutritionProvider(clientId));
    final cycle = ref.watch(clientCycleProvider(clientId));
    final unit = ref.watch(weightUnitProvider);
    final today = _today();
    final mealPlan = ref.watch(
      clientMealPlanProvider((clientId: clientId, date: today)),
    );

    return FeatureScreenFrame(
      title: l10n.coachClientDetailTitle,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: TextButton.icon(
            onPressed: () => unawaited(
              context.push('/coach/clients/$clientId/ai-insight'),
            ),
            icon: const Icon(Icons.auto_awesome_rounded, size: 18),
            label: Text(l10n.coachAiInsightButton),
          ),
        ),
      ],
      onRefresh: () async {
        ref
          ..invalidate(clientProfileProvider(clientId))
          ..invalidate(clientPlansProvider(clientId))
          ..invalidate(clientBodyweightHistoryProvider(clientId))
          ..invalidate(clientNutritionProvider(clientId))
          ..invalidate(clientCycleProvider(clientId))
          ..invalidate(
            clientMealPlanProvider((clientId: clientId, date: today)),
          );
      },
      children: [
        _ClientHero(value: profile, unit: unit),
        const SizedBox(height: AppSpacing.md),
        XnSectionGroup(
          children: [
            _ProfileStatsPanel(value: profile),
            const XnSectionDivider(),
            _TrainingPlanPanel(
              value: clientPlans,
              onCreatePlan: () => _createClientPlan(context, ref),
              onOpenPlan: (plan) {
                final planId = textOf(plan, ['id', 'planId'], fallback: '');
                if (planId.isNotEmpty) {
                  unawaited(context.push('/plans/$planId'));
                }
              },
            ),
            const XnSectionDivider(),
            _NutritionPanel(value: nutrition),
            const XnSectionDivider(),
            _ClientMealPlanPanel(
              date: today,
              value: mealPlan,
              onEdit: () => _editMealPlan(
                context,
                ref,
                date: today,
                initialPlan: mealPlan.value,
              ),
            ),
            const XnSectionDivider(),
            _CyclePanel(value: cycle),
            const XnSectionDivider(),
            _BodyweightPanel(
              profile: profile,
              history: bodyweightHistory,
              unit: unit,
            ),
          ],
        ),
      ],
    );
  }
}

class _ClientHero extends StatelessWidget {
  const _ClientHero({required this.value, required this.unit});

  final AsyncValue<JsonMap> value;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return switch (value) {
      AsyncData(:final value) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ProfileAvatar(name: textOf(value, ['fullName', 'name'])),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      textOf(value, ['fullName', 'name']),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.display(
                        24,
                        weight: FontWeight.w500,
                        height: 1.05,
                        letterSpacing: 0,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      textOf(value, ['email']),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
          const SizedBox(height: AppSpacing.md),
          _HeroKpiGrid(value: value, unit: unit),
        ],
      ),
      AsyncError(:final error) => FeatureError(error: error),
      _ => const LoadingList(),
    };
  }
}

class _HeroKpiGrid extends StatelessWidget {
  const _HeroKpiGrid({required this.value, required this.unit});

  final JsonMap value;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return LayoutBuilder(
      builder: (context, constraints) {
        final width = (constraints.maxWidth - AppSpacing.sm) / 2;
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            _HeroKpiCard(
              width: width,
              label: l10n.coachStreakLabel,
              value: _withUnit(
                textOf(value, ['currentStreak', 'streakDays'], fallback: '0'),
                l10n.coachDaysUnit,
              ),
              icon: Icons.local_fire_department_rounded,
              fg: AppColors.warning,
              bg: const Color(0xFFFFF3C4),
            ),
            _HeroKpiCard(
              width: width,
              label: l10n.coachWeightLabel,
              value: _weightWithUnit(
                textOf(value, [
                  'latestBodyweight',
                  'bodyweight',
                ], fallback: '-'),
                unit,
              ),
              icon: Icons.monitor_weight_outlined,
              fg: AppColors.info,
              bg: AppColors.bg2,
            ),
            _HeroKpiCard(
              width: width,
              label: l10n.coachBmiLabel,
              value: _bmiLabel(value),
              icon: Icons.show_chart_rounded,
              fg: AppColors.success,
              bg: AppColors.bg2,
            ),
            _HeroKpiCard(
              width: width,
              label: l10n.coachDotsScoreLabel,
              value: textOf(value, ['dotsScore'], fallback: '-'),
              icon: Icons.auto_graph_rounded,
              fg: const Color(0xFF7250CC),
              bg: AppColors.bg2,
            ),
          ],
        );
      },
    );
  }
}

class _HeroKpiCard extends StatelessWidget {
  const _HeroKpiCard({
    required this.width,
    required this.label,
    required this.value,
    required this.icon,
    required this.fg,
    required this.bg,
  });

  final double width;
  final String label;
  final String value;
  final IconData icon;
  final Color fg;
  final Color bg;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      padding: const EdgeInsets.all(AppSpacing.xl),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: fg.withValues(alpha: 0.28)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(icon, color: fg, size: 18),
              const SizedBox(width: AppSpacing.sm),
              Text(
                label,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontSize: 11,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(17, weight: FontWeight.w500),
          ),
        ],
      ),
    );
  }
}

class _ProfileStatsPanel extends StatelessWidget {
  const _ProfileStatsPanel({required this.value});

  final AsyncValue<JsonMap> value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.coachStatsTitle,
      icon: Icons.badge_outlined,
      child: switch (value) {
        AsyncData(:final value) => _InfoGrid(
          items: [
            _InfoItem(
              l10n.coachHeightLabel,
              _withUnit(textOf(value, ['height'], fallback: '-'), 'cm'),
              Icons.straighten_rounded,
            ),
            _InfoItem(
              l10n.coachGenderLabel,
              textOf(value, ['gender']),
              Icons.groups_2,
            ),
            _InfoItem(
              l10n.coachDateOfBirthLabel,
              textOf(value, ['dateOfBirth', 'birthDate', 'dob']),
              Icons.calendar_month_outlined,
            ),
            _InfoItem(
              l10n.coachDevelopmentDirectionLabel,
              textOf(value, ['developmentDirection']),
              Icons.adjust_rounded,
            ),
            _InfoItem(
              l10n.coachTrainingDisciplineLabel,
              textOf(value, ['trainingDiscipline']),
              Icons.emoji_events_outlined,
            ),
          ],
        ),
        AsyncError(:final error) => FeatureError(error: error),
        _ => const _PanelLoading(),
      },
    );
  }
}

class _TrainingPlanPanel extends StatelessWidget {
  const _TrainingPlanPanel({
    required this.value,
    required this.onCreatePlan,
    required this.onOpenPlan,
  });

  final AsyncValue<List<JsonMap>> value;
  final VoidCallback onCreatePlan;
  final ValueChanged<JsonMap> onOpenPlan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.coachTrainingPlanTitle,
      icon: Icons.assignment_outlined,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Wrap(
            spacing: AppSpacing.xs,
            runSpacing: AppSpacing.xs,
            children: [
              XnChip(label: l10n.coachTodaysWorkoutChip, compact: true),
              XnChip(label: l10n.coachForThisClientChip, compact: true),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          SizedBox(
            width: double.infinity,
            child: XnButton(
              label: l10n.trainingCreatePlanCta,
              icon: Icons.add_rounded,
              variant: XnButtonVariant.secondary,
              onPressed: onCreatePlan,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          switch (value) {
            AsyncData(:final value) when value.isEmpty =>
              const _EmptyPlanState(),
            AsyncData(:final value) => _PlanList(
              plans: value,
              onOpenPlan: onOpenPlan,
            ),
            AsyncError(:final error) => FeatureError(error: error),
            _ => const _PanelLoading(),
          },
        ],
      ),
    );
  }
}

class _PlanList extends StatelessWidget {
  const _PlanList({required this.plans, required this.onOpenPlan});

  final List<JsonMap> plans;
  final ValueChanged<JsonMap> onOpenPlan;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final plan in plans) ...[
          GestureDetector(
            onTap: () => onOpenPlan(plan),
            child: _PlanCard(value: plan),
          ),
          if (plan != plans.last) const SizedBox(height: AppSpacing.sm),
        ],
      ],
    );
  }
}

class _PlanCard extends StatelessWidget {
  const _PlanCard({required this.value});

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress = _progress(value);
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF1FF),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: const Color(0xFF4F7EFF)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  textOf(value, [
                    'activePlanName',
                    'planName',
                    'name',
                    'title',
                  ], fallback: l10n.coachCurrentTrainingBlockFallback),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.display(
                    18,
                    weight: FontWeight.w500,
                    letterSpacing: 0,
                  ),
                ),
              ),
              XnChip(
                label: _planStatus(value, l10n),
                tone: _isActivePlan(value)
                    ? XnChipTone.info
                    : XnChipTone.neutral,
                compact: true,
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            [
              textOf(value, ['startDate'], fallback: ''),
              textOf(value, ['endDate'], fallback: ''),
              textOf(value, ['durationWeeks', 'weeks'], fallback: ''),
            ].where((part) => part.isNotEmpty).join(' - '),
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 12,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: AppSpacing.md),
          Row(
            children: [
              Expanded(
                child: Text(
                  l10n.coachClientPlanProgressLabel,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
              Text(
                '${(progress * 100).round()}%',
                style: AppTypography.mono(12, weight: FontWeight.w500),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          ClipRRect(
            borderRadius: BorderRadius.circular(AppRadius.pill),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: Colors.white.withValues(alpha: 0.64),
              valueColor: const AlwaysStoppedAnimation(Color(0xFF4F7EFF)),
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyPlanState extends StatelessWidget {
  const _EmptyPlanState();

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Text(
        l10n.coachNoPlanCreatedMessage,
        style: const TextStyle(
          color: AppColors.fg2,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _NutritionPanel extends StatelessWidget {
  const _NutritionPanel({required this.value});

  final AsyncValue<JsonMap> value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.coachNutritionTitle,
      icon: Icons.restaurant_menu_rounded,
      child: switch (value) {
        AsyncData(:final value) => _MetricGrid(
          metrics: [
            _Metric(
              l10n.coachCaloriesLabel,
              textOf(value, ['targetCalories', 'calories']),
            ),
            _Metric(
              l10n.coachProteinLabel,
              _withUnit(textOf(value, ['targetProteinG', 'proteinG']), 'g'),
            ),
            _Metric(
              l10n.coachCarbsLabel,
              _withUnit(textOf(value, ['targetCarbsG', 'carbsG']), 'g'),
            ),
            _Metric(
              l10n.coachFatLabel,
              _withUnit(textOf(value, ['targetFatG', 'fatG']), 'g'),
            ),
          ],
        ),
        AsyncError(:final error) => FeatureError(error: error),
        _ => const _PanelLoading(),
      },
    );
  }
}

class _ClientMealPlanPanel extends StatelessWidget {
  const _ClientMealPlanPanel({
    required this.date,
    required this.value,
    required this.onEdit,
  });

  final DateTime date;
  final AsyncValue<MealPlanDay> value;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.coachTodaysMealPlanTitle,
      icon: Icons.room_service_outlined,
      trailing: Wrap(
        alignment: WrapAlignment.end,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: AppSpacing.xs,
        children: [
          TextButton.icon(
            onPressed: onEdit,
            icon: const Icon(Icons.edit_calendar_rounded, size: 17),
            label: Text(
              switch (value) {
                AsyncData(:final value) when value.totalItemCount > 0 =>
                  l10n.nutritionMealPlanEditCta,
                _ => l10n.nutritionMealPlanCreateCta,
              },
            ),
          ),
          if (value.value case final plan? when plan.totalItemCount > 0)
            XnChip(
              label: '${plan.checkedItemCount}/${plan.totalItemCount}',
              tone: XnChipTone.sage,
              compact: true,
            ),
        ],
      ),
      child: switch (value) {
        AsyncData(:final value) when value.totalItemCount == 0 =>
          _EmptyInlineState(
            icon: Icons.no_meals_outlined,
            message: l10n.coachNoMealPlanForDateMessage(DateOnly.format(date)),
          ),
        AsyncData(:final value) => _ClientMealPlanContent(plan: value),
        AsyncError(:final error) => FeatureError(error: error),
        _ => const _PanelLoading(),
      },
    );
  }
}

class _ClientMealPlanContent extends StatelessWidget {
  const _ClientMealPlanContent({required this.plan});

  final MealPlanDay plan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final meals = plan.meals.where((meal) => meal.items.isNotEmpty).toList();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.pill),
          child: XnAnimatedLinearProgress(
            value: plan.progress.clamp(0.0, 1.0),
            minHeight: 8,
            backgroundColor: AppColors.bg3,
            color: AppColors.sage500,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        Row(
          children: [
            Expanded(
              child: _MealMacroSummary(
                label: l10n.coachPlannedLabel,
                totals: plan.plannedTotals,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: _MealMacroSummary(
                label: l10n.coachDoneLabel,
                totals: plan.checkedTotals,
              ),
            ),
          ],
        ),
        if (plan.notes case final notes? when notes.trim().isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          Text(
            notes.trim(),
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 12,
              fontWeight: FontWeight.w500,
              height: 1.35,
            ),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        for (final meal in meals) ...[
          _ClientMealSection(meal: meal),
          if (meal != meals.last) const SizedBox(height: AppSpacing.md),
        ],
      ],
    );
  }
}

class _MealMacroSummary extends StatelessWidget {
  const _MealMacroSummary({required this.label, required this.totals});

  final String label;
  final MealPlanTotals totals;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            '${totals.calories} kcal',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(14, weight: FontWeight.w500),
          ),
          const SizedBox(height: 2),
          Text(
            'P ${totals.proteinG.toStringAsFixed(0)} - '
            'C ${totals.carbsG.toStringAsFixed(0)} - '
            'F ${totals.fatG.toStringAsFixed(0)}',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: AppTypography.mono(10, color: AppColors.fg3),
          ),
        ],
      ),
    );
  }
}

class _ClientMealSection extends StatelessWidget {
  const _ClientMealSection({required this.meal});

  final MealPlanMeal meal;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Expanded(
              child: Text(
                meal.name,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg1,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
            Text(
              '${meal.plannedTotals.calories} kcal',
              style: AppTypography.mono(
                12,
                color: AppColors.fg3,
                weight: FontWeight.w500,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        for (final item in meal.items) _ClientMealItemTile(item: item),
      ],
    );
  }
}

class _ClientMealItemTile extends StatelessWidget {
  const _ClientMealItemTile({required this.item});

  final MealPlanItem item;

  @override
  Widget build(BuildContext context) {
    final languageCode = Localizations.localeOf(context).languageCode;
    return Container(
      margin: const EdgeInsets.only(bottom: AppSpacing.xs),
      padding: const EdgeInsets.all(AppSpacing.sm),
      decoration: BoxDecoration(
        color: item.isChecked
            ? AppColors.successBg.withValues(alpha: 0.58)
            : AppColors.bg2,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        children: [
          Container(
            width: 24,
            height: 24,
            decoration: BoxDecoration(
              color: item.isChecked ? AppColors.success : AppColors.bg3,
              borderRadius: BorderRadius.circular(AppRadius.sm),
            ),
            child: item.isChecked
                ? const Icon(
                    Icons.check_rounded,
                    color: AppColors.fgOnClay,
                    size: 16,
                  )
                : null,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  item.displayNameFor(languageCode),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: item.isChecked ? AppColors.fg3 : AppColors.fg1,
                    decoration: item.isChecked
                        ? TextDecoration.lineThrough
                        : null,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '${item.amountLabelFor(languageCode)} - ${item.plannedCalories} kcal - '
                  'P ${item.plannedProteinG.toStringAsFixed(0)} - '
                  'C ${item.plannedCarbsG.toStringAsFixed(0)} - '
                  'F ${item.plannedFatG.toStringAsFixed(0)}',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: AppTypography.mono(10, color: AppColors.fg3),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _CyclePanel extends StatelessWidget {
  const _CyclePanel({required this.value});

  final AsyncValue<JsonMap?> value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.coachCycleTitle,
      icon: Icons.water_drop_rounded,
      child: switch (value) {
        AsyncData(value: null) => _EmptyInlineState(
          icon: Icons.visibility_off_outlined,
          message: l10n.coachCycleNotSharedMessage,
        ),
        AsyncData(:final value?) => _MetricGrid(
          metrics: [
            _Metric(
              l10n.coachCurrentDayLabel,
              textOf(value, ['cycleDay', 'currentCycleDay']),
            ),
            _Metric(
              l10n.coachPhaseLabel,
              textOf(value, ['currentPhase', 'phase']),
            ),
            _Metric(
              l10n.coachNextPeriodLabel,
              textOf(value, ['nextPeriodStart']),
            ),
            _Metric(
              l10n.coachDaysToPeriodLabel,
              textOf(value, ['daysUntilNextPeriod']),
            ),
          ],
        ),
        AsyncError(:final error) => FeatureError(error: error),
        _ => const _PanelLoading(),
      },
    );
  }
}

class _BodyweightPanel extends StatelessWidget {
  const _BodyweightPanel({
    required this.profile,
    required this.history,
    required this.unit,
  });

  final AsyncValue<JsonMap> profile;
  final AsyncValue<List<BodyweightLog>> history;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final profileValue = profile.value;
    final latestFromProfile = profileValue == null
        ? '-'
        : _weightWithUnit(
            textOf(profileValue, ['latestBodyweight', 'bodyweight']),
            unit,
          );

    return _PanelFrame(
      title: l10n.coachBodyweightAnalysisTitle,
      icon: Icons.monitor_weight_outlined,
      trailing: Text(
        _latestBodyweightLabel(history.value, latestFromProfile, unit),
        style: AppTypography.mono(18, weight: FontWeight.w500),
      ),
      child: switch (history) {
        AsyncData(:final value) when value.isEmpty => _EmptyInlineState(
          icon: Icons.show_chart_rounded,
          message: l10n.coachNoBodyweightEntriesMessage,
        ),
        AsyncData(:final value) => _BodyweightGraphContent(
          logs: value,
          unit: unit,
        ),
        AsyncError(:final error) => FeatureError(error: error),
        _ => const _PanelLoading(),
      },
    );
  }
}

class _BodyweightGraphContent extends StatelessWidget {
  const _BodyweightGraphContent({required this.logs, required this.unit});

  final List<BodyweightLog> logs;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final cutoff = DateTime.now().subtract(const Duration(days: 90));
    final recent = logs.where((log) => !log.date.isBefore(cutoff)).toList();
    final chartLogs = recent.isEmpty ? logs : recent;
    final delta = chartLogs.length < 2
        ? null
        : unit.fromKg(chartLogs.last.weight - chartLogs.first.weight);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        BodyweightChart(logs: chartLogs, unit: unit, height: 178),
        const SizedBox(height: AppSpacing.md),
        Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            XnChip(
              label: l10n.coachEntriesChip(chartLogs.length),
              compact: true,
            ),
            if (delta != null)
              XnChip(
                label:
                    '${delta >= 0 ? '+' : ''}${formatWeight(delta)} ${unit.suffix}',
                tone: delta <= 0 ? XnChipTone.sage : XnChipTone.warn,
                compact: true,
              ),
            XnChip(
              label: l10n.coachLast90DaysChip,
              tone: XnChipTone.neutral,
              compact: true,
            ),
          ],
        ),
      ],
    );
  }
}

class ClientAiInsightsScreen extends ConsumerWidget {
  const ClientAiInsightsScreen({required this.clientId, super.key});

  final String clientId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final insight = ref.watch(clientAiInsightProvider(clientId));

    return FeatureScreenFrame(
      title: l10n.coachAiClientInsightsTitle,
      onRefresh: () => ref.refresh(clientAiInsightProvider(clientId).future),
      children: [
        switch (insight) {
          AsyncData(:final value) => _AiClientInsightContent(value: value),
          AsyncError(:final error) => FeatureError(error: error),
          _ => const LoadingList(),
        },
      ],
    );
  }
}

class _AiClientInsightContent extends StatelessWidget {
  const _AiClientInsightContent({required this.value});

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final summary = optionalTextOf(value, ['summary', 'content', 'message']);
    final progressSummary = optionalTextOf(value, ['progressSummary']);
    final headlineBullets = _stringsFrom(
      value['bullets'] ??
          value['points'] ??
          value['highlights'] ??
          value['evidence'],
    );
    final progressBullets = splitIntoSentences(progressSummary);
    final sections = _insightSections(value);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        XnCard(
          color: AppColors.bg3,
          padding: const EdgeInsets.all(AppSpacing.xl),
          border: Border.all(color: AppColors.border1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Wrap(
                spacing: AppSpacing.sm,
                runSpacing: AppSpacing.xs,
                children: [
                  if (optionalTextOf(
                        value,
                        ['attentionLevel', 'severity', 'level', 'priority'],
                      )
                      case final severity?)
                    XnChip(
                      label: severity,
                      tone: _severityTone(severity),
                      compact: true,
                    ),
                  if (value['cached'] == true)
                    XnChip(label: l10n.coachCachedLabel, compact: true),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const _SmallIconTile(icon: Icons.auto_awesome_rounded),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: Text(
                      textOf(
                        value,
                        ['headline', 'title'],
                        fallback: l10n.coachAiClientInsightFallback,
                      ),
                      style: AppTypography.display(
                        22,
                        weight: FontWeight.w500,
                        letterSpacing: 0,
                        height: 1.12,
                      ),
                    ),
                  ),
                ],
              ),
              if (summary != null) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  summary,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ],
              if (progressBullets.isNotEmpty || headlineBullets.isNotEmpty) ...[
                const SizedBox(height: AppSpacing.lg),
                BulletList(
                  items: [...progressBullets, ...headlineBullets],
                ),
              ],
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        if (sections.isEmpty)
          _EmptyInlineState(
            icon: Icons.psychology_alt_outlined,
            message: l10n.coachNoAdditionalAiInsightMessage,
          )
        else
          for (final section in sections) ...[
            _AiInsightSection(section: section),
            if (section != sections.last) const SizedBox(height: AppSpacing.md),
          ],
      ],
    );
  }
}

class _AiInsightSection extends StatelessWidget {
  const _AiInsightSection({required this.section});

  final _InsightSection section;

  @override
  Widget build(BuildContext context) {
    return XnSectionGroup(
      children: [
        Row(
          children: [
            Icon(section.icon, color: AppColors.accent, size: 18),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                section.title,
                style: AppTypography.display(
                  17,
                  weight: FontWeight.w500,
                  letterSpacing: 0,
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.md),
        BulletList(items: section.items),
      ],
    );
  }
}

class _PanelFrame extends StatelessWidget {
  const _PanelFrame({
    required this.title,
    required this.icon,
    required this.child,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return XnSection(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(icon, size: 16, color: AppColors.fg3),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Text(
                  title,
                  style: const TextStyle(
                    color: AppColors.fg2,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.4,
                  ),
                ),
              ),
              if (trailing != null) Flexible(child: trailing!),
            ],
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _InfoGrid extends StatelessWidget {
  const _InfoGrid({required this.items});

  final List<_InfoItem> items;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 480 ? 3 : 2;
        final width =
            (constraints.maxWidth - (AppSpacing.md * (columns - 1))) / columns;
        return Wrap(
          spacing: AppSpacing.md,
          runSpacing: AppSpacing.md,
          children: [
            for (final item in items)
              SizedBox(
                width: width,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(item.icon, color: AppColors.fg1, size: 17),
                    const SizedBox(width: AppSpacing.sm),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            item.label,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: const TextStyle(
                              color: AppColors.fg2,
                              fontSize: 11,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          const SizedBox(height: 2),
                          Text(
                            item.value,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: AppTypography.mono(
                              14,
                              weight: FontWeight.w500,
                            ),
                          ),
                        ],
                      ),
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

class _MetricGrid extends StatelessWidget {
  const _MetricGrid({required this.metrics});

  final List<_Metric> metrics;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final columns = constraints.maxWidth > 480 ? 4 : 2;
        final itemWidth =
            (constraints.maxWidth - (AppSpacing.sm * (columns - 1))) / columns;
        return Wrap(
          spacing: AppSpacing.sm,
          runSpacing: AppSpacing.sm,
          children: [
            for (final metric in metrics)
              Container(
                width: itemWidth,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.bg3.withValues(alpha: 0.5),
                  borderRadius: BorderRadius.circular(AppRadius.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      metric.label,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 11,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                    const SizedBox(height: 5),
                    Text(
                      metric.value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.mono(15, weight: FontWeight.w500),
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

class _PanelLoading extends StatelessWidget {
  const _PanelLoading();

  @override
  Widget build(BuildContext context) {
    return const Wrap(
      spacing: AppSpacing.sm,
      runSpacing: AppSpacing.sm,
      children: [
        _SkeletonBox(width: 92, height: 56),
        _SkeletonBox(width: 92, height: 56),
        _SkeletonBox(width: 92, height: 56),
      ],
    );
  }
}

class _EmptyInlineState extends StatelessWidget {
  const _EmptyInlineState({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.42),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Row(
        children: [
          Icon(icon, color: AppColors.fg3, size: 20),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              message,
              style: const TextStyle(
                color: AppColors.fg2,
                fontWeight: FontWeight.w500,
                height: 1.35,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  const _SkeletonBox({required this.width, required this.height});

  final double width;
  final double height;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
    );
  }
}

class _SmallIconTile extends StatelessWidget {
  const _SmallIconTile({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 34,
      height: 34,
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.62),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Icon(icon, color: AppColors.accent, size: 18),
    );
  }
}

class _ProfileAvatar extends StatelessWidget {
  const _ProfileAvatar({required this.name});

  final String name;

  @override
  Widget build(BuildContext context) {
    final initials = name
        .split(' ')
        .where((part) => part.trim().isNotEmpty)
        .take(2)
        .map((part) => part.characters.first.toUpperCase())
        .join();
    return Container(
      width: 54,
      height: 54,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: AppColors.accentSoft,
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Text(
        initials.isEmpty ? '-' : initials,
        style: const TextStyle(
          color: AppColors.clay900,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _Metric {
  const _Metric(this.label, this.value);

  final String label;
  final String value;
}

class _InsightSection {
  const _InsightSection({
    required this.title,
    required this.icon,
    required this.items,
  });

  final String title;
  final IconData icon;
  final List<String> items;
}

class _InfoItem {
  const _InfoItem(this.label, this.value, this.icon);

  final String label;
  final String value;
  final IconData icon;
}

String _bmiLabel(JsonMap value) {
  final bmi = textOf(value, ['bmi'], fallback: '-');
  final category = optionalTextOf(value, ['bmiCategory']);
  if (category == null || category == '-') return bmi;
  return '$bmi ($category)';
}

String _withUnit(String value, String unit) {
  if (value == '-' || value.trim().isEmpty) return value;
  final lower = value.toLowerCase();
  if (lower.endsWith(unit.toLowerCase())) return value;
  return '$value $unit';
}

/// Converts a raw kg value coming back as text from the API (e.g.
/// `textOf(...)`) into the display [unit], appending its suffix. Falls back
/// to the original text (with the suffix appended) if it isn't a number.
String _weightWithUnit(String rawKg, WeightUnit unit) {
  if (rawKg == '-' || rawKg.trim().isEmpty) return rawKg;
  final parsed = double.tryParse(rawKg);
  if (parsed == null) return _withUnit(rawKg, unit.suffix);
  return '${formatWeight(unit.fromKg(parsed))} ${unit.suffix}';
}

String _latestBodyweightLabel(
  List<BodyweightLog>? logs,
  String fallback,
  WeightUnit unit,
) {
  if (logs != null && logs.isNotEmpty) {
    return '${formatWeight(unit.fromKg(logs.last.weight))} ${unit.suffix}';
  }
  return fallback;
}

List<_InsightSection> _insightSections(JsonMap value) {
  const keys = [
    'actions',
    'actionItems',
    'recommendations',
    'risks',
    'warnings',
    'training',
    'nutrition',
    'recovery',
    'adherence',
    'strengths',
    'opportunities',
    'nextSteps',
  ];

  final sections = <_InsightSection>[];
  for (final key in keys) {
    final items = _stringsFrom(value[key]);
    if (items.isEmpty) continue;
    sections.add(
      _InsightSection(
        title: _titleFromKey(key),
        icon: _iconForKey(key),
        items: items,
      ),
    );
  }
  return sections;
}

List<String> _stringsFrom(Object? value) {
  if (value == null) return const [];
  if (value is String) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? const [] : [trimmed];
  }
  if (value is List<dynamic>) {
    return value
        .map((item) {
          if (item is String) return item.trim();
          if (item is JsonMap) {
            return textOf(item, ['text', 'title', 'message', 'description']);
          }
          return item.toString().trim();
        })
        .where((text) => text.isNotEmpty && text != '-')
        .toList();
  }
  if (value is JsonMap) {
    final parts = <String>[];
    for (final entry in value.entries) {
      final nested = _stringsFrom(entry.value);
      if (nested.isEmpty) continue;
      parts.add('${_titleFromKey(entry.key)}: ${nested.join(' ')}');
    }
    return parts;
  }
  final text = value.toString().trim();
  return text.isEmpty ? const [] : [text];
}

String _titleFromKey(String key) {
  final spaced = key
      .replaceAllMapped(RegExp('([a-z])([A-Z])'), (m) => '${m[1]} ${m[2]}')
      .replaceAll('_', ' ')
      .replaceAll('-', ' ')
      .trim();
  if (spaced.isEmpty) return key;
  return spaced[0].toUpperCase() + spaced.substring(1);
}

IconData _iconForKey(String key) {
  final normalized = key.toLowerCase();
  if (normalized.contains('risk') || normalized.contains('warning')) {
    return Icons.warning_amber_rounded;
  }
  if (normalized.contains('nutrition')) return Icons.restaurant_menu_rounded;
  if (normalized.contains('recovery')) return Icons.bedtime_outlined;
  if (normalized.contains('adherence')) return Icons.fact_check_outlined;
  if (normalized.contains('strength')) return Icons.trending_up_rounded;
  if (normalized.contains('training')) return Icons.fitness_center_rounded;
  return Icons.bolt_rounded;
}

XnChipTone _severityTone(String value) {
  final normalized = value.toLowerCase();
  if (normalized.contains('high') || normalized.contains('critical')) {
    return XnChipTone.danger;
  }
  if (normalized.contains('medium') || normalized.contains('moderate')) {
    return XnChipTone.warn;
  }
  if (normalized.contains('low')) return XnChipTone.sage;
  return XnChipTone.neutral;
}

DateTime _today() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

double _progress(JsonMap value) {
  final raw = textOf(value, [
    'progressPercent',
    'completionPercent',
    'progress',
  ], fallback: '0');
  final parsed = double.tryParse(raw.replaceAll('%', '').trim()) ?? 0;
  if (parsed > 0) {
    if (parsed > 1) return (parsed / 100).clamp(0, 1);
    return parsed.clamp(0, 1);
  }

  final completed = double.tryParse(
    textOf(value, ['completedDays', 'completedWeeks'], fallback: '0'),
  );
  final total = double.tryParse(
    textOf(value, ['totalDays', 'totalWeeks'], fallback: '0'),
  );
  if (completed == null || total == null || total <= 0) return 0;
  return (completed / total).clamp(0, 1);
}

bool _isActivePlan(JsonMap value) {
  final raw = textOf(value, ['isActive', 'active'], fallback: '').toLowerCase();
  if (raw == 'true') return true;
  final status = textOf(value, ['status'], fallback: '').toLowerCase();
  return status == 'active';
}

String _planStatus(JsonMap value, AppLocalizations l10n) {
  if (_isActivePlan(value)) return l10n.coachActiveStatusFallback;
  final status = optionalTextOf(value, ['status']);
  return status ?? l10n.coachPlanFallbackLabel;
}

List<JsonMap> _coachCreatedClientPlans(List<JsonMap> plans, String clientId) {
  return plans
      .where((plan) => _isCoachCreatedClientPlan(plan, clientId))
      .toList();
}

bool _isCoachCreatedClientPlan(JsonMap plan, String clientId) {
  final planType = optionalTextOf(plan, ['planType', 'type']);
  if (planType?.toLowerCase() != 'coach') return false;

  final ownerId = optionalTextOf(plan, [
    'ownerId',
    'clientId',
    'userId',
    'ownerUserId',
  ]);
  return ownerId?.toLowerCase() == clientId.toLowerCase();
}
