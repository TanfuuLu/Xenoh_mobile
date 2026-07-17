import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/key_vault_screen.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _FakeXenohApi extends XenohApi {
  _FakeXenohApi() : super(Dio());

  final posts = <JsonMap>[];

  @override
  Future<List<JsonMap>> getList(String path) async {
    expect(path, '/coach-client/invite-codes');
    return const <JsonMap>[];
  }

  @override
  Future<JsonMap> postObject(String path, JsonMap data) async {
    expect(path, '/coach-client/invite-codes');
    posts.add(data);
    return {'id': 'key1', 'code': 'COACH-123'};
  }
}

Widget _app(_FakeXenohApi api) {
  return ProviderScope(
    overrides: [xenohApiProvider.overrideWithValue(api)],
    child: const MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: KeyVaultScreen(),
    ),
  );
}

void main() {
  testWidgets('creates coach key with coaching date window', (tester) async {
    final api = _FakeXenohApi();

    await tester.pumpWidget(_app(api));
    await tester.pumpAndSettle();

    await tester.tap(find.byTooltip('Generate invite code'));
    await tester.pumpAndSettle();

    expect(find.text('Create coach key'), findsOneWidget);

    await tester.tap(find.text('Create key'));
    await tester.pumpAndSettle();

    expect(api.posts, hasLength(1));
    expect(api.posts.single, contains('coachingStartDate'));
    expect(api.posts.single, contains('coachingEndDate'));
    expect(api.posts.single['coachingStartDate'], isA<String>());
    expect(api.posts.single['coachingEndDate'], isA<String>());
    expect(find.text('Coach key created.'), findsOneWidget);
  });
}
