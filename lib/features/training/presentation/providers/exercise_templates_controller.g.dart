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
    required ({String? muscleGroup, String? clientId}) super.argument,
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
        '$argument';
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
    r'cacf3c3f077a57ae0f79678289937c2ca805e13b';

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
          ({String? muscleGroup, String? clientId})
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

  ExerciseTemplatesControllerProvider call({
    String? muscleGroup,
    String? clientId,
  }) => ExerciseTemplatesControllerProvider._(
    argument: (muscleGroup: muscleGroup, clientId: clientId),
    from: this,
  );

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
  late final _$args = ref.$arg as ({String? muscleGroup, String? clientId});
  String? get muscleGroup => _$args.muscleGroup;
  String? get clientId => _$args.clientId;

  FutureOr<List<ExerciseTemplate>> build({
    String? muscleGroup,
    String? clientId,
  });
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
    element.handleCreate(
      ref,
      () => build(muscleGroup: _$args.muscleGroup, clientId: _$args.clientId),
    );
  }
}
