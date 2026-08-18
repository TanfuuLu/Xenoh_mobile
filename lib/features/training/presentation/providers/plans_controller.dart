import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../data/repositories/training_repository_provider.dart';
import '../../domain/entities/plan.dart';

part 'plans_controller.g.dart';

/// Paginated list of the user's plans (with create / activate / delete).
@riverpod
class PlansController extends _$PlansController {
  static const _pageSize = 20;

  int _page = 1;
  bool _hasMore = false;

  bool get hasMore => _hasMore;

  @override
  Future<List<Plan>> build() async {
    ref.syncOn(const [DataTopic.training]);
    _page = 1;
    final result = await ref
        .watch(trainingRepositoryProvider)
        .getPlans(pageNumber: _page, pageSize: _pageSize);
    _hasMore = result.hasMore;
    return result.items;
  }

  Future<void> refresh() async {
    state = await AsyncValue.guard(() async {
      _page = 1;
      final result = await ref
          .read(trainingRepositoryProvider)
          .getPlans(pageNumber: _page, pageSize: _pageSize);
      _hasMore = result.hasMore;
      return result.items;
    });
  }

  Future<void> loadMore() async {
    if (!_hasMore) return;
    final current = state.value ?? const [];
    final next = await ref
        .read(trainingRepositoryProvider)
        .getPlans(pageNumber: _page + 1, pageSize: _pageSize);
    _page += 1;
    _hasMore = next.hasMore;
    state = AsyncValue.data([...current, ...next.items]);
  }

  Future<Plan> createPlan({
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final plan = await ref
        .read(trainingRepositoryProvider)
        .createPlan(
          name: name,
          startDate: startDate,
          endDate: endDate,
        );
    return plan;
  }

  Future<Plan> updatePlan({
    required String planId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final plan = await ref
        .read(trainingRepositoryProvider)
        .updatePlan(
          planId: planId,
          name: name,
          startDate: startDate,
          endDate: endDate,
        );
    return plan;
  }

  Future<void> deletePlan(String planId) async {
    await ref.read(trainingRepositoryProvider).deletePlan(planId);
  }

  Future<void> activate(String planId) async {
    await ref.read(trainingRepositoryProvider).activatePlan(planId);
  }

  Future<void> deactivate(String planId) async {
    await ref.read(trainingRepositoryProvider).deactivatePlan(planId);
  }

  Future<Plan> duplicatePlan({
    required String sourcePlanId,
    required String name,
    required DateTime startDate,
    required DateTime endDate,
  }) async {
    final plan = await ref
        .read(trainingRepositoryProvider)
        .duplicatePlan(
          sourcePlanId: sourcePlanId,
          name: name,
          startDate: startDate,
          endDate: endDate,
        );
    return plan;
  }
}
