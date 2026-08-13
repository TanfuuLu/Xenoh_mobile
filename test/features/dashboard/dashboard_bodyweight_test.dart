import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/widgets/hero_card_background.dart';
import 'package:xenoh_mobile/features/dashboard/data/repositories/dashboard_repository_provider.dart';
import 'package:xenoh_mobile/features/dashboard/domain/entities/personal_dashboard.dart';
import 'package:xenoh_mobile/features/dashboard/domain/repositories/dashboard_repository.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/community_dashboard_card.dart';
import 'package:xenoh_mobile/features/profile/data/repositories/profile_repository_provider.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/bodyweight_log.dart';
import 'package:xenoh_mobile/features/profile/domain/repositories/profile_repository.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockDashboardRepository extends Mock implements DashboardRepository {}

class MockProfileRepository extends Mock implements ProfileRepository {}

const _dashboard = PersonalDashboard(
  profile: DashboardProfile(
    firstName: 'Lu',
    currentStreak: 2,
    level: 18,
    totalXp: 18400,
    xpToNextLevel: 18000,
    title: 'Novice',
    latestBodyweight: 78.1,
    bmi: 22.4,
  ),
  nutritionToday: NutritionToday(
    loggedCalories: 0,
    loggedProteinG: 0,
    loggedCarbsG: 0,
    loggedFatG: 0,
  ),
  proInsights: ProInsights(isUnlocked: false),
);

void main() {
  testWidgets('Home shows the bodyweight card with its trend', (tester) async {
    final dash = MockDashboardRepository();
    when(dash.fetchPersonal).thenAnswer((_) async => _dashboard);

    final profile = MockProfileRepository();
    when(profile.getBodyweightHistory).thenAnswer(
      (_) async => [
        BodyweightLog(id: 'b1', weight: 78.2, date: DateTime(2026, 5, 20)),
        BodyweightLog(id: 'b2', weight: 78.1, date: DateTime(2026, 6, 1)),
      ],
    );
    when(() => profile.logBodyweight(any())).thenAnswer((_) async {});

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          dashboardRepositoryProvider.overrideWithValue(dash),
          profileRepositoryProvider.overrideWithValue(profile),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: DashboardScreen(),
        ),
      ),
    );
    // Not pumpAndSettle: the nutrition ring is an indeterminate (forever
    // animating) spinner when no target is set, so the tree never "settles".
    await tester.pump(); // kick off the async repo reads
    await tester.pump(const Duration(milliseconds: 50)); // resolve futures

    expect(tester.takeException(), isNull);
    expect(find.byType(CommunityDashboardCard), findsNothing);

    // Identity, quick action, and XP share the image-backed hero surface.
    expect(find.byType(HeroCardBackground), findsOneWidget);

    await tester.scrollUntilVisible(
      find.text('BODYWEIGHT'),
      300,
      scrollable: find.byType(Scrollable).first,
    );

    expect(tester.takeException(), isNull);
    await tester.pump(const Duration(milliseconds: 750));

    expect(find.text('BODYWEIGHT'), findsOneWidget);
    expect(find.text('78.1 kg'), findsOneWidget);
    expect(find.text('Log'), findsOneWidget);
    expect(find.byTooltip('Bodyweight history'), findsOneWidget);

    await tester.tap(find.byTooltip('Bodyweight history'));
    await tester.pump(const Duration(milliseconds: 400));
    expect(find.text('Bodyweight history'), findsOneWidget);
    await tester.tapAt(const Offset(10, 10));
    await tester.pump(const Duration(milliseconds: 400));

    await tester.tap(find.text('78.1 kg'));
    await tester.pump();

    expect(find.byType(TextField), findsOneWidget);
    await tester.enterText(find.byType(TextField), '76.4');
    await tester.tapAt(const Offset(10, 10));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 750));

    expect(find.byType(TextField), findsNothing);
    expect(find.text('78.1 kg'), findsOneWidget);
    verifyNever(() => profile.logBodyweight(any()));

    await tester.tap(find.text('78.1 kg'));
    await tester.pump();
    await tester.enterText(find.byType(TextField), '77.8');
    await tester.tap(find.text('Log'));
    await tester.pump();
    await tester.pump(const Duration(milliseconds: 50));

    expect(find.byType(AlertDialog), findsNothing);
    verify(() => profile.logBodyweight(77.8)).called(1);
  });
}
