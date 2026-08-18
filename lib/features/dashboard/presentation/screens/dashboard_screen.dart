import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/home_shell.dart';
import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/realtime/realtime_service.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../notifications/presentation/screens/notification_center_screen.dart';
import '../../../nutrition/presentation/providers/nutrition_controller.dart';
import '../../../profile/data/repositories/profile_background_repository.dart';
import '../../../profile/data/repositories/profile_repository_provider.dart';
import '../../../profile/domain/entities/bodyweight_log.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../profile/presentation/providers/profile_controller.dart';
import '../../../profile/presentation/widgets/bodyweight_card.dart';
import '../../../supplements/presentation/providers/supplement_controllers.dart';
import '../../domain/entities/personal_dashboard.dart';
import '../providers/dashboard_controller.dart';
import '../widgets/dashboard_hero.dart';
import '../widgets/nutrition_card.dart';
import '../widgets/plate_calculator_card.dart';
import '../widgets/plate_calculator_entry.dart';
import '../widgets/pro_insights_card.dart';
import '../widgets/supplements_card.dart';
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
            ..invalidate(mealPlanProvider(today))
            ..invalidate(supplementDailyProvider(date: today));
        },
        child: AsyncValueView(
          value: dashboard,
          onRetry: () => ref.invalidate(dashboardControllerProvider),
          data: (data) => _DashboardBody(
            data: data,
            unit: ref.watch(weightUnitProvider),
            backgroundImagePath: backgroundPath,
            backgroundAlignment: backgroundAlignment,
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
    required this.backgroundAlignment,
    this.backgroundImagePath,
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
        ),
        const SizedBox(height: AppSpacing.md),
        _DashboardPanel(
          child: PlateCalculatorEntry(
            onOpen: () => _openPlateCalculator(context),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        _DashboardPanel(
          child: TodayWorkoutCard(
            workout: data.todayWorkout,
            currentStreak: data.profile.currentStreak,
            unit: unit,
            onOpen: data.todayWorkout != null
                ? () => context.push('/days/${data.todayWorkout!.id}')
                : null,
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        const _DashboardPanel(child: _DashboardBodyweight()),
        const SizedBox(height: AppSpacing.md),
        const _DashboardPanel(child: NutritionCard()),
        const SizedBox(height: AppSpacing.md),
        const _DashboardPanel(child: TodayMealPlanCard()),
        const SizedBox(height: AppSpacing.md),
        const _DashboardPanel(child: SupplementsCard()),
        if (!data.proInsights.isUnlocked ||
            data.proInsights.items.isNotEmpty) ...[
          const SizedBox(height: AppSpacing.md),
          _DashboardPanel(child: ProInsightsCard(insights: data.proInsights)),
        ],
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

class _DashboardPanel extends StatelessWidget {
  const _DashboardPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return XnCard(
      padding: const EdgeInsets.all(AppSpacing.md),
      child: child,
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
      onLog: (weightKg) => _logBodyweight(context, ref, weightKg),
      onShowHistory: history.value?.isNotEmpty ?? false
          ? () => _showBodyweightHistory(context, ref, history.value!, unit)
          : null,
      framed: false,
    );
  }

  void _showBodyweightHistory(
    BuildContext context,
    WidgetRef ref,
    List<BodyweightLog> logs,
    WeightUnit unit,
  ) {
    unawaited(
      showModalBottomSheet<void>(
        context: context,
        backgroundColor: AppColors.bgPage,
        showDragHandle: true,
        builder: (_) => BodyweightHistorySheet(
          logs: logs,
          unit: unit,
          onDelete: (id) => _deleteBodyweightLog(context, ref, id),
        ),
      ),
    );
  }

  Future<void> _deleteBodyweightLog(
    BuildContext context,
    WidgetRef ref,
    String id,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    try {
      await ref.read(profileRepositoryProvider).deleteBodyweightLog(id);
      ref
        ..invalidate(bodyweightHistoryProvider)
        ..invalidate(myProfileControllerProvider);
      await ref.read(dashboardControllerProvider.notifier).refresh();
      if (context.mounted) Navigator.of(context).pop();
    } catch (error) {
      messenger
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text('$error')));
    }
  }

  Future<void> _logBodyweight(
    BuildContext context,
    WidgetRef ref,
    double weightKg,
  ) async {
    final messenger = ScaffoldMessenger.of(context);
    final l10n = AppLocalizations.of(context);
    try {
      await ref.read(profileRepositoryProvider).logBodyweight(weightKg);
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
      rethrow;
    }
  }
}
