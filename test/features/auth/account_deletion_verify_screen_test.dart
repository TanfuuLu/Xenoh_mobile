import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/result.dart';
import 'package:xenoh_mobile/features/auth/data/repositories/auth_repository_provider.dart';
import 'package:xenoh_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:xenoh_mobile/features/auth/presentation/screens/account_deletion_verify_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('verifies the token and shows permanent deletion success', (
    tester,
  ) async {
    final repository = _MockAuthRepository();
    when(repository.restoreSession).thenAnswer(
      (_) async => const Err(AuthFailure()),
    );
    when(
      () => repository.verifyAccountDeletion('valid-token'),
    ).thenAnswer((_) async => const Ok(null));

    await _pump(
      tester,
      repository,
      const AccountDeletionVerifyScreen(token: 'valid-token'),
    );

    expect(find.byKey(AccountDeletionVerifyScreen.successKey), findsOneWidget);
    expect(find.text('Account deletion completed'), findsOneWidget);
    verify(() => repository.verifyAccountDeletion('valid-token')).called(1);
  });

  testWidgets('does not call the API when the link has no token', (
    tester,
  ) async {
    final repository = _MockAuthRepository();
    when(repository.restoreSession).thenAnswer(
      (_) async => const Err(AuthFailure()),
    );

    await _pump(
      tester,
      repository,
      const AccountDeletionVerifyScreen(),
    );

    expect(find.byKey(AccountDeletionVerifyScreen.failureKey), findsOneWidget);
    expect(
      find.text('This deletion link is invalid or expired'),
      findsOneWidget,
    );
    verifyNever(() => repository.verifyAccountDeletion(any()));
  });

  testWidgets('shows failure when the backend rejects an expired token', (
    tester,
  ) async {
    final repository = _MockAuthRepository();
    when(repository.restoreSession).thenAnswer(
      (_) async => const Err(AuthFailure()),
    );
    when(
      () => repository.verifyAccountDeletion('expired-token'),
    ).thenAnswer(
      (_) async => const Err(ValidationFailure('Invalid or expired link.')),
    );

    await _pump(
      tester,
      repository,
      const AccountDeletionVerifyScreen(token: 'expired-token'),
    );

    expect(find.byKey(AccountDeletionVerifyScreen.failureKey), findsOneWidget);
  });
}

Future<void> _pump(
  WidgetTester tester,
  AuthRepository repository,
  Widget child,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: child,
      ),
    ),
  );
  await tester.pumpAndSettle();
}
