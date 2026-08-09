import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/community/data/datasources/community_remote_data_source.dart';

void main() {
  test('reports a non-owner share with the backend enum and details', () async {
    final adapter = _ShareActionAdapter();
    final source = CommunityRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.reportShare(
      shareId: 'share-1',
      reason: 'Spam',
      details: 'Repeated promotional content',
    );

    expect(
      adapter.requests.single.path,
      '/training-day-shares/share-1/reports',
    );
    expect(adapter.requests.single.method, 'POST');
    expect(adapter.requests.single.body, {
      'reason': 'Spam',
      'details': 'Repeated promotional content',
    });
  });

  test('copies only the reusable structure into an owned target day', () async {
    final adapter = _ShareActionAdapter();
    final source = CommunityRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final copied = await source.copyShare(
      shareId: 'share-1',
      targetDailyWorkoutId: 'day-2',
    );

    expect(copied, 4);
    expect(adapter.requests.single.path, '/training-day-shares/share-1/copy');
    expect(adapter.requests.single.body, {'targetDailyWorkoutId': 'day-2'});
  });
}

class _Request {
  const _Request(this.path, this.method, this.body);

  final String path;
  final String method;
  final Map<String, dynamic> body;
}

class _ShareActionAdapter implements HttpClientAdapter {
  final List<_Request> requests = [];

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final bytes = await requestStream!.expand((chunk) => chunk).toList();
    requests.add(
      _Request(
        options.path,
        options.method,
        jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>,
      ),
    );
    return ResponseBody.fromString(
      options.path.endsWith('/copy') ? '{"exercisesCopied":4}' : '{}',
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
