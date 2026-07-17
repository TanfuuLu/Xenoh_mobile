// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The signed-in user's full profile (`GET /users/me`).

@ProviderFor(MyProfileController)
final myProfileControllerProvider = MyProfileControllerProvider._();

/// The signed-in user's full profile (`GET /users/me`).
final class MyProfileControllerProvider
    extends $AsyncNotifierProvider<MyProfileController, UserProfile> {
  /// The signed-in user's full profile (`GET /users/me`).
  MyProfileControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'myProfileControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$myProfileControllerHash();

  @$internal
  @override
  MyProfileController create() => MyProfileController();
}

String _$myProfileControllerHash() =>
    r'77fef984e16b5f1d9a49b15179b4e8eda1994505';

/// The signed-in user's full profile (`GET /users/me`).

abstract class _$MyProfileController extends $AsyncNotifier<UserProfile> {
  FutureOr<UserProfile> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<UserProfile>, UserProfile>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<UserProfile>, UserProfile>,
              AsyncValue<UserProfile>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

/// Bodyweight history (oldest → newest) for the profile chart.

@ProviderFor(bodyweightHistory)
final bodyweightHistoryProvider = BodyweightHistoryProvider._();

/// Bodyweight history (oldest → newest) for the profile chart.

final class BodyweightHistoryProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<BodyweightLog>>,
          List<BodyweightLog>,
          FutureOr<List<BodyweightLog>>
        >
    with
        $FutureModifier<List<BodyweightLog>>,
        $FutureProvider<List<BodyweightLog>> {
  /// Bodyweight history (oldest → newest) for the profile chart.
  BodyweightHistoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'bodyweightHistoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$bodyweightHistoryHash();

  @$internal
  @override
  $FutureProviderElement<List<BodyweightLog>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<BodyweightLog>> create(Ref ref) {
    return bodyweightHistory(ref);
  }
}

String _$bodyweightHistoryHash() => r'ff3d25d6ec61f570a7d183fc099397a68009cec5';

/// Monthly training activity (calendar + totals), keyed by year/month.

@ProviderFor(trainingActivity)
final trainingActivityProvider = TrainingActivityFamily._();

/// Monthly training activity (calendar + totals), keyed by year/month.

final class TrainingActivityProvider
    extends
        $FunctionalProvider<
          AsyncValue<TrainingActivity>,
          TrainingActivity,
          FutureOr<TrainingActivity>
        >
    with $FutureModifier<TrainingActivity>, $FutureProvider<TrainingActivity> {
  /// Monthly training activity (calendar + totals), keyed by year/month.
  TrainingActivityProvider._({
    required TrainingActivityFamily super.from,
    required ({int year, int month}) super.argument,
  }) : super(
         retry: null,
         name: r'trainingActivityProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$trainingActivityHash();

  @override
  String toString() {
    return r'trainingActivityProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<TrainingActivity> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<TrainingActivity> create(Ref ref) {
    final argument = this.argument as ({int year, int month});
    return trainingActivity(ref, year: argument.year, month: argument.month);
  }

  @override
  bool operator ==(Object other) {
    return other is TrainingActivityProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$trainingActivityHash() => r'37126ad901a446fb1ff08c84c5d378c66ef809fb';

/// Monthly training activity (calendar + totals), keyed by year/month.

final class TrainingActivityFamily extends $Family
    with
        $FunctionalFamilyOverride<
          FutureOr<TrainingActivity>,
          ({int year, int month})
        > {
  TrainingActivityFamily._()
    : super(
        retry: null,
        name: r'trainingActivityProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  /// Monthly training activity (calendar + totals), keyed by year/month.

  TrainingActivityProvider call({required int year, required int month}) =>
      TrainingActivityProvider._(
        argument: (year: year, month: month),
        from: this,
      );

  @override
  String toString() => r'trainingActivityProvider';
}
