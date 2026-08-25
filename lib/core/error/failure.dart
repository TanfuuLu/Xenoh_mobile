/// Domain-facing error type. Repositories map exceptions → [Failure]; the UI
/// only ever sees a [Failure] (never a raw `DioException`). Implements
/// [Exception] so it can be thrown and caught by `AsyncValue.guard`.
///
/// [message] is the English developer/log text. **Never render it directly** —
/// pass the failure through `localizedFailureMessage` (see
/// `failure_l10n.dart`) so the user sees copy in their own language. Failures
/// built from an API error body set [isServerMessage], which tells the
/// presentation layer the text is specific enough to show as-is.
sealed class Failure implements Exception {
  const Failure(this.message, {this.isServerMessage = false});

  /// Human-readable, safe to show to the user — in English.
  final String message;

  /// True when [message] came from the API response body rather than from one
  /// of the generic defaults below.
  final bool isServerMessage;

  @override
  String toString() => message;
}

/// Why a [NetworkFailure] happened, so the UI can localize each case.
enum NetworkFailureKind { transport, cancelled, certificate }

/// No connectivity / timeout / transport error.
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Network error. Check your connection.',
    this.kind = NetworkFailureKind.transport,
  ]);

  final NetworkFailureKind kind;
}

/// 401 — credentials invalid or session expired (re-auth required).
class AuthFailure extends Failure {
  const AuthFailure([
    super.message = 'Your session has expired. Please sign in again.',
  ]);
}

/// 403 — authenticated but not allowed (wrong role / no Pro subscription).
class ForbiddenFailure extends Failure {
  const ForbiddenFailure([super.message = "You don't have access to this."]);

  /// The API explained why access was denied; show that text as-is.
  const ForbiddenFailure.fromServer(super.message)
    : super(isServerMessage: true);
}

/// 400 with field errors (model validation) or a business `{message}` error.
class ValidationFailure extends Failure {
  const ValidationFailure(
    super.message, {
    this.fieldErrors = const {},
    super.isServerMessage,
  });

  /// Field → messages, from ASP.NET `ValidationProblemDetails`.
  final Map<String, List<String>> fieldErrors;
}

/// 404 — resource not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Not found.']);

  /// The API named what was missing; show that text as-is.
  const NotFoundFailure.fromServer(super.message)
    : super(isServerMessage: true);
}

/// 429 — rate limited.
class RateLimitFailure extends Failure {
  const RateLimitFailure([
    super.message = 'Too many requests. Please slow down.',
  ]);
}

/// 5xx — server error.
class ServerFailure extends Failure {
  const ServerFailure([
    super.message = 'Server error. Please try again later.',
  ]);
}

/// Anything else.
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Something went wrong.']);

  /// The API returned its own error text; show that as-is.
  const UnknownFailure.fromServer(super.message) : super(isServerMessage: true);
}
