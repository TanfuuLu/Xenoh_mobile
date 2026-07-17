import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/training/data/datasources/training_remote_data_source.dart';
import 'package:xenoh_mobile/features/training/data/dtos/exercise_dto.dart';
import 'package:xenoh_mobile/features/training/data/dtos/exercise_template_dto.dart';
import 'package:xenoh_mobile/features/training/data/repositories/training_repository_impl.dart';

class MockTrainingRemoteDataSource extends Mock
    implements TrainingRemoteDataSource {}

ExerciseDto _exerciseDto({String? imageUrl}) => ExerciseDto(
  id: 'e1',
  exerciseTemplateId: 't1',
  name: 'Bench Press',
  primaryMuscleGroup: 'Chest',
  exerciseKind: 'Strength',
  plannedSets: 3,
  plannedReps: 10,
  completedSetsCount: 0,
  isCompleted: false,
  isSkipped: false,
  dailyWorkoutId: 'd1',
  sortOrder: 0,
  imageUrl: imageUrl,
);

ExerciseTemplateDto _templateDto({String? imageUrl}) => ExerciseTemplateDto(
  id: 't1',
  name: 'Bench Press',
  primaryMuscleGroup: 'Chest',
  exerciseKind: 'Strength',
  isCustom: false,
  imageUrl: imageUrl,
);

void main() {
  test('getExercisesByDay fills missing images from templates', () async {
    final remote = MockTrainingRemoteDataSource();
    when(
      () => remote.getExercisesByDay('d1'),
    ).thenAnswer((_) async => [_exerciseDto()]);
    when(
      remote.getExerciseTemplates,
    ).thenAnswer((_) async => [_templateDto(imageUrl: '/images/bench.png')]);

    final repository = TrainingRepositoryImpl(remote);
    final exercises = await repository.getExercisesByDay('d1');

    expect(
      exercises.single.imageUrl,
      'https://assets.xenoh.online/images/bench.png',
    );
  });

  test(
    'getExercisesByDay keeps exercise images without template lookup',
    () async {
      final remote = MockTrainingRemoteDataSource();
      when(
        () => remote.getExercisesByDay('d1'),
      ).thenAnswer(
        (_) async => [
          _exerciseDto(imageUrl: 'https://cdn.example.com/exercise.png'),
        ],
      );

      final repository = TrainingRepositoryImpl(remote);
      final exercises = await repository.getExercisesByDay('d1');

      expect(exercises.single.imageUrl, 'https://cdn.example.com/exercise.png');
      verifyNever(remote.getExerciseTemplates);
    },
  );

  test('getExerciseTemplates resolves R2 object keys', () async {
    final remote = MockTrainingRemoteDataSource();
    when(
      () => remote.getExerciseTemplates(muscleGroup: null),
    ).thenAnswer(
      (_) async => [_templateDto(imageUrl: '/ExerciseImages/chest/bench.png')],
    );

    final repository = TrainingRepositoryImpl(remote);
    final templates = await repository.getExerciseTemplates();

    expect(
      templates.single.imageUrl,
      'https://assets.xenoh.online/ExerciseImages/chest/bench.png',
    );
  });

  test('getExercisesByDay resolves an exercises-image R2 object key', () async {
    final remote = MockTrainingRemoteDataSource();
    when(
      () => remote.getExercisesByDay('d1'),
    ).thenAnswer(
      (_) async => [_exerciseDto(imageUrl: 'exercises-image/bench-press.webp')],
    );

    final repository = TrainingRepositoryImpl(remote);
    final exercises = await repository.getExercisesByDay('d1');

    expect(
      exercises.single.imageUrl,
      'https://assets.xenoh.online/exercises-image/bench-press.webp',
    );
  });
}
