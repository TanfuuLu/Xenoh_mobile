// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplement_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supplementRepository)
final supplementRepositoryProvider = SupplementRepositoryProvider._();

final class SupplementRepositoryProvider
    extends
        $FunctionalProvider<
          SupplementRepository,
          SupplementRepository,
          SupplementRepository
        >
    with $Provider<SupplementRepository> {
  SupplementRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supplementRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supplementRepositoryHash();

  @$internal
  @override
  $ProviderElement<SupplementRepository> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  SupplementRepository create(Ref ref) {
    return supplementRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(SupplementRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<SupplementRepository>(value),
    );
  }
}

String _$supplementRepositoryHash() =>
    r'0efb76a4433485e59f2522822a359c7b70d0b0cf';
