import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/community/data/repositories/community_repository_provider.dart';
import 'package:xenoh_mobile/features/community/domain/entities/community_models.dart';
import 'package:xenoh_mobile/features/community/domain/repositories/community_repository.dart';
import 'package:xenoh_mobile/features/community/presentation/screens/community_settings_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('loads and saves community stats visibility', (tester) async {
    final repository = _SettingsRepository();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          communityRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: CommunitySettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Community privacy'), findsOneWidget);
    expect(find.text('Friends can view stats'), findsOneWidget);

    await tester.tap(find.text('Only me'));
    await tester.tap(find.text('Save'));
    await tester.pumpAndSettle();

    expect(repository.saved, CommunityStatsVisibility.onlyMe);
    expect(find.text('Privacy settings saved.'), findsOneWidget);
  });

  testWidgets('keeps the privacy form mounted while a save is pending', (
    tester,
  ) async {
    final repository = _DelayedSettingsRepository();
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          communityRepositoryProvider.overrideWithValue(repository),
        ],
        child: const MaterialApp(
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: AppLocalizations.supportedLocales,
          home: CommunitySettingsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    await tester.tap(find.text('Only me'));
    await tester.tap(find.text('Save'));
    await tester.pump();

    expect(find.text('Friends can view stats'), findsOneWidget);
    expect(find.byType(CircularProgressIndicator), findsOneWidget);

    repository.completeSave();
    await tester.pumpAndSettle();
    expect(find.text('Privacy settings saved.'), findsOneWidget);
  });
}

class _SettingsRepository implements CommunityRepository {
  CommunityStatsVisibility? saved;

  @override
  Future<CommunitySettings> getSettings() async => const CommunitySettings(
    statsVisibility: CommunityStatsVisibility.friends,
  );

  @override
  Future<CommunitySettings> updateSettings(
    CommunityStatsVisibility visibility,
  ) async {
    saved = visibility;
    return CommunitySettings(statsVisibility: visibility);
  }

  @override
  dynamic noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
}

class _DelayedSettingsRepository extends _SettingsRepository {
  final _save = Completer<CommunitySettings>();

  @override
  Future<CommunitySettings> updateSettings(
    CommunityStatsVisibility visibility,
  ) {
    saved = visibility;
    return _save.future;
  }

  void completeSave() {
    _save.complete(
      CommunitySettings(
        statsVisibility: saved ?? CommunityStatsVisibility.friends,
      ),
    );
  }
}
