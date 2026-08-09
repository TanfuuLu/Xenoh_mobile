import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../../../core/error/failure.dart';
import '../../../../core/error/result.dart';
import '../../../../core/storage/token_storage.dart';
import '../../domain/entities/auth_session.dart';
import '../../domain/entities/register_params.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_data_source.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required AuthRemoteDataSource remote,
    required TokenStorage tokens,
    required CookieJar cookieJar,
  }) : _remote = remote,
       _tokens = tokens,
       _cookieJar = cookieJar;

  final AuthRemoteDataSource _remote;
  final TokenStorage _tokens;
  final CookieJar _cookieJar;

  @override
  Future<Result<AuthSession>> login({
    required String email,
    required String password,
  }) async {
    try {
      final dto = await _remote.login(email: email, password: password);
      final session = dto.toEntity();
      await _cacheSession(session);
      return Ok(session);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthSession>> exchangeExternalTicket(String ticket) async {
    try {
      final dto = await _remote.exchangeExternalTicket(ticket);
      final session = dto.toEntity();
      await _cacheSession(session);
      return Ok(session);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthSession>> completeExternalRegistration({
    required String role,
  }) async {
    try {
      final dto = await _remote.completeExternalRegistration(role: role);
      final session = dto.toEntity();
      await _cacheSession(session);
      return Ok(session);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> sendForgotPasswordCode(String email) async {
    try {
      await _remote.sendForgotPasswordCode(email);
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> resetPasswordWithCode({
    required String email,
    required String code,
    required String newPassword,
  }) async {
    try {
      await _remote.resetPasswordWithCode(
        email: email,
        code: code,
        newPassword: newPassword,
      );
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> changePassword({
    required String oldPassword,
    required String newPassword,
  }) async {
    try {
      await _remote.changePassword(
        oldPassword: oldPassword,
        newPassword: newPassword,
      );
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> register(RegisterParams params) async {
    try {
      await _remote.register(params);
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<AuthSession>> restoreSession() async {
    try {
      final dto = await _remote.refresh();
      final session = dto.toEntity();
      await _cacheSession(session);
      return Ok(session);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<void> logout() async {
    try {
      await _remote.logout();
    } on DioException {
      // Best-effort; clear locally regardless.
    } finally {
      await _tokens.clear();
      await _cookieJar.deleteAll();
    }
  }

  @override
  Future<Result<void>> deleteAccount() async {
    try {
      await _remote.deleteAccount();
      await _tokens.clear();
      await _cookieJar.deleteAll();
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> requestAccountDeletion(String email) async {
    try {
      await _remote.requestAccountDeletion(email);
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  @override
  Future<Result<void>> verifyAccountDeletion(String token) async {
    try {
      await _remote.verifyAccountDeletion(token);
      // The verified request permanently deletes the account server-side.
      // Any session cached on this device is therefore no longer usable.
      await _tokens.clear();
      await _cookieJar.deleteAll();
      return const Ok(null);
    } on DioException catch (e) {
      return Err(failureFromDio(e));
    } catch (_) {
      return const Err(UnknownFailure());
    }
  }

  Future<void> _cacheSession(AuthSession session) async {
    _tokens.accessToken = session.accessToken;
    await _tokens.setUserId(session.user.id);
  }
}
