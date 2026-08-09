import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/challenges/data/challenge_remote_data_source.dart';
import 'package:xenoh_mobile/features/challenges/domain/challenge_models.dart';

void main() {
  test('uses the exact challenge discovery and participation routes', () async {
    final adapter = _ChallengeAdapter();
    final source = ChallengeRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.getMine();
    await source.discover();
    await source.getById('c1');
    await source.accept('c1');
    await source.join('c1');
    await source.decline('c1');
    await source.leave('c1');
    await source.checkIn('c1', 'done');
    await source.undoCheckIn('c1');

    expect(adapter.paths, [
      'GET /community/challenges',
      'GET /community/challenges/discover',
      'GET /community/challenges/c1',
      'POST /community/challenges/c1/accept',
      'POST /community/challenges/c1/join',
      'POST /community/challenges/c1/decline',
      'POST /community/challenges/c1/leave',
      'POST /community/challenges/c1/check-ins',
      'DELETE /community/challenges/c1/check-ins/today',
    ]);
  });

  test('creates with backend metric/access/schedule payload', () async {
    final adapter = _ChallengeAdapter();
    final source = ChallengeRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.create(
      ChallengeInput(
        title: 'August consistency',
        description: 'Train together',
        metricType: 'TrainingSessions',
        accessType: 'Community',
        targetSessionsPerWeek: 3,
        selectedLifts: const [],
        capacity: 10,
        startsAtUtc: DateTime.utc(2026, 8, 5, 2),
        endsAtUtc: DateTime.utc(2026, 8, 19, 2),
      ),
    );

    expect(adapter.lastBody?['timeZoneId'], 'Asia/Ho_Chi_Minh');
    expect(adapter.lastBody?['metricType'], 'TrainingSessions');
    expect(adapter.lastBody?['startsAtUtc'], '2026-08-05T02:00:00.000Z');
  });

  test('updates an existing challenge with the full input contract', () async {
    final adapter = _ChallengeAdapter();
    final source = ChallengeRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );
    final input = ChallengeInput(
      title: 'Updated consistency',
      description: 'New description',
      metricType: 'TrainingSessions',
      accessType: 'Connections',
      targetSessionsPerWeek: 4,
      selectedLifts: const [],
      capacity: 12,
      startsAtUtc: DateTime.utc(2026, 8, 5, 2),
      endsAtUtc: DateTime.utc(2026, 8, 19, 2),
    );

    final updated = await source.update('c1', input);

    expect(adapter.paths.single, 'PUT /community/challenges/c1');
    expect(adapter.lastBody?['title'], 'Updated consistency');
    expect(updated.id, 'c1');
  });
}

class _ChallengeAdapter implements HttpClientAdapter {
  final paths = <String>[];
  Map<String, dynamic>? lastBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    paths.add('${options.method} ${options.path}');
    if (requestStream != null) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      if (bytes.isNotEmpty) {
        lastBody = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      }
    }
    final list =
        options.path == '/community/challenges' && options.method == 'GET' ||
        options.path.endsWith('/discover');
    final body = list ? [_challengeJson] : _challengeJson;
    return ResponseBody.fromString(
      jsonEncode(body),
      options.method == 'DELETE' && !options.path.contains('check-ins')
          ? 204
          : 200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final _challengeJson = <String, dynamic>{
  'id': 'c1',
  'title': 'Consistency',
  'description': 'Train together',
  'creatorId': 'u1',
  'creatorName': 'Ada',
  'metricType': 'TrainingSessions',
  'accessType': 'Community',
  'capacity': 10,
  'acceptedCount': 1,
  'reservedCount': 1,
  'timeZoneId': 'Asia/Ho_Chi_Minh',
  'startsAtUtc': '2026-08-05T02:00:00Z',
  'endsAtUtc': '2026-08-19T02:00:00Z',
  'status': 'Upcoming',
  'canJoin': true,
  'targetSessionsPerWeek': 3,
  'selectedLifts': <String>[],
  'canManage': false,
  'joinClosed': false,
  'members': <dynamic>[],
};
