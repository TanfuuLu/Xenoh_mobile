import '../../../../core/error/result.dart';
import '../entities/auth_session.dart';
import '../entities/register_params.dart';

/// Abstraction over auth. The `data` layer implements this; presentation
/// depends only on this interface.
abstract interface class AuthRepository {
  /// Sign in. On success the refresh cookie is set and the access token cached.
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  });

  Future<Result<AuthSession>> exchangeExternalTicket(String ticket);

  Future<Result<AuthSession>> completeExternalRegistration({
    required String role,
  });

  Future<Result<void>> sendForgotPasswordCode(String email);

  Future<Result<void>> resetPasswordWithCode({
    required String email,
    required String code,
    required String newPassword,
  });

  Future<Result<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  });

  /// Register a new account. Returns void — the API issues no token here, so
  /// the caller must log in afterwards.
  Future<Result<void>> register(RegisterParams params);

  /// Attempt to restore a session on app launch using the persisted refresh
  /// cookie. Returns [Err] when there is no valid session.
  Future<Result<AuthSession>> restoreSession();

  /// Sign out: revoke server-side, clear the token and cookie.
  Future<void> logout();

  /// Permanently delete the authenticated account and all deletable user data.
  Future<Result<void>> deleteAccount();

  /// Request account deletion when the user cannot sign in to the app.
  Future<Result<void>> requestAccountDeletion(String email);
}
