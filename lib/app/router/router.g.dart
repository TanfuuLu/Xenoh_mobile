// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'router.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App router. Watches [AuthController] and gates routes:
/// - while auth is `unknown` → `/splash`
/// - unauthenticated → `/login` (and `/register`)
/// - authenticated → `/dashboard` (bottom-nav shell: Home + Plans)

@ProviderFor(router)
final routerProvider = RouterProvider._();

/// App router. Watches [AuthController] and gates routes:
/// - while auth is `unknown` → `/splash`
/// - unauthenticated → `/login` (and `/register`)
/// - authenticated → `/dashboard` (bottom-nav shell: Home + Plans)

final class RouterProvider
    extends $FunctionalProvider<GoRouter, GoRouter, GoRouter>
    with $Provider<GoRouter> {
  /// App router. Watches [AuthController] and gates routes:
  /// - while auth is `unknown` → `/splash`
  /// - unauthenticated → `/login` (and `/register`)
  /// - authenticated → `/dashboard` (bottom-nav shell: Home + Plans)
  RouterProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'routerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$routerHash();

  @$internal
  @override
  $ProviderElement<GoRouter> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  GoRouter create(Ref ref) {
    return router(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(GoRouter value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<GoRouter>(value),
    );
  }
}

String _$routerHash() => r'4c806d78e85869fcd26b0193ab33f96661537e8d';
