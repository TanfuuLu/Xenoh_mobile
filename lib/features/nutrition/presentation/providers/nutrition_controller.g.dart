// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Nutrition summary: profile, calculated targets, and today's log.

@ProviderFor(NutritionController)
final nutritionControllerProvider = NutritionControllerProvider._();

/// Nutrition summary: profile, calculated targets, and today's log.
final class NutritionControllerProvider
    extends $AsyncNotifierProvider<NutritionController, NutritionSummary> {
  /// Nutrition summary: profile, calculated targets, and today's log.
  NutritionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionControllerHash();

  @$internal
  @override
  NutritionController create() => NutritionController();
}

String _$nutritionControllerHash() =>
    r'6f113b853e3c655df3c4a3a804987adf2934e4fb';

/// Nutrition summary: profile, calculated targets, and today's log.

abstract class _$NutritionController extends $AsyncNotifier<NutritionSummary> {
  FutureOr<NutritionSummary> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<NutritionSummary>, NutritionSummary>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<NutritionSummary>, NutritionSummary>,
              AsyncValue<NutritionSummary>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Logged foods + totals for a date (today by default), keyed by `yyyy-MM-dd`.

@ProviderFor(foodLogs)
final foodLogsProvider = FoodLogsFamily._();

/// Logged foods + totals for a date (today by default), keyed by `yyyy-MM-dd`.

final class FoodLogsProvider
    extends
        $FunctionalProvider<
          AsyncValue<FoodLogsForDate>,
          FoodLogsForDate,
          FutureOr<FoodLogsForDate>
        >
    with $FutureModifier<FoodLogsForDate>, $FutureProvider<FoodLogsForDate> {
  /// Logged foods + totals for a date (today by default), keyed by `yyyy-MM-dd`.
  FoodLogsProvider._({
    required FoodLogsFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'foodLogsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$foodLogsHash();

  @override
  String toString() {
    return r'foodLogsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<FoodLogsForDate> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<FoodLogsForDate> create(Ref ref) {
    final argument = this.argument as DateTime;
    return foodLogs(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodLogsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$foodLogsHash() => r'65f00713cbf75bd4edadfba5017340379e655f84';

/// Logged foods + totals for a date (today by default), keyed by `yyyy-MM-dd`.

final class FoodLogsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<FoodLogsForDate>, DateTime> {
  FoodLogsFamily._()
    : super(
        retry: null,
        name: r'foodLogsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Logged foods + totals for a date (today by default), keyed by `yyyy-MM-dd`.

  FoodLogsProvider call(DateTime date) =>
      FoodLogsProvider._(argument: date, from: this);

  @override
  String toString() => r'foodLogsProvider';
}

/// Food-database search results for [query] (empty for short queries).

@ProviderFor(foodSearch)
final foodSearchProvider = FoodSearchFamily._();

/// Food-database search results for [query] (empty for short queries).

final class FoodSearchProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FoodItem>>,
          List<FoodItem>,
          FutureOr<List<FoodItem>>
        >
    with $FutureModifier<List<FoodItem>>, $FutureProvider<List<FoodItem>> {
  /// Food-database search results for [query] (empty for short queries).
  FoodSearchProvider._({
    required FoodSearchFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'foodSearchProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$foodSearchHash();

  @override
  String toString() {
    return r'foodSearchProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<FoodItem>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FoodItem>> create(Ref ref) {
    final argument = this.argument as String;
    return foodSearch(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodSearchProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$foodSearchHash() => r'fb325de0684022cfc75aa74c8cd0387c082fc839';

/// Food-database search results for [query] (empty for short queries).

final class FoodSearchFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<FoodItem>>, String> {
  FoodSearchFamily._()
    : super(
        retry: null,
        name: r'foodSearchProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Food-database search results for [query] (empty for short queries).

  FoodSearchProvider call(String query) =>
      FoodSearchProvider._(argument: query, from: this);

  @override
  String toString() => r'foodSearchProvider';
}

@ProviderFor(mealPlan)
final mealPlanProvider = MealPlanFamily._();

final class MealPlanProvider
    extends
        $FunctionalProvider<
          AsyncValue<MealPlanDay>,
          MealPlanDay,
          FutureOr<MealPlanDay>
        >
    with $FutureModifier<MealPlanDay>, $FutureProvider<MealPlanDay> {
  MealPlanProvider._({
    required MealPlanFamily super.from,
    required DateTime super.argument,
  }) : super(
         retry: null,
         name: r'mealPlanProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$mealPlanHash();

  @override
  String toString() {
    return r'mealPlanProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<MealPlanDay> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<MealPlanDay> create(Ref ref) {
    final argument = this.argument as DateTime;
    return mealPlan(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is MealPlanProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$mealPlanHash() => r'a9535007cb6f6b4a4bdc76ebaf32c9b3e4fc9080';

final class MealPlanFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<MealPlanDay>, DateTime> {
  MealPlanFamily._()
    : super(
        retry: null,
        name: r'mealPlanProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  MealPlanProvider call(DateTime date) =>
      MealPlanProvider._(argument: date, from: this);

  @override
  String toString() => r'mealPlanProvider';
}

@ProviderFor(MealPlanActionController)
final mealPlanActionControllerProvider = MealPlanActionControllerProvider._();

final class MealPlanActionControllerProvider
    extends $AsyncNotifierProvider<MealPlanActionController, void> {
  MealPlanActionControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'mealPlanActionControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$mealPlanActionControllerHash();

  @$internal
  @override
  MealPlanActionController create() => MealPlanActionController();
}

String _$mealPlanActionControllerHash() =>
    r'313397c4e835139b9e4585dc03e59459b385358c';

abstract class _$MealPlanActionController extends $AsyncNotifier<void> {
  FutureOr<void> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<void>, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<void>, void>,
              AsyncValue<void>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
