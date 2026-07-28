import 'package:dio/dio.dart';

import 'failure.dart';

/// Translates a [DioException] into a domain [Failure], parsing the two backend
/// error body shapes (see `XENOH_API_REFERENCE.md` §1):
///   - business/validation-by-handler: `{ "message": "..." }`
///   - model validation: `{ "errors": { "Field": ["..."] }, "title": "..." }`
Failure failureFromDio(DioException e) {
  switch (e.type) {
    case DioExceptionType.connectionTimeout:
    case DioExceptionType.sendTimeout:
    case DioExceptionType.receiveTimeout:
    case DioExceptionType.transformTimeout:
    case DioExceptionType.connectionError:
      return const NetworkFailure();
    case DioExceptionType.cancel:
      return const NetworkFailure('Request cancelled.');
    case DioExceptionType.badCertificate:
      return const NetworkFailure('Certificate error.');
    case DioExceptionType.unknown:
      return const NetworkFailure();
    case DioExceptionType.badResponse:
      break;
  }

  final status = e.response?.statusCode ?? 0;
  final data = e.response?.data;
  final (message, fieldErrors) = _parseBody(data);

  return switch (status) {
    400 => ValidationFailure(
      message ?? 'Please check your input.',
      fieldErrors: fieldErrors,
    ),
    409 => ValidationFailure(
      message ?? 'This change conflicts with existing data.',
    ),
    401 => const AuthFailure(),
    403 => ForbiddenFailure(message ?? "You don't have access to this."),
    404 => NotFoundFailure(message ?? 'Not found.'),
    429 => const RateLimitFailure(),
    >= 500 => ServerFailure(message ?? 'Server error. Please try again later.'),
    _ => UnknownFailure(message ?? 'Something went wrong.'),
  };
}

(String?, Map<String, List<String>>) _parseBody(Object? data) {
  if (data is! Map) return (null, const {});
  final map = data.cast<String, dynamic>();

  // Business error: { "message": "..." }
  final message = map['message'];

  // Model validation: { "errors": { "Field": ["..."] } }
  final fieldErrors = <String, List<String>>{};
  final errors = map['errors'];
  if (errors is Map) {
    errors.forEach((key, value) {
      if (value is List) {
        fieldErrors['$key'] = value.map((e) => '$e').toList();
      }
    });
  }

  // Prefer an explicit message; else surface the first field error; else title.
  final resolved = (message is String && message.isNotEmpty)
      ? message
      : fieldErrors.values.isNotEmpty && fieldErrors.values.first.isNotEmpty
      ? fieldErrors.values.first.first
      : map['title'] is String
      ? map['title'] as String
      : null;

  return (resolved, fieldErrors);
}
