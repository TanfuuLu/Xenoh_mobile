// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'days_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Days within a week.

@ProviderFor(DaysController)
final daysControllerProvider = DaysControllerFamily._();

/// Days within a week.
final class DaysControllerProvider
    extends $AsyncNotifierProvider<DaysController, List<DailyWorkout>> {
  /// Days within a week.
  DaysControllerProvider._({
    required DaysControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'daysControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$daysControllerHash();

  @override
  String toString() {
    return r'daysControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  DaysController create() => DaysController();

  @override
  bool operator ==(Object other) {
    return other is DaysControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$daysControllerHash() => r'db0b3186132a6425ec662170197ac70af041941c';

/// Days within a week.

final class DaysControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          DaysController,
          AsyncValue<List<DailyWorkout>>,
          List<DailyWorkout>,
          FutureOr<List<DailyWorkout>>,
          String
        > {
  DaysControllerFamily._()
    : super(
        retry: null,
        name: r'daysControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Days within a week.

  DaysControllerProvider call(String weeklyWorkoutId) =>
      DaysControllerProvider._(argument: weeklyWorkoutId, from: this);

  @override
  String toString() => r'daysControllerProvider';
}

/// Days within a week.

abstract class _$DaysController extends $AsyncNotifier<List<DailyWorkout>> {
  late final _$args = ref.$arg as String;
  String get weeklyWorkoutId => _$args;

  FutureOr<List<DailyWorkout>> build(String weeklyWorkoutId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<List<DailyWorkout>>, List<DailyWorkout>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<DailyWorkout>>, List<DailyWorkout>>,
              AsyncValue<List<DailyWorkout>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
