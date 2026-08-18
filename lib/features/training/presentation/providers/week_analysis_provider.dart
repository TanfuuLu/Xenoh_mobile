import 'dart:math' as math;

import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/daily_workout.dart';
import '../../domain/entities/exercise.dart';
import '../../domain/services/training_calorie_estimator.dart';

final weekAnalysisProvider = FutureProvider.family<WeekAnalysis, String>((
  ref,
  weeklyWorkoutId,
) async {
  ref.syncOn(const [DataTopic.training]);
  final repo = ref.watch(trainingRepositoryProvider);
  final daysPage = await repo.getDays(
    weeklyWorkoutId,
    pageNumber: 1,
    pageSize: 100,
  );
  final exercises = await repo.getExercisesByWeek(weeklyWorkoutId);
  return WeekAnalysis.from(daysPage.items, exercises);
});

enum WeekRecommendationTone { danger, warning, info }

enum WeekRecommendationType {
  lowCompletion,
  lowVolume,
  highEffort,
  missedDays,
  onTrack,
}

class WeekAnalysis {
  WeekAnalysis({
    required this.days,
    required this.daily,
    required this.completedDays,
    required this.totalDays,
    required this.restDays,
    required this.missedDays,
    required this.warningDays,
    required this.actualVolume,
    required this.plannedVolume,
    required this.completedSets,
    required this.totalSets,
    required this.averageRpe,
    required this.totalDurationSeconds,
    required this.muscleFocus,
    required this.recommendations,
  });

  factory WeekAnalysis.from(
    List<DailyWorkout> days,
    List<Exercise> exercises,
  ) {
    final sortedDays = [...days]..sort((a, b) => a.date.compareTo(b.date));
    final exercisesByDay = <String, List<Exercise>>{};
    for (final exercise in exercises) {
      exercisesByDay
          .putIfAbsent(exercise.dailyWorkoutId, () => <Exercise>[])
          .add(exercise);
    }

    final daily = [
      for (final day in sortedDays)
        DayAnalysis.from(day, exercisesByDay[day.id] ?? const []),
    ];
    final completedDays = sortedDays.where((day) => day.isCompleted).length;
    final restDays = sortedDays.where((day) => day.isRest).length;
    final missedDays = sortedDays.where((day) => day.isMissed).length;
    final warningDays = sortedDays.where((day) => day.hasWarning).length;
    final actualVolume = daily.fold<double>(
      0,
      (sum, day) => sum + day.actualVolume,
    );
    final plannedVolume = daily.fold<double>(
      0,
      (sum, day) => sum + day.plannedVolume,
    );
    final totalSets = exercises.fold<int>(
      0,
      (sum, exercise) =>
          sum +
          (exercise.sets.isEmpty ? exercise.plannedSets : exercise.sets.length),
    );
    final completedSets = exercises.fold<int>(
      0,
      (sum, exercise) =>
          sum +
          (exercise.sets.isEmpty
              ? (exercise.isCompleted ? exercise.plannedSets : 0)
              : exercise.sets.where((set) => set.isCompleted).length),
    );
    final averageRpe = _averageRpe(exercises);
    final totalDurationSeconds = exercises.fold<int>(
      0,
      (sum, exercise) => sum + _durationSeconds(exercise),
    );
    final muscleFocus = _buildMuscleFocus(exercises);

    final analysis = WeekAnalysis(
      days: sortedDays,
      daily: daily,
      completedDays: completedDays,
      totalDays: sortedDays.length,
      restDays: restDays,
      missedDays: missedDays,
      warningDays: warningDays,
      actualVolume: actualVolume,
      plannedVolume: plannedVolume,
      completedSets: completedSets,
      totalSets: totalSets,
      averageRpe: averageRpe,
      totalDurationSeconds: totalDurationSeconds,
      muscleFocus: muscleFocus,
      recommendations: const [],
    );

    return WeekAnalysis(
      days: analysis.days,
      daily: analysis.daily,
      completedDays: analysis.completedDays,
      totalDays: analysis.totalDays,
      restDays: analysis.restDays,
      missedDays: analysis.missedDays,
      warningDays: analysis.warningDays,
      actualVolume: analysis.actualVolume,
      plannedVolume: analysis.plannedVolume,
      completedSets: analysis.completedSets,
      totalSets: analysis.totalSets,
      averageRpe: analysis.averageRpe,
      totalDurationSeconds: analysis.totalDurationSeconds,
      muscleFocus: analysis.muscleFocus,
      recommendations: _buildRecommendations(analysis),
    );
  }

  final List<DailyWorkout> days;
  final List<DayAnalysis> daily;
  final int completedDays;
  final int totalDays;
  final int restDays;
  final int missedDays;
  final int warningDays;
  final double actualVolume;
  final double plannedVolume;
  final int completedSets;
  final int totalSets;
  final double? averageRpe;
  final int totalDurationSeconds;
  final List<MuscleFocusPoint> muscleFocus;
  final List<WeekRecommendation> recommendations;

  DateTime? get startDate => days.isEmpty ? null : days.first.date;

  DateTime? get endDate => days.isEmpty ? null : days.last.date;

  double get completionRate =>
      totalDays == 0 ? 0 : completedDays / math.max(totalDays, 1);

  double get volumeRate =>
      plannedVolume <= 0 ? 0 : actualVolume / plannedVolume;

  int get estimatedCalories => _estimatedCalories(totalDurationSeconds);
}

class DayAnalysis {
  DayAnalysis({
    required this.day,
    required this.actualVolume,
    required this.plannedVolume,
    required this.averageRpe,
    required this.estimatedCalories,
  });

  factory DayAnalysis.from(DailyWorkout day, List<Exercise> exercises) {
    final actual = exercises.fold<double>(
      0,
      (sum, exercise) => sum + _actualVolume(exercise),
    );
    final planned = exercises.fold<double>(
      0,
      (sum, exercise) => sum + _plannedVolume(exercise),
    );
    return DayAnalysis(
      day: day,
      actualVolume: actual,
      plannedVolume: planned,
      averageRpe: _averageRpe(exercises),
      estimatedCalories: _estimatedCalories(
        exercises.fold<int>(
          0,
          (sum, exercise) => sum + _durationSeconds(exercise),
        ),
      ),
    );
  }

  final DailyWorkout day;
  final double actualVolume;
  final double plannedVolume;
  final double? averageRpe;
  final int estimatedCalories;

  double get volumeRate =>
      plannedVolume <= 0 ? 0 : actualVolume / plannedVolume;

  double get completionRate => day.totalExercises <= 0
      ? 0
      : day.completedExercises / math.max(day.totalExercises, 1);
}

class WeekRecommendation {
  const WeekRecommendation({
    required this.tone,
    required this.type,
    this.percent,
    this.rpe,
    this.count,
  });

  final WeekRecommendationTone tone;
  final WeekRecommendationType type;
  final int? percent;
  final double? rpe;
  final int? count;
}

class MuscleFocusPoint {
  const MuscleFocusPoint({
    required this.muscleGroup,
    required this.totalVolume,
    required this.percentOfTotal,
  });

  final String muscleGroup;
  final double totalVolume;
  final double percentOfTotal;
}

List<WeekRecommendation> _buildRecommendations(WeekAnalysis analysis) {
  final items = <WeekRecommendation>[];
  final completionPercent = (analysis.completionRate * 100).round();
  final volumePercent = (analysis.volumeRate * 100).round();

  if (analysis.completionRate < 0.6 && analysis.totalDays > 0) {
    items.add(
      WeekRecommendation(
        tone: WeekRecommendationTone.danger,
        type: WeekRecommendationType.lowCompletion,
        percent: completionPercent,
      ),
    );
  }

  if (analysis.plannedVolume > 0 && analysis.volumeRate < 0.75) {
    items.add(
      WeekRecommendation(
        tone: WeekRecommendationTone.warning,
        type: WeekRecommendationType.lowVolume,
        percent: volumePercent,
      ),
    );
  }

  final averageRpe = analysis.averageRpe;
  if (averageRpe != null && averageRpe >= 9) {
    items.add(
      WeekRecommendation(
        tone: WeekRecommendationTone.warning,
        type: WeekRecommendationType.highEffort,
        rpe: averageRpe,
      ),
    );
  }

  if (analysis.missedDays > 0) {
    items.add(
      WeekRecommendation(
        tone: WeekRecommendationTone.danger,
        type: WeekRecommendationType.missedDays,
        count: analysis.missedDays,
      ),
    );
  }

  if (items.isEmpty) {
    items.add(
      const WeekRecommendation(
        tone: WeekRecommendationTone.info,
        type: WeekRecommendationType.onTrack,
      ),
    );
  }

  return items;
}

double _plannedVolume(Exercise exercise) {
  if (exercise.sets.isEmpty) {
    return (exercise.plannedWeight ?? 0) *
        exercise.plannedReps *
        exercise.plannedSets;
  }
  return exercise.sets.fold<double>(0, (sum, set) {
    return sum +
        (set.plannedWeight ?? exercise.plannedWeight ?? 0) * set.plannedReps;
  });
}

double _actualVolume(Exercise exercise) {
  if (exercise.sets.isEmpty) {
    return exercise.isCompleted ? _plannedVolume(exercise) : 0;
  }
  return exercise.sets.where((set) => set.isCompleted).fold<double>(0, (
    sum,
    set,
  ) {
    final weight =
        set.actualWeight ?? set.plannedWeight ?? exercise.plannedWeight ?? 0;
    final reps = set.actualReps ?? set.plannedReps;
    return sum + weight * reps;
  });
}

List<MuscleFocusPoint> _buildMuscleFocus(List<Exercise> exercises) {
  final volumes = <String, double>{};
  for (final exercise in exercises) {
    final groups = <String>{
      if (exercise.primaryMuscleGroup.trim().isNotEmpty)
        exercise.primaryMuscleGroup.trim(),
      for (final group in exercise.secondaryMuscleGroups)
        if (group.trim().isNotEmpty) group.trim(),
    }.toList();
    if (groups.isEmpty) continue;

    final volume = _plannedVolume(exercise);
    if (volume <= 0) continue;
    final share = volume / groups.length;
    for (final group in groups) {
      volumes[group] = (volumes[group] ?? 0) + share;
    }
  }

  final total = volumes.values.fold<double>(0, (sum, value) => sum + value);
  if (total <= 0) return const [];

  final points = [
    for (final entry in volumes.entries)
      MuscleFocusPoint(
        muscleGroup: entry.key,
        totalVolume: entry.value,
        percentOfTotal: entry.value / total * 100,
      ),
  ]..sort((a, b) => b.totalVolume.compareTo(a.totalVolume));

  return points;
}

double? _averageRpe(List<Exercise> exercises) {
  final values = [
    for (final exercise in exercises)
      for (final set in exercise.sets)
        if (set.rpe != null) set.rpe!,
  ];
  if (values.isEmpty) return null;
  return values.reduce((a, b) => a + b) / values.length;
}

int _estimatedCalories(int durationSeconds) =>
    estimateTrainingCalories(Duration(seconds: durationSeconds));

int _durationSeconds(Exercise exercise) {
  final explicit = exercise.durationSeconds;
  if (explicit != null && explicit > 0) return explicit;
  final started = exercise.startedAtUtc;
  final ended = exercise.endedAtUtc;
  if (started != null && ended != null && ended.isAfter(started)) {
    return ended.difference(started).inSeconds;
  }
  return 0;
}
