// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'progress_controllers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current personal records across all exercises. Refresh by invalidating.

@ProviderFor(exercisePrs)
final exercisePrsProvider = ExercisePrsProvider._();

/// Current personal records across all exercises. Refresh by invalidating.

final class ExercisePrsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExercisePr>>,
          List<ExercisePr>,
          FutureOr<List<ExercisePr>>
        >
    with $FutureModifier<List<ExercisePr>>, $FutureProvider<List<ExercisePr>> {
  /// Current personal records across all exercises. Refresh by invalidating.
  ExercisePrsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'exercisePrsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$exercisePrsHash();

  @$internal
  @override
  $FutureProviderElement<List<ExercisePr>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExercisePr>> create(Ref ref) {
    return exercisePrs(ref);
  }
}

String _$exercisePrsHash() => r'4f477823b80f9bec8e19dca0da92b10476835303';

/// PR progression for one exercise template (oldest → newest).

@ProviderFor(exercisePrHistory)
final exercisePrHistoryProvider = ExercisePrHistoryFamily._();

/// PR progression for one exercise template (oldest → newest).

final class ExercisePrHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<ExercisePrPoint>>,
          List<ExercisePrPoint>,
          FutureOr<List<ExercisePrPoint>>
        >
    with
        $FutureModifier<List<ExercisePrPoint>>,
        $FutureProvider<List<ExercisePrPoint>> {
  /// PR progression for one exercise template (oldest → newest).
  ExercisePrHistoryProvider._({
    required ExercisePrHistoryFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'exercisePrHistoryProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$exercisePrHistoryHash();

  @override
  String toString() {
    return r'exercisePrHistoryProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<ExercisePrPoint>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<ExercisePrPoint>> create(Ref ref) {
    final argument = this.argument as String;
    return exercisePrHistory(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is ExercisePrHistoryProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$exercisePrHistoryHash() => r'8539d3c4484b0a34b731cd0727e72e77148b5749';

/// PR progression for one exercise template (oldest → newest).

final class ExercisePrHistoryFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<ExercisePrPoint>>, String> {
  ExercisePrHistoryFamily._()
    : super(
        retry: null,
        name: r'exercisePrHistoryProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// PR progression for one exercise template (oldest → newest).

  ExercisePrHistoryProvider call(String exerciseTemplateId) =>
      ExercisePrHistoryProvider._(argument: exerciseTemplateId, from: this);

  @override
  String toString() => r'exercisePrHistoryProvider';
}

/// Pro-gated analytics for one plan. Emits `ForbiddenFailure` for non-Pro.

@ProviderFor(planAnalytics)
final planAnalyticsProvider = PlanAnalyticsFamily._();

/// Pro-gated analytics for one plan. Emits `ForbiddenFailure` for non-Pro.

final class PlanAnalyticsProvider
    extends
        $FunctionalProvider<
          AsyncValue<PlanAnalytics>,
          PlanAnalytics,
          FutureOr<PlanAnalytics>
        >
    with $FutureModifier<PlanAnalytics>, $FutureProvider<PlanAnalytics> {
  /// Pro-gated analytics for one plan. Emits `ForbiddenFailure` for non-Pro.
  PlanAnalyticsProvider._({
    required PlanAnalyticsFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'planAnalyticsProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$planAnalyticsHash();

  @override
  String toString() {
    return r'planAnalyticsProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<PlanAnalytics> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<PlanAnalytics> create(Ref ref) {
    final argument = this.argument as String;
    return planAnalytics(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is PlanAnalyticsProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$planAnalyticsHash() => r'08b9e852b4424a476ce269b269442101e89b94fb';

/// Pro-gated analytics for one plan. Emits `ForbiddenFailure` for non-Pro.

final class PlanAnalyticsFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<PlanAnalytics>, String> {
  PlanAnalyticsFamily._()
    : super(
        retry: null,
        name: r'planAnalyticsProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Pro-gated analytics for one plan. Emits `ForbiddenFailure` for non-Pro.

  PlanAnalyticsProvider call(String planId) =>
      PlanAnalyticsProvider._(argument: planId, from: this);

  @override
  String toString() => r'planAnalyticsProvider';
}
