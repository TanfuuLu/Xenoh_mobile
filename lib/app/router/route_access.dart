import '../../features/auth/presentation/providers/auth_state.dart';

bool isPublicLocation(String location) =>
    location == '/' ||
    location == '/about' ||
    location == '/privacy' ||
    location == '/account-deletion' ||
    location == '/account-deletion/verify' ||
    location == '/terms' ||
    location == '/refund-policy' ||
    location == '/competitions' ||
    (location.startsWith('/competitions/') &&
        location != '/competitions/mine') ||
    location.startsWith('/share/pr/') ||
    location == '/forgot-password' ||
    location == '/auth/social-callback' ||
    location == '/social-callback';

/// Returns the canonical redirect for the current authentication state.
///
/// Backend authorization remains authoritative; this only controls client UX.
String? routeAccessRedirect(AuthState auth, String location) {
  final publicRoute = isPublicLocation(location);
  if (!auth.isResolved) {
    return location == '/splash' || publicRoute ? null : '/splash';
  }

  final atAuthScreen = location == '/login' || location == '/register';
  if (!auth.isAuthed) {
    return atAuthScreen || publicRoute ? null : '/login';
  }

  if (location == '/auth/social-callback' || location == '/social-callback') {
    return '/dashboard';
  }
  if (atAuthScreen || location == '/splash') return '/dashboard';
  final user = auth.sessionOrNull?.user;
  if (location.startsWith('/admin') && user?.isAdmin != true) {
    return '/dashboard';
  }
  final coachRoute =
      location.startsWith('/coach/clients') ||
      location.startsWith('/coach/key-vault') ||
      location.startsWith('/coach/chat');
  if (coachRoute && user?.isCoach != true) return '/dashboard';
  return null;
}
