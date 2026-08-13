import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../data/repositories/nutrition_repository_provider.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/nutrition_summary.dart';

part 'nutrition_controller.g.dart';

/// Nutrition summary: profile, calculated targets, and today's log.
@riverpod
class NutritionController extends _$NutritionController {
  @override
  Future<NutritionSummary> build() {
    ref.watch(appLocaleProvider);
    return ref.watch(nutritionRepositoryProvider).getSummary();
  }

  Future<void> refresh() async {
    // Keep the current value visible while re-fetching (no blanking); the
    // RefreshIndicator shows its own progress.
    state = await AsyncValue.guard(
      () => ref.read(nutritionRepositoryProvider).getSummary(),
    );
  }
}

/// Logged foods + totals for a date (today by default), keyed by `yyyy-MM-dd`.
@riverpod
Future<FoodLogsForDate> foodLogs(Ref ref, DateTime date) {
  ref.watch(appLocaleProvider);
  return ref.watch(nutritionRepositoryProvider).getFoodLogs(date);
}

typedef NutritionHistoryRange = ({DateTime from, DateTime to});

final nutritionHistoryProvider = FutureProvider.autoDispose
    .family<List<NutritionDailyLog>, NutritionHistoryRange>((ref, range) {
      return ref
          .watch(nutritionRepositoryProvider)
          .getHistory(from: range.from, to: range.to);
    });

/// Food-database search results for [query] (empty for short queries).
@riverpod
Future<List<FoodItem>> foodSearch(Ref ref, String query) {
  if (query.trim().length < 2) return Future.value(const []);
  final lang = ref.watch(appLocaleProvider)?.languageCode ?? 'en';
  return ref
      .watch(nutritionRepositoryProvider)
      .searchFoods(query: query, lang: lang);
}

@riverpod
Future<MealPlanDay> mealPlan(Ref ref, DateTime date) {
  ref.watch(appLocaleProvider);
  return ref.watch(nutritionRepositoryProvider).getMealPlan(date);
}

@riverpod
class MealPlanActionController extends _$MealPlanActionController {
  @override
  FutureOr<void> build() {}

  Future<void> saveDay({
    required DateTime date,
    required List<Map<String, dynamic>> meals,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    final day = _dateOnly(date);
    state = await AsyncValue.guard(() async {
      await ref
          .read(nutritionRepositoryProvider)
          .upsertMealPlan(date: day, meals: meals, notes: notes);
    });
    ref
      ..invalidate(mealPlanProvider(day))
      ..invalidate(nutritionControllerProvider);
  }

  Future<void> saveRange({
    required DateTime startDate,
    required DateTime endDate,
    required List<Map<String, dynamic>> meals,
    String? notes,
  }) async {
    state = const AsyncValue.loading();
    final start = _dateOnly(startDate);
    final end = _dateOnly(endDate);
    state = await AsyncValue.guard(() async {
      await ref
          .read(nutritionRepositoryProvider)
          .applyMealPlanTemplate(
            startDate: start,
            endDate: end,
            meals: meals,
            notes: notes,
          );
    });
    final dayCount = end.difference(start).inDays + 1;
    for (var i = 0; i < dayCount; i++) {
      ref.invalidate(mealPlanProvider(start.add(Duration(days: i))));
    }
    ref.invalidate(nutritionControllerProvider);
  }

  Future<void> setChecked({
    required DateTime date,
    required String itemId,
    required bool checked,
  }) async {
    state = const AsyncValue.loading();
    final repo = ref.read(nutritionRepositoryProvider);
    state = await AsyncValue.guard(() async {
      if (checked) {
        await repo.checkMealPlanItem(itemId);
      } else {
        await repo.uncheckMealPlanItem(itemId);
      }
    });
    ref
      ..invalidate(mealPlanProvider(date))
      ..invalidate(foodLogsProvider(date))
      ..invalidate(nutritionControllerProvider);
  }

  DateTime _dateOnly(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
