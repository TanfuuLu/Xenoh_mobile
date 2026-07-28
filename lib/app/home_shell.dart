import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../core/realtime/realtime_service.dart';
import '../core/workout_notification/workout_notification_controller.dart';
import '../core/workout_notification/workout_notification_service.dart';
import '../features/auth/domain/entities/user.dart';
import '../features/auth/presentation/providers/auth_controller.dart';
import '../features/auth/presentation/providers/auth_state.dart';
import '../features/dashboard/presentation/providers/dashboard_controller.dart';
import '../features/profile/presentation/providers/profile_controller.dart';
import '../l10n/app_localizations.dart';
import 'theme/app_colors.dart';
import 'theme/app_dimens.dart';
import 'widgets/app_responsive_frame.dart';

/// Exposes the [HomeShell]'s drawer to descendant screens (which live in the
/// shell's branch navigators and have their own Scaffolds). Avoids a global
/// `ScaffoldState` key, which collides when go_router transiently keeps two
/// shell Scaffolds alive during a navigation animation.
class _HomeShellScope extends InheritedWidget {
  const _HomeShellScope({required this.openDrawer, required super.child});

  final VoidCallback openDrawer;

  static _HomeShellScope? of(BuildContext context) =>
      context.dependOnInheritedWidgetOfExactType<_HomeShellScope>();

  @override
  bool updateShouldNotify(_HomeShellScope oldWidget) => false;
}

class HomeShellMenuButton extends StatelessWidget {
  const HomeShellMenuButton({super.key});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: AppLocalizations.of(context).appShellOpenMenuTooltip,
      icon: const Icon(Icons.menu_rounded),
      onPressed: () => _HomeShellScope.of(context)?.openDrawer(),
    );
  }
}

class AppBottomMenuFrame extends StatelessWidget {
  const AppBottomMenuFrame({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AppResponsiveFrame(child: child),
      bottomNavigationBar: _XenohBottomMenuBar(
        selectedIndex: 0,
        onDestinationSelected: (index, destinations) {
          context.go(destinations[index].path);
        },
      ),
    );
  }
}

/// Bottom-navigation shell hosting the top-level tabs (Dashboard, Plans).
/// Uses go_router's [StatefulNavigationShell] so each tab keeps its own stack.
class HomeShell extends ConsumerWidget {
  const HomeShell({required this.navigationShell, super.key});

  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final session = ref.watch(authControllerProvider).sessionOrNull;
    if (session == null) {
      unawaited(ref.read(realtimeServiceProvider).disconnect());
    } else {
      unawaited(ref.read(realtimeServiceProvider).connect());
    }
    // Keeps the Android ongoing "current exercise" notification alive for the
    // whole authenticated session, reacting to today's workout progress.
    ref.watch(workoutNotificationControllerProvider);
    final isCoach = session?.user.isCoach ?? false;
    // Cycle lives in the sidebar only (never the bottom bar) and is shown to any
    // female user, including coaches.
    final showCycleNavigation =
        session != null &&
        ref.watch(myProfileControllerProvider).value?.gender == 'Female';
    final bottomDestinations = _bottomDestinations(context, isCoach: isCoach);
    final location = GoRouterState.of(context).uri.path;
    final clientsIndex = bottomDestinations.indexWhere(
      (item) => item.path == '/coach/clients',
    );
    final selectedBottomIndex =
        clientsIndex >= 0 && location.startsWith('/coach/clients')
        ? clientsIndex
        : bottomDestinations.indexWhere(
            (item) => item.branchIndex == navigationShell.currentIndex,
          );

    return Scaffold(
      drawer: _AppDrawer(
        user: session?.user,
        isFemale: showCycleNavigation,
        currentIndex: navigationShell.currentIndex,
        onBranchSelected: (index) => navigationShell.goBranch(
          index,
          initialLocation: index == navigationShell.currentIndex,
        ),
        onOpenLibrary: () => unawaited(context.push('/exercise-library')),
        onOpenProgress: () => unawaited(context.push('/progress')),
        onOpenPersonalRecords: () =>
            unawaited(context.push('/personal-records')),
        onOpenNotifications: () => unawaited(context.push('/notifications')),
        onOpenCommunity: () => navigationShell.goBranch(
          4,
          initialLocation: navigationShell.currentIndex == 4,
        ),
        onOpenFriends: () => unawaited(context.push('/community/friends')),
        onOpenCycle: () => navigationShell.goBranch(
          5,
          initialLocation: navigationShell.currentIndex == 5,
        ),
        onOpenInsights: () => unawaited(context.push('/insights')),
        onOpenCoachChat: () => unawaited(context.push('/insights/coach-chat')),
        onOpenMyCoach: () => unawaited(context.push('/coach')),
        onOpenEnterCoachCode: () =>
            unawaited(context.push('/enter-coach-code')),
        onOpenClients: () => unawaited(context.push('/coach/clients')),
        onOpenKeyVault: () => unawaited(context.push('/coach/key-vault')),
        onOpenChat: () => unawaited(context.push('/coach/chat')),
        onOpenAdminDashboard: () => unawaited(context.push('/admin/dashboard')),
        onOpenAdminAnalytics: () => unawaited(context.push('/admin/analytics')),
        onOpenAdminReports: () => unawaited(context.push('/admin/reports')),
        onOpenAdminBugReports: () =>
            unawaited(context.push('/admin/bug-reports')),
        onOpenAdminUsers: () => unawaited(context.push('/admin/users')),
        onOpenAdminPlans: () => unawaited(context.push('/admin/plans')),
      ),
      body: Builder(
        builder: (innerContext) => _HomeShellScope(
          openDrawer: () => Scaffold.of(innerContext).openDrawer(),
          child: _WorkoutLockScreenConsentGate(
            child: AppResponsiveFrame(child: navigationShell),
          ),
        ),
      ),
      bottomNavigationBar: _XenohBottomMenuBar(
        isCoach: isCoach,
        selectedIndex: selectedBottomIndex < 0 ? 0 : selectedBottomIndex,
        onDestinationSelected: (index, destinations) {
          final path = destinations[index].path;
          if (path == '/profile' || path == '/coach/clients') {
            context.go(path);
            return;
          }
          final branchIndex = destinations[index].branchIndex;
          navigationShell.goBranch(
            branchIndex,
            initialLocation: branchIndex == navigationShell.currentIndex,
          );
        },
      ),
    );
  }
}

class _WorkoutLockScreenConsentGate extends ConsumerStatefulWidget {
  const _WorkoutLockScreenConsentGate({required this.child});

  final Widget child;

  @override
  ConsumerState<_WorkoutLockScreenConsentGate> createState() =>
      _WorkoutLockScreenConsentGateState();
}

class _WorkoutLockScreenConsentGateState
    extends ConsumerState<_WorkoutLockScreenConsentGate> {
  bool? _enabled;
  bool _handlingPermission = false;
  String? _promptedWorkoutId;

  @override
  void initState() {
    super.initState();
    unawaited(_loadConsent());
  }

  Future<void> _loadConsent() async {
    final enabled =
        await WorkoutNotificationService.isLockScreenConsentGranted();
    if (!mounted) return;
    setState(() => _enabled = enabled);
  }

  @override
  Widget build(BuildContext context) {
    final workout = ref.watch(dashboardControllerProvider).value?.todayWorkout;
    if (_enabled == false &&
        !_handlingPermission &&
        workout != null &&
        !workout.isCompleted &&
        _promptedWorkoutId != workout.id) {
      _promptedWorkoutId = workout.id;
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) unawaited(_requestAccess());
      });
    }
    return widget.child;
  }

  Future<void> _requestAccess() async {
    final l10n = AppLocalizations.of(context);
    final accepted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        icon: const Icon(Icons.lock_outline_rounded),
        title: Text(l10n.workoutLockScreenPermissionTitle),
        content: Text(l10n.workoutLockScreenPermissionMessage),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonNotNow),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(l10n.commonAllow),
          ),
        ],
      ),
    );
    if (accepted != true || !mounted) return;

    setState(() => _handlingPermission = true);
    final granted =
        await WorkoutNotificationService.requestNotificationAccess();
    if (!mounted) return;
    setState(() {
      _handlingPermission = false;
      _enabled = granted;
    });
    if (!granted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.workoutNotificationPermissionDenied)),
      );
      return;
    }

    ref.invalidate(workoutNotificationControllerProvider);
    await Future<void>.delayed(const Duration(milliseconds: 700));
    await WorkoutNotificationService.openLockScreenChannelSettings();
  }
}

class _ShellDestination {
  const _ShellDestination({
    required this.branchIndex,
    required this.path,
    required this.destination,
  });

  final int branchIndex;
  final String path;
  final NavigationDestination destination;
}

class _XenohBottomMenuBar extends StatelessWidget {
  const _XenohBottomMenuBar({
    required this.selectedIndex,
    required this.onDestinationSelected,
    this.isCoach = false,
  });

  final bool isCoach;
  final int selectedIndex;
  final void Function(int index, List<_ShellDestination> destinations)
  onDestinationSelected;

  @override
  Widget build(BuildContext context) {
    final destinations = _bottomDestinations(context, isCoach: isCoach);
    final selected = selectedIndex.clamp(0, destinations.length - 1);
    return SafeArea(
      top: false,
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.lg,
          2,
          AppSpacing.lg,
          AppSpacing.sm,
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 5,
            vertical: 5,
          ),
          decoration: BoxDecoration(
            color: AppColors.bg2.withValues(alpha: 0.98),
            borderRadius: BorderRadius.circular(AppRadius.xl),
            border: Border.all(
              color: AppColors.surfaceBorderSoft.withValues(alpha: 0.72),
            ),
            boxShadow: const [
              BoxShadow(
                color: AppColors.shadowDeep,
                blurRadius: 28,
                offset: Offset(0, 12),
              ),
            ],
          ),
          child: Row(
            children: [
              for (var i = 0; i < destinations.length; i++)
                Expanded(
                  child: _NavItem(
                    destination: destinations[i].destination,
                    selected: i == selected,
                    onTap: () => onDestinationSelected(i, destinations),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A single bottom-bar tab. The active tab sits in a soft accent capsule that
/// wraps both the icon and label, with a gentle icon "pop" — replacing
/// Material's default icon-only pill indicator.
class _NavItem extends StatelessWidget {
  const _NavItem({
    required this.destination,
    required this.selected,
    required this.onTap,
  });

  final NavigationDestination destination;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final iconWidget = selected
        ? (destination.selectedIcon ?? destination.icon)
        : destination.icon;
    final color = selected ? AppColors.fgOnClay : AppColors.fg3;

    return Semantics(
      button: true,
      selected: selected,
      label: destination.label,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 3),
        child: Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(AppRadius.lg),
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            child: AnimatedContainer(
              duration: AppMotion.med,
              curve: Curves.easeOutCubic,
              padding: const EdgeInsets.symmetric(vertical: 7),
              decoration: BoxDecoration(
                color: selected ? AppColors.clay900 : Colors.transparent,
                borderRadius: BorderRadius.circular(AppRadius.lg),
                border: Border.all(
                  color: selected ? AppColors.clay900 : Colors.transparent,
                ),
                boxShadow: selected
                    ? const [
                        BoxShadow(
                          color: AppColors.shadow,
                          blurRadius: 10,
                          offset: Offset(0, 4),
                        ),
                      ]
                    : null,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  AnimatedScale(
                    scale: selected ? 1.04 : 1,
                    duration: AppMotion.med,
                    curve: Curves.easeOutBack,
                    child: IconTheme(
                      data: IconThemeData(color: color, size: 21),
                      child: iconWidget,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    destination.label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: color,
                      fontSize: 11,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
                      letterSpacing: 0.1,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

List<_ShellDestination> _bottomDestinations(
  BuildContext context, {
  bool isCoach = false,
}) {
  final l10n = AppLocalizations.of(context);
  return [
    _ShellDestination(
      branchIndex: 0,
      path: '/dashboard',
      destination: NavigationDestination(
        icon: const Icon(Icons.dashboard_outlined),
        selectedIcon: const Icon(Icons.dashboard_rounded),
        label: l10n.appShellNavDashboard,
      ),
    ),
    _ShellDestination(
      branchIndex: 1,
      path: '/plans',
      destination: NavigationDestination(
        icon: const Icon(Icons.calendar_month_outlined),
        selectedIcon: const Icon(Icons.calendar_month_rounded),
        label: l10n.appShellNavPlans,
      ),
    ),
    if (isCoach)
      // Lives in branch 0 (see router); navigated to via `context.go` and
      // selected by location rather than branch index.
      _ShellDestination(
        branchIndex: 0,
        path: '/coach/clients',
        destination: NavigationDestination(
          icon: const Icon(Icons.supervisor_account_outlined),
          selectedIcon: const Icon(Icons.supervisor_account_rounded),
          label: l10n.appShellNavClients,
        ),
      ),
    _ShellDestination(
      branchIndex: 2,
      path: '/nutrition',
      destination: NavigationDestination(
        icon: const Icon(Icons.restaurant_menu_outlined),
        selectedIcon: const Icon(Icons.restaurant_menu_rounded),
        label: l10n.appShellNavNutrition,
      ),
    ),
    _ShellDestination(
      branchIndex: 3,
      path: '/profile',
      destination: NavigationDestination(
        icon: const Icon(Icons.person_outline_rounded),
        selectedIcon: const Icon(Icons.person_rounded),
        label: l10n.appShellNavProfile,
      ),
    ),
  ];
}

class _AppDrawer extends StatelessWidget {
  const _AppDrawer({
    required this.user,
    required this.isFemale,
    required this.currentIndex,
    required this.onBranchSelected,
    required this.onOpenLibrary,
    required this.onOpenProgress,
    required this.onOpenPersonalRecords,
    required this.onOpenNotifications,
    required this.onOpenCommunity,
    required this.onOpenFriends,
    required this.onOpenCycle,
    required this.onOpenInsights,
    required this.onOpenCoachChat,
    required this.onOpenMyCoach,
    required this.onOpenEnterCoachCode,
    required this.onOpenClients,
    required this.onOpenKeyVault,
    required this.onOpenChat,
    required this.onOpenAdminDashboard,
    required this.onOpenAdminAnalytics,
    required this.onOpenAdminReports,
    required this.onOpenAdminBugReports,
    required this.onOpenAdminUsers,
    required this.onOpenAdminPlans,
  });

  final User? user;
  final bool isFemale;
  final int currentIndex;
  final ValueChanged<int> onBranchSelected;
  final VoidCallback onOpenLibrary;
  final VoidCallback onOpenProgress;
  final VoidCallback onOpenPersonalRecords;
  final VoidCallback onOpenNotifications;
  final VoidCallback onOpenCommunity;
  final VoidCallback onOpenFriends;
  final VoidCallback onOpenCycle;
  final VoidCallback onOpenInsights;
  final VoidCallback onOpenCoachChat;
  final VoidCallback onOpenMyCoach;
  final VoidCallback onOpenEnterCoachCode;
  final VoidCallback onOpenClients;
  final VoidCallback onOpenKeyVault;
  final VoidCallback onOpenChat;
  final VoidCallback onOpenAdminDashboard;
  final VoidCallback onOpenAdminAnalytics;
  final VoidCallback onOpenAdminReports;
  final VoidCallback onOpenAdminBugReports;
  final VoidCallback onOpenAdminUsers;
  final VoidCallback onOpenAdminPlans;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final isCoach = user?.isCoach ?? false;
    final isAdmin = user?.isAdmin ?? false;
    final drawerWidth = (MediaQuery.sizeOf(context).width * 0.88).clamp(
      280.0,
      336.0,
    );

    return Drawer(
      width: drawerWidth,
      backgroundColor: AppColors.clay050,
      surfaceTintColor: Colors.transparent,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.horizontal(right: Radius.circular(24)),
      ),
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 14, 10, 10),
              child: Row(
                children: [
                  Expanded(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Image.asset(
                        'assets/icon/banner_logo_xenoh.png',
                        height: 34,
                        fit: BoxFit.contain,
                        filterQuality: FilterQuality.medium,
                      ),
                    ),
                  ),
                  IconButton(
                    tooltip: MaterialLocalizations.of(
                      context,
                    ).closeButtonTooltip,
                    onPressed: () => Scaffold.maybeOf(context)?.closeDrawer(),
                    icon: const Icon(Icons.close_rounded),
                    color: AppColors.fg2,
                    style: IconButton.styleFrom(
                      backgroundColor: AppColors.bg2,
                      side: const BorderSide(
                        color: AppColors.surfaceBorderSoft,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            if (user != null)
              _UserPanel(user: user!, onOpenNotifications: onOpenNotifications),
            const SizedBox(height: AppSpacing.sm),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(
                  10,
                  8,
                  10,
                  20,
                ),
                children: [
                  _DrawerSection(
                    title: isCoach
                        ? l10n.appShellDrawerCoachWorkspaceSection
                        : l10n.appShellDrawerTrainingSection,
                    icon: isCoach
                        ? Icons.workspace_premium_outlined
                        : Icons.fitness_center_outlined,
                    initiallyExpanded:
                        currentIndex == 0 ||
                        currentIndex == 1 ||
                        currentIndex == 2,
                    selected:
                        currentIndex == 0 ||
                        currentIndex == 1 ||
                        currentIndex == 2,
                    children: [
                      _DrawerItem(
                        icon: Icons.dashboard_outlined,
                        activeIcon: Icons.dashboard_rounded,
                        label: isCoach
                            ? l10n.appShellDrawerOverview
                            : l10n.appShellNavDashboard,
                        selected: currentIndex == 0,
                        onTap: () => onBranchSelected(0),
                      ),
                      _DrawerItem(
                        icon: Icons.calendar_month_outlined,
                        activeIcon: Icons.calendar_month_rounded,
                        label: l10n.appShellNavPlans,
                        selected: currentIndex == 1,
                        onTap: () => onBranchSelected(1),
                      ),
                      _DrawerItem(
                        icon: Icons.restaurant_menu_outlined,
                        activeIcon: Icons.restaurant_menu_rounded,
                        label: l10n.appShellNavNutrition,
                        selected: currentIndex == 2,
                        onTap: () => onBranchSelected(2),
                      ),
                      _DrawerItem(
                        icon: Icons.menu_book_outlined,
                        activeIcon: Icons.menu_book_rounded,
                        label: l10n.appShellDrawerExerciseLibrary,
                        onTap: onOpenLibrary,
                      ),
                      if (isFemale)
                        _DrawerItem(
                          icon: Icons.water_drop_outlined,
                          activeIcon: Icons.water_drop_rounded,
                          label: l10n.appShellNavCycle,
                          selected: currentIndex == 5,
                          onTap: onOpenCycle,
                        ),
                    ],
                  ),
                  _DrawerSection(
                    title: l10n.appShellDrawerProgressSection,
                    icon: Icons.trending_up_outlined,
                    children: [
                      _DrawerItem(
                        icon: Icons.trending_up_outlined,
                        label: l10n.appShellDrawerProgressSection,
                        onTap: onOpenProgress,
                      ),
                      _DrawerItem(
                        icon: Icons.emoji_events_outlined,
                        label: l10n.appShellDrawerPersonalRecords,
                        onTap: onOpenPersonalRecords,
                      ),
                    ],
                  ),
                  _DrawerSection(
                    title: l10n.appShellDrawerCommunitySection,
                    icon: Icons.groups_outlined,
                    initiallyExpanded: currentIndex == 4,
                    selected: currentIndex == 4,
                    children: [
                      _DrawerItem(
                        icon: Icons.groups_outlined,
                        activeIcon: Icons.groups_rounded,
                        label: l10n.appShellDrawerCommunitySection,
                        selected: currentIndex == 4,
                        onTap: onOpenCommunity,
                      ),
                      _DrawerItem(
                        icon: Icons.people_alt_outlined,
                        label: l10n.appShellDrawerFriends,
                        onTap: onOpenFriends,
                      ),
                    ],
                  ),
                  _DrawerSection(
                    title: l10n.appShellDrawerAiToolsSection,
                    icon: Icons.auto_awesome_outlined,
                    children: [
                      _DrawerItem(
                        icon: Icons.auto_awesome_outlined,
                        label: l10n.appShellDrawerInsights,
                        onTap: onOpenInsights,
                      ),
                      _DrawerItem(
                        icon: Icons.smart_toy_outlined,
                        label: l10n.appShellDrawerAiCoachChat,
                        onTap: onOpenCoachChat,
                      ),
                    ],
                  ),
                  if (isCoach)
                    _DrawerSection(
                      title: l10n.appShellDrawerCoachToolsSection,
                      icon: Icons.supervisor_account_outlined,
                      initiallyExpanded: true,
                      children: [
                        _DrawerItem(
                          icon: Icons.supervisor_account_outlined,
                          label: l10n.appShellNavClients,
                          onTap: onOpenClients,
                        ),
                        _DrawerItem(
                          icon: Icons.key_outlined,
                          label: l10n.appShellDrawerKeyVault,
                          onTap: onOpenKeyVault,
                        ),
                        _DrawerItem(
                          icon: Icons.forum_outlined,
                          label: l10n.appShellDrawerChat,
                          onTap: onOpenChat,
                        ),
                      ],
                    )
                  else if (!isAdmin)
                    _DrawerSection(
                      title: l10n.appShellDrawerCoachAccessSection,
                      icon: Icons.school_outlined,
                      children: [
                        _DrawerItem(
                          icon: Icons.school_outlined,
                          label: l10n.appShellDrawerMyCoach,
                          onTap: onOpenMyCoach,
                        ),
                        _DrawerItem(
                          icon: Icons.vpn_key_outlined,
                          label: l10n.appShellDrawerEnterCoachCode,
                          onTap: onOpenEnterCoachCode,
                        ),
                      ],
                    ),
                  if (isAdmin)
                    _DrawerSection(
                      title: l10n.appShellDrawerAdministrationSection,
                      icon: Icons.admin_panel_settings_outlined,
                      initiallyExpanded: true,
                      selected: isAdmin,
                      children: [
                        _DrawerItem(
                          icon: Icons.admin_panel_settings_outlined,
                          label: l10n.appShellDrawerAdminDashboard,
                          onTap: onOpenAdminDashboard,
                        ),
                        _DrawerItem(
                          icon: Icons.bar_chart_rounded,
                          label: l10n.appShellDrawerAdminAnalytics,
                          onTap: onOpenAdminAnalytics,
                        ),
                        _DrawerItem(
                          icon: Icons.report_outlined,
                          label: l10n.appShellDrawerAdminReports,
                          onTap: onOpenAdminReports,
                        ),
                        _DrawerItem(
                          icon: Icons.bug_report_outlined,
                          label: l10n.appShellDrawerAdminBugReports,
                          onTap: onOpenAdminBugReports,
                        ),
                        _DrawerItem(
                          icon: Icons.people_alt_outlined,
                          label: l10n.appShellDrawerAdminUsers,
                          onTap: onOpenAdminUsers,
                        ),
                        _DrawerItem(
                          icon: Icons.calendar_month_outlined,
                          label: l10n.appShellDrawerAdminPlans,
                          onTap: onOpenAdminPlans,
                        ),
                      ],
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

class _UserPanel extends StatelessWidget {
  const _UserPanel({required this.user, required this.onOpenNotifications});

  final User user;
  final VoidCallback onOpenNotifications;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 12, 8, 12),
        decoration: BoxDecoration(
          color: AppColors.ink900,
          borderRadius: BorderRadius.circular(AppRadius.xl),
          boxShadow: const [
            BoxShadow(
              color: AppColors.shadowDeep,
              blurRadius: 18,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                color: AppColors.paperAlt,
                borderRadius: BorderRadius.circular(AppRadius.md),
                border: Border.all(
                  color: AppColors.fgOnClay.withValues(alpha: 0.18),
                ),
              ),
              child: user.avatarUrl == null || user.avatarUrl!.isEmpty
                  ? Center(
                      child: Text(
                        user.initials,
                        style: const TextStyle(
                          color: AppColors.ink900,
                          fontSize: 14,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    )
                  : Image.network(user.avatarUrl!, fit: BoxFit.cover),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    user.fullName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.fgOnClay,
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    user.email,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: AppColors.ink300,
                      fontSize: 11.5,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            IconButton(
              tooltip: AppLocalizations.of(
                context,
              ).appShellNotificationsTooltip,
              icon: const Icon(Icons.notifications_none_rounded, size: 20),
              visualDensity: VisualDensity.compact,
              constraints: const BoxConstraints.tightFor(width: 38, height: 38),
              color: AppColors.fgOnClay,
              style: IconButton.styleFrom(
                backgroundColor: AppColors.fgOnClay.withValues(alpha: 0.08),
              ),
              onPressed: onOpenNotifications,
            ),
          ],
        ),
      ),
    );
  }
}

class _DrawerSection extends StatefulWidget {
  const _DrawerSection({
    required this.title,
    required this.icon,
    required this.children,
    this.initiallyExpanded = false,
    this.selected = false,
  });

  final String title;
  final IconData icon;
  final List<Widget> children;
  final bool initiallyExpanded;
  final bool selected;

  @override
  State<_DrawerSection> createState() => _DrawerSectionState();
}

class _DrawerSectionState extends State<_DrawerSection> {
  late bool _expanded = widget.initiallyExpanded;

  @override
  Widget build(BuildContext context) {
    final highlighted = widget.selected || _expanded;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AnimatedContainer(
          duration: AppMotion.med,
          curve: Curves.easeOutCubic,
          decoration: BoxDecoration(
            color: _expanded
                ? AppColors.bg2.withValues(alpha: 0.78)
                : Colors.transparent,
            borderRadius: BorderRadius.circular(AppRadius.lg),
            border: Border.all(
              color: _expanded
                  ? AppColors.surfaceBorderSoft.withValues(alpha: 0.82)
                  : Colors.transparent,
            ),
          ),
          child: Theme(
            data: Theme.of(context).copyWith(
              dividerColor: Colors.transparent,
              splashColor: AppColors.accentSoft.withValues(alpha: 0.34),
              highlightColor: AppColors.accentSoft.withValues(alpha: 0.18),
            ),
            child: Material(
              type: MaterialType.transparency,
              child: ExpansionTile(
                initiallyExpanded: widget.initiallyExpanded,
                onExpansionChanged: (value) =>
                    setState(() => _expanded = value),
                maintainState: true,
                minTileHeight: 54,
                shape: const Border(),
                collapsedShape: const Border(),
                tilePadding: const EdgeInsets.symmetric(horizontal: 10),
                childrenPadding: const EdgeInsets.fromLTRB(8, 0, 8, 8),
                expandedCrossAxisAlignment: CrossAxisAlignment.stretch,
                iconColor: AppColors.accent,
                collapsedIconColor: AppColors.fg3,
                leading: AnimatedContainer(
                  duration: AppMotion.med,
                  width: 34,
                  height: 34,
                  decoration: BoxDecoration(
                    color: highlighted
                        ? AppColors.accentSoft
                        : AppColors.bg2.withValues(alpha: 0.72),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: Icon(
                    widget.icon,
                    size: 18,
                    color: highlighted ? AppColors.clay900 : AppColors.fg2,
                  ),
                ),
                title: Text(
                  widget.title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: highlighted ? AppColors.ink900 : AppColors.fg2,
                    fontSize: 13.5,
                    fontWeight: FontWeight.w600,
                    letterSpacing: 0.1,
                  ),
                ),
                children: widget.children,
              ),
            ),
          ),
        ),
        const SizedBox(height: 6),
      ],
    );
  }
}

class _DrawerItem extends StatelessWidget {
  const _DrawerItem({
    required this.icon,
    required this.label,
    required this.onTap,
    this.activeIcon,
    this.selected = false,
  });

  final IconData icon;
  final IconData? activeIcon;
  final String label;
  final VoidCallback onTap;
  final bool selected;

  @override
  Widget build(BuildContext context) {
    final fg = selected ? AppColors.fgOnClay : AppColors.fg2;

    return Padding(
      padding: const EdgeInsets.only(top: 3),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(AppRadius.md),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppRadius.md),
          onTap: () {
            // Dismiss the drawer first; its context is under the shell Scaffold.
            Scaffold.maybeOf(context)?.closeDrawer();
            onTap();
          },
          child: AnimatedContainer(
            duration: AppMotion.fast,
            curve: Curves.easeOutCubic,
            padding: const EdgeInsets.fromLTRB(8, 7, 10, 7),
            decoration: BoxDecoration(
              color: selected ? AppColors.clay900 : Colors.transparent,
              borderRadius: BorderRadius.circular(AppRadius.md),
            ),
            child: Row(
              children: [
                Container(
                  width: 30,
                  height: 30,
                  decoration: BoxDecoration(
                    color: selected
                        ? AppColors.fgOnClay.withValues(alpha: 0.12)
                        : AppColors.clay100.withValues(alpha: 0.5),
                    borderRadius: BorderRadius.circular(9),
                  ),
                  child: Icon(
                    selected ? activeIcon ?? icon : icon,
                    size: 17,
                    color: fg,
                  ),
                ),
                const SizedBox(width: 11),
                Expanded(
                  child: Text(
                    label,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: fg,
                      fontSize: 13.5,
                      fontWeight: selected ? FontWeight.w600 : FontWeight.w500,
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
