// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'subscription_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The current user's server-authoritative subscription state.

@ProviderFor(subscription)
final subscriptionProvider = SubscriptionProvider._();

/// The current user's server-authoritative subscription state.

final class SubscriptionProvider
    extends
        $FunctionalProvider<
          AsyncValue<Subscription>,
          Subscription,
          FutureOr<Subscription>
        >
    with $FutureModifier<Subscription>, $FutureProvider<Subscription> {
  /// The current user's server-authoritative subscription state.
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

String _$subscriptionHash() => r'1ed36d3da4a5794047540794ced56f7e77e3c731';
