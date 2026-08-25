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
          ),
        ),
      ),
    );
  }
}

/// Notification entry point in the dashboard app bar.
///
/// Reads as a soft chip button rather than a bare glyph so it holds its own
/// against the paper background and the banner logo next to it. The unread
/// badge sits just outside the chip with a paper-colored ring, so the count
/// never collides with the bell itself.
class _NotificationBell extends StatelessWidget {
  const _NotificationBell({required this.unreadCount, required this.onPressed});

  final int unreadCount;
  final VoidCallback onPressed;

  static const double _size = 38;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final hasUnread = unreadCount > 0;
    final label = hasUnread
        ? '${l10n.dashboardNotificationsTooltip} ($unreadCount)'
        : l10n.dashboardNotificationsTooltip;

    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.md),
      child: Tooltip(
        message: label,
        child: Semantics(
          button: true,
          label: label,
          child: SizedBox(
            width: _size,
            height: _size,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Material(
                  color: hasUnread ? AppColors.accentSoft : AppColors.bg2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    side: BorderSide(
                      color: hasUnread
                          ? AppColors.accent.withValues(alpha: 0.28)
                          : AppColors.surfaceBorderSoft,
                    ),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: InkWell(
                    onTap: onPressed,
                    child: Center(
                      child: Icon(
                        hasUnread
                            ? Icons.notifications_rounded
                            : Icons.notifications_none_rounded,
                        size: 20,
                        color: hasUnread ? AppColors.accent : AppColors.fg3,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: -5,
                  right: -5,
                  child: AnimatedScale(
                    scale: hasUnread ? 1 : 0,
                    duration: AppMotion.fast,
                    curve: Curves.easeOutBack,
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 4),
                      constraints: const BoxConstraints(
                        minWidth: 18,
                        minHeight: 18,
                      ),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: AppColors.accent,
                        borderRadius: BorderRadius.circular(AppRadius.pill),
                        border: Border.all(color: AppColors.paper, width: 2),
                      ),
                      child: Text(
                        unreadCount > 99 ? '99+' : '$unreadCount',
                        style: const TextStyle(
                          color: AppColors.fgOnClay,
                          fontSize: 10,
                          height: 1.1,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _DashboardBody extends StatelessWidget {
  const _DashboardBody({required this.data, required this.unit});

  final PersonalDashboard data;
  final WeightUnit unit;

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        DashboardHero(profile: data.profile),
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
          // The sheet is its own subtree, so the unit preference is watched
          // here rather than inherited from the dashboard body.
          child: SingleChildScrollView(
            child: Consumer(
              builder: (context, ref, _) =>
                  PlateCalculatorCard(unit: ref.watch(weightUnitProvider)),
            ),
          ),
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
