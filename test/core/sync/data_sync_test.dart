import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/sync/data_revision.dart';
import 'package:xenoh_mobile/core/sync/data_sync_bus.dart';
import 'package:xenoh_mobile/core/sync/data_sync_interceptor.dart';
import 'package:xenoh_mobile/core/sync/data_topic.dart';
import 'package:xenoh_mobile/core/sync/mutation_topics.dart';

void main() {
  group('topicsForMutation', () {
    test('ignores reads', () {
      expect(topicsForMutation(method: 'GET', path: '/plans'), isEmpty);
    });

    test('maps writes to the data they touch', () {
      expect(
        topicsForMutation(method: 'POST', path: '/exercises'),
        {DataTopic.training},
      );
      expect(
        topicsForMutation(
          method: 'DELETE',
          path: '/nutrition/logs/2026-08-17/foods/abc',
        ),
        {DataTopic.nutrition},
      );
      expect(
        topicsForMutation(method: 'POST', path: '/users/me/bodyweight'),
        {DataTopic.bodyweight, DataTopic.profile},
      );
      expect(
        topicsForMutation(method: 'DELETE', path: '/friends/u1'),
        {DataTopic.community},
      );
    });

    test('routes writes that land in two places to both', () {
      expect(
        topicsForMutation(
          method: 'POST',
          path: '/training-day-shares/s1/copy',
        ),
        {DataTopic.community, DataTopic.training},
      );
      expect(
        topicsForMutation(
          method: 'PUT',
          path: '/nutrition/clients/c1/meal-plans/2026-08-17',
        ),
        {DataTopic.nutrition, DataTopic.coaching},
      );
    });

    test('ending a coaching relationship syncs everything it tears down', () {
      // The server deletes the coach's plans and file shares on /end and
      // revokes the coach's read access to client nutrition and supplements,
      // so refreshing only the coaching lists would leave all of it on screen.
      expect(topicsForMutation(method: 'POST', path: '/coach-client/r1/end'), {
        DataTopic.coaching,
        DataTopic.training,
        DataTopic.storage,
        DataTopic.messages,
        DataTopic.nutrition,
        DataTopic.supplements,
      });
      // Every other coaching write stays narrow.
      expect(
        topicsForMutation(
          method: 'POST',
          path: '/coach-client/connect-by-code',
        ),
        {DataTopic.coaching},
      );
    });

    test('reads comments as community data, not training data', () {
      expect(
        topicsForMutation(method: 'POST', path: '/plans/p1/comments'),
        {DataTopic.community},
      );
    });

    test('ignores unmapped and read-only-POST endpoints', () {
      // Auth traffic must never trigger a global refetch.
      expect(topicsForMutation(method: 'POST', path: '/auth/logout'), isEmpty);
      // Fetched from inside a provider — syncing it would loop forever.
      expect(
        topicsForMutation(method: 'POST', path: '/plans/p1/balance-check'),
        isEmpty,
      );
    });

    test('accepts an absolute URL carrying the API base path', () {
      expect(
        topicsForMutation(method: 'POST', path: '/api/users/me/bodyweight'),
        {DataTopic.bodyweight, DataTopic.profile},
      );
    });

    test('ignores the query string', () {
      expect(
        topicsForMutation(method: 'POST', path: '/plans/p1/duplicate?copy=1'),
        {DataTopic.training},
      );
    });
  });

  group('DataSyncBus', () {
    test('coalesces a burst of writes into one flush', () {
      final flushes = <Set<DataTopic>>[];
      final bus = DataSyncBus(onFlush: flushes.add)
        ..notify({DataTopic.nutrition})
        ..notify({DataTopic.nutrition})
        ..notify({DataTopic.training});

      expect(flushes, isEmpty, reason: 'flush is deferred');
      bus.flush();

      expect(flushes, [
        {DataTopic.nutrition, DataTopic.training},
      ]);
    });

    test('bumps the revision of every flushed topic', () {
      final container = ProviderContainer();
      addTearDown(container.dispose);

      final before = container.read(
        dataRevisionProvider(DataTopic.supplements),
      );
      container.read(dataSyncBusProvider)
        ..notify({DataTopic.supplements})
        ..flush();

      expect(
        container.read(dataRevisionProvider(DataTopic.supplements)),
        before + 1,
      );
    });
  });

  test('a successful write drives the topic revision through Dio', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final bus = container.read(dataSyncBusProvider);
    final dio = Dio()
      ..httpClientAdapter = _OkAdapter()
      ..interceptors.add(DataSyncInterceptor(bus));

    final before = container.read(dataRevisionProvider(DataTopic.bodyweight));
    await dio.post<void>('https://example.test/users/me/bodyweight');
    bus.flush();

    expect(
      container.read(dataRevisionProvider(DataTopic.bodyweight)),
      before + 1,
    );
  });

  test('a failed write leaves every revision untouched', () async {
    final container = ProviderContainer();
    addTearDown(container.dispose);

    final bus = container.read(dataSyncBusProvider);
    final dio = Dio()
      ..httpClientAdapter = _OkAdapter(statusCode: 500)
      ..interceptors.add(DataSyncInterceptor(bus));

    final before = container.read(dataRevisionProvider(DataTopic.bodyweight));
    await expectLater(
      dio.post<void>('https://example.test/users/me/bodyweight'),
      throwsA(isA<DioException>()),
    );
    bus.flush();

    expect(container.read(dataRevisionProvider(DataTopic.bodyweight)), before);
  });
}

class _OkAdapter implements HttpClientAdapter {
  _OkAdapter({this.statusCode = 204});

  final int statusCode;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async => ResponseBody.fromString('', statusCode);

  @override
  void close({bool force = false}) {}
}
