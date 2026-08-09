import 'package:dio/dio.dart';

import '../../../../core/utils/date_only.dart';
import '../../domain/entities/register_params.dart';
import '../dtos/auth_response_dto.dart';

/// Thin wrapper over the `/auth` endpoints. Throws [DioException]; the
/// repository maps those to domain failures.
class AuthRemoteDataSource {
  AuthRemoteDataSource(this._dio);

  final Dio _dio;

  Future<AuthResponseDto> login({
    required String email,
    required String password,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/login',
      data: {'email': email, 'password': password},
    );
    return AuthResponseDto.fromJson(res.data!);
  }

  Future<AuthResponseDto> exchangeExternalTicket(String ticket) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/external/exchange',
      data: {'ticket': ticket},
    );
    return AuthResponseDto.fromJson(res.data!);
  }

  Future<AuthResponseDto> completeExternalRegistration({
    required String role,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/auth/external/complete-registration',
      data: {'role': role},
    );
    return AuthResponseDto.fromJson(res.data!);
  }

  Future<void> sendForgotPasswordCode(String email) async {
    await _dio.post<void>(
      '/auth/forgot-password/send-code',
      data: {'email': email},
    );
  }

  Future<void> resetPasswordWithCode({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    await _dio.post<void>(
      '/auth/forgot-password/reset',
      data: {'email': email, 'code': code, 'newPassword': newPassword},
    );
  }

  Future<void> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    await _dio.post<void>(
      '/auth/change-password',
      data: {'oldPassword': oldPassword, 'newPassword': newPassword},
    );
  }

  /// Register; the API returns `{ userId, email }` (no token).
  Future<void> register(RegisterParams p) async {
    await _dio.post<Map<String, dynamic>>(
      '/auth/register',
      data: {
        'email': p.email,
        'password': p.password,
        'firstName': p.firstName,
        'lastName': p.lastName,
        'role': p.role.wire,
        'gender': p.gender.wire,
        'dateOfBirth': DateOnly.format(p.dateOfBirth),
        'developmentDirection': p.developmentDirection.wire,
        'trainingDiscipline': p.trainingDiscipline.wire,
        if (p.height != null) 'height': p.height,
        if (p.bodyweight != null) 'bodyweight': p.bodyweight,
      },
    );
  }

  /// Refresh using the `xenoh.refresh` cookie (auto-sent by the cookie jar).
  Future<AuthResponseDto> refresh() async {
    final res = await _dio.post<Map<String, dynamic>>('/auth/refresh-token');
    return AuthResponseDto.fromJson(res.data!);
  }

  Future<void> logout() async {
    await _dio.post<void>('/auth/logout');
  }

  /// Permanently deletes the authenticated user's account and associated data.
  /// The API must revoke every active session before returning success.
  Future<void> deleteAccount() async {
    await _dio.delete<void>('/users/me');
  }

  /// Starts a deletion request for users who can no longer access the app.
  /// The backend must verify ownership of [email] before deleting any data.
  Future<void> requestAccountDeletion(String email) async {
    await _dio.post<void>(
      '/auth/account-deletion-requests',
      data: {'email': email},
    );
  }

  /// Completes a deletion request from the one-time email link.
  Future<void> verifyAccountDeletion(String token) async {
    await _dio.post<void>(
      '/auth/account-deletion-requests/verify',
      data: {'token': token},
    );
  }
}
