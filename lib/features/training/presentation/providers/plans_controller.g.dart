// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'plans_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Paginated list of the user's plans (with create / activate / delete).

@ProviderFor(PlansController)
final plansControllerProvider = PlansControllerProvider._();

/// Paginated list of the user's plans (with create / activate / delete).
final class PlansControllerProvider
    extends $AsyncNotifierProvider<PlansController, List<Plan>> {
  /// Paginated list of the user's plans (with create / activate / delete).
  PlansControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'plansControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$plansControllerHash();

  @$internal
  @override
  PlansController create() => PlansController();
}

String _$plansControllerHash() => r'067f5ab0644aecc4ee4d25eb40437c2af462a737';

/// Paginated list of the user's plans (with create / activate / delete).

abstract class _$PlansController extends $AsyncNotifier<List<Plan>> {
  FutureOr<List<Plan>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Plan>>, List<Plan>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Plan>>, List<Plan>>,
              AsyncValue<List<Plan>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
