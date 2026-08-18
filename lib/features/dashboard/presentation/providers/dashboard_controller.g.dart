// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dashboard_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(DashboardController)
final dashboardControllerProvider = DashboardControllerProvider._();

final class DashboardControllerProvider
    extends $AsyncNotifierProvider<DashboardController, PersonalDashboard> {
  DashboardControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dashboardControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dashboardControllerHash();

  @$internal
  @override
  DashboardController create() => DashboardController();
}

String _$dashboardControllerHash() =>
    r'eed926b58de748e711f5c427e4b8bfe1cf2df9bc';

abstract class _$DashboardController extends $AsyncNotifier<PersonalDashboard> {
  FutureOr<PersonalDashboard> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref =
        this.ref as $Ref<AsyncValue<PersonalDashboard>, PersonalDashboard>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<PersonalDashboard>, PersonalDashboard>,
              AsyncValue<PersonalDashboard>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
