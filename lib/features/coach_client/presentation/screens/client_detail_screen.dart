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
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_chip.dart';
import '../../../../core/widgets/xn_progress.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../core/widgets/xn_user_avatar.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../nutrition/data/dtos/meal_plan_dto.dart';
import '../../../nutrition/data/dtos/nutrition_summary_dto.dart';
import '../../../nutrition/domain/entities/meal_plan.dart';
import '../../../nutrition/domain/entities/nutrition_summary.dart';
import '../../../nutrition/presentation/widgets/meal_plan_setup_sheet.dart';
import '../../../profile/data/dtos/bodyweight_log_dto.dart';
import '../../../profile/domain/entities/bodyweight_log.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/widgets/bodyweight_chart.dart';
import '../../../shared_api/ai_widgets.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../../training/data/dtos/exercise_template_dto.dart';
import '../../../training/domain/entities/exercise_template.dart';
import '../../../training/presentation/navigation/training_route_scope.dart';
import '../../../training/presentation/widgets/create_plan_sheet.dart';
import '../../../training/presentation/widgets/exercise_template_form_sheet.dart';
import '../widgets/client_detail_section_header.dart';
import '../widgets/client_training_plan_actions.dart';

final clientProfileProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, clientId) async {
      final profile = await ref
          .watch(xenohApiProvider)
          .getObject('/users/$clientId');
      final fullName =
          [
                profile['firstName'],
                profile['lastName'],
              ]
              .whereType<String>()
              .map((part) => part.trim())
              .where(
                (part) => part.isNotEmpty,
              )
              .join(' ');
      return {...profile, if (fullName.isNotEmpty) 'fullName': fullName};
    });

final clientPlansProvider = FutureProvider.autoDispose
    .family<List<JsonMap>, String>((ref, clientId) async {
      final api = ref.watch(xenohApiProvider);
      final plans = await api.getList(
        '/plans/coach-overview?pageNumber=1&pageSize=100',
      );
      final dashboard = await api.getList('/coach-client/dashboard');
      return _mergeClientPlanDashboard(
        plans: _coachCreatedClientPlans(plans, clientId),
        dashboard: dashboard,
        clientId: clientId,
      );
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
    .family<NutritionSummary, String>((ref, clientId) async {
      final data = await ref
          .watch(xenohApiProvider)
          .getObject('/nutrition/clients/$clientId/summary');
      return NutritionSummaryDto.fromJson(data).toEntity();
    });

final clientExerciseTemplatesProvider = FutureProvider.autoDispose
    .family<List<ExerciseTemplate>, String>((ref, clientId) async {
      final raw = await ref
          .watch(xenohApiProvider)
          .getList('/exercise-templates/for-client/$clientId');
      return raw
          .map((item) => ExerciseTemplateDto.fromJson(item).toEntity())
          .where(
            (template) =>
                template.isCustom &&
                template.ownerId?.toLowerCase() == clientId.toLowerCase(),
          )
          .toList();
    });

Future<ExerciseTemplate> createCustomExerciseForClient({
  required XenohApi api,
  required String clientId,
  required String name,
  required String primaryMuscleGroup,
  required List<String> secondaryMuscleGroups,
  required String exerciseKind,
  String? description,
}) async {
  final data = await api.postObject(
    '/exercise-templates/custom/for-client/$clientId',
    {
      'clientId': clientId,
      'name': name,
      'description': ?description,
      'primaryMuscleGroup': primaryMuscleGroup,
      'secondaryMuscleGroups': secondaryMuscleGroups,
      'exerciseKind': exerciseKind,
    },
  );
  return ExerciseTemplateDto.fromJson(data).toEntity();
}

Future<ExerciseTemplate> updateCustomExerciseForClient({
  required XenohApi api,
  required String exerciseId,
  required String name,
  required String primaryMuscleGroup,
  required List<String> secondaryMuscleGroups,
  required String exerciseKind,
  String? description,
}) async {
  final data = await api.putObject(
    '/exercise-templates/custom/$exerciseId',
    {
      'id': exerciseId,
      'name': name,
      'description': ?description,
      'primaryMuscleGroup': primaryMuscleGroup,
      'secondaryMuscleGroups': secondaryMuscleGroups,
      'exerciseKind': exerciseKind,
    },
  );
  return ExerciseTemplateDto.fromJson(data).toEntity();
}

Future<void> deleteCustomExerciseForClient({
  required XenohApi api,
  required String exerciseId,
}) => api.delete('/exercise-templates/custom/$exerciseId');

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

  Future<void> _createClientExercise(
    BuildContext context,
    WidgetRef ref,
  ) async {
    final l10n = AppLocalizations.of(context);
    final result = await showModalBottomSheet<ExerciseTemplateFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplateFormSheet(
        title: l10n.trainingCustomExerciseTitle,
        submitLabel: l10n.trainingCreateExerciseCta,
      ),
    );
    if (result == null || !context.mounted) return;

    try {
      await createCustomExerciseForClient(
        api: ref.read(xenohApiProvider),
        clientId: clientId,
        name: result.name,
        description: result.description,
        primaryMuscleGroup: result.primaryMuscleGroup,
        secondaryMuscleGroups: result.secondaryMuscleGroups,
        exerciseKind: result.exerciseKind,
      );
      ref.invalidate(clientExerciseTemplatesProvider(clientId));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.trainingExerciseCreatedSnackbar)),
        );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
    }
  }

  Future<void> _editClientExercise(
    BuildContext context,
    WidgetRef ref,
    ExerciseTemplate exercise,
  ) async {
    final l10n = AppLocalizations.of(context);
    final result = await showModalBottomSheet<ExerciseTemplateFormResult>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => ExerciseTemplateFormSheet(
        title: l10n.trainingEditExerciseTitle,
        submitLabel: l10n.commonSave,
        initial: exercise,
      ),
    );
    if (result == null || !context.mounted) return;

    try {
      await updateCustomExerciseForClient(
        api: ref.read(xenohApiProvider),
        exerciseId: exercise.id,
        name: result.name,
        description: result.description,
        primaryMuscleGroup: result.primaryMuscleGroup,
        secondaryMuscleGroups: result.secondaryMuscleGroups,
        exerciseKind: result.exerciseKind,
      );
      ref.invalidate(clientExerciseTemplatesProvider(clientId));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.trainingExerciseUpdatedSnackbar)),
        );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
    }
  }

  Future<void> _deleteClientExercise(
    BuildContext context,
    WidgetRef ref,
    ExerciseTemplate exercise,
  ) async {
    final l10n = AppLocalizations.of(context);
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.trainingDeleteCustomExerciseTitle),
        content: Text(l10n.trainingDeleteCustomExerciseMessage(exercise.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            style: TextButton.styleFrom(foregroundColor: AppColors.danger),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (confirmed != true || !context.mounted) return;

    try {
      await deleteCustomExerciseForClient(
        api: ref.read(xenohApiProvider),
        exerciseId: exercise.id,
      );
      ref.invalidate(clientExerciseTemplatesProvider(clientId));
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.trainingExerciseDeletedSnackbar)),
        );
    } catch (error) {
      if (!context.mounted) return;
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final compactActions = MediaQuery.sizeOf(context).width < 560;
    final profile = ref.watch(clientProfileProvider(clientId));
    final clientPlans = ref.watch(clientPlansProvider(clientId));
    final bodyweightHistory = ref.watch(
      clientBodyweightHistoryProvider(clientId),
    );
    final nutrition = ref.watch(clientNutritionProvider(clientId));
    final clientExercises = ref.watch(
      clientExerciseTemplatesProvider(clientId),
    );
    final cycle = ref.watch(clientCycleProvider(clientId));
    final unit = ref.watch(weightUnitProvider);
    final today = _today();
    final mealPlan = ref.watch(
      clientMealPlanProvider((clientId: clientId, date: today)),
    );

    return FeatureScreenFrame(
      title: l10n.coachClientDetailTitle,
      contentMaxWidth: AppLayout.screenMaxWidth,
      actions: [
        IconButton(
          tooltip: l10n.supplementsTitle,
          onPressed: () => unawaited(
            context.push('/coach/clients/$clientId/supplements'),
          ),
          icon: const Icon(Icons.medication_outlined),
        ),
        if (compactActions)
          IconButton(
            tooltip: l10n.coachAiInsightButton,
            onPressed: () => unawaited(
              context.push('/coach/clients/$clientId/ai-insight'),
            ),
            icon: const Icon(Icons.auto_awesome_rounded),
          )
        else
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
          ..invalidate(clientExerciseTemplatesProvider(clientId))
          ..invalidate(clientCycleProvider(clientId))
          ..invalidate(
            clientMealPlanProvider((clientId: clientId, date: today)),
          );
      },
      children: [
        _ClientHero(value: profile, unit: unit),
        const SizedBox(height: AppSpacing.md),
        ClientDetailResponsiveLayout(
          primary: _PanelStack(
            children: [
              _TrainingPlanPanel(
                value: clientPlans,
                onCreatePlan: () => _createClientPlan(context, ref),
                onOpenPlan: (plan) {
                  final planId = textOf(plan, ['id', 'planId'], fallback: '');
                  if (planId.isNotEmpty) {
                    unawaited(
                      context.push(
                        trainingRouteLocation(
                          '/plans/$planId',
                          coachView: true,
                          clientId: clientId,
                        ),
                      ),
                    );
                  }
                },
              ),
              _ClientExercisesPanel(
                value: clientExercises,
                onCreate: () => _createClientExercise(context, ref),
                onEdit: (exercise) =>
                    _editClientExercise(context, ref, exercise),
                onDelete: (exercise) =>
                    _deleteClientExercise(context, ref, exercise),
              ),
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
              _CyclePanel(value: cycle),
            ],
          ),
          secondary: _PanelStack(
            children: [
              _ProfileStatsPanel(value: profile),
              _NutritionPanel(
                value: nutrition,
                onOpen: () => unawaited(
                  context.push('/coach/clients/$clientId/nutrition'),
                ),
              ),
              _BodyweightPanel(
                profile: profile,
                history: bodyweightHistory,
                unit: unit,
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class ClientDetailResponsiveLayout extends StatelessWidget {
  const ClientDetailResponsiveLayout({
    required this.primary,
    required this.secondary,
    super.key,
  });

  static const desktopKey = ValueKey('client-detail-desktop-content');
  static const mobileKey = ValueKey('client-detail-mobile-content');

  final Widget primary;
  final Widget secondary;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= 860) {
          return Row(
            key: desktopKey,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(flex: 7, child: primary),
              const SizedBox(width: AppSpacing.md),
              Expanded(flex: 5, child: secondary),
            ],
          );
        }

        return Column(
          key: mobileKey,
          children: [
            secondary,
            const SizedBox(height: AppSpacing.md),
            primary,
          ],
        );
      },
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
      AsyncData(:final value) => XnCard(
        padding: const EdgeInsets.all(AppSpacing.lg),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final identity = _ClientIdentity(value: value);
            final metrics = _HeroKpiGrid(value: value, unit: unit);

            if (constraints.maxWidth >= 720) {
              return Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(width: 250, child: identity),
                  const SizedBox(width: AppSpacing.xl),
                  Expanded(child: metrics),
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                identity,
                const SizedBox(height: AppSpacing.lg),
                metrics,
              ],
            );
          },
        ),
      ),
      AsyncError(:final error) => FeatureError(error: error),
      _ => const LoadingList(),
    };
  }
}

class _ClientIdentity extends StatelessWidget {
  const _ClientIdentity({required this.value});

  final JsonMap value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _ProfileAvatar(
          name: textOf(value, ['fullName', 'name']),
          imageUrl: optionalTextOf(value, [
            'avatarUrl',
            'userAvatarUrl',
            'profilePictureUrl',
            'photoUrl',
          ]),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                textOf(value, ['fullName', 'name']),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: AppTypography.display(
                  23,
                  weight: FontWeight.w600,
                  height: 1.08,
                  letterSpacing: -0.2,
                ),
              ),
              const SizedBox(height: AppSpacing.xs),
              Text(
                textOf(value, ['email']),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: AppColors.fg3,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ],
    );
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
        final columns = constraints.maxWidth >= 620 ? 4 : 2;
        final width = (constraints.maxWidth - 2) / columns;
        return Container(
          width: double.infinity,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            color: AppColors.bgPage,
            borderRadius: BorderRadius.circular(AppRadius.md),
            border: Border.all(color: AppColors.surfaceBorderSoft),
          ),
          child: Wrap(
            children: [
              _HeroKpiCell(
                width: width,
                label: l10n.coachStreakLabel,
                value: _withUnit(
                  textOf(value, ['currentStreak', 'streakDays'], fallback: '0'),
                  l10n.coachDaysUnit,
                ),
                icon: Icons.local_fire_department_rounded,
              ),
              _HeroKpiCell(
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
              ),
              _HeroKpiCell(
                width: width,
                label: l10n.coachBmiLabel,
                value: _bmiLabel(value),
                icon: Icons.show_chart_rounded,
              ),
              _HeroKpiCell(
                width: width,
                label: l10n.coachDotsScoreLabel,
                value: textOf(value, ['dotsScore'], fallback: '-'),
                icon: Icons.auto_graph_rounded,
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HeroKpiCell extends StatelessWidget {
  const _HeroKpiCell({
    required this.width,
    required this.label,
    required this.value,
    required this.icon,
  });

  final double width;
  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                color: AppColors.bg2,
                borderRadius: BorderRadius.circular(AppRadius.sm),
                border: Border.all(color: AppColors.surfaceBorderSoft),
              ),
              child: Icon(icon, color: AppColors.accent, size: 17),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 10,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    value,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: AppTypography.mono(
                      15,
                      weight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
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
      accent: AppColors.dataBlue,
      child: switch (value) {
        AsyncData(:final value) => _InfoGrid(
          items: [
            _InfoItem(
              l10n.profileBioLabel,
              textOf(value, ['bio']),
              Icons.notes_rounded,
            ),
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
              _profileDate(
                textOf(value, ['dateOfBirth', 'birthDate', 'dob']),
              ),
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
    final activePlan = _firstActivePlan(value.value);
    return _PanelFrame(
      title: l10n.coachCurrentTrainingBlockFallback,
      icon: Icons.assignment_outlined,
      accent: AppColors.sage700,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          switch (value) {
            AsyncData() =>
              activePlan == null
                  ? const _EmptyPlanState()
                  : GestureDetector(
                      onTap: () => onOpenPlan(activePlan),
                      child: _PlanCard(value: activePlan),
                    ),
            AsyncError(:final error) => FeatureError(error: error),
            _ => const _PanelLoading(),
          },
          const SizedBox(height: AppSpacing.md),
          ClientTrainingPlanActions(onCreatePlan: onCreatePlan),
        ],
      ),
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
        color: AppColors.bgPage,
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
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
                    ? XnChipTone.sage
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

class _ClientExercisesPanel extends StatelessWidget {
  const _ClientExercisesPanel({
    required this.value,
    required this.onCreate,
    required this.onEdit,
    required this.onDelete,
  });

  final AsyncValue<List<ExerciseTemplate>> value;
  final VoidCallback onCreate;
  final ValueChanged<ExerciseTemplate> onEdit;
  final ValueChanged<ExerciseTemplate> onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.trainingCustomExerciseTitle,
      icon: Icons.fitness_center_rounded,
      accent: AppColors.clay800,
      trailing: TextButton.icon(
        onPressed: onCreate,
        icon: const Icon(Icons.add_rounded, size: 17),
        label: Text(l10n.trainingAddExerciseCta),
      ),
      child: switch (value) {
        AsyncData(:final value) when value.isEmpty => _EmptyInlineState(
          icon: Icons.fitness_center_outlined,
          message: l10n.trainingNoExercisesFoundMessage,
        ),
        AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              l10n.trainingTemplatesCount(value.length),
              style: const TextStyle(color: AppColors.fg3, fontSize: 12),
            ),
            const SizedBox(height: AppSpacing.sm),
            for (final exercise in value) ...[
              _ClientExerciseCard(
                exercise: exercise,
                onEdit: () => onEdit(exercise),
                onDelete: () => onDelete(exercise),
              ),
              if (exercise != value.last) const SizedBox(height: AppSpacing.sm),
            ],
          ],
        ),
        AsyncError(:final error) => FeatureError(error: error),
        _ => const _PanelLoading(),
      },
    );
  }
}

class _ClientExerciseCard extends StatelessWidget {
  const _ClientExerciseCard({
    required this.exercise,
    required this.onEdit,
    required this.onDelete,
  });

  final ExerciseTemplate exercise;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(AppSpacing.md),
      decoration: BoxDecoration(
        color: AppColors.bg3.withValues(alpha: 0.5),
        borderRadius: BorderRadius.circular(AppRadius.md),
        border: Border.all(color: AppColors.surfaceBorderSoft),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  exercise.name,
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
              ),
              IconButton(
                tooltip: l10n.trainingEditExerciseTitle,
                visualDensity: VisualDensity.compact,
                onPressed: onEdit,
                icon: const Icon(Icons.edit_outlined, size: 18),
              ),
              IconButton(
                tooltip: l10n.trainingDeleteExerciseTooltip,
                visualDensity: VisualDensity.compact,
                color: AppColors.danger,
                onPressed: onDelete,
                icon: const Icon(Icons.delete_outline_rounded, size: 18),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${exercise.primaryMuscleGroup} · ${exercise.exerciseKind}',
            style: const TextStyle(color: AppColors.fg2, fontSize: 12),
          ),
          if (exercise.description?.trim().isNotEmpty ?? false) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              exercise.description!.trim(),
              style: const TextStyle(color: AppColors.fg2, height: 1.35),
            ),
          ],
          if (exercise.secondaryMuscleGroups.isNotEmpty) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(
              l10n.trainingSecondaryMuscleGroupsLabel,
              style: const TextStyle(
                color: AppColors.fg3,
                fontSize: 11,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            Wrap(
              spacing: AppSpacing.xs,
              runSpacing: AppSpacing.xs,
              children: [
                for (final group in exercise.secondaryMuscleGroups)
                  XnChip(label: group, compact: true),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _NutritionPanel extends StatelessWidget {
  const _NutritionPanel({required this.value, required this.onOpen});

  final AsyncValue<NutritionSummary> value;
  final VoidCallback onOpen;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return _PanelFrame(
      title: l10n.coachNutritionTitle,
      icon: Icons.restaurant_menu_rounded,
      accent: AppColors.dataAmber,
      trailing: IconButton(
        tooltip: l10n.coachClientNutritionTitle,
        onPressed: onOpen,
        icon: const Icon(Icons.arrow_forward_rounded, size: 18),
      ),
      child: switch (value) {
        AsyncData(:final value) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _MetricGrid(
              metrics: [
                _Metric(
                  l10n.nutritionGoalLabel,
                  _nutritionGoalLabel(value.profile.goal, l10n),
                ),
                _Metric(
                  l10n.nutritionTdeeLabel,
                  _quantity(value.calculation.tdee, l10n.nutritionKcalLabel),
                ),
                _Metric(
                  l10n.dashboardInsightNutritionTargetTitle,
                  _quantity(
                    value.calculation.calorieTarget,
                    l10n.nutritionKcalLabel,
                  ),
                ),
                _Metric(
                  l10n.coachProteinLabel,
                  _quantity(value.calculation.proteinG, 'g'),
                ),
                _Metric(
                  l10n.coachCarbsLabel,
                  _quantity(value.calculation.carbsG, 'g'),
                ),
                _Metric(
                  l10n.coachFatLabel,
                  _quantity(value.calculation.fatG, 'g'),
                ),
              ],
            ),
            const SizedBox(height: AppSpacing.md),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(AppSpacing.md),
              decoration: BoxDecoration(
                color: AppColors.bg3.withValues(alpha: 0.5),
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(color: AppColors.surfaceBorderSoft),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    l10n.dashboardNutritionTodayEyebrow.toUpperCase(),
                    style: const TextStyle(
                      color: AppColors.fg3,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 0.5,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  if (value.todayLog case final log?)
                    _MetricGrid(
                      metrics: [
                        _Metric(
                          l10n.coachCaloriesLabel,
                          _quantity(log.calories, l10n.nutritionKcalLabel),
                        ),
                        _Metric(
                          l10n.coachProteinLabel,
                          _quantity(log.proteinG, 'g'),
                        ),
                        _Metric(
                          l10n.coachCarbsLabel,
                          _quantity(log.carbsG, 'g'),
                        ),
                        _Metric(
                          l10n.coachFatLabel,
                          _quantity(log.fatG, 'g'),
                        ),
                      ],
                    )
                  else
                    const Text('—', style: TextStyle(color: AppColors.fg2)),
                ],
              ),
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
      accent: AppColors.dataTeal,
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
      accent: AppColors.dataRose,
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
      accent: AppColors.dataViolet,
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
    final averageDelta = delta == null ? null : delta / (chartLogs.length - 1);

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
            if (averageDelta != null)
              XnChip(
                label: l10n.coachAverageChangeChip(
                  '${averageDelta >= 0 ? '+' : ''}'
                  '${formatWeight(averageDelta)} ${unit.suffix}',
                ),
                tone: XnChipTone.neutral,
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
          AsyncError(:final error) => AiErrorView(
            error: error,
            onRetry: () => ref.invalidate(clientAiInsightProvider(clientId)),
          ),
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
    final suggestedMessage = optionalTextOf(value, ['suggestedMessage']);

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
        if (sections.isEmpty && suggestedMessage == null)
          _EmptyInlineState(
            icon: Icons.psychology_alt_outlined,
            message: l10n.coachNoAdditionalAiInsightMessage,
          )
        else
          for (final section in sections) ...[
            _AiInsightSection(section: section),
            if (section != sections.last) const SizedBox(height: AppSpacing.md),
          ],
        if (suggestedMessage != null) ...[
          if (sections.isNotEmpty) const SizedBox(height: AppSpacing.md),
          XnSectionGroup(
            children: [
              Row(
                children: [
                  const Icon(
                    Icons.chat_bubble_outline_rounded,
                    color: AppColors.accent,
                    size: 18,
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(
                    child: Text(
                      l10n.coachSuggestedMessageTitle,
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
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(AppSpacing.md),
                decoration: BoxDecoration(
                  color: AppColors.accentSoft,
                  borderRadius: BorderRadius.circular(AppRadius.md),
                  border: Border.all(color: AppColors.clay200),
                ),
                child: Text(
                  suggestedMessage,
                  style: const TextStyle(
                    color: AppColors.fg1,
                    fontWeight: FontWeight.w500,
                    height: 1.45,
                  ),
                ),
              ),
            ],
          ),
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
    required this.accent,
    required this.child,
    this.trailing,
  });

  final String title;
  final IconData icon;
  final Color accent;
  final Widget child;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ClientDetailSectionHeader(
            title: title,
            icon: icon,
            accent: accent,
            trailing: trailing,
          ),
          const SizedBox(height: AppSpacing.md),
          child,
        ],
      ),
    );
  }
}

class _PanelStack extends StatelessWidget {
  const _PanelStack({required this.children});

  final List<Widget> children;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (var index = 0; index < children.length; index++) ...[
          children[index],
          if (index < children.length - 1)
            const SizedBox(height: AppSpacing.md),
        ],
      ],
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
  const _ProfileAvatar({required this.name, this.imageUrl});

  final String name;
  final String? imageUrl;

  @override
  Widget build(BuildContext context) {
    return XnUserAvatar(
      name: name,
      imageUrl: imageUrl,
      size: 64,
      backgroundColor: AppColors.paperAlt,
      foregroundColor: AppColors.ink900,
      borderColor: AppColors.fgOnClay.withValues(alpha: 0.16),
      borderRadius: AppRadius.lg,
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

String _quantity(num? value, String unit) {
  if (value == null) return '-';
  final rendered = value == value.roundToDouble()
      ? value.round().toString()
      : value.toStringAsFixed(1);
  return '$rendered $unit';
}

String _nutritionGoalLabel(String goal, AppLocalizations l10n) {
  return switch (goal.toLowerCase()) {
    'cut' => l10n.nutritionGoalCut,
    'maintain' => l10n.nutritionGoalMaintain,
    'bulk' => l10n.nutritionGoalBulk,
    _ => goal,
  };
}

String _profileDate(String raw) {
  final parsed = DateTime.tryParse(raw);
  if (parsed == null) return raw;
  final day = parsed.day.toString().padLeft(2, '0');
  final month = parsed.month.toString().padLeft(2, '0');
  return '$day/$month/${parsed.year}';
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

JsonMap? _firstActivePlan(List<JsonMap>? plans) {
  if (plans == null) return null;
  for (final plan in plans) {
    if (_isActivePlan(plan)) return plan;
  }
  return null;
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

List<JsonMap> _mergeClientPlanDashboard({
  required List<JsonMap> plans,
  required List<JsonMap> dashboard,
  required String clientId,
}) {
  JsonMap? clientStats;
  for (final entry in dashboard) {
    if (optionalTextOf(entry, ['clientId'])?.toLowerCase() ==
        clientId.toLowerCase()) {
      clientStats = entry;
      break;
    }
  }

  final activePlanId = clientStats == null
      ? null
      : optionalTextOf(clientStats, ['activePlanId']);
  final progress = clientStats == null
      ? null
      : clientStats['planProgressPercent'] ??
            clientStats['activePlanProgressPercent'];

  return plans.map((plan) {
    final planId = optionalTextOf(plan, ['id', 'planId']);
    final isActive = activePlanId?.isNotEmpty == true
        ? planId?.toLowerCase() == activePlanId!.toLowerCase()
        : _isPlanActiveToday(plan);
    return {
      ...plan,
      'isActive': isActive,
      if (isActive && progress != null) 'progressPercent': progress,
    };
  }).toList();
}

bool _isPlanActiveToday(JsonMap plan) {
  final start = DateTime.tryParse(textOf(plan, ['startDate'], fallback: ''));
  final end = DateTime.tryParse(textOf(plan, ['endDate'], fallback: ''));
  if (start == null || end == null) return false;
  final today = _today();
  final startDate = DateTime(start.year, start.month, start.day);
  final endDate = DateTime(end.year, end.month, end.day);
  return !today.isBefore(startDate) && !today.isAfter(endDate);
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
