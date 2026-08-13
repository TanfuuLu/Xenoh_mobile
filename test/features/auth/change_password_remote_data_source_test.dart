import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/auth/data/datasources/auth_remote_data_source.dart';

void main() {
  test('sends the current password for server-side verification', () async {
    final adapter = _ChangePasswordAdapter();
    final source = AuthRemoteDataSource(Dio()..httpClientAdapter = adapter);

    await source.changePassword(
      oldPassword: 'current-secret',
      newPassword: 'new-secret',
    );

    expect(adapter.path, '/auth/change-password');
    expect(adapter.method, 'POST');
    expect(adapter.body, {
      'oldPassword': 'current-secret',
      'newPassword': 'new-secret',
    });
  });
}

class _ChangePasswordAdapter implements HttpClientAdapter {
  String? path;
  String? method;
  Map<String, dynamic>? body;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    path = options.path;
    method = options.method;
    final bytes = await requestStream?.expand((chunk) => chunk).toList();
    body = jsonDecode(utf8.decode(bytes ?? const [])) as Map<String, dynamic>;
    return ResponseBody.fromString('', 204);
  }

  @override
  void close({bool force = false}) {}
}
