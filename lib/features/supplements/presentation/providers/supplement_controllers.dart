import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/utils/date_only.dart';
import '../../data/repositories/supplement_repository_provider.dart';
import '../../domain/entities/supplement_models.dart';

part 'supplement_controllers.g.dart';

typedef SupplementScope = ({String? clientId});
typedef SupplementDateScope = ({DateTime date, String? clientId});
typedef SupplementHistoryScope = ({
  DateTime from,
  DateTime to,
  String? clientId,
});

@riverpod
Future<List<SupplementRegimen>> supplementRegimens(
  Ref ref, {
  String? clientId,
  bool includeArchived = false,
}) => ref
    .watch(supplementRepositoryProvider)
    .getRegimens(
      clientId: clientId,
      includeArchived: includeArchived,
    );

@riverpod
Future<SupplementDaily> supplementDaily(
  Ref ref, {
  required DateTime date,
  String? clientId,
}) => ref
    .watch(supplementRepositoryProvider)
    .getDaily(DateOnly.truncate(date), clientId: clientId);

@riverpod
Future<SupplementHistory> supplementHistory(
  Ref ref, {
  required DateTime from,
  required DateTime to,
  String? clientId,
}) => ref
    .watch(supplementRepositoryProvider)
    .getHistory(from: from, to: to, clientId: clientId);

@riverpod
class SupplementMutationController extends _$SupplementMutationController {
  @override
  FutureOr<void> build() {}

  Future<bool> create(
    SupplementRegimenInput input, {
    String? clientId,
  }) => _run(
    () => ref
        .read(supplementRepositoryProvider)
        .createRegimen(input, clientId: clientId),
  );

  Future<bool> updateRegimen(
    String regimenId,
    SupplementRegimenInput input, {
    String? clientId,
  }) => _run(
    () => ref
        .read(supplementRepositoryProvider)
        .updateRegimen(regimenId, input, clientId: clientId),
  );

  Future<bool> archive(String regimenId, {String? clientId}) => _run(
    () => ref
        .read(supplementRepositoryProvider)
        .archiveRegimen(regimenId, clientId: clientId),
  );

  Future<bool> recordDose({
    required String doseSlotId,
    required DateTime date,
    required SupplementIntakeStatus status,
  }) => _run(
    () => ref
        .read(supplementRepositoryProvider)
        .recordDose(
          doseSlotId: doseSlotId,
          date: date,
          status: status,
        ),
  );

  Future<bool> resetDose({
    required String doseSlotId,
    required DateTime date,
  }) => _run(
    () => ref
        .read(supplementRepositoryProvider)
        .resetDose(doseSlotId: doseSlotId, date: date),
  );

  Future<bool> _run(Future<Object?> Function() action) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(action);
    if (!state.hasError) {
      ref
        ..invalidate(supplementRegimensProvider)
        ..invalidate(supplementDailyProvider)
        ..invalidate(supplementHistoryProvider);
    }
    return !state.hasError;
  }
}
