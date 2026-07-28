// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'workout_notification_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Keeps the Android ongoing "current exercise" notification in sync with
/// today's workout. Watching this from HomeShell (once, for the whole
/// authenticated session) is enough — since it derives "current exercise"
/// straight from live provider state, completing a set naturally advances the
/// notification to the next exercise the same way the (removed) dashboard
/// card used to, with no separate "advance" logic. Also relays a tap on the
/// notification (reported by the background isolate) into opening that
/// workout day.

@ProviderFor(WorkoutNotificationController)
final workoutNotificationControllerProvider =
    WorkoutNotificationControllerProvider._();

/// Keeps the Android ongoing "current exercise" notification in sync with
/// today's workout. Watching this from HomeShell (once, for the whole
/// authenticated session) is enough — since it derives "current exercise"
/// straight from live provider state, completing a set naturally advances the
/// notification to the next exercise the same way the (removed) dashboard
/// card used to, with no separate "advance" logic. Also relays a tap on the
/// notification (reported by the background isolate) into opening that
/// workout day.
final class WorkoutNotificationControllerProvider
    extends $NotifierProvider<WorkoutNotificationController, void> {
  /// Keeps the Android ongoing "current exercise" notification in sync with
  /// today's workout. Watching this from HomeShell (once, for the whole
  /// authenticated session) is enough — since it derives "current exercise"
  /// straight from live provider state, completing a set naturally advances the
  /// notification to the next exercise the same way the (removed) dashboard
  /// card used to, with no separate "advance" logic. Also relays a tap on the
  /// notification (reported by the background isolate) into opening that
  /// workout day.
  WorkoutNotificationControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'workoutNotificationControllerProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$workoutNotificationControllerHash();

  @$internal
  @override
  WorkoutNotificationController create() => WorkoutNotificationController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(void value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<void>(value),
    );
  }
}

String _$workoutNotificationControllerHash() =>
    r'213ac860cdad75bcbae4d1d0b5443761f64cd54d';

/// Keeps the Android ongoing "current exercise" notification in sync with
/// today's workout. Watching this from HomeShell (once, for the whole
/// authenticated session) is enough — since it derives "current exercise"
/// straight from live provider state, completing a set naturally advances the
/// notification to the next exercise the same way the (removed) dashboard
/// card used to, with no separate "advance" logic. Also relays a tap on the
/// notification (reported by the background isolate) into opening that
/// workout day.

abstract class _$WorkoutNotificationController extends $Notifier<void> {
  void build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<void, void>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<void, void>,
              void,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
