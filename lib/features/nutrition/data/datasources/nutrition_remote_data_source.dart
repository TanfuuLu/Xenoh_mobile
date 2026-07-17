import 'package:dio/dio.dart';

import '../../../../core/utils/date_only.dart';
import '../dtos/food_dto.dart';
import '../dtos/food_log_dto.dart';
import '../dtos/meal_plan_dto.dart';
import '../dtos/nutrition_summary_dto.dart';

/// Thin wrapper over `/nutrition`. Throws [DioException]; the repository maps
/// to domain failures.
class NutritionRemoteDataSource {
  NutritionRemoteDataSource(this._dio);

  final Dio _dio;

  Future<NutritionSummaryDto> getSummary() async {
    final res = await _dio.get<Map<String, dynamic>>('/nutrition/summary');
    return NutritionSummaryDto.fromJson(res.data!);
  }

  /// `PUT /nutrition/profile` — update activity/goal/targets.
  Future<NutritionProfileDto> updateProfile({
    required String activityLevel,
    required String goal,
    double? targetWeightKg,
    int? customCalorieTarget,
    double? proteinPerKg,
    double? fatPerKg,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/nutrition/profile',
      data: {
        'activityLevel': activityLevel,
        'goal': goal,
        'targetWeightKg': ?targetWeightKg,
        'customCalorieTarget': ?customCalorieTarget,
        'proteinPerKg': ?proteinPerKg,
        'fatPerKg': ?fatPerKg,
      },
    );
    return NutritionProfileDto.fromJson(res.data!);
  }

  /// `GET /nutrition/foods/search?q=&lang=`.
  Future<List<FoodItemDto>> searchFoods({
    required String query,
    String lang = 'vi',
  }) async {
    final res = await _dio.get<List<dynamic>>(
      '/nutrition/foods/search',
      queryParameters: {'q': query, 'lang': lang},
    );
    return (res.data ?? const [])
        .map((e) => FoodItemDto.fromJson(e as Map<String, dynamic>))
        .toList();
  }

  /// `GET /nutrition/foods/resolve?name=` — AI macro estimation (Pro, rate:ai).
  Future<FoodItemDto> resolveFood({
    required String name,
    String lang = 'en',
  }) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/nutrition/foods/resolve',
      queryParameters: {'name': name, 'lang': lang},
    );
    return FoodItemDto.fromJson(res.data!);
  }

  /// `POST /nutrition/foods` — create a custom food item.
  Future<FoodItemDto> createCustomFood({
    required String nameVi,
    required String nameEn,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    String? defaultServingLabel,
    double? defaultServingGrams,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/nutrition/foods',
      data: {
        'nameVi': nameVi,
        'nameEn': nameEn,
        'caloriesPer100g': caloriesPer100g,
        'proteinPer100g': proteinPer100g,
        'carbsPer100g': carbsPer100g,
        'fatPer100g': fatPer100g,
        'defaultServingLabel': ?defaultServingLabel,
        'defaultServingGrams': ?defaultServingGrams,
      },
    );
    return FoodItemDto.fromJson(res.data!);
  }

  /// `GET /nutrition/logs/{date}/foods`.
  Future<FoodLogsForDateDto> getFoodLogs(DateTime date) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/nutrition/logs/${DateOnly.format(date)}/foods',
    );
    return FoodLogsForDateDto.fromJson(res.data!);
  }

  /// `POST /nutrition/logs/{date}/foods` — log a food (by grams or serving).
  Future<FoodLogItemDto> addFoodLog({
    required DateTime date,
    required String foodItemId,
    double? grams,
    String? servingLabel,
    double? servingCount,
  }) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/nutrition/logs/${DateOnly.format(date)}/foods',
      data: {
        'foodItemId': foodItemId,
        'grams': ?grams,
        'servingLabel': ?servingLabel,
        'servingCount': ?servingCount,
      },
    );
    return FoodLogItemDto.fromJson(res.data!);
  }

  /// `DELETE /nutrition/logs/{date}/foods/{foodLogId}`.
  Future<void> deleteFoodLog({
    required DateTime date,
    required String foodLogId,
  }) async {
    await _dio.delete<void>(
      '/nutrition/logs/${DateOnly.format(date)}/foods/$foodLogId',
    );
  }

  Future<MealPlanDayDto> getMealPlan(DateTime date) async {
    final res = await _dio.get<Map<String, dynamic>>(
      '/nutrition/meal-plans/${DateOnly.format(date)}',
    );
    return MealPlanDayDto.fromJson(res.data!);
  }

  Future<MealPlanDayDto> upsertMealPlan({
    required DateTime date,
    required List<Map<String, dynamic>> meals,
    String? notes,
  }) async {
    final res = await _dio.put<Map<String, dynamic>>(
      '/nutrition/meal-plans/${DateOnly.format(date)}',
      data: {
        'date': DateOnly.format(date),
        'notes': notes,
        'meals': meals,
      },
    );
    return MealPlanDayDto.fromJson(res.data!);
  }

  Future<MealPlanDayDto> checkMealPlanItem(String itemId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/nutrition/meal-plans/items/$itemId/check',
    );
    return MealPlanDayDto.fromJson(res.data!);
  }

  Future<MealPlanDayDto> uncheckMealPlanItem(String itemId) async {
    final res = await _dio.post<Map<String, dynamic>>(
      '/nutrition/meal-plans/items/$itemId/uncheck',
    );
    return MealPlanDayDto.fromJson(res.data!);
  }
}
