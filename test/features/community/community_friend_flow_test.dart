import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/community/data/datasources/community_remote_data_source.dart';

void main() {
  test(
    'searches, connects, lists friends, and interacts with the feed',
    () async {
      final adapter = _CommunityFlowAdapter();
      final source = CommunityRemoteDataSource(
        Dio()..httpClientAdapter = adapter,
      );

      final search = await source.searchUsers(query: 'Ada');
      final request = await source.sendFriendRequest('user-2');
      final accepted = await source.acceptFriendRequest(request.id);
      final friends = await source.getFriends();
      final feed = await source.getFeed();
      final loved = await source.loveShare(feed.items.single.id);

      expect(search.items.single.id, 'user-2');
      expect(accepted.status, 'Accepted');
      expect(friends.single.userId, 'user-2');
      expect(loved.lovedByCurrentUser, isTrue);
      expect(adapter.paths, [
        'GET /community/users',
        'POST /friends/requests',
        'POST /friends/requests/request-1/accept',
        'GET /friends',
        'GET /training-day-shares/feed',
        'POST /training-day-shares/share-1/kudos',
      ]);
    },
  );
}

class _CommunityFlowAdapter implements HttpClientAdapter {
  final List<String> paths = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add('${options.method} ${options.path}');
    final response = switch ('${options.method} ${options.path}') {
      'GET /community/users' => {
        'items': [
          {
            'id': 'user-2',
            'fullName': 'Ada Friend',
            'friendStatus': 'None',
          },
        ],
        'pageNumber': 1,
        'pageSize': 20,
        'totalCount': 1,
        'hasMore': false,
      },
      'POST /friends/requests' => _requestJson('Pending'),
      'POST /friends/requests/request-1/accept' => _requestJson('Accepted'),
      'GET /friends' => [
        {
          'userId': 'user-2',
          'fullName': 'Ada Friend',
          'email': null,
          'friendsSince': '2026-08-09T10:00:00Z',
        },
      ],
      'GET /training-day-shares/feed' => {
        'items': [_shareJson(loved: false)],
        'nextCursor': null,
      },
      'POST /training-day-shares/share-1/kudos' => _shareJson(loved: true),
      _ => throw StateError('Unexpected request: ${options.path}'),
    };
    return ResponseBody.fromString(
      jsonEncode(response),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

Map<String, dynamic> _requestJson(String status) => {
  'id': 'request-1',
  'userId': 'user-2',
  'fullName': 'Ada Friend',
  'email': null,
  'direction': 'Outgoing',
  'status': status,
  'createdAt': '2026-08-09T09:00:00Z',
};

Map<String, dynamic> _shareJson({required bool loved}) => {
  'id': 'share-1',
  'userId': 'user-2',
  'userFullName': 'Ada Friend',
  'sourceDailyWorkoutId': 'workout-1',
  'workoutDate': '2026-08-09',
  'dayOfWeek': 'Sunday',
  'dayStatus': 'Completed',
  'createdAt': '2026-08-09T10:00:00Z',
  'loveCount': loved ? 1 : 0,
  'lovedByCurrentUser': loved,
  'exercises': <dynamic>[],
};
