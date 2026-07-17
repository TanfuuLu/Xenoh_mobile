import 'package:cookie_jar/cookie_jar.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cookie_jar_provider.g.dart';

/// The shared cookie jar that persists the `xenoh.refresh` HttpOnly cookie
/// across app restarts.
///
/// Overridden in `main()` with a [PersistCookieJar] rooted in the app support
/// directory (path_provider is async, so we build it before `runApp`).
@Riverpod(keepAlive: true)
CookieJar cookieJar(Ref ref) => throw StateError(
  'cookieJarProvider must be overridden in main() with a PersistCookieJar.',
);
