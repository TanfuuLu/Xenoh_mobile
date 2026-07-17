import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/synced_background_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../auth/presentation/providers/auth_state.dart';
import '../../../profile/data/repositories/profile_background_repository.dart';
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/plan.dart';
import '../providers/coach_client_plans_provider.dart';
import '../providers/plans_controller.dart';
import '../widgets/ai_starter_plan_sheet.dart';
import '../widgets/create_plan_sheet.dart';
import '../widgets/plan_card.dart';

class PlansScreen extends ConsumerStatefulWidget {
  const PlansScreen({super.key});

  @override
  ConsumerState<PlansScreen> createState() => _PlansScreenState();
}

class _PlansScreenState extends ConsumerState<PlansScreen> {
  final _scroll = ScrollController();

  @override
  void initState() {
    super.initState();
    _scroll.addListener(_onScroll);
  }

  @override
  void dispose() {
    _scroll
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  void _onScroll() {
    if (_scroll.position.pixels >= _scroll.position.maxScrollExtent - 240) {
      unawaited(ref.read(plansControllerProvider.notifier).loadMore());
    }
  }

  Future<void> _createPlan() async {
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => const CreatePlanSheet(),
    );
    if (created ?? false) {
      if (!mounted) return;
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
  }

  Future<void> _createAiPlan() async {
    final newPlanId = await showModalBottomSheet<String>(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.bgPage,
      builder: (_) => const AiStarterPlanSheet(),
    );
    if (newPlanId == null || !mounted) return;
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(
        SnackBar(
          content: Text(
            AppLocalizations.of(context).trainingAiPlanCreatedSnackbar,
          ),
        ),
      );
    unawaited(context.push('/plans/$newPlanId'));
  }

  @override
  Widget build(BuildContext context) {
    final plans = ref.watch(plansControllerProvider);
    final isCoach =
        ref.watch(authControllerProvider).sessionOrNull?.user.isCoach ?? false;
    final coachClientPlans = isCoach
        ? ref.watch(coachClientPlansProvider)
        : null;
    final backgroundPath = ref
        .watch(
          profileBackgroundPathProvider(ProfileBackgroundRepository.deviceKey),
        )
        .value;
    final backgroundAlignment =
        ref
            .watch(
              profileBackgroundAlignmentProvider(
                ProfileBackgroundRepository.deviceKey,
              ),
            )
            .value ??
        Alignment.center;

    return Scaffold(
      appBar: AppBar(
        leading: const HomeShellMenuButton(),
        title: Text(AppLocalizations.of(context).trainingPlansHeaderTitle),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.surfaceBorderSoft),
        ),
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          if (isCoach) ref.invalidate(coachClientPlansProvider);
          await ref.read(plansControllerProvider.notifier).refresh();
        },
        child: AsyncValueView(
          value: plans,
          onRetry: () => ref.invalidate(plansControllerProvider),
          data: (items) => _PlansBody(
            plans: items,
            coachClientPlans: coachClientPlans,
            backgroundImagePath: backgroundPath,
            backgroundAlignment: backgroundAlignment,
            controller: _scroll,
            onCreatePlan: _createPlan,
            onCreateAiPlan: _createAiPlan,
            onOpenPlan: (plan) => context.push('/plans/${plan.id}'),
            onOpenAnalytics: (plan) =>
                context.push('/plans/${plan.id}/analytics'),
            onOpenReview: (plan) =>
                context.push('/plans/${plan.id}/design-analysis'),
            onActivate: _activate,
            onDelete: _confirmDelete,
            onActivateClientPlan: _activateClientPlan,
            onDeleteClientPlan: _confirmDeleteClientPlan,
          ),
        ),
      ),
    );
  }

  Future<void> _activate(Plan plan) async {
    final notifier = ref.read(plansControllerProvider.notifier);
    try {
      if (plan.isActive) {
        await notifier.deactivate(plan.id);
      } else {
        await notifier.activate(plan.id);
      }
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  Future<void> _confirmDelete(Plan plan) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trainingDeletePlanTitle),
        content: Text(l10n.trainingDeletePlanMessage(plan.name)),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok ?? false) {
      try {
        await ref.read(plansControllerProvider.notifier).deletePlan(plan.id);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }

  Future<void> _activateClientPlan(Plan plan) async {
    final repo = ref.read(trainingRepositoryProvider);
    try {
      if (plan.isActive) {
        await repo.deactivatePlan(plan.id);
      } else {
        await repo.activatePlan(plan.id);
      }
      ref.invalidate(coachClientPlansProvider);
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('$e')),
      );
    }
  }

  Future<void> _confirmDeleteClientPlan(Plan plan) async {
    final l10n = AppLocalizations.of(context);
    final ok = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text(l10n.trainingDeleteClientPlanTitle),
        content: Text(
          l10n.trainingDeleteClientPlanMessage(plan.name, plan.ownerName),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            style: FilledButton.styleFrom(backgroundColor: AppColors.danger),
            onPressed: () => Navigator.pop(ctx, true),
            child: Text(l10n.commonDelete),
          ),
        ],
      ),
    );
    if (ok ?? false) {
      try {
        await ref.read(trainingRepositoryProvider).deletePlan(plan.id);
        ref.invalidate(coachClientPlansProvider);
      } catch (e) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('$e')),
        );
      }
    }
  }
}

class _PlansBody extends StatelessWidget {
  const _PlansBody({
    required this.plans,
    required this.coachClientPlans,
    required this.backgroundImagePath,
    required this.controller,
    required this.onCreatePlan,
    required this.onCreateAiPlan,
    required this.onOpenPlan,
    required this.onOpenAnalytics,
    required this.onOpenReview,
    required this.onActivate,
    required this.onDelete,
    required this.onActivateClientPlan,
    required this.onDeleteClientPlan,
    this.backgroundAlignment = Alignment.center,
  });

  final List<Plan> plans;

  /// Plans the coach created for clients, grouped by client. Null for
  /// non-coach users (the section is hidden entirely).
  final AsyncValue<List<CoachClientPlanGroup>>? coachClientPlans;
  final String? backgroundImagePath;
  final Alignment backgroundAlignment;
  final ScrollController controller;
  final VoidCallback onCreatePlan;
  final VoidCallback onCreateAiPlan;
  final ValueChanged<Plan> onOpenPlan;
  final ValueChanged<Plan> onOpenAnalytics;
  final ValueChanged<Plan> onOpenReview;
  final ValueChanged<Plan> onActivate;
  final ValueChanged<Plan> onDelete;
  final ValueChanged<Plan> onActivateClientPlan;
  final ValueChanged<Plan> onDeleteClientPlan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final myPlans = plans.where((plan) => plan.planType != 'Coach').toList();
    final coachPlans = plans.where((plan) => plan.planType == 'Coach').toList();

    return ListView(
      controller: controller,
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xxl,
      ),
      children: [
        _PlansHeader(
          myPlanCount: myPlans.length,
          coachPlanCount: coachPlans.length,
          backgroundImagePath: backgroundImagePath,
          backgroundAlignment: backgroundAlignment,
          onCreatePlan: onCreatePlan,
          onCreateAiPlan: onCreateAiPlan,
        ),
        const SizedBox(height: AppSpacing.xl),
        _GroupHeader(
          title: l10n.trainingMyPlansTitle,
          subtitle: l10n.trainingMyPlansSubtitle(myPlans.length),
        ),
        const SizedBox(height: AppSpacing.md),
        if (myPlans.isEmpty)
          _SectionEmpty(
            message: l10n.trainingNoPersonalPlansMessage,
            icon: Icons.calendar_month_outlined,
          )
        else
          for (final plan in myPlans) ...[
            PlanCard(
              plan: plan,
              onTap: () => onOpenPlan(plan),
              onAnalytics: () => onOpenAnalytics(plan),
              onReview: () => onOpenReview(plan),
              onActivate: () => onActivate(plan),
              onDelete: () => onDelete(plan),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        if (coachClientPlans case final clientPlans?) ...[
          const SizedBox(height: AppSpacing.lg),
          _GroupHeader(
            title: l10n.trainingClientPlansTitle,
            subtitle: _clientSubtitle(clientPlans, l10n),
          ),
          const SizedBox(height: AppSpacing.md),
          ..._clientPlanWidgets(clientPlans, l10n),
        ],
        if (coachPlans.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.lg),
          _GroupHeader(
            title: l10n.trainingCoachPlansTitle,
            subtitle: l10n.trainingCoachPlansSubtitle(coachPlans.length),
          ),
          const SizedBox(height: AppSpacing.md),
          for (final plan in coachPlans) ...[
            PlanCard(
              plan: plan,
              onTap: () => onOpenPlan(plan),
              onAnalytics: () => onOpenAnalytics(plan),
              onReview: () => onOpenReview(plan),
              onActivate: () => onActivate(plan),
              onDelete: () => onDelete(plan),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ],
    );
  }

  /// Client-plan area content, grouped by client, as standalone widgets.
  List<Widget> _clientPlanWidgets(
    AsyncValue<List<CoachClientPlanGroup>> plans,
    AppLocalizations l10n,
  ) {
    return switch (plans) {
      AsyncData(:final value) when value.isEmpty => [
        _SectionEmpty(
          message: l10n.trainingNoClientPlansMessage,
          icon: Icons.assignment_outlined,
        ),
      ],
      AsyncData(:final value) => [
        for (final group in value) ...[
          _ClientGroupHeader(name: group.clientName, count: group.plans.length),
          const SizedBox(height: AppSpacing.sm),
          for (final plan in group.plans) ...[
            PlanCard(
              plan: plan,
              manageAsCoach: true,
              onTap: () => onOpenPlan(plan),
              onAnalytics: () => onOpenAnalytics(plan),
              onReview: () => onOpenReview(plan),
              onActivate: () => onActivateClientPlan(plan),
              onDelete: () => onDeleteClientPlan(plan),
            ),
            const SizedBox(height: AppSpacing.md),
          ],
        ],
      ],
      AsyncError() => [
        _SectionEmpty(
          message: l10n.trainingCouldNotLoadClientPlansMessage,
          icon: Icons.error_outline_rounded,
        ),
      ],
      _ => const [_SectionLoading()],
    };
  }

  String _clientSubtitle(
    AsyncValue<List<CoachClientPlanGroup>> plans,
    AppLocalizations l10n,
  ) {
    final groups = plans.value;
    if (groups == null || groups.isEmpty) {
      return l10n.trainingPlansBuiltForClientsSubtitle;
    }
    final total = groups.fold<int>(0, (sum, g) => sum + g.plans.length);
    if (total == 0) return l10n.trainingPlansBuiltForClientsSubtitle;
    return l10n.trainingClientPlansCountSubtitle(total, groups.length);
  }
}

/// A quiet small-caps group label + subtitle. Kept deliberately subordinate to
/// the serif plan-card titles so it reads as a section marker, not a heading.
class _GroupHeader extends StatelessWidget {
  const _GroupHeader({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: AppSpacing.xs, bottom: 2),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: AppColors.fg2,
              fontSize: 13,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.4,
            ),
          ),
          const SizedBox(height: 3),
          Text(
            subtitle,
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
    );
  }
}

class _ClientGroupHeader extends StatelessWidget {
  const _ClientGroupHeader({required this.name, required this.count});

  final String name;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: AppSpacing.xs, bottom: 2),
      child: Row(
        children: [
          const Icon(
            Icons.person_outline_rounded,
            size: 15,
            color: AppColors.fg3,
          ),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              name,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.fg2,
                fontSize: 12,
                fontWeight: FontWeight.w500,
                letterSpacing: 0.2,
              ),
            ),
          ),
          Text(
            '$count',
            style: AppTypography.mono(
              12,
              weight: FontWeight.w500,
              color: AppColors.fg3,
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionLoading extends StatelessWidget {
  const _SectionLoading();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 72,
      child: Center(
        child: SizedBox(
          width: 22,
          height: 22,
          child: CircularProgressIndicator(strokeWidth: 2.4),
        ),
      ),
    );
  }
}

class _PlansHeader extends StatelessWidget {
  const _PlansHeader({
    required this.myPlanCount,
    required this.coachPlanCount,
    required this.backgroundImagePath,
    required this.onCreatePlan,
    required this.onCreateAiPlan,
    this.backgroundAlignment = Alignment.center,
  });

  final int myPlanCount;
  final int coachPlanCount;
  final String? backgroundImagePath;
  final Alignment backgroundAlignment;
  final VoidCallback onCreatePlan;
  final VoidCallback onCreateAiPlan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SyncedBackgroundCard(
      backgroundImagePath: backgroundImagePath,
      backgroundAlignment: backgroundAlignment,
      minHeight: 0,
      padding: const EdgeInsets.all(AppSpacing.xl),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.trainingPlansHeaderTitle,
                      style: AppTypography.display(
                        25,
                        weight: FontWeight.w500,
                        color: AppColors.fgOnClay,
                        letterSpacing: 0,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.trainingPlansHeaderSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: const TextStyle(
                        color: AppColors.clay200,
                        fontSize: 13,
                        height: 1.35,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppColors.clay100.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.clay200.withValues(alpha: 0.2),
                  ),
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: AppColors.clay100,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _HeaderMetric(
                  label: l10n.trainingMyPlansTitle,
                  value: '$myPlanCount',
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _HeaderMetric(
                  label: l10n.trainingCoachPlansTitle,
                  value: '$coachPlanCount',
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _PillAction(
                  label: l10n.trainingAiStarterCta,
                  icon: Icons.auto_awesome_rounded,
                  onPressed: onCreateAiPlan,
                  filled: false,
                  inverse: true,
                ),
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: _PillAction(
                  label: l10n.trainingNewPlanTitle,
                  icon: Icons.add_rounded,
                  onPressed: onCreatePlan,
                  filled: true,
                  inverse: true,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _HeaderMetric extends StatelessWidget {
  const _HeaderMetric({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.sm,
      ),
      decoration: BoxDecoration(
        color: AppColors.clay100.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          Text(
            value,
            style: AppTypography.mono(
              18,
              weight: FontWeight.w500,
              color: AppColors.fgOnClay,
            ),
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Text(
              label,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.clay200,
                fontSize: 11,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PillAction extends StatelessWidget {
  const _PillAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.filled,
    this.inverse = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;
  final bool inverse;

  @override
  Widget build(BuildContext context) {
    final bg = filled
        ? (inverse ? AppColors.clay100 : AppColors.accent)
        : (inverse ? AppColors.clay100.withValues(alpha: 0.12) : AppColors.bg2);
    final fg = filled
        ? (inverse ? AppColors.ink900 : AppColors.fgOnClay)
        : (inverse ? AppColors.fgOnClay : AppColors.fg1);
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        side: BorderSide(
          color: inverse
              ? AppColors.clay200.withValues(alpha: 0.2)
              : filled
              ? AppColors.accentHover
              : AppColors.surfaceBorderSoft,
        ),
        shape: const StadiumBorder(),
        elevation: 0,
        iconSize: 19,
        minimumSize: const Size.fromHeight(40),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 9),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

class _SectionEmpty extends StatelessWidget {
  const _SectionEmpty({required this.message, required this.icon});

  final String message;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.lg,
      ),
      child: Column(
        children: [
          Icon(icon, color: AppColors.fg3, size: 28),
          const SizedBox(height: AppSpacing.sm),
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(color: AppColors.fg2),
          ),
        ],
      ),
    );
  }
}
