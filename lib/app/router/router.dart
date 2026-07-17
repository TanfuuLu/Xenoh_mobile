import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/admin/presentation/screens/admin_analytics_screen.dart';
import '../../features/admin/presentation/screens/admin_bug_reports_screen.dart';
import '../../features/admin/presentation/screens/admin_dashboard_screen.dart';
import '../../features/admin/presentation/screens/admin_plan_analytics_screen.dart';
import '../../features/admin/presentation/screens/admin_plans_screen.dart';
import '../../features/admin/presentation/screens/admin_reports_screen.dart';
import '../../features/admin/presentation/screens/admin_user_detail_screen.dart';
import '../../features/admin/presentation/screens/admin_users_screen.dart';
import '../../features/auth/presentation/providers/auth_controller.dart';
import '../../features/auth/presentation/providers/auth_state.dart';
import '../../features/auth/presentation/screens/account_deletion_request_screen.dart';
import '../../features/auth/presentation/screens/forgot_password_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/register_screen.dart';
import '../../features/auth/presentation/screens/social_callback_screen.dart';
import '../../features/blocks_reports/presentation/screens/blocklist_screen.dart';
import '../../features/blocks_reports/presentation/screens/report_bug_screen.dart';
import '../../features/coach_client/presentation/screens/chat_hub_screen.dart';
import '../../features/coach_client/presentation/screens/client_detail_screen.dart';
import '../../features/coach_client/presentation/screens/clients_screen.dart';
import '../../features/coach_client/presentation/screens/enter_coach_code_screen.dart';
import '../../features/coach_client/presentation/screens/key_vault_screen.dart';
import '../../features/coach_client/presentation/screens/my_coach_screen.dart';
import '../../features/coach_client/presentation/screens/relationship_chat_screen.dart';
import '../../features/community/presentation/screens/community_profile_screen.dart';
import '../../features/community/presentation/screens/community_screen.dart';
import '../../features/community/presentation/screens/friends_screen.dart';
import '../../features/cycle/presentation/screens/cycle_insight_screen.dart';
import '../../features/cycle/presentation/screens/cycle_screen.dart';
import '../../features/dashboard/presentation/screens/dashboard_screen.dart';
import '../../features/insights/presentation/screens/ai_coach_chat_screen.dart';
import '../../features/insights/presentation/screens/insights_screen.dart';
import '../../features/marketing/presentation/screens/about_screen.dart';
import '../../features/marketing/presentation/screens/landing_screen.dart';
import '../../features/marketing/presentation/screens/legal_screen.dart';
import '../../features/notifications/presentation/screens/notification_center_screen.dart';
import '../../features/nutrition/presentation/screens/nutrition_screen.dart';
import '../../features/profile/domain/entities/user_profile.dart';
import '../../features/profile/presentation/screens/edit_profile_screen.dart';
import '../../features/profile/presentation/screens/profile_screen.dart';
import '../../features/progress/presentation/screens/personal_records_screen.dart';
import '../../features/progress/presentation/screens/plan_analytics_screen.dart';
import '../../features/progress/presentation/screens/progress_screen.dart';
import '../../features/settings/presentation/screens/change_password_screen.dart';
import '../../features/settings/presentation/screens/settings_screen.dart';
import '../../features/sharing/presentation/screens/pr_share_screen.dart';
import '../../features/subscription/presentation/screens/subscription_status_screen.dart';
import '../../features/training/presentation/screens/comments_screen.dart';
import '../../features/training/presentation/screens/day_screen.dart';
import '../../features/training/presentation/screens/exercise_library_screen.dart';
import '../../features/training/presentation/screens/plan_ai_review_screen.dart';
import '../../features/training/presentation/screens/plan_detail_screen.dart';
import '../../features/training/presentation/screens/plans_screen.dart';
import '../../features/training/presentation/screens/week_analysis_screen.dart';
import '../../features/training/presentation/screens/week_screen.dart';
import '../home_shell.dart';
import '../splash_screen.dart';

part 'router.g.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// App router. Watches [AuthController] and gates routes:
/// - while auth is `unknown` → `/splash`
/// - unauthenticated → `/login` (and `/register`)
/// - authenticated → `/dashboard` (bottom-nav shell: Home + Plans)
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  // Bridge Riverpod auth changes to a Listenable go_router can refresh on,
  // without rebuilding the whole router (which would reset navigation).
  final refresh = ValueNotifier<AuthState>(const AuthState.unknown());
  ref
    ..onDispose(refresh.dispose)
    ..listen(
      authControllerProvider,
      (_, next) => refresh.value = next,
      fireImmediately: true,
    );

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/dashboard',
    debugLogDiagnostics: kDebugMode,
    refreshListenable: refresh,
    errorBuilder: (_, state) {
      final clientId = _clientAiInsightIdFromPath(state.uri.path);
      if (clientId != null) {
        return ClientAiInsightsScreen(clientId: clientId);
      }
      return const DashboardScreen();
    },
    redirect: (context, state) {
      final auth = ref.read(authControllerProvider);
      final loc = state.matchedLocation;

      final publicRoute =
          loc == '/' ||
          loc == '/about' ||
          loc == '/privacy' ||
          loc == '/account-deletion' ||
          loc == '/terms' ||
          loc == '/refund-policy' ||
          loc.startsWith('/share/pr/') ||
          loc == '/forgot-password' ||
          loc == '/auth/social-callback';

      if (!auth.isResolved) {
        return loc == '/splash' || publicRoute ? null : '/splash';
      }

      final atAuthScreen = loc == '/login' || loc == '/register';
      if (!auth.isAuthed) {
        return atAuthScreen || publicRoute ? null : '/login';
      }

      if (atAuthScreen || loc == '/splash') return '/dashboard';
      final user = auth.sessionOrNull?.user;
      if (loc.startsWith('/admin') && user?.isAdmin != true) {
        return '/dashboard';
      }
      final coachRoute =
          loc.startsWith('/coach/clients') ||
          loc.startsWith('/coach/key-vault') ||
          loc.startsWith('/coach/chat');
      if (coachRoute && user?.isCoach != true) {
        return '/dashboard';
      }
      return null;
    },
    routes: [
      GoRoute(path: '/', builder: (_, _) => _withMenu(const LandingScreen())),
      GoRoute(
        path: '/about',
        builder: (_, _) => _withMenu(const AboutScreen()),
      ),
      GoRoute(
        path: '/privacy',
        builder: (_, _) =>
            _withMenu(const LegalScreen(kind: LegalPageKind.privacy)),
      ),
      GoRoute(
        path: '/account-deletion',
        builder: (_, _) => const AccountDeletionRequestScreen(),
      ),
      GoRoute(
        path: '/terms',
        builder: (_, _) =>
            _withMenu(const LegalScreen(kind: LegalPageKind.terms)),
      ),
      GoRoute(
        path: '/subscription',
        builder: (_, _) => const SubscriptionStatusScreen(),
      ),
      GoRoute(
        path: '/refund-policy',
        builder: (_, _) =>
            _withMenu(const LegalScreen(kind: LegalPageKind.refund)),
      ),
      GoRoute(
        path: '/splash',
        builder: (_, _) => const SplashScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (_, _) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (_, _) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (_, _) => _withMenu(const ForgotPasswordScreen()),
      ),
      GoRoute(
        path: '/auth/social-callback',
        builder: (_, state) => _withMenu(
          SocialCallbackScreen(ticket: state.uri.queryParameters['ticket']),
        ),
      ),
      GoRoute(
        path: '/coach/clients/:clientId/ai-insight',
        builder: (_, state) => ClientAiInsightsScreen(
          clientId: state.pathParameters['clientId']!,
        ),
      ),
      GoRoute(
        path: '/coach/clients/:clientId/ai-insights',
        redirect: (_, state) =>
            '/coach/clients/${state.pathParameters['clientId']!}/ai-insight',
      ),

      // Top-level tabs (bottom nav).
      StatefulShellRoute.indexedStack(
        builder: (_, _, navigationShell) =>
            HomeShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/dashboard',
                builder: (_, _) => const DashboardScreen(),
              ),
              GoRoute(
                path: '/exercise-library',
                builder: (_, _) => const ExerciseLibraryScreen(),
              ),
              GoRoute(
                path: '/notifications',
                builder: (_, _) => const NotificationCenterScreen(),
              ),
              GoRoute(
                path: '/progress',
                builder: (_, _) => const ProgressScreen(),
              ),
              GoRoute(
                path: '/personal-records',
                builder: (_, _) => const PersonalRecordsScreen(),
              ),
              GoRoute(
                path: '/insights',
                builder: (_, _) => const InsightsScreen(),
              ),
              GoRoute(
                path: '/insights/coach-chat',
                builder: (_, _) => const AiCoachChatScreen(),
              ),
              GoRoute(
                path: '/coach/clients',
                builder: (_, _) => const ClientsScreen(),
              ),
              GoRoute(
                path: '/coach/clients/:clientId',
                builder: (_, state) => ClientDetailScreen(
                  clientId: state.pathParameters['clientId']!,
                ),
              ),
              GoRoute(
                path: '/coach/key-vault',
                builder: (_, _) => const KeyVaultScreen(),
              ),
              GoRoute(
                path: '/coach/chat',
                builder: (_, _) => const ChatHubScreen(),
              ),
              GoRoute(
                path: '/coach/chat/messages',
                builder: (_, state) {
                  final extra =
                      state.extra!
                          as ({String relationshipId, String clientName});
                  return RelationshipChatScreen(
                    relationshipId: extra.relationshipId,
                    peerName: extra.clientName,
                  );
                },
              ),
              GoRoute(
                path: '/admin',
                redirect: (_, _) => '/admin/dashboard',
              ),
              GoRoute(
                path: '/admin/dashboard',
                builder: (_, _) => const AdminDashboardScreen(),
              ),
              GoRoute(
                path: '/admin/analytics',
                builder: (_, _) => const AdminAnalyticsScreen(),
              ),
              GoRoute(
                path: '/admin/reports',
                builder: (_, _) => const AdminReportsScreen(),
              ),
              GoRoute(
                path: '/admin/bug-reports',
                builder: (_, _) => const AdminBugReportsScreen(),
              ),
              GoRoute(
                path: '/admin/users',
                builder: (_, _) => const AdminUsersScreen(),
              ),
              GoRoute(
                path: '/admin/users/:userId',
                builder: (_, state) => AdminUserDetailScreen(
                  userId: state.pathParameters['userId']!,
                ),
              ),
              GoRoute(
                path: '/admin/plans',
                builder: (_, _) => const AdminPlansScreen(),
              ),
              GoRoute(
                path: '/admin/plans/:planId/analytics',
                builder: (_, state) => AdminPlanAnalyticsScreen(
                  planId: state.pathParameters['planId']!,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/plans',
                builder: (_, _) => const PlansScreen(),
              ),
              GoRoute(
                path: '/plans/:planId/analytics',
                builder: (_, state) => PlanAnalyticsScreen(
                  planId: state.pathParameters['planId']!,
                ),
              ),
              GoRoute(
                path: '/plans/:planId/balance-check',
                builder: (_, state) => PlanBalanceCheckScreen(
                  planId: state.pathParameters['planId']!,
                ),
              ),
              GoRoute(
                path: '/plans/:planId/design-analysis',
                builder: (_, state) => PlanDesignAnalysisScreen(
                  planId: state.pathParameters['planId']!,
                ),
              ),
              GoRoute(
                path: '/plans/:planId/comments',
                builder: (_, state) => CommentsScreen(
                  scope: CommentScope.plan,
                  ownerId: state.pathParameters['planId']!,
                ),
              ),
              GoRoute(
                path: '/plans/:planId',
                builder: (_, state) =>
                    PlanDetailScreen(planId: state.pathParameters['planId']!),
              ),
              GoRoute(
                path: '/weeks/:weekId/comments',
                builder: (_, state) => CommentsScreen(
                  scope: CommentScope.week,
                  ownerId: state.pathParameters['weekId']!,
                ),
              ),
              GoRoute(
                path: '/weeks/:weekId/analysis',
                builder: (_, state) => WeekAnalysisScreen(
                  weekId: state.pathParameters['weekId']!,
                ),
              ),
              GoRoute(
                path: '/weeks/:weekId',
                builder: (_, state) =>
                    WeekScreen(weekId: state.pathParameters['weekId']!),
              ),
              GoRoute(
                path: '/days/:dayId',
                builder: (_, state) =>
                    DayScreen(dayId: state.pathParameters['dayId']!),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/nutrition',
                builder: (_, _) => const NutritionScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/profile',
                builder: (_, _) => const ProfileScreen(),
              ),
              GoRoute(
                path: '/profile/edit',
                builder: (_, state) =>
                    EditProfileScreen(profile: state.extra! as UserProfile),
              ),
              GoRoute(
                path: '/settings',
                builder: (_, _) => const SettingsScreen(),
              ),
              GoRoute(
                path: '/change-password',
                builder: (_, _) => const ChangePasswordScreen(),
              ),
              GoRoute(
                path: '/settings/blocklist',
                builder: (_, _) => const BlocklistScreen(),
              ),
              GoRoute(
                path: '/report-bug',
                builder: (_, _) => const ReportBugScreen(),
              ),
              GoRoute(path: '/coach', builder: (_, _) => const MyCoachScreen()),
              GoRoute(
                path: '/coach/messages',
                builder: (_, state) {
                  final extra =
                      state.extra!
                          as ({String relationshipId, String coachName});
                  return RelationshipChatScreen(
                    relationshipId: extra.relationshipId,
                    peerName: extra.coachName,
                  );
                },
              ),
              GoRoute(
                path: '/enter-coach-code',
                builder: (_, _) => const EnterCoachCodeScreen(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/community',
                builder: (_, _) => const CommunityScreen(),
              ),
              GoRoute(
                path: '/community/friends',
                builder: (_, _) => const FriendsScreen(),
              ),
              GoRoute(
                path: '/community/users/:userId',
                builder: (_, state) => CommunityProfileScreen(
                  userId: state.pathParameters['userId']!,
                ),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: '/cycle',
                builder: (_, _) => const CycleScreen(),
              ),
              GoRoute(
                path: '/cycle/insight',
                builder: (_, _) => const CycleInsightScreen(),
              ),
            ],
          ),
        ],
      ),

      // Public share page stays outside the authenticated app shell.
      GoRoute(
        path: '/share/pr/:userId/:exerciseTemplateId',
        builder: (_, state) => _withMenu(
          PrShareScreen(
            userId: state.pathParameters['userId']!,
            exerciseTemplateId: state.pathParameters['exerciseTemplateId']!,
          ),
        ),
      ),
    ],
  );
}

Widget _withMenu(Widget child) => AppBottomMenuFrame(child: child);

String? _clientAiInsightIdFromPath(String path) {
  final match = RegExp(
    r'^/coach/clients/([^/]+)/ai-insights?/?$',
  ).firstMatch(path);
  return match?.group(1);
}
