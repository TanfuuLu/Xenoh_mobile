// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plan_detail_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Plan header detail (for the plan detail screen app bar / progress).

@ProviderFor(planDetail)
final planDetailProvider = PlanDetailFamily._();

/// Plan header detail (for the plan detail screen app bar / progress).

final class PlanDetailProvider
    extends $FunctionalProvider<AsyncValue<Plan>, Plan, FutureOr<Plan>>
    with $FutureModifier<Plan>, $FutureProvider<Plan> {
  /// Plan header detail (for the plan detail screen app bar / progress).
  PlanDetailProvider._({
    required PlanDetailFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'planDetailProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$planDetailHash();

  @override
  String toString() {
    return r'planDetailProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Plan> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Plan> create(Ref ref) {
    final argument = this.argument as String;
    return planDetail(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanDetailProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$planDetailHash() => r'95e34bedf6ebdcda5909f8f74a820a2c9461f6a8';

/// Plan header detail (for the plan detail screen app bar / progress).

final class PlanDetailFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Plan>, String> {
  PlanDetailFamily._()
    : super(
        retry: null,
        name: r'planDetailProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Plan header detail (for the plan detail screen app bar / progress).

  PlanDetailProvider call(String planId) =>
      PlanDetailProvider._(argument: planId, from: this);

  @override
  String toString() => r'planDetailProvider';
}

/// Weeks within a plan.

@ProviderFor(WeeksController)
final weeksControllerProvider = WeeksControllerFamily._();

/// Weeks within a plan.
final class WeeksControllerProvider
    extends $AsyncNotifierProvider<WeeksController, List<WeeklyWorkout>> {
  /// Weeks within a plan.
  WeeksControllerProvider._({
    required WeeksControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'weeksControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$weeksControllerHash();

  @override
  String toString() {
    return r'weeksControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  WeeksController create() => WeeksController();

  @override
  bool operator ==(Object other) {
    return other is WeeksControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$weeksControllerHash() => r'7c5235120f6a2ffe99ced0f2f48e98f8cf1106de';

/// Weeks within a plan.

final class WeeksControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          WeeksController,
          AsyncValue<List<WeeklyWorkout>>,
          List<WeeklyWorkout>,
          FutureOr<List<WeeklyWorkout>>,
          String
        > {
  WeeksControllerFamily._()
    : super(
        retry: null,
        name: r'weeksControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Weeks within a plan.

  WeeksControllerProvider call(String planId) =>
      WeeksControllerProvider._(argument: planId, from: this);

  @override
  String toString() => r'weeksControllerProvider';
}

/// Weeks within a plan.

abstract class _$WeeksController extends $AsyncNotifier<List<WeeklyWorkout>> {
  late final _$args = ref.$arg as String;
  String get planId => _$args;

  FutureOr<List<WeeklyWorkout>> build(String planId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<WeeklyWorkout>>, List<WeeklyWorkout>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<WeeklyWorkout>>, List<WeeklyWorkout>>,
              AsyncValue<List<WeeklyWorkout>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
