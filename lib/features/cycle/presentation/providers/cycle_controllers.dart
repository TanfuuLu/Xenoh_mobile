import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../data/repositories/cycle_repository_provider.dart';
import '../../domain/entities/cycle_models.dart';

part 'cycle_controllers.g.dart';

@riverpod
class CycleOverviewController extends _$CycleOverviewController {
  @override
  Future<CycleOverview> build() =>
      ref.watch(cycleRepositoryProvider).getOverview();

  Future<void> refresh() async {
    state = await AsyncValue.guard(
      () => ref.read(cycleRepositoryProvider).getOverview(),
    );
  }
}

@riverpod
Future<List<CycleDailyLog>> cycleLogs(
  Ref ref, {
  required DateTime from,
  required DateTime to,
}) {
  return ref.watch(cycleRepositoryProvider).getLogs(from: from, to: to);
}

@riverpod
Future<CycleSettings> cycleSettings(Ref ref) {
  return ref.watch(cycleRepositoryProvider).getSettings();
}

@riverpod
Future<CycleInsight> cycleInsight(Ref ref, {String lang = 'en'}) {
  return ref.watch(cycleRepositoryProvider).getInsight(lang: lang);
}

@riverpod
class CycleMutationController extends _$CycleMutationController {
  @override
  FutureOr<void> build() {}

  Future<void> upsertLog({
    required DateTime date,
    String? flow,
    List<String>? symptoms,
    String? mood,
    int? energyLevel,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(cycleRepositoryProvider)
          .upsertLog(
            date: date,
            flow: flow,
            symptoms: symptoms,
            mood: mood,
            energyLevel: energyLevel,
            notes: notes,
          ),
    );
    _invalidateCycle();
  }

  Future<void> deleteLog(DateTime date) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref.read(cycleRepositoryProvider).deleteLog(date),
    );
    _invalidateCycle();
  }

  Future<void> updateSettings({
    required bool shareWithCoach,
    int? averageCycleLengthOverride,
    int? averagePeriodLengthOverride,
  }) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(
      () => ref
          .read(cycleRepositoryProvider)
          .updateSettings(
            shareWithCoach: shareWithCoach,
            averageCycleLengthOverride: averageCycleLengthOverride,
            averagePeriodLengthOverride: averagePeriodLengthOverride,
          ),
    );
    _invalidateCycle();
  }

  void _invalidateCycle() {
    ref
      ..invalidate(cycleOverviewControllerProvider)
      ..invalidate(cycleLogsProvider)
      ..invalidate(cycleSettingsProvider)
      ..invalidate(cycleInsightProvider);
  }
}
