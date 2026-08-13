import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/network/dio_provider.dart';
import '../../data/repositories/auth_repository_provider.dart';
import '../../domain/entities/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import 'auth_state.dart';

part 'auth_controller.g.dart';

/// App-wide auth state holder. Attempts a silent refresh on startup and exposes
/// login / register / logout. Submit-level loading/errors are returned to the
/// caller (the screens) rather than folded into [AuthState].
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthState build() {
    // When a background refresh fails, the interceptor flips this flag — drop
    // the session so the router redirects to /login.
    ref.listen(sessionExpiredProvider, (previous, next) {
      if (next) {
        ref.read(sessionExpiredProvider.notifier).reset();
        state = const AuthState.unauthenticated();
      }
    });

    unawaited(_restore());
    return const AuthState.unknown();
  }

  AuthRepository get _repo => ref.read(authRepositoryProvider);

  Future<void> _restore() async {
    final result = await _repo.restoreSession();
    state = switch (result) {
      Ok(:final value) => AuthState.authenticated(value),
      Err() => const AuthState.unauthenticated(),
    };
    ref.read(authBootstrappedProvider.notifier).markDone();
  }

  /// Returns null on success, or the [Failure] to surface in the UI.
  Future<Failure?> login({
    required String email,
    required String password,
  }) async {
    final result = await _repo.login(email: email, password: password);
    switch (result) {
      case Ok(:final value):
        state = AuthState.authenticated(value);
        _refreshUserScopedCaches();
        return null;
      case Err(:final failure):
        return failure;
    }
  }

  Future<Failure?> exchangeExternalTicket(String ticket) async {
    final result = await _repo.exchangeExternalTicket(ticket);
    switch (result) {
      case Ok(:final value):
        state = AuthState.authenticated(value);
        _refreshUserScopedCaches();
        return null;
      case Err(:final failure):
        return failure;
    }
  }

  Future<Failure?> completeExternalRegistration({required String role}) async {
    final result = await _repo.completeExternalRegistration(role: role);
    switch (result) {
      case Ok(:final value):
        state = AuthState.authenticated(value);
        _refreshUserScopedCaches();
        return null;
      case Err(:final failure):
        return failure;
    }
  }

  /// Rebuilds the authenticated HTTP dependency graph after the access token
  /// changes. Every remote repository/API provider watches [dioProvider], so
  /// invalidating it also discards data and in-flight requests from the
  /// previous account instead of leaving screens with stale cached results.
  void _refreshUserScopedCaches() {
    ref.invalidate(dioProvider);
  }

  Future<Failure?> sendForgotPasswordCode(String email) async {
    final result = await _repo.sendForgotPasswordCode(email);
    return switch (result) {
      Ok() => null,
      Err(:final failure) => failure,
    };
  }

  Future<Failure?> resetPasswordWithCode({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    final result = await _repo.resetPasswordWithCode(
      email: email,
      code: code,
      newPassword: newPassword,
    );
    return switch (result) {
      Ok() => null,
      Err(:final failure) => failure,
    };
  }

  Future<Failure?> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    final result = await _repo.changePassword(
      oldPassword: oldPassword,
      newPassword: newPassword,
    );
    return switch (result) {
      Ok() => null,
      Err(:final failure) => failure,
    };
  }

  /// Register a new account. Returns null on success or the [Failure] to
  /// surface. The caller decides where to navigate after registration.
  Future<Failure?> register(RegisterParams params) async {
    final result = await _repo.register(params);
    return switch (result) {
      Ok() => null,
      Err(:final failure) => failure,
    };
  }

  Future<void> logout() async {
    await _repo.logout();
    state = const AuthState.unauthenticated();
  }

  Future<Failure?> deleteAccount() async {
    final result = await _repo.deleteAccount();
    switch (result) {
      case Ok():
        state = const AuthState.unauthenticated();
        return null;
      case Err(:final failure):
        return failure;
    }
  }

  Future<Failure?> requestAccountDeletion(String email) async {
    final result = await _repo.requestAccountDeletion(email);
    return switch (result) {
      Ok() => null,
      Err(:final failure) => failure,
    };
  }

  Future<Failure?> verifyAccountDeletion(String token) async {
    final result = await _repo.verifyAccountDeletion(token);
    switch (result) {
      case Ok():
        state = const AuthState.unauthenticated();
        return null;
      case Err(:final failure):
        return failure;
    }
  }
}

/// Cheap, independent flag: true once the startup silent-refresh attempt
/// ([AuthController._restore]) has finished, regardless of outcome.
/// [features/profile/presentation/providers/preferences_provider.dart]'s
/// `AppLocale` watches this — not [authControllerProvider] itself — so that
/// checking "is auth ready yet" never forces [AuthController]'s build (and
/// its network/token bootstrap) as a side effect on screens that don't
/// otherwise need auth. `authControllerProvider` already gets built
/// independently by the router on every navigation, which is what actually
/// drives this flag in the real app.
@Riverpod(keepAlive: true)
class AuthBootstrapped extends _$AuthBootstrapped {
  @override
  bool build() => false;

  void markDone() => state = true;
}
