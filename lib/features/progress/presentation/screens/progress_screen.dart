import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/failure_l10n.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/pro_locked_view.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/domain/entities/volume_history_point.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/providers/profile_controller.dart';
import '../../../training/domain/entities/plan.dart';
import '../../../training/presentation/providers/plans_controller.dart';
import '../../domain/entities/plan_analytics.dart';
import '../providers/progress_controllers.dart';
import '../widgets/powerlifting_panel.dart';
import '../widgets/volume_history_card.dart';
import 'plan_analytics_screen.dart';

/// Plan progress: pick one of the user's plans (defaulting to the active one)
/// and view its analytics — mirrors the website Progress page. Replaces the
/// former personal-records entry point for the "Progress" navigation item.
class ProgressScreen extends ConsumerStatefulWidget {
  const ProgressScreen({super.key});

  @override
  ConsumerState<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends ConsumerState<ProgressScreen> {
  String? _selectedPlanId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final plans = ref.watch(plansControllerProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l10n.progressTitle)),
      body: AsyncValueView(
        value: plans,
        onRetry: () => ref.invalidate(plansControllerProvider),
        data: (items) {
          if (items.isEmpty) return const _NoPlans();
          final selected = _resolveSelected(items);
          return _PlanProgress(
            plans: items,
            selectedPlanId: selected.id,
            onSelect: (id) => setState(() => _selectedPlanId = id),
          );
        },
      ),
    );
  }

  /// The plan to show: the last user choice if still present, otherwise the
  /// active plan, otherwise the first plan.
  Plan _resolveSelected(List<Plan> plans) {
    final chosen = plans.where((p) => p.id == _selectedPlanId);
    if (chosen.isNotEmpty) return chosen.first;
    return plans.firstWhere((p) => p.isActive, orElse: () => plans.first);
  }
}

enum _ProgressTab { overview, powerlifting }

class _PlanProgress extends ConsumerStatefulWidget {
  const _PlanProgress({
    required this.plans,
    required this.selectedPlanId,
    required this.onSelect,
  });

  final List<Plan> plans;
  final String selectedPlanId;
  final ValueChanged<String> onSelect;

  @override
  ConsumerState<_PlanProgress> createState() => _PlanProgressState();
}

class _PlanProgressState extends ConsumerState<_PlanProgress> {
  _ProgressTab _tab = _ProgressTab.overview;
  var _volumeMonths = 6;

  @override
  Widget build(BuildContext context) {
    final analytics = ref.watch(planAnalyticsProvider(widget.selectedPlanId));
    final volume = ref.watch(volumeHistoryProvider(_volumeMonths));

    return RefreshIndicator(
      color: AppColors.accent,
      onRefresh: () {
        ref
          ..invalidate(plansControllerProvider)
          ..invalidate(volumeHistoryProvider(_volumeMonths));
        return ref.refresh(planAnalyticsProvider(widget.selectedPlanId).future);
      },
      child: _content(context, analytics, volume),
    );
  }

  Widget _content(
    BuildContext context,
    AsyncValue<PlanAnalytics> analytics,
    AsyncValue<List<VolumeHistoryPoint>> volume,
  ) {
    final l10n = AppLocalizations.of(context);
    final selector = _PlanSelector(
      plans: widget.plans,
      selectedPlanId: widget.selectedPlanId,
      onSelect: widget.onSelect,
    );

    // Pro gate: surface a clear upgrade prompt instead of a generic error.
    if (!analytics.hasValue && analytics.error is ForbiddenFailure) {
      return ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          selector,
          const SizedBox(height: AppSpacing.lg),
          _volumeCard(volume),
          const SizedBox(height: AppSpacing.lg),
          ProLockedView(
            title: l10n.progressProFeatureTitle,
            message: localizedFailureMessage(
              analytics.error! as ForbiddenFailure,
              l10n,
            ),
            onUpgrade: () => context.push('/subscription'),
          ),
        ],
      );
    }

    return AsyncValueView(
      value: analytics,
      onRetry: () =>
          ref.invalidate(planAnalyticsProvider(widget.selectedPlanId)),
      loading: ListView(
        padding: const EdgeInsets.all(AppSpacing.lg),
        children: [
          selector,
          const SizedBox(height: AppSpacing.lg),
          _volumeCard(volume),
          SizedBox(
            height: MediaQuery.sizeOf(context).height * 0.5,
            child: const Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
      data: (a) {
        final powerlifting = a.powerlifting;
        // No powerlifting data for this plan → force the overview tab.
        final tab = powerlifting == null ? _ProgressTab.overview : _tab;
        return ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            selector,
            const SizedBox(height: AppSpacing.lg),
            _volumeCard(volume),
            if (powerlifting != null) ...[
              const SizedBox(height: AppSpacing.md),
              _TabBar(
                current: tab,
                onChange: (t) => setState(() => _tab = t),
              ),
            ],
            const SizedBox(height: AppSpacing.lg),
            if (tab == _ProgressTab.powerlifting && powerlifting != null)
              PowerliftingPanel(
                section: powerlifting,
                unit: ref.watch(weightUnitProvider),
              )
            else
              PlanAnalyticsView(
                analytics: a,
                unit: ref.watch(weightUnitProvider),
                trackRpe: ref.watch(trackRpeProvider),
              ),
          ],
        );
      },
    );
  }

  Widget _volumeCard(AsyncValue<List<VolumeHistoryPoint>> volume) {
    final l10n = AppLocalizations.of(context);
    return switch (volume) {
      AsyncData(:final value) => VolumeHistoryCard(
        points: value,
        unit: ref.watch(weightUnitProvider),
        months: _volumeMonths,
        onMonthsChanged: (months) => setState(() => _volumeMonths = months),
      ),
      AsyncError() => XnSectionGroup(
        children: [
          Text(l10n.progressVolumeHistoryLoadError),
          const SizedBox(height: AppSpacing.sm),
          Align(
            alignment: Alignment.centerLeft,
            child: TextButton(
              onPressed: () => ref.invalidate(
                volumeHistoryProvider(_volumeMonths),
              ),
              child: Text(l10n.commonRetry),
            ),
          ),
        ],
      ),
      _ => const XnSectionGroup(
        children: [
          SizedBox(
            height: 160,
            child: Center(child: CircularProgressIndicator()),
          ),
        ],
      ),
    };
  }
}

/// Overview / Powerlifting segmented toggle, shown only when the plan has
/// competition-lift data.
class _TabBar extends StatelessWidget {
  const _TabBar({required this.current, required this.onChange});

  final _ProgressTab current;
  final ValueChanged<_ProgressTab> onChange;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Container(
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: AppColors.bg3,
        borderRadius: BorderRadius.circular(AppRadius.md),
      ),
      child: Row(
        children: [
          _segment(l10n.progressOverviewTab, _ProgressTab.overview),
          _segment(l10n.progressPowerliftingTab, _ProgressTab.powerlifting),
        ],
      ),
    );
  }

  Widget _segment(String label, _ProgressTab tab) {
    final selected = current == tab;
    return Expanded(
      child: GestureDetector(
        onTap: () => onChange(tab),
        behavior: HitTestBehavior.opaque,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 150),
          padding: const EdgeInsets.symmetric(vertical: 8),
          decoration: BoxDecoration(
            color: selected ? AppColors.bg2 : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.sm),
          ),
          alignment: Alignment.center,
          child: Text(
            label,
            style: TextStyle(
              color: selected ? AppColors.fg1 : AppColors.fg3,
              fontWeight: FontWeight.w500,
              fontSize: 13,
            ),
          ),
        ),
      ),
    );
  }
}

/// Dropdown to switch between the user's plans, with the active plan marked.
class _PlanSelector extends StatelessWidget {
  const _PlanSelector({
    required this.plans,
    required this.selectedPlanId,
    required this.onSelect,
  });

  final List<Plan> plans;
  final String selectedPlanId;
  final ValueChanged<String> onSelect;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final current = plans.firstWhere((p) => p.id == selectedPlanId);
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: AppColors.bg2.withValues(alpha: 0.92),
        borderRadius: BorderRadius.circular(AppRadius.xl),
        border: Border.all(
          color: AppColors.surfaceBorderSoft.withValues(alpha: 0.46),
        ),
      ),
      child: PopupMenuButton<String>(
        initialValue: selectedPlanId,
        tooltip: l10n.progressSelectPlanTooltip,
        position: PopupMenuPosition.under,
        onSelected: onSelect,
        itemBuilder: (_) => [
          for (final p in plans)
            PopupMenuItem<String>(
              value: p.id,
              child: Row(
                children: [
                  Expanded(child: Text(p.name)),
                  if (p.isActive)
                    Padding(
                      padding: const EdgeInsets.only(left: AppSpacing.sm),
                      child: Text(
                        l10n.progressActiveLabel,
                        style: AppTypography.mono(11, color: AppColors.accent),
                      ),
                    ),
                ],
              ),
            ),
        ],
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          child: Row(
            children: [
              const Icon(
                Icons.fitness_center_rounded,
                size: 18,
                color: AppColors.fg3,
              ),
              const SizedBox(width: AppSpacing.sm),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      l10n.progressPlanEyebrow,
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 10,
                        fontWeight: FontWeight.w500,
                        letterSpacing: 0.6,
                      ),
                    ),
                    const SizedBox(height: 1),
                    Text(
                      current.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: AppTypography.display(16, letterSpacing: 0),
                    ),
                  ],
                ),
              ),
              if (current.isActive)
                Padding(
                  padding: const EdgeInsets.only(right: AppSpacing.sm),
                  child: Text(
                    l10n.progressActiveLabel,
                    style: AppTypography.mono(11, color: AppColors.accent),
                  ),
                ),
              const Icon(Icons.expand_more_rounded, color: AppColors.fg3),
            ],
          ),
        ),
      ),
    );
  }
}

class _NoPlans extends StatelessWidget {
  const _NoPlans();

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
                    Icons.trending_up_outlined,
                    size: 48,
                    color: AppColors.fg4,
                  ),
                  const SizedBox(height: AppSpacing.md),
                  Text(
                    l10n.progressNoPlansTitle,
                    style: const TextStyle(
                      color: AppColors.fg2,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  Text(
                    l10n.progressNoPlansMessage,
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
