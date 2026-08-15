// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// App-wide auth state holder. Attempts a silent refresh on startup and exposes
/// login / register / logout. Submit-level loading/errors are returned to the
/// caller (the screens) rather than folded into [AuthState].

@ProviderFor(AuthController)
final authControllerProvider = AuthControllerProvider._();

/// App-wide auth state holder. Attempts a silent refresh on startup and exposes
/// login / register / logout. Submit-level loading/errors are returned to the
/// caller (the screens) rather than folded into [AuthState].
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AuthState> {
  /// App-wide auth state holder. Attempts a silent refresh on startup and exposes
  /// login / register / logout. Submit-level loading/errors are returned to the
  /// caller (the screens) rather than folded into [AuthState].
  AuthControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthState value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthState>(value),
    );
  }
}

String _$authControllerHash() => r'1100693dde740f0446b1b4f7d37d3dc27faa8ded';

/// App-wide auth state holder. Attempts a silent refresh on startup and exposes
/// login / register / logout. Submit-level loading/errors are returned to the
/// caller (the screens) rather than folded into [AuthState].

abstract class _$AuthController extends $Notifier<AuthState> {
  AuthState build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthState, AuthState>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthState, AuthState>,
              AuthState,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Cheap, independent flag: true once the startup silent-refresh attempt
/// ([AuthController._restore]) has finished, regardless of outcome.
/// [features/profile/presentation/providers/preferences_provider.dart]'s
/// `AppLocale` watches this — not [authControllerProvider] itself — so that
/// checking "is auth ready yet" never forces [AuthController]'s build (and
/// its network/token bootstrap) as a side effect on screens that don't
/// otherwise need auth. `authControllerProvider` already gets built
/// independently by the router on every navigation, which is what actually
/// drives this flag in the real app.

@ProviderFor(AuthBootstrapped)
final authBootstrappedProvider = AuthBootstrappedProvider._();

/// Cheap, independent flag: true once the startup silent-refresh attempt
/// ([AuthController._restore]) has finished, regardless of outcome.
/// [features/profile/presentation/providers/preferences_provider.dart]'s
/// `AppLocale` watches this — not [authControllerProvider] itself — so that
/// checking "is auth ready yet" never forces [AuthController]'s build (and
/// its network/token bootstrap) as a side effect on screens that don't
/// otherwise need auth. `authControllerProvider` already gets built
/// independently by the router on every navigation, which is what actually
/// drives this flag in the real app.
final class AuthBootstrappedProvider
    extends $NotifierProvider<AuthBootstrapped, bool> {
  /// Cheap, independent flag: true once the startup silent-refresh attempt
  /// ([AuthController._restore]) has finished, regardless of outcome.
  /// [features/profile/presentation/providers/preferences_provider.dart]'s
  /// `AppLocale` watches this — not [authControllerProvider] itself — so that
  /// checking "is auth ready yet" never forces [AuthController]'s build (and
  /// its network/token bootstrap) as a side effect on screens that don't
  /// otherwise need auth. `authControllerProvider` already gets built
  /// independently by the router on every navigation, which is what actually
  /// drives this flag in the real app.
  AuthBootstrappedProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authBootstrappedProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authBootstrappedHash();

  @$internal
  @override
  AuthBootstrapped create() => AuthBootstrapped();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$authBootstrappedHash() => r'c40b2b5d372fc39bdaadfd695997358028078e0d';

/// Cheap, independent flag: true once the startup silent-refresh attempt
/// ([AuthController._restore]) has finished, regardless of outcome.
/// [features/profile/presentation/providers/preferences_provider.dart]'s
/// `AppLocale` watches this — not [authControllerProvider] itself — so that
/// checking "is auth ready yet" never forces [AuthController]'s build (and
/// its network/token bootstrap) as a side effect on screens that don't
/// otherwise need auth. `authControllerProvider` already gets built
/// independently by the router on every navigation, which is what actually
/// drives this flag in the real app.

abstract class _$AuthBootstrapped extends $Notifier<bool> {
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
