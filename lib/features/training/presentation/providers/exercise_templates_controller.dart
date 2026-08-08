import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/exercise_template.dart';

part 'exercise_templates_controller.g.dart';

/// Exercise templates for the add-exercise picker, optionally filtered by
/// muscle group (enum name, e.g. `Chest`).
// Exercise templates change only after an explicit create, update, delete, or
// pull-to-refresh. Keeping each filter result alive avoids a round-trip to the
// API/Redis cache every time the user leaves and reopens the exercise library.
@Riverpod(keepAlive: true)
class ExerciseTemplatesController extends _$ExerciseTemplatesController {
  @override
  Future<List<ExerciseTemplate>> build({
    String? muscleGroup,
    String? clientId,
  }) {
    return ref
        .watch(trainingRepositoryProvider)
        .getExerciseTemplates(muscleGroup: muscleGroup, clientId: clientId);
  }

  Future<void> createCustom({
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
  }) async {
    final created = await ref
        .read(trainingRepositoryProvider)
        .createCustomExerciseTemplate(
          name: name,
          primaryMuscleGroup: primaryMuscleGroup,
          secondaryMuscleGroups: secondaryMuscleGroups,
          exerciseKind: exerciseKind,
          description: description,
          clientId: clientId,
        );
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      return;
    }
    final matchesFilter =
        muscleGroup == null ||
        created.primaryMuscleGroup.toLowerCase() == muscleGroup!.toLowerCase();
    if (matchesFilter) {
      state = AsyncValue.data([created, ...current]);
    }
  }

  Future<void> updateCustom({
    required String id,
    required String name,
    required String primaryMuscleGroup,
    required List<String> secondaryMuscleGroups,
    required String exerciseKind,
    String? description,
  }) async {
    final updated = await ref
        .read(trainingRepositoryProvider)
        .updateCustomExerciseTemplate(
          id: id,
          name: name,
          primaryMuscleGroup: primaryMuscleGroup,
          secondaryMuscleGroups: secondaryMuscleGroups,
          exerciseKind: exerciseKind,
          description: description,
        );
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      return;
    }
    state = AsyncValue.data([
      for (final template in current)
        if (template.id == updated.id) updated else template,
    ]);
  }

  Future<void> deleteCustom(String id) async {
    await ref.read(trainingRepositoryProvider).deleteCustomExerciseTemplate(id);
    final current = state.value;
    if (current == null) {
      ref.invalidateSelf();
      return;
    }
    state = AsyncValue.data([
      for (final template in current)
        if (template.id != id) template,
    ]);
  }
}
