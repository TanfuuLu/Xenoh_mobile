// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_repository_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(cycleRepository)
final cycleRepositoryProvider = CycleRepositoryProvider._();

final class CycleRepositoryProvider
    extends
        $FunctionalProvider<CycleRepository, CycleRepository, CycleRepository>
    with $Provider<CycleRepository> {
  CycleRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cycleRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cycleRepositoryHash();

  @$internal
  @override
  $ProviderElement<CycleRepository> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  CycleRepository create(Ref ref) {
    return cycleRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(CycleRepository value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<CycleRepository>(value),
    );
  }
}

String _$cycleRepositoryHash() => r'9ee177216390953f3920d53d7f9cc94abc8d2173';
