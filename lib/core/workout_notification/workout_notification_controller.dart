import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../app/router/router.dart';
import '../../features/dashboard/presentation/providers/dashboard_controller.dart';
import '../../features/training/domain/entities/exercise.dart';
import '../../features/training/presentation/providers/exercises_controller.dart';
import 'workout_notification_service.dart';

part 'workout_notification_controller.g.dart';

/// Keeps the Android ongoing "current exercise" notification in sync with
/// today's workout. Watching this from HomeShell (once, for the whole
/// authenticated session) is enough — since it derives "current exercise"
/// straight from live provider state, completing a set naturally advances the
/// notification to the next exercise the same way the (removed) dashboard
/// card used to, with no separate "advance" logic. Also relays a tap on the
/// notification (reported by the background isolate) into opening that
/// workout day.
@Riverpod(keepAlive: true)
class WorkoutNotificationController extends _$WorkoutNotificationController {
  String? _dismissedWorkoutId;

  @override
  void build() {
    WorkoutNotificationService.addNotificationTapListener(
      _onNotificationTapped,
    );
    WorkoutNotificationService.addNotificationDismissListener(
      _onNotificationDismissed,
    );

    final dashboard = ref.watch(dashboardControllerProvider);
    final workout = dashboard.value?.todayWorkout;
    debugPrint(
      '[WorkoutNotification] dashboard hasValue=${dashboard.hasValue} '
      'hasError=${dashboard.hasError} error=${dashboard.error} '
      'todayWorkout=${workout?.id} isCompleted=${workout?.isCompleted}',
    );
    if (workout == null || workout.isCompleted) {
      unawaited(WorkoutNotificationService.stop());
      return;
    }

    if (_dismissedWorkoutId != null && _dismissedWorkoutId != workout.id) {
      _dismissedWorkoutId = null;
    }
    if (_dismissedWorkoutId == workout.id) {
      unawaited(WorkoutNotificationService.stop());
      return;
    }

    final exercisesValue = ref.watch(exercisesControllerProvider(workout.id));
    final exercises = exercisesValue.value;
    debugPrint(
      '[WorkoutNotification] exercises hasValue=${exercisesValue.hasValue} '
      'hasError=${exercisesValue.hasError} error=${exercisesValue.error} '
      'count=${exercises?.length}',
    );
    if (exercises == null) {
      return; // still loading — leave any existing notification as-is.
    }

    final sorted = [...exercises]
      ..sort((a, b) => a.sortOrder.compareTo(b.sortOrder));
    Exercise? current;
    for (final exercise in sorted) {
      if (!exercise.isCompleted) {
        current = exercise;
        break;
      }
    }
    debugPrint(
      '[WorkoutNotification] current exercise: ${current?.name} '
      '(${current?.completedSetsCount}/${current?.plannedSets} sets)',
    );

    if (current == null) {
      unawaited(WorkoutNotificationService.stop());
      return;
    }

    final setInfo = buildWorkoutNotificationSetInfo(
      completedSets: current.completedSetsCount,
      plannedSets: current.plannedSets,
      plannedReps: current.plannedReps,
      plannedWeight: current.plannedWeight,
    );

    unawaited(
      WorkoutNotificationService.showOrUpdate(
        title: current.name,
        setInfo: setInfo,
        timerStartedAtUtc: current.isTimerRunning ? current.startedAtUtc : null,
        dailyWorkoutId: workout.id,
        imageUrl: current.imageUrl,
      ),
    );
  }

  void _onNotificationTapped(String dailyWorkoutId) {
    debugPrint(
      '[WorkoutNotification] notification tapped, opening day $dailyWorkoutId',
    );
    unawaited(ref.read(routerProvider).push('/days/$dailyWorkoutId'));
  }

  void _onNotificationDismissed(String dailyWorkoutId) {
    debugPrint(
      '[WorkoutNotification] notification dismissed for $dailyWorkoutId',
    );
    _dismissedWorkoutId = dailyWorkoutId;
  }
}

@visibleForTesting
String buildWorkoutNotificationSetInfo({
  required int completedSets,
  required int plannedSets,
  required int plannedReps,
  double? plannedWeight,
}) {
  final currentSet = (completedSets + 1).clamp(1, plannedSets);
  final weight = plannedWeight == null
      ? ''
      : ' • ${_compactWeight(plannedWeight)} kg';
  return 'Set $currentSet of $plannedSets • $plannedReps reps$weight';
}

/// Drops a trailing `.0` for whole numbers (e.g. `60.0` → `60`).
String _compactWeight(double v) =>
    v == v.roundToDouble() ? v.toStringAsFixed(0) : v.toStringAsFixed(1);
