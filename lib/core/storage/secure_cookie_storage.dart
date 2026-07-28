import 'package:cookie_jar/cookie_jar.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

/// Persists the native refresh-cookie jar in platform-protected storage.
///
/// Only cookie-jar-owned keys are removed; other secure application values are
/// never affected.
class SecureCookieStorage extends Storage {
  const SecureCookieStorage(this._storage);

  static const _prefix = 'xenoh.cookie.';

  final FlutterSecureStorage _storage;

  @override
  Future<void> init(bool persistSession, bool ignoreExpires) async {}

  @override
  Future<String?> read(String key) => _storage.read(key: _key(key));

  @override
  Future<void> write(String key, String value) =>
      _storage.write(key: _key(key), value: value);

  @override
  Future<void> delete(String key) => _storage.delete(key: _key(key));

  @override
  Future<void> deleteAll(List<String> keys) =>
      Future.wait(keys.map(delete)).then((_) {});

  String _key(String key) => '$_prefix$key';
}
