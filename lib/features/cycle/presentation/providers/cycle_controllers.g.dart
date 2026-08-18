// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cycle_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(CycleOverviewController)
final cycleOverviewControllerProvider = CycleOverviewControllerProvider._();

final class CycleOverviewControllerProvider
    extends $AsyncNotifierProvider<CycleOverviewController, CycleOverview> {
  CycleOverviewControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cycleOverviewControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cycleOverviewControllerHash();

  @$internal
  @override
  CycleOverviewController create() => CycleOverviewController();
}

String _$cycleOverviewControllerHash() =>
    r'70c67e837a73fa35b30ec23232375a7f209ef831';

abstract class _$CycleOverviewController extends $AsyncNotifier<CycleOverview> {
  FutureOr<CycleOverview> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<CycleOverview>, CycleOverview>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<CycleOverview>, CycleOverview>,
              AsyncValue<CycleOverview>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(cycleLogs)
final cycleLogsProvider = CycleLogsFamily._();

final class CycleLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<CycleDailyLog>>,
          List<CycleDailyLog>,
          FutureOr<List<CycleDailyLog>>
        >
    with
        $FutureModifier<List<CycleDailyLog>>,
        $FutureProvider<List<CycleDailyLog>> {
  CycleLogsProvider._({
    required CycleLogsFamily super.from,
    required ({DateTime from, DateTime to}) super.argument,
  }) : super(
         retry: null,
         name: r'cycleLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cycleLogsHash();

  @override
  String toString() {
    return r'cycleLogsProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<CycleDailyLog>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<CycleDailyLog>> create(Ref ref) {
    final argument = this.argument as ({DateTime from, DateTime to});
    return cycleLogs(ref, from: argument.from, to: argument.to);
  }

  @override
  bool operator ==(Object other) {
    return other is CycleLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cycleLogsHash() => r'431afa012b1a1efc3e67b03bc858a0032671155e';

final class CycleLogsFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<CycleDailyLog>>,
          ({DateTime from, DateTime to})
        > {
  CycleLogsFamily._()
    : super(
        retry: null,
        name: r'cycleLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CycleLogsProvider call({required DateTime from, required DateTime to}) =>
      CycleLogsProvider._(argument: (from: from, to: to), from: this);

  @override
  String toString() => r'cycleLogsProvider';
}

@ProviderFor(cycleSettings)
final cycleSettingsProvider = CycleSettingsProvider._();

final class CycleSettingsProvider
    extends
        $FunctionalProvider<
          AsyncValue<CycleSettings>,
          CycleSettings,
          FutureOr<CycleSettings>
        >
    with $FutureModifier<CycleSettings>, $FutureProvider<CycleSettings> {
  CycleSettingsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cycleSettingsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cycleSettingsHash();

  @$internal
  @override
  $FutureProviderElement<CycleSettings> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CycleSettings> create(Ref ref) {
    return cycleSettings(ref);
  }
}

String _$cycleSettingsHash() => r'c09454a0235fc89a543c2f9dc8ac39af1f603551';

@ProviderFor(cycleInsight)
final cycleInsightProvider = CycleInsightFamily._();

final class CycleInsightProvider
    extends
        $FunctionalProvider<
          AsyncValue<CycleInsight>,
          CycleInsight,
          FutureOr<CycleInsight>
        >
    with $FutureModifier<CycleInsight>, $FutureProvider<CycleInsight> {
  CycleInsightProvider._({
    required CycleInsightFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'cycleInsightProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$cycleInsightHash();

  @override
  String toString() {
    return r'cycleInsightProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<CycleInsight> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<CycleInsight> create(Ref ref) {
    final argument = this.argument as String;
    return cycleInsight(ref, lang: argument);
  }

  @override
  bool operator ==(Object other) {
    return other is CycleInsightProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$cycleInsightHash() => r'fd8a9d4692fcfedb0739b0cd19bf9ea8530d8cc7';

final class CycleInsightFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<CycleInsight>, String> {
  CycleInsightFamily._()
    : super(
        retry: null,
        name: r'cycleInsightProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  CycleInsightProvider call({String lang = 'en'}) =>
      CycleInsightProvider._(argument: lang, from: this);

  @override
  String toString() => r'cycleInsightProvider';
}

@ProviderFor(CycleMutationController)
final cycleMutationControllerProvider = CycleMutationControllerProvider._();

final class CycleMutationControllerProvider
    extends $AsyncNotifierProvider<CycleMutationController, void> {
  CycleMutationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'cycleMutationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$cycleMutationControllerHash();

  @$internal
  @override
  CycleMutationController create() => CycleMutationController();
}

String _$cycleMutationControllerHash() =>
    r'5ddba1c6edb5819395fce33ba4d331b21e5a2760';

abstract class _$CycleMutationController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
