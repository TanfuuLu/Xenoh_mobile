// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cookie_jar_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The shared cookie jar that persists the `xenoh.refresh` HttpOnly cookie
/// across app restarts.
///
/// Overridden in `main()` with a [PersistCookieJar] rooted in the app support
/// directory (path_provider is async, so we build it before `runApp`).

@ProviderFor(cookieJar)
final cookieJarProvider = CookieJarProvider._();

/// The shared cookie jar that persists the `xenoh.refresh` HttpOnly cookie
/// across app restarts.
///
/// Overridden in `main()` with a [PersistCookieJar] rooted in the app support
/// directory (path_provider is async, so we build it before `runApp`).

final class CookieJarProvider
    extends $FunctionalProvider<CookieJar, CookieJar, CookieJar>
    with $Provider<CookieJar> {
  /// The shared cookie jar that persists the `xenoh.refresh` HttpOnly cookie
  /// across app restarts.
  ///
  /// Overridden in `main()` with a [PersistCookieJar] rooted in the app support
  /// directory (path_provider is async, so we build it before `runApp`).
  CookieJarProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cookieJarProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cookieJarHash();

  @$internal
  @override
  $ProviderElement<CookieJar> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CookieJar create(Ref ref) {
    return cookieJar(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CookieJar value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CookieJar>(value),
    );
  }
}

String _$cookieJarHash() => r'4732a0673132a5d5433dbdada001b0d3cdb1e907';
