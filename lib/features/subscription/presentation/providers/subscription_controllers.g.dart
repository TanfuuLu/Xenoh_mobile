// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The current user's subscription. Refresh by invalidating (e.g. after a
/// payment completes or a dev-activate).

@ProviderFor(subscription)
final subscriptionProvider = SubscriptionProvider._();

/// The current user's subscription. Refresh by invalidating (e.g. after a
/// payment completes or a dev-activate).

final class SubscriptionProvider
    extends
        $FunctionalProvider<
          AsyncValue<Subscription>,
          Subscription,
          FutureOr<Subscription>
        >
    with $FutureModifier<Subscription>, $FutureProvider<Subscription> {
  /// The current user's subscription. Refresh by invalidating (e.g. after a
  /// payment completes or a dev-activate).
  SubscriptionProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'subscriptionProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$subscriptionHash();

  @$internal
  @override
  $FutureProviderElement<Subscription> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<Subscription> create(Ref ref) {
    return subscription(ref);
  }
}

String _$subscriptionHash() => r'51107b75b5b3f6e185e6760d8aee40948514b68f';

/// Convenience gate other features can watch synchronously: `true` only once
/// the subscription has loaded and is an active Pro tier.

@ProviderFor(isPro)
final isProProvider = IsProProvider._();

/// Convenience gate other features can watch synchronously: `true` only once
/// the subscription has loaded and is an active Pro tier.

final class IsProProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Convenience gate other features can watch synchronously: `true` only once
  /// the subscription has loaded and is an active Pro tier.
  IsProProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'isProProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$isProHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isPro(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isProHash() => r'9c146c09613d91cd57145193f751a2ef46a196f0';
