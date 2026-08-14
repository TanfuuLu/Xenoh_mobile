import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/result.dart';
import 'package:xenoh_mobile/core/network/cookie_jar_provider.dart';
import 'package:xenoh_mobile/features/auth/data/repositories/auth_repository_provider.dart';
import 'package:xenoh_mobile/features/auth/domain/repositories/auth_repository.dart';
import 'package:xenoh_mobile/features/coach_client/domain/chat_unread_repository.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/providers/chat_unread_controller.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/client_chat_entry_screen.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/relationship_chat_screen.dart';
import 'package:xenoh_mobile/features/shared_api/api_widgets.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _ClientChatApi extends XenohApi {
  _ClientChatApi(this.relationship) : super(Dio());

  final JsonMap? relationship;

  @override
  Future<JsonMap?> getNullableObject(String path) async {
    expect(path, '/coach-client/my-coach');
    return relationship;
  }

  @override
  Future<JsonMap> getObject(String path) async {
    expect(path, '/messages/relationships/relationship-1?pageSize=50');
    return const {'items': <JsonMap>[]};
  }
}

class _UnreadRepository implements ChatUnreadRepository {
  @override
  Future<Map<String, int>> getUnreadCounts() async => const {};

  @override
  Future<void> markRead(String relationshipId) async {}
}

class _FailingClientChatApi extends _ClientChatApi {
  _FailingClientChatApi() : super(null);

  @override
  Future<JsonMap?> getNullableObject(String path) async {
    throw Exception('relationship request failed');
  }
}

class _AuthRepository extends Mock implements AuthRepository {}

void main() {
  testWidgets('active relationship opens the client coach conversation', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        _ClientChatApi(const {
          'id': 'relationship-1',
          'coachName': 'Demo Coach',
        }),
      ),
    );
    await tester.pumpAndSettle();

    final screen = tester.widget<RelationshipChatScreen>(
      find.byType(RelationshipChatScreen),
    );
    expect(screen.relationshipId, 'relationship-1');
    expect(screen.peerName, 'Demo Coach');
  });

  testWidgets('missing relationship shows the connect-coach empty state', (
    tester,
  ) async {
    await tester.pumpWidget(_app(_ClientChatApi(null)));
    await tester.pumpAndSettle();

    expect(find.text('No coach connected'), findsOneWidget);
    expect(find.byType(RelationshipChatScreen), findsNothing);
  });

  testWidgets('notification deep link without a peer name shows a safe title', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        _ClientChatApi(null),
        home: const RelationshipChatScreen(
          relationshipId: 'relationship-1',
          peerName: '',
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('User'), findsOneWidget);
    expect(find.text('Message User'), findsOneWidget);
  });

  testWidgets('relationship lookup failure renders a retryable error', (
    tester,
  ) async {
    await tester.pumpWidget(_app(_FailingClientChatApi()));
    await tester.pumpAndSettle();

    expect(find.byType(FeatureError), findsOneWidget);
    expect(find.text('Retry'), findsOneWidget);
  });
}

Widget _app(_ClientChatApi api, {Widget? home}) {
  final authRepository = _AuthRepository();
  when(
    authRepository.restoreSession,
  ).thenAnswer((_) async => const Err(AuthFailure()));
  return ProviderScope(
    overrides: [
      xenohApiProvider.overrideWithValue(api),
      chatUnreadRepositoryProvider.overrideWithValue(_UnreadRepository()),
      authRepositoryProvider.overrideWithValue(authRepository),
      cookieJarProvider.overrideWithValue(CookieJar()),
    ],
    child: MaterialApp(
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,
      home: home ?? const ClientChatEntryScreen(),
    ),
  );
}
