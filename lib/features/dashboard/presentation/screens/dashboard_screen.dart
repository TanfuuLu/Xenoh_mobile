import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/realtime/realtime_service.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../notifications/presentation/screens/notification_center_screen.dart';
import '../../../nutrition/presentation/providers/nutrition_controller.dart';
import '../../../profile/data/repositories/profile_background_repository.dart';
import '../../../profile/data/repositories/profile_repository_provider.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/providers/profile_controller.dart';
import '../../../profile/presentation/widgets/bodyweight_card.dart';
import '../../../profile/presentation/widgets/log_bodyweight_dialog.dart';
import '../../domain/entities/personal_dashboard.dart';
import '../providers/dashboard_controller.dart';
import '../utils/dashboard_localization.dart';
import '../widgets/dashboard_hero.dart';
import '../widgets/nutrition_card.dart';
import '../widgets/plate_calculator_card.dart';
import '../widgets/pro_insights_card.dart';
import '../widgets/today_meal_plan_card.dart';
import '../widgets/today_workout_card.dart';

/// Date-only key for today, matching the key used by the nutrition card so
/// pull-to-refresh invalidates the same `foodLogsProvider` instance.
DateTime _todayKey() {
  final now = DateTime.now();
  return DateTime(now.year, now.month, now.day);
}

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen(realtimeEventsProvider, (_, next) {
      final event = next.value;
      if (event == null) return;
      if (event.name == 'ReceiveNotification') {
        ref.invalidate(notificationsProvider);
      }
    });

    final dashboard = ref.watch(dashboardControllerProvider);
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
    final unreadNotifications = ref
        .watch(notificationsProvider)
        .value
        ?.where((n) => n['isRead'] != true)
        .length;

    return Scaffold(
      appBar: AppBar(
        leading: const HomeShellMenuButton(),
        title: Image.asset(
          'assets/icon/banner_logo_xenoh.png',
          height: 30,
          width: 168,
          fit: BoxFit.contain,
          alignment: Alignment.centerLeft,
          filterQuality: FilterQuality.medium,
        ),
        actions: [
          _NotificationBell(
            unreadCount: unreadNotifications ?? 0,
            onPressed: () => context.push('/notifications'),
          ),
        ],
      ),
      body: RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () async {
          // Refresh the dashboard and the nutrition source the card reads from,
          // so a pull-to-refresh updates both in step.
          await ref.read(dashboardControllerProvider.notifier).refresh();
          await ref.read(nutritionControllerProvider.notifier).refresh();
          final today = _todayKey();
          ref
            ..invalidate(foodLogsProvider(today))
            ..invalidate(mealPlanProvider(today));
        },
        child: AsyncValueView(
          value: dashboard,
          onRetry: () => ref.invalidate(dashboardControllerProvider),
          data: (data) => _DashboardBody(
            data: data,
            backgroundImagePath: backgroundPath,
            backgroundAlignment: backgroundAlignment,
            unit: ref.watch(weightUnitProvider),
          ),
        ),
      ),
    );
  }
}

class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.unreadCount, required this.onPressed});

  final int unreadCount;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          tooltip: AppLocalizations.of(context).dashboardNotificationsTooltip,
          icon: const Icon(Icons.notifications_none_rounded),
          onPressed: onPressed,
        ),
        if (unreadCount > 0)
          Positioned(
            top: 6,
            right: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 4),
              constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
              alignment: Alignment.center,
              decoration: const BoxDecoration(
                color: AppColors.danger,
                shape: BoxShape.circle,
              ),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: const TextStyle(
                  color: AppColors.fgOnClay,
                  fontSize: 10,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
      ],
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({
    required this.data,
    required this.unit,
    this.backgroundImagePath,
    this.backgroundAlignment = Alignment.center,
  });

  final PersonalDashboard data;
  final WeightUnit unit;
  final String? backgroundImagePath;
  final Alignment backgroundAlignment;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        DashboardHero(
          profile: data.profile,
          backgroundImagePath: backgroundImagePath,
          backgroundAlignment: backgroundAlignment,
          onOpenPlateCalculator: () => _openPlateCalculator(context),
        ),
        const SizedBox(height: AppSpacing.md),
        XnSectionGroup(
          children: [
            TodayWorkoutCard(
              workout: data.todayWorkout,
              currentStreak: data.profile.currentStreak,
              unit: unit,
              onOpen: data.todayWorkout != null
                  ? () => context.push('/days/${data.todayWorkout!.id}')
                  : null,
            ),
            const XnSectionDivider(),
            const NutritionCard(),
            const XnSectionDivider(),
            const TodayMealPlanCard(),
            const XnSectionDivider(),
            const _DashboardBodyweight(),
            if (data.nextActions.isNotEmpty) ...[
              const XnSectionDivider(),
              _NextActions(actions: data.nextActions),
            ],
            if (!data.proInsights.isUnlocked ||
                data.proInsights.items.isNotEmpty) ...[
              const XnSectionDivider(),
              ProInsightsCard(insights: data.proInsights),
            ],
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
      ],
    );
  }

  Future<void> _openPlateCalculator(BuildContext context) async {
    await showModalBottomSheet<void>(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      barrierColor: AppColors.ink900.withValues(alpha: 0.26),
      builder: (context) {
        final bottomInset = MediaQuery.viewInsetsOf(context).bottom;
        return Padding(
          padding: EdgeInsets.fromLTRB(
            AppSpacing.lg,
            0,
            AppSpacing.lg,
            AppSpacing.lg + bottomInset,
          ),
          child: const SingleChildScrollView(child: PlateCalculatorCard()),
        );
      },
    );
  }
}

/// Bodyweight trend + quick log, mirroring the profile card. Watches the
/// shared history provider and refreshes the dashboard after a new entry.
class _DashboardBodyweight extends ConsumerWidget {
  const _DashboardBodyweight();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final history = ref.watch(bodyweightHistoryProvider);
    final unit = ref.watch(weightUnitProvider);
    return BodyweightCard(
      history: history,
      unit: unit,
      onLog: () => _logBodyweight(context, ref, unit),
      framed: false,
    );
  }

  Future<void> _logBodyweight(
    BuildContext context,
    WidgetRef ref,
    WeightUnit unit,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    final current = ref
        .read(bodyweightHistoryProvider)
        .value
        ?.lastOrNull
        ?.weight;
    final weight = await showDialog<double>(
      context: context,
      builder: (_) => LogBodyweightDialog(unit: unit, initialWeight: current),
    );
    if (weight == null) return;

    try {
      await ref.read(profileRepositoryProvider).logBodyweight(weight);
      // Re-fetch so the chart, dashboard (BMI) and profile reflect it.
      ref
        ..invalidate(bodyweightHistoryProvider)
        ..invalidate(myProfileControllerProvider);
      await ref.read(dashboardControllerProvider.notifier).refresh();
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(content: Text(l10n.dashboardBodyweightLoggedSnackbar)),
        );
    } catch (e) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$e')));
    }
  }
}

class _NextActions extends StatelessWidget {
  const _NextActions({required this.actions});

  final List<NextAction> actions;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final sorted = [...actions]
      ..sort((a, b) => a.priority.compareTo(b.priority));
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.sm,
            AppSpacing.xl,
            AppSpacing.sm,
            AppSpacing.md,
          ),
          child: Text(
            l10n.dashboardNextActionsTitle,
            style: const TextStyle(
              color: AppColors.fg3,
              fontSize: 11,
              fontWeight: FontWeight.w500,
              letterSpacing: 0.6,
            ),
          ),
        ),
        for (final action in sorted)
          Padding(
            padding: EdgeInsets.only(
              left: AppSpacing.sm,
              right: AppSpacing.sm,
              bottom: action == sorted.last ? AppSpacing.xl : AppSpacing.md,
            ),
            child: _NextActionRow(action: action),
          ),
      ],
    );
  }
}

class _NextActionRow extends StatelessWidget {
  const _NextActionRow({required this.action});

  final NextAction action;

  @override
  Widget build(BuildContext context) {
    final localized = localizeDashboardNextAction(
      action,
      AppLocalizations.of(context),
      Localizations.localeOf(context).languageCode,
    );
    return Row(
      children: [
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                localized.label,
                style: const TextStyle(
                  fontWeight: FontWeight.w500,
                  color: AppColors.fg1,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                localized.description,
                style: const TextStyle(
                  color: AppColors.fg2,
                  fontSize: 13,
                ),
              ),
            ],
          ),
        ),
        const Icon(Icons.chevron_right_rounded, color: AppColors.fg3),
      ],
    );
  }
}
