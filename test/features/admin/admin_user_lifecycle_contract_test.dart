import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/network/xenoh_api.dart';

void main() {
  test('uses exact admin suspend and unsuspend routes', () async {
    final adapter = _AdminAdapter();
    final api = XenohApi(Dio()..httpClientAdapter = adapter);

    await api.postVoid('/admin/users/user-1/suspend');
    await api.postVoid('/admin/users/user-1/unsuspend');

    expect(adapter.requests, [
      'POST /admin/users/user-1/suspend',
      'POST /admin/users/user-1/unsuspend',
    ]);
  });

  test('sends the exact subscription adjustment fields', () async {
    final adapter = _AdminAdapter();
    final api = XenohApi(Dio()..httpClientAdapter = adapter);

    await api.patchObject('/admin/users/user-1/subscription', {
      'tier': 'ProCoach',
      'durationMonths': 6,
      'reason': 'Support adjustment',
    });

    expect(adapter.requests.single, 'PATCH /admin/users/user-1/subscription');
    expect(adapter.lastBody, {
      'tier': 'ProCoach',
      'durationMonths': 6,
      'reason': 'Support adjustment',
    });
  });
}

class _AdminAdapter implements HttpClientAdapter {
  final requests = <String>[];
  Map<String, dynamic>? lastBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    requests.add('${options.method} ${options.path}');
    if (requestStream != null) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      if (bytes.isNotEmpty) {
        lastBody = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
      }
    }
    return ResponseBody.fromString(
      jsonEncode(<String, dynamic>{}),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
