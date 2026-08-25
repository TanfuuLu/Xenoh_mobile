import '../../l10n/app_localizations.dart';
import 'failure.dart';

/// Localized, user-facing copy for a [Failure].
///
/// [Failure.message] is always English (it is the log/developer text and the
/// fallback), so rendering it directly left Vietnamese users looking at
/// English error states. This maps the failure to translated copy by type,
/// and only keeps the raw text when the API supplied a specific message —
/// those are business errors ("Plan limit reached") that carry information the
/// generic copy cannot.
String localizedFailureMessage(Failure failure, AppLocalizations l10n) {
  if (failure.isServerMessage && failure.message.trim().isNotEmpty) {
    return failure.message;
  }
  return switch (failure) {
    NetworkFailure(:final kind) => switch (kind) {
      NetworkFailureKind.cancelled => l10n.commonRequestCancelledError,
      NetworkFailureKind.certificate => l10n.commonCertificateError,
      NetworkFailureKind.transport => l10n.commonNetworkError,
    },
    AuthFailure() => l10n.commonSessionExpiredError,
    ForbiddenFailure() => l10n.commonForbiddenError,
    ValidationFailure() => l10n.commonValidationError,
    NotFoundFailure() => l10n.commonNotFoundError,
    RateLimitFailure() => l10n.commonTooManyRequestsError,
    ServerFailure() => l10n.commonServerError,
    UnknownFailure() => l10n.commonSomethingWentWrong,
  };
}
