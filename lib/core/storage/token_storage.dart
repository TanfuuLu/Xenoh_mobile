import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'token_storage.g.dart';

/// Holds the short-lived (60-min) access token **in memory** and persists the
/// user id in secure storage. The refresh token is NOT stored here — it lives
/// in the `xenoh.refresh` HttpOnly cookie managed by the dio cookie jar.
class TokenStorage {
  TokenStorage(this._secure);

  final FlutterSecureStorage _secure;

  static const _kUserId = 'xenoh.userId';

  /// In-memory access token (null when signed out).
  String? accessToken;

  Future<void> setUserId(String? userId) async {
    if (userId == null) {
      await _secure.delete(key: _kUserId);
    } else {
      await _secure.write(key: _kUserId, value: userId);
    }
  }

  Future<String?> userId() => _secure.read(key: _kUserId);

  /// Clear everything on logout (cookie is cleared separately).
  Future<void> clear() async {
    accessToken = null;
    await _secure.delete(key: _kUserId);
  }
}

@Riverpod(keepAlive: true)
FlutterSecureStorage secureStorage(Ref ref) => const FlutterSecureStorage();

@Riverpod(keepAlive: true)
TokenStorage tokenStorage(Ref ref) =>
    TokenStorage(ref.watch(secureStorageProvider));
