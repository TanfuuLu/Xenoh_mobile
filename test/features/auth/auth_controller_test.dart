// ignore_for_file: cascade_invocations — sequential container.read calls read clearer.

import 'dart:async';

import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/result.dart';
import 'package:xenoh_mobile/core/network/cookie_jar_provider.dart';
import 'package:xenoh_mobile/core/network/xenoh_api.dart';
import 'package:xenoh_mobile/features/auth/data/repositories/auth_repository_provider.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/auth_session.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/register_params.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_controller.dart';
import 'package:xenoh_mobile/features/auth/presentation/providers/auth_state.dart';

class MockAuthRepository extends Mock implements AuthRepository {}

class FakeRegisterParams extends Fake implements RegisterParams {}

const _session = AuthSession(
  accessToken: 'tok',
  user: User(
    id: '1',
    email: 'a@b.com',
    fullName: 'Ada Lovelace',
    roles: ['Individual'],
  ),
);

ProviderContainer _container(AuthRepository repo) {
  final container = ProviderContainer(
    overrides: [
      authRepositoryProvider.overrideWithValue(repo),
      cookieJarProvider.overrideWithValue(CookieJar()),
    ],
  );
  addTearDown(container.dispose);
  return container;
}

void main() {
  setUpAll(() => registerFallbackValue(FakeRegisterParams()));

  test('restores to unauthenticated when there is no session', () async {
    final repo = MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));

    final container = _container(repo);
    // Trigger build(), then let its async _restore() settle.
    container.read(authControllerProvider);
    await Future<void>.delayed(Duration.zero);

    expect(
      container.read(authControllerProvider),
      isA<Unauthenticated>(),
    );
  });

  test('login success transitions to authenticated', () async {
    final repo = MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Ok(_session));

    final container = _container(repo);
    final controller = container.read(authControllerProvider.notifier);

    final failure = await controller.login(email: 'a@b.com', password: 'pw');

    expect(failure, isNull);
    expect(container.read(authControllerProvider).isAuthed, isTrue);
    expect(
      container.read(authControllerProvider).sessionOrNull?.user.fullName,
      'Ada Lovelace',
    );
  });

  test('login success rebuilds user-scoped API dependencies', () async {
    final repo = MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Ok(_session));

    final container = _container(repo);
    final controller = container.read(authControllerProvider.notifier);
    await Future<void>.delayed(Duration.zero);
    final apiBeforeLogin = container.read(xenohApiProvider);

    final failure = await controller.login(email: 'a@b.com', password: 'pw');
    final apiAfterLogin = container.read(xenohApiProvider);

    expect(failure, isNull);
    expect(apiAfterLogin, isNot(same(apiBeforeLogin)));
  });

  test('login failure returns the failure and stays unauthenticated', () async {
    final repo = MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));
    when(
      () => repo.login(
        email: any(named: 'email'),
        password: any(named: 'password'),
      ),
    ).thenAnswer((_) async => const Err(ValidationFailure('Bad creds')));

    final container = _container(repo);
    final controller = container.read(authControllerProvider.notifier);

    final failure = await controller.login(email: 'a@b.com', password: 'pw');

    expect(failure, isA<ValidationFailure>());
    expect(container.read(authControllerProvider).isAuthed, isFalse);
  });

  test('duplicate external ticket deliveries share one exchange', () async {
    final repo = MockAuthRepository();
    final exchange = Completer<Result<AuthSession>>();
    when(repo.restoreSession).thenAnswer((_) async => const Err(AuthFailure()));
    when(
      () => repo.exchangeExternalTicket('one-time-ticket'),
    ).thenAnswer((_) => exchange.future);

    final container = _container(repo);
    final controller = container.read(authControllerProvider.notifier);

    final first = controller.exchangeExternalTicket('one-time-ticket');
    final duplicate = controller.exchangeExternalTicket('one-time-ticket');
    exchange.complete(const Ok(_session));

    expect(await first, isNull);
    expect(await duplicate, isNull);
    verify(() => repo.exchangeExternalTicket('one-time-ticket')).called(1);
  });

  test(
    'late startup restore cannot overwrite external login success',
    () async {
      final repo = MockAuthRepository();
      final restore = Completer<Result<AuthSession>>();
      when(repo.restoreSession).thenAnswer((_) => restore.future);
      when(
        () => repo.exchangeExternalTicket('one-time-ticket'),
      ).thenAnswer((_) async => const Ok(_session));

      final container = _container(repo);
      final controller = container.read(authControllerProvider.notifier);

      expect(
        await controller.exchangeExternalTicket('one-time-ticket'),
        isNull,
      );
      restore.complete(const Err(AuthFailure()));
      await Future<void>.delayed(Duration.zero);

      expect(container.read(authControllerProvider), isA<Authenticated>());
    },
  );

  test('logout clears the session', () async {
    final repo = MockAuthRepository();
    when(repo.restoreSession).thenAnswer((_) async => const Ok(_session));
    when(repo.logout).thenAnswer((_) async {});

    final container = _container(repo);
    final controller = container.read(authControllerProvider.notifier);
    await Future<void>.delayed(Duration.zero);

    await controller.logout();

    expect(container.read(authControllerProvider), isA<Unauthenticated>());
    verify(repo.logout).called(1);
  });
}
