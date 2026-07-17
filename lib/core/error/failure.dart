/// Domain-facing error type. Repositories map exceptions → [Failure]; the UI
/// only ever sees a [Failure] (never a raw `DioException`). Implements
/// [Exception] so it can be thrown and caught by `AsyncValue.guard`.
sealed class Failure implements Exception {
  const Failure(this.message);

  /// Human-readable, safe to show to the user.
  final String message;

  @override
  String toString() => message;
}

/// No connectivity / timeout / transport error.
class NetworkFailure extends Failure {
  const NetworkFailure([
    super.message = 'Network error. Check your connection.',
  ]);
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
}

/// 400 with field errors (model validation) or a business `{message}` error.
class ValidationFailure extends Failure {
  const ValidationFailure(super.message, {this.fieldErrors = const {}});

  /// Field → messages, from ASP.NET `ValidationProblemDetails`.
  final Map<String, List<String>> fieldErrors;
}

/// 404 — resource not found.
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Not found.']);
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
}
