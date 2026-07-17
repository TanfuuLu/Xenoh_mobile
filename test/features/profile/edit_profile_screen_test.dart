import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/profile/data/repositories/profile_repository_provider.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/user_profile.dart';
import 'package:xenoh_mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:xenoh_mobile/features/profile/presentation/screens/edit_profile_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

const _profile = UserProfile(
  id: 'u1',
  email: 'lu@example.com',
  firstName: 'Lu',
  lastName: 'Phuc',
  currentStreak: 2,
  level: 2,
  totalXp: 530,
  xpToNextLevel: 1470,
  title: 'Beginner',
  big3Prs: Big3Prs(),
  gender: 'Male',
);

void main() {
  testWidgets('renders the form prefilled and saves edits', (tester) async {
    final repo = MockProfileRepository();
    when(
      () => repo.updateProfile(
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        bio: any(named: 'bio'),
        height: any(named: 'height'),
        gender: any(named: 'gender'),
        dateOfBirth: any(named: 'dateOfBirth'),
        developmentDirection: any(named: 'developmentDirection'),
        trainingDiscipline: any(named: 'trainingDiscipline'),
        facebookUrl: any(named: 'facebookUrl'),
        instagramUrl: any(named: 'instagramUrl'),
        zaloUrl: any(named: 'zaloUrl'),
      ),
    ).thenAnswer((_) async => _profile);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [profileRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: EditProfileScreen(profile: _profile),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    // Prefilled name.
    expect(find.widgetWithText(TextFormField, 'Lu'), findsOneWidget);

    // Edit the bio and save.
    await tester.enterText(
      find.widgetWithText(TextFormField, 'A short line about you'),
      'Chasing a 200kg squat',
    );
    await tester.scrollUntilVisible(
      find.text('Save changes'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save changes'));
    await tester.pump();

    verify(
      () => repo.updateProfile(
        firstName: 'Lu',
        lastName: 'Phuc',
        bio: 'Chasing a 200kg squat',
        height: null,
        gender: 'Male',
        dateOfBirth: null,
        developmentDirection: null,
        trainingDiscipline: null,
        facebookUrl: null,
        instagramUrl: null,
        zaloUrl: null,
      ),
    ).called(1);
  });

  testWidgets('blocks save when a required name is cleared', (tester) async {
    final repo = MockProfileRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [profileRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: EditProfileScreen(profile: _profile),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.enterText(find.widgetWithText(TextFormField, 'Lu'), '');
    await tester.scrollUntilVisible(
      find.text('Save changes'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    await tester.tap(find.text('Save changes'));
    await tester.pump();

    // Scroll the (now invalid) name field back into view to see its error.
    await tester.scrollUntilVisible(
      find.text('First name'),
      -300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();
    expect(find.text('Required'), findsOneWidget);
    verifyNever(
      () => repo.updateProfile(
        firstName: any(named: 'firstName'),
        lastName: any(named: 'lastName'),
        bio: any(named: 'bio'),
        height: any(named: 'height'),
        gender: any(named: 'gender'),
        dateOfBirth: any(named: 'dateOfBirth'),
        developmentDirection: any(named: 'developmentDirection'),
        trainingDiscipline: any(named: 'trainingDiscipline'),
        facebookUrl: any(named: 'facebookUrl'),
        instagramUrl: any(named: 'instagramUrl'),
        zaloUrl: any(named: 'zaloUrl'),
      ),
    );
  });
}
