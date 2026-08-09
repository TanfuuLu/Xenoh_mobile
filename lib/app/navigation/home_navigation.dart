import '../../features/auth/domain/entities/user.dart';

enum HomeNavigationRole { athlete, coach, organizer, admin }

HomeNavigationRole resolveHomeNavigationRole(
  User user, {
  bool hasOrganizerAccess = false,
}) {
  if (user.isAdmin) return HomeNavigationRole.admin;
  if (hasOrganizerAccess) return HomeNavigationRole.organizer;
  if (user.isCoach) return HomeNavigationRole.coach;
  return HomeNavigationRole.athlete;
}

List<String> homeNavigationPaths(HomeNavigationRole role) => switch (role) {
  HomeNavigationRole.athlete => const [
    '/dashboard',
    '/plans',
    '/nutrition',
    '/profile',
  ],
  HomeNavigationRole.coach => const [
    '/dashboard',
    '/coach/clients',
    '/coach/chat',
    '/profile',
  ],
  HomeNavigationRole.organizer => const [
    '/organizer',
    '/organizer/events',
    '/organizer/roster',
    '/organizer/results',
    '/profile',
  ],
  HomeNavigationRole.admin => const [
    '/admin/dashboard',
    '/admin/users',
    '/admin/moderation',
    '/admin/finance',
    '/admin/more',
  ],
};

int homeNavigationSelectedIndex(HomeNavigationRole role, String location) {
  if (role == HomeNavigationRole.admin) {
    if (_matchesAny(location, const [
      '/admin/reports',
      '/admin/bug-reports',
      '/admin/organizers',
      '/admin/moderation',
    ])) {
      return 2;
    }
    if (_matchesAny(location, const [
      '/admin/payments',
      '/admin/promotions',
      '/admin/plans',
      '/admin/finance',
    ])) {
      return 3;
    }
    if (_matchesAny(location, const [
      '/admin/analytics',
      '/admin/more',
    ])) {
      return 4;
    }
  }

  final paths = homeNavigationPaths(role);
  var selected = -1;
  var matchedLength = -1;
  for (var index = 0; index < paths.length; index++) {
    final path = paths[index];
    if ((location == path || location.startsWith('$path/')) &&
        path.length > matchedLength) {
      selected = index;
      matchedLength = path.length;
    }
  }
  return selected;
}

bool _matchesAny(String location, List<String> paths) => paths.any(
  (path) => location == path || location.startsWith('$path/'),
);
