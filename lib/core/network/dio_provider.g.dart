// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dio_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Signals that the session expired (refresh failed). The auth controller
/// watches this to drop back to the unauthenticated state; the router then
/// redirects to `/login`.

@ProviderFor(SessionExpired)
final sessionExpiredProvider = SessionExpiredProvider._();

/// Signals that the session expired (refresh failed). The auth controller
/// watches this to drop back to the unauthenticated state; the router then
/// redirects to `/login`.
final class SessionExpiredProvider
    extends $NotifierProvider<SessionExpired, bool> {
  /// Signals that the session expired (refresh failed). The auth controller
  /// watches this to drop back to the unauthenticated state; the router then
  /// redirects to `/login`.
  SessionExpiredProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'sessionExpiredProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$sessionExpiredHash();

  @$internal
  @override
  SessionExpired create() => SessionExpired();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$sessionExpiredHash() => r'c6ead4a021e86fe7258a3ac7beb5ad12cfafdcc6';

/// Signals that the session expired (refresh failed). The auth controller
/// watches this to drop back to the unauthenticated state; the router then
/// redirects to `/login`.

abstract class _$SessionExpired extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<bool, bool>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<bool, bool>,
              bool,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// The single shared authenticated [Dio] instance.

@ProviderFor(dio)
final dioProvider = DioProvider._();

/// The single shared authenticated [Dio] instance.

final class DioProvider extends $FunctionalProvider<Dio, Dio, Dio>
    with $Provider<Dio> {
  /// The single shared authenticated [Dio] instance.
  DioProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dioProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dioHash();

  @$internal
  @override
  $ProviderElement<Dio> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  Dio create(Ref ref) {
    return dio(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Dio value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Dio>(value),
    );
  }
}

String _$dioHash() => r'dda9223748e78ad417d49efe8670a490346fd3a6';
