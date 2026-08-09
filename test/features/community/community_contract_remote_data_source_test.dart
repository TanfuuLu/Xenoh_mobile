import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/community/data/datasources/community_remote_data_source.dart';
import 'package:xenoh_mobile/features/community/domain/entities/community_models.dart';

void main() {
  test('parses cursor feed envelope and forwards paging parameters', () async {
    final adapter = _JsonAdapter({
      '/training-day-shares/feed': {
        'items': [_shareJson('share-1')],
        'nextCursor': '2026-08-08T10:00:00.000Z',
      },
    });
    final source = CommunityRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final page = await source.getFeed(
      scope: 'friends',
      cursor: '2026-08-08T11:00:00.000Z',
      pageSize: 20,
    );

    expect(page.items.single.id, 'share-1');
    expect(page.nextCursor, '2026-08-08T10:00:00.000Z');
    expect(adapter.requests.single.queryParameters, {
      'scope': 'friends',
      'cursor': '2026-08-08T11:00:00.000Z',
      'pageSize': 20,
    });
  });

  test('accepts friends and friend requests without an email', () async {
    final adapter = _JsonAdapter({
      '/friends': [
        {
          'userId': 'user-1',
          'fullName': 'No Email',
          'email': null,
          'friendsSince': '2026-08-08T10:00:00Z',
        },
      ],
      '/friends/requests': [
        {
          'id': 'request-1',
          'userId': 'user-2',
          'fullName': 'Also No Email',
          'email': null,
          'direction': 'Incoming',
          'status': 'Pending',
          'createdAt': '2026-08-08T10:00:00Z',
        },
      ],
    });
    final source = CommunityRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final friends = await source.getFriends();
    final requests = await source.getFriendRequests(
      RequestDirection.incoming,
    );

    expect(friends.single.email, isNull);
    expect(requests.single.email, isNull);
  });

  test('loads and updates community stats visibility', () async {
    final adapter = _JsonAdapter({
      '/community/settings': {'statsVisibility': 'Friends'},
    });
    final source = CommunityRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final current = await source.getSettings();
    final updated = await source.updateSettings(
      CommunityStatsVisibility.onlyMe,
    );

    expect(current.statsVisibility, CommunityStatsVisibility.friends);
    expect(updated.statsVisibility, CommunityStatsVisibility.friends);
    expect(adapter.requests.last.method, 'PUT');
    expect(adapter.requests.last.body, {'statsVisibility': 'OnlyMe'});
  });

  test('rejects an unknown community stats visibility value', () async {
    final adapter = _JsonAdapter({
      '/community/settings': {'statsVisibility': 'Everyone'},
    });
    final source = CommunityRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    expect(source.getSettings(), throwsA(isA<FormatException>()));
  });
}

Map<String, dynamic> _shareJson(String id) => {
  'id': id,
  'userId': 'user-1',
  'userFullName': 'Demo Athlete',
  'sourceDailyWorkoutId': 'workout-1',
  'workoutDate': '2026-08-08',
  'dayOfWeek': 'Saturday',
  'dayStatus': 'Completed',
  'createdAt': '2026-08-08T09:00:00Z',
  'exercises': <dynamic>[],
};

class _CapturedRequest {
  const _CapturedRequest({
    required this.method,
    required this.queryParameters,
    required this.body,
  });

  final String method;
  final Map<String, dynamic> queryParameters;
  final Map<String, dynamic>? body;
}

class _JsonAdapter implements HttpClientAdapter {
  _JsonAdapter(this.responses);

  final Map<String, Object> responses;
  final List<_CapturedRequest> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    Map<String, dynamic>? body;
    if (requestStream != null) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      if (bytes.isNotEmpty) {
        body = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      }
    }
    requests.add(
      _CapturedRequest(
        method: options.method,
        queryParameters: Map<String, dynamic>.from(options.queryParameters),
        body: body,
      ),
    );
    return ResponseBody.fromString(
      jsonEncode(responses[options.path]),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
