import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/router/route_access.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_state.dart';

void main() {
  const member = AuthState.authenticated(
    AuthSession(
      accessToken: 'not-logged',
      user: User(
        id: 'member',
        email: 'member@example.test',
        fullName: 'Member',
        roles: [],
      ),
    ),
  );
  const coach = AuthState.authenticated(
    AuthSession(
      accessToken: 'not-logged',
      user: User(
        id: 'coach',
        email: 'coach@example.test',
        fullName: 'Coach',
        roles: ['Coach'],
      ),
    ),
  );
  const admin = AuthState.authenticated(
    AuthSession(
      accessToken: 'not-logged',
      user: User(
        id: 'admin',
        email: 'admin@example.test',
        fullName: 'Admin',
        roles: ['Admin'],
      ),
    ),
  );

  test('public routes remain available without a session', () {
    expect(
      routeAccessRedirect(
        const AuthState.unauthenticated(),
        '/privacy',
      ),
      isNull,
    );
  });

  test('protected routes require a session', () {
    expect(
      routeAccessRedirect(
        const AuthState.unauthenticated(),
        '/dashboard',
      ),
      '/login',
    );
  });

  test('coach and admin routes enforce their client-side role gates', () {
    expect(routeAccessRedirect(member, '/coach/clients'), '/dashboard');
    expect(routeAccessRedirect(coach, '/coach/clients'), isNull);
    expect(routeAccessRedirect(member, '/admin/users'), '/dashboard');
    expect(routeAccessRedirect(admin, '/admin/users'), isNull);
  });
}
