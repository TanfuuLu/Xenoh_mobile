import 'package:dio/dio.dart';

import '../../../../core/error/api_exception.dart';
import '../../domain/entities/food.dart';
import '../../domain/entities/food_log.dart';
import '../../domain/entities/meal_plan.dart';
import '../../domain/entities/nutrition_summary.dart';
import '../../domain/repositories/nutrition_repository.dart';
import '../datasources/nutrition_remote_data_source.dart';

class NutritionRepositoryImpl implements NutritionRepository {
  NutritionRepositoryImpl(this._remote);

  final NutritionRemoteDataSource _remote;

  @override
  Future<NutritionSummary> getSummary() async {
    try {
      final dto = await _remote.getSummary();
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<NutritionProfile> updateProfile({
    required String activityLevel,
    required String goal,
    double? targetWeightKg,
    int? customCalorieTarget,
    double? proteinPerKg,
    double? fatPerKg,
  }) async {
    try {
      final dto = await _remote.updateProfile(
        activityLevel: activityLevel,
        goal: goal,
        targetWeightKg: targetWeightKg,
        customCalorieTarget: customCalorieTarget,
        proteinPerKg: proteinPerKg,
        fatPerKg: fatPerKg,
      );
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<List<FoodItem>> searchFoods({
    required String query,
    String lang = 'vi',
  }) async {
    if (query.trim().isEmpty) return const [];
    try {
      final dtos = await _remote.searchFoods(query: query.trim(), lang: lang);
      return dtos.map((e) => e.toEntity()).toList();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<FoodItem> resolveFood({
    required String name,
    String lang = 'en',
  }) async {
    try {
      final dto = await _remote.resolveFood(name: name.trim(), lang: lang);
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<FoodItem> createCustomFood({
    required String nameVi,
    required String nameEn,
    required double caloriesPer100g,
    required double proteinPer100g,
    required double carbsPer100g,
    required double fatPer100g,
    String? defaultServingLabel,
    double? defaultServingGrams,
  }) async {
    try {
      final dto = await _remote.createCustomFood(
        nameVi: nameVi,
        nameEn: nameEn,
        caloriesPer100g: caloriesPer100g,
        proteinPer100g: proteinPer100g,
        carbsPer100g: carbsPer100g,
        fatPer100g: fatPer100g,
        defaultServingLabel: defaultServingLabel,
        defaultServingGrams: defaultServingGrams,
      );
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<FoodLogsForDate> getFoodLogs(DateTime date) async {
    try {
      final dto = await _remote.getFoodLogs(date);
      return dto.toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> addFoodLog({
    required DateTime date,
    required String foodItemId,
    double? grams,
    String? servingLabel,
    double? servingCount,
  }) async {
    try {
      await _remote.addFoodLog(
        date: date,
        foodItemId: foodItemId,
        grams: grams,
        servingLabel: servingLabel,
        servingCount: servingCount,
      );
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<void> deleteFoodLog({
    required DateTime date,
    required String foodLogId,
  }) async {
    try {
      await _remote.deleteFoodLog(date: date, foodLogId: foodLogId);
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<MealPlanDay> getMealPlan(DateTime date) async {
    try {
      return (await _remote.getMealPlan(date)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<MealPlanDay> upsertMealPlan({
    required DateTime date,
    required List<Map<String, dynamic>> meals,
    String? notes,
  }) async {
    try {
      return (await _remote.upsertMealPlan(
        date: date,
        meals: meals,
        notes: notes,
      )).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<MealPlanDay> checkMealPlanItem(String itemId) async {
    try {
      return (await _remote.checkMealPlanItem(itemId)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }

  @override
  Future<MealPlanDay> uncheckMealPlanItem(String itemId) async {
    try {
      return (await _remote.uncheckMealPlanItem(itemId)).toEntity();
    } on DioException catch (e) {
      throw failureFromDio(e);
    }
  }
}
