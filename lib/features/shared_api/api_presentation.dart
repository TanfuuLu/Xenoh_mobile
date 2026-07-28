import 'package:dio/dio.dart';
import 'package:flutter/widgets.dart';

import '../../core/network/xenoh_api.dart';
import '../../l10n/app_localizations.dart';

/// Converts an API failure to localized, user-safe copy.
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
    return l10n.commonRequestFailed;
  }
  return l10n.commonSomethingWentWrong;
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
