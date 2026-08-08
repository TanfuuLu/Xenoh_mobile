import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/navigation/home_navigation.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';

void main() {
  const athlete = User(
    id: 'athlete',
    email: 'athlete@xenoh.app',
    fullName: 'Athlete',
    roles: ['Individual'],
  );
  const coach = User(
    id: 'coach',
    email: 'coach@xenoh.app',
    fullName: 'Coach',
    roles: ['Individual', 'Coach'],
  );
  const admin = User(
    id: 'admin',
    email: 'admin@xenoh.app',
    fullName: 'Admin',
    roles: ['Individual', 'Coach', 'Admin'],
  );

  test('resolves navigation role with admin and organizer priority', () {
    expect(resolveHomeNavigationRole(athlete), HomeNavigationRole.athlete);
    expect(resolveHomeNavigationRole(coach), HomeNavigationRole.coach);
    expect(
      resolveHomeNavigationRole(athlete, hasOrganizerAccess: true),
      HomeNavigationRole.organizer,
    );
    expect(
      resolveHomeNavigationRole(admin, hasOrganizerAccess: true),
      HomeNavigationRole.admin,
    );
  });

  test('uses the approved destination set for every role', () {
    expect(homeNavigationPaths(HomeNavigationRole.athlete), [
      '/dashboard',
      '/plans',
      '/nutrition',
      '/profile',
    ]);
    expect(homeNavigationPaths(HomeNavigationRole.coach), [
      '/dashboard',
      '/coach/clients',
      '/coach/chat',
      '/profile',
    ]);
    expect(homeNavigationPaths(HomeNavigationRole.organizer), [
      '/organizer',
      '/organizer/events',
      '/organizer/roster',
      '/organizer/results',
      '/profile',
    ]);
    expect(homeNavigationPaths(HomeNavigationRole.admin), [
      '/admin/dashboard',
      '/admin/users',
      '/admin/moderation',
      '/admin/finance',
      '/admin/more',
    ]);
  });

  test('selects the owning Admin hub for nested operational routes', () {
    expect(
      homeNavigationSelectedIndex(
        HomeNavigationRole.admin,
        '/admin/organizers',
      ),
      2,
    );
    expect(
      homeNavigationSelectedIndex(
        HomeNavigationRole.admin,
        '/admin/payments',
      ),
      3,
    );
    expect(
      homeNavigationSelectedIndex(
        HomeNavigationRole.admin,
        '/admin/promotions',
      ),
      3,
    );
    expect(
      homeNavigationSelectedIndex(
        HomeNavigationRole.organizer,
        '/organizer/events/event-1/open-2027',
      ),
      1,
    );
  });
}
