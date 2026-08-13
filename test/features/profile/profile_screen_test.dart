import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/core/widgets/synced_background_card.dart';
import 'package:xenoh_mobile/features/profile/data/repositories/profile_repository_provider.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/training_activity.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/user_profile.dart';
import 'package:xenoh_mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:xenoh_mobile/features/profile/presentation/screens/profile_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockProfileRepository extends Mock implements ProfileRepository {}

final _profile = UserProfile(
  id: 'u1',
  email: 'lu@example.com',
  firstName: 'Lu',
  lastName: 'Phuc',
  currentStreak: 2,
  level: 2,
  totalXp: 530,
  xpToNextLevel: 1470,
  title: 'Beginner',
  big3Prs: const Big3Prs(),
  bio: 'Female powerlifter chasing a 1.5x bodyweight squat',
  dateOfBirth: DateTime(2009, 6, 13),
  gender: 'Male',
);

final _activity = TrainingActivity(
  totalDurationSeconds: 0,
  totalWeightTrainedKg: 0,
  accountCreatedAt: DateTime(2026),
  year: DateTime.now().year,
  month: DateTime.now().month,
  trainedDates: [DateTime(DateTime.now().year, DateTime.now().month, 7)],
);

void main() {
  testWidgets('ProfileScreen renders profile + calendar without errors', (
    tester,
  ) async {
    final repo = MockProfileRepository();
    when(repo.getMe).thenAnswer((_) async => _profile);
    when(
      () => repo.getTrainingActivity(
        year: any(named: 'year'),
        month: any(named: 'month'),
      ),
    ).thenAnswer((_) async => _activity);
    await tester.pumpWidget(
      ProviderScope(
        overrides: [profileRepositoryProvider.overrideWithValue(repo)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ProfileScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Lu Phuc'), findsOneWidget);
    expect(find.text('Beginner'), findsOneWidget);
    expect(find.textContaining('Female powerlifter'), findsNothing);
    expect(find.text('BIO'), findsNothing);
    // Bodyweight and its history live on Home, not in the Profile level card.
    expect(find.text('BODYWEIGHT'), findsNothing);
    expect(find.text('80 kg'), findsNothing);
    expect(find.byIcon(Icons.history_rounded), findsNothing);
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Container &&
            widget.constraints?.minHeight == AppLayout.heroCardMinHeight,
      ),
      findsOneWidget,
    );
    expect(
      tester.getSize(find.byType(SyncedBackgroundCard)).height,
      AppLayout.heroCardMinHeight,
    );
    final heroRect = tester.getRect(find.byType(SyncedBackgroundCard));
    final levelRect = tester.getRect(
      find.byKey(const ValueKey('profile-level-card')),
    );
    expect(heroRect.bottom - levelRect.bottom, AppSpacing.lg + 1);

    // Scroll the calendar (grid) into view to exercise its layout too.
    await tester.scrollUntilVisible(
      find.text('TRAINING CALENDAR'),
      300,
      scrollable: find.byType(Scrollable).first,
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('TRAINING CALENDAR'), findsOneWidget);
    // A trained day cell renders (day 7 was seeded as trained).
    expect(find.text('7'), findsOneWidget);
  });
}
