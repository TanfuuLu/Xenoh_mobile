// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'exercise_templates_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Exercise templates for the add-exercise picker, optionally filtered by
/// muscle group (enum name, e.g. `Chest`).
// Exercise templates change only after an explicit create, update, delete, or
// pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
// API/Redis cache every time the user leaves and reopens the exercise library.

@ProviderFor(ExerciseTemplatesController)
final exerciseTemplatesControllerProvider =
    ExerciseTemplatesControllerFamily._();

/// Exercise templates for the add-exercise picker, optionally filtered by
/// muscle group (enum name, e.g. `Chest`).
// Exercise templates change only after an explicit create, update, delete, or
// pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
// API/Redis cache every time the user leaves and reopens the exercise library.
final class ExerciseTemplatesControllerProvider
    extends
        $AsyncNotifierProvider<
          ExerciseTemplatesController,
          List<ExerciseTemplate>
        > {
  /// Exercise templates for the add-exercise picker, optionally filtered by
  /// muscle group (enum name, e.g. `Chest`).
  // Exercise templates change only after an explicit create, update, delete, or
  // pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
  // API/Redis cache every time the user leaves and reopens the exercise library.
  ExerciseTemplatesControllerProvider._({
    required ExerciseTemplatesControllerFamily super.from,
    required String? super.argument,
  }) : super(
         retry: null,
         name: r'exerciseTemplatesControllerProvider',
         isAutoDispose: false,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exerciseTemplatesControllerHash();

  @override
  String toString() {
    return r'exerciseTemplatesControllerProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  ExerciseTemplatesController create() => ExerciseTemplatesController();

  @override
  bool operator ==(Object other) {
    return other is ExerciseTemplatesControllerProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exerciseTemplatesControllerHash() =>
    r'54eed55fdb285b02db74fe83daeb2c16bac6222b';

/// Exercise templates for the add-exercise picker, optionally filtered by
/// muscle group (enum name, e.g. `Chest`).
// Exercise templates change only after an explicit create, update, delete, or
// pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
// API/Redis cache every time the user leaves and reopens the exercise library.

final class ExerciseTemplatesControllerFamily extends $Family
    with
        $ClassFamilyOverride<
          ExerciseTemplatesController,
          AsyncValue<List<ExerciseTemplate>>,
          List<ExerciseTemplate>,
          FutureOr<List<ExerciseTemplate>>,
          String?
        > {
  ExerciseTemplatesControllerFamily._()
    : super(
        retry: null,
        name: r'exerciseTemplatesControllerProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: false,
      );

  /// Exercise templates for the add-exercise picker, optionally filtered by
  /// muscle group (enum name, e.g. `Chest`).
  // Exercise templates change only after an explicit create, update, delete, or
  // pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
  // API/Redis cache every time the user leaves and reopens the exercise library.

  ExerciseTemplatesControllerProvider call({String? muscleGroup}) =>
      ExerciseTemplatesControllerProvider._(argument: muscleGroup, from: this);

  @override
  String toString() => r'exerciseTemplatesControllerProvider';
}

/// Exercise templates for the add-exercise picker, optionally filtered by
/// muscle group (enum name, e.g. `Chest`).
// Exercise templates change only after an explicit create, update, delete, or
// pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
// API/Redis cache every time the user leaves and reopens the exercise library.

abstract class _$ExerciseTemplatesController
    extends $AsyncNotifier<List<ExerciseTemplate>> {
  late final _$args = ref.$arg as String?;
  String? get muscleGroup => _$args;

  FutureOr<List<ExerciseTemplate>> build({String? muscleGroup});
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref
            as $Ref<AsyncValue<List<ExerciseTemplate>>, List<ExerciseTemplate>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<List<ExerciseTemplate>>,
                List<ExerciseTemplate>
              >,
              AsyncValue<List<ExerciseTemplate>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, () => build(muscleGroup: _$args));
  }
}
