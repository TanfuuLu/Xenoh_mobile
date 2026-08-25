import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_dimens.dart';
import 'package:xenoh_mobile/core/widgets/synced_background_card.dart';
import 'package:xenoh_mobile/features/dashboard/domain/entities/personal_dashboard.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/dashboard_hero.dart';
import 'package:xenoh_mobile/features/profile/data/repositories/profile_background_repository.dart';
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

    // A real file: the card only paints a background it can find on disk.
    final background = File(
      '${Directory.systemTemp.createTempSync('hero').path}'
      '${Platform.pathSeparator}saved-background.png',
    )..writeAsBytesSync(_transparentPng);
    addTearDown(() => background.parent.deleteSync(recursive: true));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentUserBackgroundProvider.overrideWith(
            (ref) async => UserBackground(
              path: background.path,
              alignment: Alignment.topCenter,
            ),
          ),
        ],
        child: MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(
            body: ListView(children: const [DashboardHero(profile: profile)]),
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is SyncedBackgroundCard &&
            widget.minHeight == AppLayout.heroCardMinHeight,
      ),
      findsOneWidget,
    );
    // The hero shows the signed-in user's saved background, framed as saved.
    expect(
      find.byWidgetPredicate(
        (widget) =>
            widget is Image &&
            widget.image is FileImage &&
            (widget.image as FileImage).file.path == background.path &&
            widget.alignment == Alignment.topCenter,
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

/// Smallest valid PNG — enough for [Image.file] to decode.
final _transparentPng = <int>[
  137, 80, 78, 71, 13, 10, 26, 10, 0, 0, 0, 13, 73, 72, 68, 82, //
  0, 0, 0, 1, 0, 0, 0, 1, 8, 6, 0, 0, 0, 31, 21, 196, 137,
  0, 0, 0, 10, 73, 68, 65, 84, 120, 156, 99, 0, 1, 0, 0, 5, 0, 1,
  13, 10, 45, 180, 0, 0, 0, 0, 73, 69, 78, 68, 174, 66, 96, 130,
];
