import 'dart:async';
import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/coach_client/data/chat_unread_remote_data_source.dart';
import 'package:xenoh_mobile/features/coach_client/domain/chat_unread_repository.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/providers/chat_unread_controller.dart';

void main() {
  test('uses exact unread count and mark-read routes', () async {
    final adapter = _ChatAdapter();
    final source = ChatUnreadRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final counts = await source.getUnreadCounts();
    await source.markRead('relationship-1');

    expect(counts, {'relationship-1': 2});
    expect(adapter.requests, [
      'GET /messages/unread-counts',
      'POST /messages/relationships/relationship-1/read',
    ]);
  });

  test('latest reconciliation wins when duplicate events race', () async {
    final repository = _FakeChatUnreadRepository();
    final container = ProviderContainer(
      overrides: [
        chatUnreadRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);
    expect(await container.read(chatUnreadControllerProvider.future), {
      'relationship-1': 1,
    });

    final first = Completer<Map<String, int>>();
    final second = Completer<Map<String, int>>();
    repository.pending
      ..add(first)
      ..add(second);
    final controller = container.read(chatUnreadControllerProvider.notifier);
    final firstRefresh = controller.reconcile();
    final secondRefresh = controller.reconcile();
    second.complete({'relationship-1': 3});
    await secondRefresh;
    first.complete({'relationship-1': 2});
    await firstRefresh;

    expect(container.read(chatUnreadControllerProvider).value, {
      'relationship-1': 3,
    });
  });
}

class _ChatAdapter implements HttpClientAdapter {
  final requests = <String>[];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add('${options.method} ${options.path}');
    return ResponseBody.fromString(
      jsonEncode(
        options.path == '/messages/unread-counts'
            ? {'relationship-1': 2}
            : <String, dynamic>{},
      ),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

class _FakeChatUnreadRepository implements ChatUnreadRepository {
  final pending = <Completer<Map<String, int>>>[];
  int calls = 0;

  @override
  Future<Map<String, int>> getUnreadCounts() {
    calls++;
    if (calls == 1) {
      return Future.value({'relationship-1': 1});
    }
    return pending.removeAt(0).future;
  }

  @override
  Future<void> markRead(String relationshipId) async {}
}
