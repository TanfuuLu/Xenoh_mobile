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
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/plan.dart';
import '../navigation/training_route_scope.dart';
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
            controller: _scroll,
            onCreatePlan: _createPlan,
            onCreateAiPlan: _createAiPlan,
            onOpenPlan: (plan, clientId) => context.push(
              trainingRouteLocation(
                '/plans/${plan.id}',
                coachView: clientId != null,
                coachPlan: plan.planType == 'Coach',
                clientId: clientId,
              ),
            ),
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
    required this.controller,
    required this.onCreatePlan,
    required this.onCreateAiPlan,
    required this.onOpenPlan,
    required this.onOpenReview,
    required this.onActivate,
    required this.onDelete,
    required this.onActivateClientPlan,
    required this.onDeleteClientPlan,
  });

  final List<Plan> plans;

  /// Plans the coach created for clients, grouped by client. Null for
  /// non-coach users (the section is hidden entirely).
  final AsyncValue<List<CoachClientPlanGroup>>? coachClientPlans;
  final ScrollController controller;
  final VoidCallback onCreatePlan;
  final VoidCallback onCreateAiPlan;
  final void Function(Plan plan, String? clientId) onOpenPlan;
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
              onTap: () => onOpenPlan(plan, null),
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
              onTap: () => onOpenPlan(plan, null),
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
              onTap: () => onOpenPlan(plan, group.clientId),
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
      height: 63,
      child: Center(
        child: SizedBox(
          width: 20,
          height: 20,
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
    required this.onCreatePlan,
    required this.onCreateAiPlan,
  });

  final int myPlanCount;
  final int coachPlanCount;
  final VoidCallback onCreatePlan;
  final VoidCallback onCreateAiPlan;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SyncedBackgroundCard(
      padding: const EdgeInsets.all(AppSpacing.lg),
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
                        26,
                        weight: FontWeight.w700,
                        color: AppColors.fgOnClay,
                        letterSpacing: -0.3,
                        height: 1.05,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.trainingPlansHeaderSubtitle,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: AppColors.fgOnClay.withValues(alpha: 0.78),
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
                  color: AppColors.fgOnClay.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(AppRadius.lg),
                  border: Border.all(
                    color: AppColors.fgOnClay.withValues(alpha: 0.16),
                  ),
                ),
                child: const Icon(
                  Icons.lightbulb_outline_rounded,
                  color: AppColors.clay200,
                  size: 24,
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.lg),
          _HeaderStats(
            myPlanCount: myPlanCount,
            coachPlanCount: coachPlanCount,
          ),
          const SizedBox(height: AppSpacing.lg),
          LayoutBuilder(
            builder: (context, constraints) {
              final aiAction = _PillAction(
                label: l10n.trainingAiStarterCta,
                icon: Icons.auto_awesome_rounded,
                onPressed: onCreateAiPlan,
                filled: false,
              );
              final createAction = _PillAction(
                label: l10n.trainingNewPlanTitle,
                icon: Icons.add_rounded,
                onPressed: onCreatePlan,
                filled: true,
              );
              if (constraints.maxWidth < 360) {
                return Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    aiAction,
                    const SizedBox(height: AppSpacing.sm),
                    createAction,
                  ],
                );
              }
              return Row(
                children: [
                  Expanded(child: aiAction),
                  const SizedBox(width: AppSpacing.sm),
                  Expanded(child: createAction),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}

/// Plan counts as one translucent strip rather than two opaque cards: the
/// header sits on a user-chosen photo, so tinted glass keeps the counts
/// readable without competing with the actions below them.
class _HeaderStats extends StatelessWidget {
  const _HeaderStats({
    required this.myPlanCount,
    required this.coachPlanCount,
  });

  final int myPlanCount;
  final int coachPlanCount;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      decoration: BoxDecoration(
        color: AppColors.fgOnClay.withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppRadius.lg),
        border: Border.all(
          color: AppColors.fgOnClay.withValues(alpha: 0.16),
        ),
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.md,
        vertical: AppSpacing.md,
      ),
      child: Row(
        children: [
          Expanded(
            child: _HeaderStat(
              label: l10n.trainingMyPlansTitle,
              value: myPlanCount,
            ),
          ),
          Container(
            width: 1,
            height: 34,
            color: AppColors.fgOnClay.withValues(alpha: 0.16),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(left: AppSpacing.md),
              child: _HeaderStat(
                label: l10n.trainingCoachPlansTitle,
                value: coachPlanCount,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _HeaderStat extends StatelessWidget {
  const _HeaderStat({required this.label, required this.value});

  final String label;
  final int value;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          '$value',
          style: AppTypography.display(
            24,
            weight: FontWeight.w700,
            color: AppColors.fgOnClay,
            height: 1,
            letterSpacing: -0.5,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          label.toUpperCase(),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            color: AppColors.fgOnClay.withValues(alpha: 0.7),
            fontSize: 10,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.8,
          ),
        ),
      ],
    );
  }
}

class _PillAction extends StatelessWidget {
  const _PillAction({
    required this.label,
    required this.icon,
    required this.onPressed,
    required this.filled,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;
  final bool filled;

  @override
  Widget build(BuildContext context) {
    // On the photo header the primary action is the solid light pill; the
    // secondary one stays glass so it never outshouts it.
    final bg = filled
        ? AppColors.clay050
        : AppColors.fgOnClay.withValues(alpha: 0.12);
    final fg = filled ? AppColors.clay900 : AppColors.fgOnClay;
    return FilledButton.icon(
      onPressed: onPressed,
      icon: Icon(icon),
      label: Text(label),
      style: FilledButton.styleFrom(
        backgroundColor: bg,
        foregroundColor: fg,
        side: BorderSide(
          color: filled
              ? AppColors.clay050
              : AppColors.fgOnClay.withValues(alpha: 0.28),
        ),
        shape: const StadiumBorder(),
        elevation: 0,
        iconSize: 19,
        minimumSize: const Size.fromHeight(44),
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        textStyle: const TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w600,
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
