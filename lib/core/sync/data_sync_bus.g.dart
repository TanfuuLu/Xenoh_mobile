// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_sync_bus.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dataSyncBus)
final dataSyncBusProvider = DataSyncBusProvider._();

final class DataSyncBusProvider
    extends $FunctionalProvider<DataSyncBus, DataSyncBus, DataSyncBus>
    with $Provider<DataSyncBus> {
  DataSyncBusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dataSyncBusProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dataSyncBusHash();

  @$internal
  @override
  $ProviderElement<DataSyncBus> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  DataSyncBus create(Ref ref) {
    return dataSyncBus(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DataSyncBus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DataSyncBus>(value),
    );
  }
}

String _$dataSyncBusHash() => r'd98fa0934954f2ea3617ce456f2594f9bdeace03';
