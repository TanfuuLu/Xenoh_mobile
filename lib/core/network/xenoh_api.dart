import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dio_provider.dart';

typedef JsonMap = Map<String, dynamic>;

final xenohApiProvider = Provider<XenohApi>((ref) {
  return XenohApi(ref.watch(dioProvider));
});

/// Infrastructure-level HTTP operations shared by features that have not yet
/// moved to a feature-specific repository.
class XenohApi {
  XenohApi(this._dio);

  final Dio _dio;

  Future<JsonMap> getObject(String path) async {
    final res = await _dio.get<JsonMap>(path);
    return res.data ?? <String, dynamic>{};
  }

  Future<JsonMap?> getNullableObject(String path) async {
    final res = await _dio.get<JsonMap?>(path);
    return res.data;
  }

  Future<List<JsonMap>> getList(String path) async {
    final res = await _dio.get<dynamic>(path);
    final data = res.data;
    if (data is List<dynamic>) {
      return data.whereType<JsonMap>().toList();
    }
    if (data is JsonMap) {
      final items = data['items'];
      if (items is List<dynamic>) return items.whereType<JsonMap>().toList();
      return <JsonMap>[data];
    }
    return <JsonMap>[];
  }

  Future<JsonMap> postObject(String path, JsonMap data) async {
    final res = await _dio.post<JsonMap>(path, data: data);
    return res.data ?? <String, dynamic>{};
  }

  Future<JsonMap> postFormData(String path, FormData data) async {
    final res = await _dio.post<JsonMap>(path, data: data);
    return res.data ?? <String, dynamic>{};
  }

  Future<JsonMap> putObject(String path, JsonMap data) async {
    final res = await _dio.put<JsonMap>(path, data: data);
    return res.data ?? <String, dynamic>{};
  }

  Future<void> postVoid(String path, [JsonMap? data]) async {
    await _dio.post<void>(path, data: data);
  }

  Future<JsonMap> patchObject(String path, [JsonMap? data]) async {
    final res = await _dio.patch<JsonMap>(path, data: data);
    return res.data ?? <String, dynamic>{};
  }

  Future<void> patchVoid(String path, [JsonMap? data]) async {
    await _dio.patch<void>(path, data: data);
  }

  Future<void> delete(String path) async {
    await _dio.delete<void>(path);
  }
}
