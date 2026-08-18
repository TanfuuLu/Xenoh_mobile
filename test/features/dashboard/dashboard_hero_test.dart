import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/core/widgets/synced_background_card.dart';
import 'package:xenoh_mobile/features/dashboard/domain/entities/personal_dashboard.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/dashboard_hero.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('combines dashboard identity and XP in one hero card', (
    tester,
  ) async {
    const profile = DashboardProfile(
      firstName: 'Demo',
      currentStreak: 4,
      level: 11,
      totalXp: 9200,
      xpToNextLevel: 11000,
      title: 'Novice',
    );

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ListView(
            children: const [
              DashboardHero(
                profile: profile,
                backgroundImagePath: 'saved-background.jpg',
              ),
            ],
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SyncedBackgroundCard &&
            widget.minHeight == AppLayout.heroCardMinHeight &&
            widget.backgroundImagePath == 'saved-background.jpg',
      ),
      findsOneWidget,
    );
    expect(
      tester.getSize(find.byType(SyncedBackgroundCard)).height,
      AppLayout.heroCardMinHeight,
    );
    expect(find.text('Demo'), findsOneWidget);
    // The plate calculator now lives in its own card below the hero.
    expect(find.text('Plate calculator'), findsNothing);
    expect(find.textContaining('Novice'), findsOneWidget);
    expect(find.textContaining('11,000 XP'), findsOneWidget);
  });
}
