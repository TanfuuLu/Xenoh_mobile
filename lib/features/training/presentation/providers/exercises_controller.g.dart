// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercises_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exercises (with their sets) for a daily workout.
///
/// Deliberately *not* wired to [DataTopic.training]: this is the workout
/// logging hot path, and every mutation here already patches the affected
/// exercise into state in place. Re-fetching the whole day on each completed
/// set would be slower and visibly jumpier. Other screens still pick these
/// changes up, because the same writes bump the topic they watch.

@ProviderFor(ExercisesController)
final exercisesControllerProvider = ExercisesControllerFamily._();

/// Exercises (with their sets) for a daily workout.
///
/// Deliberately *not* wired to [DataTopic.training]: this is the workout
/// logging hot path, and every mutation here already patches the affected
/// exercise into state in place. Re-fetching the whole day on each completed
/// set would be slower and visibly jumpier. Other screens still pick these
/// changes up, because the same writes bump the topic they watch.
final class ExercisesControllerProvider
    extends $AsyncNotifierProvider<ExercisesController, List<Exercise>> {
  /// Exercises (with their sets) for a daily workout.
  ///
  /// Deliberately *not* wired to [DataTopic.training]: this is the workout
  /// logging hot path, and every mutation here already patches the affected
  /// exercise into state in place. Re-fetching the whole day on each completed
  /// set would be slower and visibly jumpier. Other screens still pick these
  /// changes up, because the same writes bump the topic they watch.
  ExercisesControllerProvider._({
    required ExercisesControllerFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'exercisesControllerProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exercisesControllerHash();

  @override
  String toString() {
    return r'exercisesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExercisesController create() => ExercisesController();

  @override
  bool operator ==(Object other) {
    return other is ExercisesControllerProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exercisesControllerHash() =>
    r'a968148f2176f1565cc499b8fca96b864ad7bf0f';

/// Exercises (with their sets) for a daily workout.
///
/// Deliberately *not* wired to [DataTopic.training]: this is the workout
/// logging hot path, and every mutation here already patches the affected
/// exercise into state in place. Re-fetching the whole day on each completed
/// set would be slower and visibly jumpier. Other screens still pick these
/// changes up, because the same writes bump the topic they watch.

final class ExercisesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ExercisesController,
          AsyncValue<List<Exercise>>,
          List<Exercise>,
          FutureOr<List<Exercise>>,
          String
        > {
  ExercisesControllerFamily._()
    : super(
        retry: null,
        name: r'exercisesControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Exercises (with their sets) for a daily workout.
  ///
  /// Deliberately *not* wired to [DataTopic.training]: this is the workout
  /// logging hot path, and every mutation here already patches the affected
  /// exercise into state in place. Re-fetching the whole day on each completed
  /// set would be slower and visibly jumpier. Other screens still pick these
  /// changes up, because the same writes bump the topic they watch.

  ExercisesControllerProvider call(String dailyWorkoutId) =>
      ExercisesControllerProvider._(argument: dailyWorkoutId, from: this);

  @override
  String toString() => r'exercisesControllerProvider';
}

/// Exercises (with their sets) for a daily workout.
///
/// Deliberately *not* wired to [DataTopic.training]: this is the workout
/// logging hot path, and every mutation here already patches the affected
/// exercise into state in place. Re-fetching the whole day on each completed
/// set would be slower and visibly jumpier. Other screens still pick these
/// changes up, because the same writes bump the topic they watch.

abstract class _$ExercisesController extends $AsyncNotifier<List<Exercise>> {
  late final _$args = ref.$arg as String;
  String get dailyWorkoutId => _$args;

  FutureOr<List<Exercise>> build(String dailyWorkoutId);
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Exercise>>, List<Exercise>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Exercise>>, List<Exercise>>,
              AsyncValue<List<Exercise>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(_$args));
  }
}
