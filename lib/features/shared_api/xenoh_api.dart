import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../core/network/dio_provider.dart';
import '../../l10n/app_localizations.dart';

typedef JsonMap = Map<String, dynamic>;

final xenohApiProvider = Provider<XenohApi>((ref) {
  return XenohApi(ref.watch(dioProvider));
});

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

/// Extracts a user-facing message from an API error. Falls back to
/// localized generic copy when the server response doesn't carry one.
String apiErrorMessage(Object error, BuildContext context) {
  final l10n = AppLocalizations.of(context);
  if (error is DioException) {
    final data = error.response?.data;
    if (data is JsonMap) {
      final message = data['message'];
      if (message is String && message.trim().isNotEmpty) return message;
      final title = data['title'];
      if (title is String && title.trim().isNotEmpty) return title;
      final errors = data['errors'];
      if (errors is JsonMap) {
        final parts = <String>[];
        for (final entry in errors.entries) {
          final value = entry.value;
          if (value is List<dynamic>) {
            parts.addAll(value.whereType<String>());
          }
        }
        if (parts.isNotEmpty) return parts.join('\n');
      }
    }
    if (error.response?.statusCode == 403) {
      return l10n.commonForbiddenError;
    }
    if (error.response?.statusCode == 429) {
      return l10n.commonTooManyRequestsError;
    }
    return error.message ?? l10n.commonRequestFailed;
  }
  return '$error';
}

String textOf(JsonMap item, List<String> keys, {String fallback = '-'}) {
  for (final key in keys) {
    final value = item[key];
    if (value == null) continue;
    final text = value.toString();
    if (text.trim().isNotEmpty) return text;
  }
  return fallback;
}

String? optionalTextOf(JsonMap item, List<String> keys) {
  final value = textOf(item, keys, fallback: '');
  return value.isEmpty ? null : value;
}
