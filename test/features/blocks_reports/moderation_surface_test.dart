import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/weight_units.dart';
import 'package:xenoh_mobile/core/widgets/chat_bubble.dart';
import 'package:xenoh_mobile/features/community/domain/entities/community_models.dart';
import 'package:xenoh_mobile/features/community/presentation/widgets/community_widgets.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/preferences_provider.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

/// Google Play's UGC policy requires an in-app way to report *and* block
/// another user, and its Generative AI policy requires a way to flag offensive
/// model output. The app previously shipped a blocklist screen that could only
/// unblock — `POST /users/{id}/block` was never called from anywhere — which
/// made the blocklist permanently empty. These tests fail loudly if any of
/// those affordances regress.

void main() {
  testWidgets('a community post offers reporting and blocking its author', (
    tester,
  ) async {
    await tester.pumpWidget(
      _wrap(
        TrainingDayShareCard(
          share: _share(),
          onUserTap: () {},
          onLoveToggle: () {},
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.byType(PopupMenuButton<String>));
    await tester.pumpAndSettle();

    expect(find.text('Report user'), findsOneWidget);
    expect(find.text('Block user'), findsOneWidget);
  });

  testWidgets('report-only chat bubbles run the report action on long press', (
    tester,
  ) async {
    var reported = false;
    await tester.pumpWidget(
      _wrap(
        ChatBubble(
          text: 'An AI response',
          mine: false,
          onReport: () => reported = true,
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.longPress(find.text('An AI response'));
    await tester.pumpAndSettle();

    expect(reported, isTrue);
  });

  test('the client creates blocks, not just deletes them', () {
    final sources = _libSources();

    final createsBlock = sources.entries.where(
      (e) =>
          e.value.contains('/block') &&
          (e.value.contains('postVoid') || e.value.contains('postObject')),
    );
    expect(
      createsBlock,
      isNotEmpty,
      reason:
          'No client code POSTs to /users/{id}/block. Play requires an in-app '
          'block affordance; an unblock-only blocklist does not satisfy it.',
    );
  });

  test('the client can report a user and an AI response', () {
    final sources = _libSources();

    expect(
      sources.entries.where((e) => e.value.contains('/reports')),
      isNotEmpty,
      reason: 'No client code POSTs a user report.',
    );
    expect(
      sources.entries.where(
        (e) =>
            e.key.contains('moderation_dialogs') &&
            e.value.contains('/bug-reports'),
      ),
      isNotEmpty,
      reason:
          'AI responses must be reportable. That flow rides on /bug-reports '
          'because there is no dedicated AI-report endpoint.',
    );
  });

  test('report reasons are localized rather than hardcoded English', () {
    final source = File(
      'lib/features/community/presentation/widgets/share_action_dialogs.dart',
    ).readAsStringSync();

    expect(source, contains('moderationReasonLabel'));
    expect(
      source,
      isNot(contains("'Harassment'")),
      reason:
          'Reason labels must come from l10n; only the value sent to the API '
          'stays in English, and that list lives in moderation_dialogs.dart.',
    );
  });
}

Map<String, String> _libSources() {
  final sources = <String, String>{};
  for (final entity in Directory('lib').listSync(recursive: true)) {
    if (entity is! File || !entity.path.endsWith('.dart')) continue;
    sources[entity.path.replaceAll(r'\', '/')] = entity.readAsStringSync();
  }
  return sources;
}

Widget _wrap(Widget child) => ProviderScope(
  overrides: [weightUnitProvider.overrideWithValue(WeightUnit.kg)],
  child: MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(body: SingleChildScrollView(child: child)),
  ),
);

TrainingDayShare _share() => TrainingDayShare(
  id: 'share-1',
  userId: 'user-1',
  userFullName: 'Another Athlete',
  sourceDailyWorkoutId: 'workout-1',
  workoutDate: DateTime(2026, 8, 9),
  dayOfWeek: 'Sunday',
  dayStatus: 'Completed',
  exerciseCount: 0,
  completedSets: 0,
  totalVolume: 0,
  totalDurationSeconds: 0,
  hasPersonalRecord: false,
  loveCount: 0,
  lovedByCurrentUser: false,
  createdAt: DateTime(2026, 8, 9),
  exercises: const [],
);
