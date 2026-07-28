// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'supplement_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(supplementRegimens)
final supplementRegimensProvider = SupplementRegimensFamily._();

final class SupplementRegimensProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<SupplementRegimen>>,
          List<SupplementRegimen>,
          FutureOr<List<SupplementRegimen>>
        >
    with
        $FutureModifier<List<SupplementRegimen>>,
        $FutureProvider<List<SupplementRegimen>> {
  SupplementRegimensProvider._({
    required SupplementRegimensFamily super.from,
    required ({String? clientId, bool includeArchived}) super.argument,
  }) : super(
         retry: null,
         name: r'supplementRegimensProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$supplementRegimensHash();

  @override
  String toString() {
    return r'supplementRegimensProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<List<SupplementRegimen>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<SupplementRegimen>> create(Ref ref) {
    final argument =
        this.argument as ({String? clientId, bool includeArchived});
    return supplementRegimens(
      ref,
      clientId: argument.clientId,
      includeArchived: argument.includeArchived,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SupplementRegimensProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$supplementRegimensHash() =>
    r'22d4570fc7fa5df54332409c38c1a95a35fe85c9';

final class SupplementRegimensFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<List<SupplementRegimen>>,
          ({String? clientId, bool includeArchived})
        > {
  SupplementRegimensFamily._()
    : super(
        retry: null,
        name: r'supplementRegimensProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SupplementRegimensProvider call({
    String? clientId,
    bool includeArchived = false,
  }) => SupplementRegimensProvider._(
    argument: (clientId: clientId, includeArchived: includeArchived),
    from: this,
  );

  @override
  String toString() => r'supplementRegimensProvider';
}

@ProviderFor(supplementDaily)
final supplementDailyProvider = SupplementDailyFamily._();

final class SupplementDailyProvider
    extends
        $FunctionalProvider<
          AsyncValue<SupplementDaily>,
          SupplementDaily,
          FutureOr<SupplementDaily>
        >
    with $FutureModifier<SupplementDaily>, $FutureProvider<SupplementDaily> {
  SupplementDailyProvider._({
    required SupplementDailyFamily super.from,
    required ({DateTime date, String? clientId}) super.argument,
  }) : super(
         retry: null,
         name: r'supplementDailyProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$supplementDailyHash();

  @override
  String toString() {
    return r'supplementDailyProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<SupplementDaily> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SupplementDaily> create(Ref ref) {
    final argument = this.argument as ({DateTime date, String? clientId});
    return supplementDaily(
      ref,
      date: argument.date,
      clientId: argument.clientId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SupplementDailyProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$supplementDailyHash() => r'87042a453d0fb6d299d3bc600be865524261f78a';

final class SupplementDailyFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<SupplementDaily>,
          ({DateTime date, String? clientId})
        > {
  SupplementDailyFamily._()
    : super(
        retry: null,
        name: r'supplementDailyProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SupplementDailyProvider call({required DateTime date, String? clientId}) =>
      SupplementDailyProvider._(
        argument: (date: date, clientId: clientId),
        from: this,
      );

  @override
  String toString() => r'supplementDailyProvider';
}

@ProviderFor(supplementHistory)
final supplementHistoryProvider = SupplementHistoryFamily._();

final class SupplementHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<SupplementHistory>,
          SupplementHistory,
          FutureOr<SupplementHistory>
        >
    with
        $FutureModifier<SupplementHistory>,
        $FutureProvider<SupplementHistory> {
  SupplementHistoryProvider._({
    required SupplementHistoryFamily super.from,
    required ({DateTime from, DateTime to, String? clientId}) super.argument,
  }) : super(
         retry: null,
         name: r'supplementHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$supplementHistoryHash();

  @override
  String toString() {
    return r'supplementHistoryProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<SupplementHistory> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<SupplementHistory> create(Ref ref) {
    final argument =
        this.argument as ({DateTime from, DateTime to, String? clientId});
    return supplementHistory(
      ref,
      from: argument.from,
      to: argument.to,
      clientId: argument.clientId,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is SupplementHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$supplementHistoryHash() => r'0ead5a46408c6bffc682660db0393349886a9757';

final class SupplementHistoryFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<SupplementHistory>,
          ({DateTime from, DateTime to, String? clientId})
        > {
  SupplementHistoryFamily._()
    : super(
        retry: null,
        name: r'supplementHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  SupplementHistoryProvider call({
    required DateTime from,
    required DateTime to,
    String? clientId,
  }) => SupplementHistoryProvider._(
    argument: (from: from, to: to, clientId: clientId),
    from: this,
  );

  @override
  String toString() => r'supplementHistoryProvider';
}

@ProviderFor(SupplementMutationController)
final supplementMutationControllerProvider =
    SupplementMutationControllerProvider._();

final class SupplementMutationControllerProvider
    extends $AsyncNotifierProvider<SupplementMutationController, void> {
  SupplementMutationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'supplementMutationControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$supplementMutationControllerHash();

  @$internal
  @override
  SupplementMutationController create() => SupplementMutationController();
}

String _$supplementMutationControllerHash() =>
    r'7e3cce667709494f964b472bce49220d840f303a';

abstract class _$SupplementMutationController extends $AsyncNotifier<void> {
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
