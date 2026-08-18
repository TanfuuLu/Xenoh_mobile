// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_revision.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
/// topic succeeds.
///
/// Providers never read the value — they only `watch` it so Riverpod re-runs
/// them when it changes. Kept alive so the revision survives screens being
/// popped; otherwise a topic bumped while nothing is listening would reset and
/// the next screen would show stale data.

@ProviderFor(DataRevision)
final dataRevisionProvider = DataRevisionFamily._();

/// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
/// topic succeeds.
///
/// Providers never read the value — they only `watch` it so Riverpod re-runs
/// them when it changes. Kept alive so the revision survives screens being
/// popped; otherwise a topic bumped while nothing is listening would reset and
/// the next screen would show stale data.
final class DataRevisionProvider extends $NotifierProvider<DataRevision, int> {
  /// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
  /// topic succeeds.
  ///
  /// Providers never read the value — they only `watch` it so Riverpod re-runs
  /// them when it changes. Kept alive so the revision survives screens being
  /// popped; otherwise a topic bumped while nothing is listening would reset and
  /// the next screen would show stale data.
  DataRevisionProvider._({
    required DataRevisionFamily super.from,
    required DataTopic super.argument,
  }) : super(
         retry: null,
         name: r'dataRevisionProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$dataRevisionHash();

  @override
  String toString() {
    return r'dataRevisionProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DataRevision create() => DataRevision();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(int value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<int>(value),
    );
  }

  @override
  bool operator ==(Object other) {
    return other is DataRevisionProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$dataRevisionHash() => r'1258d9873317a2741a9b6b180b28479c8c920980';

/// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
/// topic succeeds.
///
/// Providers never read the value — they only `watch` it so Riverpod re-runs
/// them when it changes. Kept alive so the revision survives screens being
/// popped; otherwise a topic bumped while nothing is listening would reset and
/// the next screen would show stale data.

final class DataRevisionFamily extends $Family
    with $ClassFamilyOverride<DataRevision, int, int, int, DataTopic> {
  DataRevisionFamily._()
    : super(
        retry: null,
        name: r'dataRevisionProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
  /// topic succeeds.
  ///
  /// Providers never read the value — they only `watch` it so Riverpod re-runs
  /// them when it changes. Kept alive so the revision survives screens being
  /// popped; otherwise a topic bumped while nothing is listening would reset and
  /// the next screen would show stale data.

  DataRevisionProvider call(DataTopic topic) =>
      DataRevisionProvider._(argument: topic, from: this);

  @override
  String toString() => r'dataRevisionProvider';
}

/// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
/// topic succeeds.
///
/// Providers never read the value — they only `watch` it so Riverpod re-runs
/// them when it changes. Kept alive so the revision survives screens being
/// popped; otherwise a topic bumped while nothing is listening would reset and
/// the next screen would show stale data.

abstract class _$DataRevision extends $Notifier<int> {
  late final _$args = ref.$arg as DataTopic;
  DataTopic get topic => _$args;

  int build(DataTopic topic);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<int, int>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<int, int>,
              int,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
