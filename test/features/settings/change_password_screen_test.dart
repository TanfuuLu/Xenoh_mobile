import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/result.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/core/widgets/xn_input.dart';
import 'package:xenoh_mobile/features/auth/data/repositories/auth_repository_provider.dart';
import 'package:xenoh_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:xenoh_mobile/features/settings/presentation/screens/change_password_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockAuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('matches the website security header and card structure', (
    tester,
  ) async {
    final repository = _MockAuthRepository();
    when(repository.restoreSession).thenAnswer(
      (_) async => const Err(AuthFailure()),
    );

    await _pump(tester, repository);

    expect(find.text('SECURITY'), findsOneWidget);
    expect(find.text('Change Password'), findsWidgets);
    expect(
      find.text('Confirm your current password before setting a new one.'),
      findsOneWidget,
    );
    expect(find.text('Confirm new password'), findsOneWidget);
    expect(find.byIcon(Icons.lock_outline_rounded), findsNWidgets(3));
    expect(find.byType(XnCard), findsOneWidget);
  });

  testWidgets('requires all three passwords before enabling submit', (
    tester,
  ) async {
    final repository = _MockAuthRepository();
    when(repository.restoreSession).thenAnswer(
      (_) async => const Err(AuthFailure()),
    );

    await _pump(tester, repository);

    expect(_saveButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).first, 'current-secret');
    await tester.pump();
    expect(_saveButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).at(1), 'new-secret');
    await tester.pump();
    expect(_saveButton(tester).onPressed, isNull);

    await tester.enterText(find.byType(TextFormField).at(2), 'new-secret');
    await tester.pump();
    expect(_saveButton(tester).onPressed, isNotNull);
  });

  testWidgets('does not call the API when new passwords do not match', (
    tester,
  ) async {
    final repository = _MockAuthRepository();
    when(repository.restoreSession).thenAnswer(
      (_) async => const Err(AuthFailure()),
    );

    await _pump(tester, repository);
    await tester.enterText(find.byType(TextFormField).at(0), 'current-secret');
    await tester.enterText(find.byType(TextFormField).at(1), 'new-secret');
    await tester.enterText(
      find.byType(TextFormField).at(2),
      'different-secret',
    );
    await tester.pump();
    await tester.tap(find.text('Update password'));
    await tester.pump();

    expect(find.text('New passwords do not match.'), findsOneWidget);
    verifyNever(
      () => repository.changePassword(
        oldPassword: any(named: 'oldPassword'),
        newPassword: any(named: 'newPassword'),
      ),
    );
  });

  testWidgets(
    'shows an incorrect current password error and does not succeed',
    (
      tester,
    ) async {
      final repository = _MockAuthRepository();
      when(repository.restoreSession).thenAnswer(
        (_) async => const Err(AuthFailure()),
      );
      when(
        () => repository.changePassword(
          oldPassword: 'wrong-secret',
          newPassword: 'new-secret',
        ),
      ).thenAnswer(
        (_) async => const Err(
          // Mirrors a 400 whose body carried a message: `failureFromDio` marks
          // those as server text, which the UI shows instead of generic copy.
          ValidationFailure(
            'Current password is incorrect.',
            isServerMessage: true,
          ),
        ),
      );

      await _pump(tester, repository);
      await tester.enterText(find.byType(TextFormField).first, 'wrong-secret');
      await tester.enterText(find.byType(TextFormField).at(1), 'new-secret');
      await tester.enterText(find.byType(TextFormField).at(2), 'new-secret');
      await tester.pump();
      await tester.tap(find.text('Update password'));
      await tester.pumpAndSettle();

      verify(
        () => repository.changePassword(
          oldPassword: 'wrong-secret',
          newPassword: 'new-secret',
        ),
      ).called(1);
      expect(find.byType(SnackBar), findsNothing);
      expect(
        tester
            .widgetList<XnInput>(find.byType(XnInput))
            .map((widget) => widget.errorText),
        contains('Current password is incorrect.'),
      );
      expect(
        tester
            .widgetList<InputDecorator>(find.byType(InputDecorator))
            .map((widget) => widget.decoration.errorText),
        contains('Current password is incorrect.'),
      );
      expect(find.text('Current password is incorrect.'), findsOneWidget);
      expect(find.text('Password updated.'), findsNothing);
    },
  );
}

FilledButton _saveButton(WidgetTester tester) {
  return tester.widget<FilledButton>(find.byType(FilledButton));
}

Future<void> _pump(
  WidgetTester tester,
  AuthRepository repository,
) async {
  await tester.pumpWidget(
    ProviderScope(
      overrides: [authRepositoryProvider.overrideWithValue(repository)],
      child: MaterialApp(
        theme: AppTheme.light(),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: const ChangePasswordScreen(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
