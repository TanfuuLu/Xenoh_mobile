import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/profile/data/datasources/profile_remote_data_source.dart';

void main() {
  test('loads completed monthly volume with the exact months query', () async {
    final adapter = _VolumeAdapter();
    final source = ProfileRemoteDataSource(Dio()..httpClientAdapter = adapter);

    final points = await source.getVolumeHistory(months: 12);

    expect(adapter.uri, '/users/me/volume-history?months=12');
    expect(points, hasLength(2));
    expect(points.last.volumeKg, 12500);
  });
}

class _VolumeAdapter implements HttpClientAdapter {
  String? uri;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    uri = '${options.path}?months=${options.queryParameters['months']}';
    return ResponseBody.fromString(
      jsonEncode([
        {'year': 2026, 'month': 7, 'volumeKg': 10000},
        {'year': 2026, 'month': 8, 'volumeKg': 12500},
      ]),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
