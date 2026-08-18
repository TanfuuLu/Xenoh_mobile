import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../domain/entities/plan.dart';

/// Plans a coach has created for a single client.
class CoachClientPlanGroup {
  const CoachClientPlanGroup({
    required this.clientId,
    required this.clientName,
    required this.plans,
  });

  final String clientId;
  final String clientName;
  final List<Plan> plans;
}

/// Plans the signed-in coach has created for their clients, grouped by client.
///
/// Sourced from `/plans/coach-overview` (the same endpoint the client-detail
/// screen reads) and parsed defensively so a shape change can't crash the
/// Plans screen.
final coachClientPlansProvider =
    FutureProvider.autoDispose<List<CoachClientPlanGroup>>((ref) async {
      ref.syncOn(const [DataTopic.training, DataTopic.coaching]);
      final api = ref.watch(xenohApiProvider);
      final l10n = lookupAppLocalizations(
        ref.watch(appLocaleProvider) ?? const Locale('en'),
      );
      final raw = await api.getList(
        '/plans/coach-overview?pageNumber=1&pageSize=100',
      );
      return _groupByClient(raw, l10n);
    });

List<CoachClientPlanGroup> _groupByClient(
  List<JsonMap> raw,
  AppLocalizations l10n,
) {
  final byClient = <String, List<Plan>>{};
  final names = <String, String>{};

  for (final json in raw) {
    final plan = _planFromJson(json, l10n);
    if (plan == null) continue;
    final clientId = _clientIdOf(json);
    final clientName = optionalTextOf(json, [
      'ownerName',
      'clientName',
      'userName',
      'fullName',
    ]);
    final key = clientId.isNotEmpty ? clientId : (clientName ?? plan.ownerName);
    byClient.putIfAbsent(key, () => []).add(plan);
    names[key] = clientName ?? plan.ownerName;
  }

  final groups =
      byClient.entries.map((entry) {
        final plans = entry.value
          ..sort((a, b) {
            if (a.isActive != b.isActive) return a.isActive ? -1 : 1;
            return a.name.toLowerCase().compareTo(b.name.toLowerCase());
          });
        return CoachClientPlanGroup(
          clientId: entry.key,
          clientName: names[entry.key] ?? l10n.coachClientDefaultName,
          plans: plans,
        );
      }).toList()..sort((a, b) {
        return a.clientName.toLowerCase().compareTo(b.clientName.toLowerCase());
      });

  return groups;
}

String _clientIdOf(JsonMap json) {
  return textOf(json, [
    'ownerId',
    'clientId',
    'userId',
    'ownerUserId',
  ], fallback: '');
}

/// Builds a [Plan] from a coach-overview row, tolerating missing fields.
Plan? _planFromJson(JsonMap json, AppLocalizations l10n) {
  final id = textOf(json, ['id', 'planId'], fallback: '');
  if (id.isEmpty) return null;

  return Plan(
    id: id,
    name: textOf(json, [
      'name',
      'planName',
      'activePlanName',
      'title',
    ], fallback: l10n.trainingPlanDefaultName),
    startDate: _date(json, ['startDate', 'planStartDate']),
    endDate: _date(json, ['endDate', 'planEndDate']),
    planType: textOf(json, ['planType', 'type'], fallback: 'Coach'),
    ownerName: textOf(json, [
      'ownerName',
      'clientName',
      'userName',
      'fullName',
    ], fallback: l10n.coachClientDefaultName),
    totalWeeks: _int(json, ['totalWeeks', 'durationWeeks', 'weeks']),
    completedWeeks: _int(json, ['completedWeeks']),
    totalDays: _int(json, ['totalDays']),
    completedDays: _int(json, ['completedDays']),
    isActive: _bool(json, ['isActive', 'active']) || _statusActive(json),
    coachName: optionalTextOf(json, ['coachName']),
  );
}

DateTime _date(JsonMap json, List<String> keys) {
  final value = optionalTextOf(json, keys);
  if (value == null) return DateTime.now();
  try {
    return DateOnly.tryParse(value) ?? DateTime.now();
  } on FormatException {
    return DateTime.now();
  }
}

int _int(JsonMap json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is num) return value.toInt();
    if (value is String) {
      final parsed = int.tryParse(value.trim());
      if (parsed != null) return parsed;
    }
  }
  return 0;
}

bool _bool(JsonMap json, List<String> keys) {
  for (final key in keys) {
    final value = json[key];
    if (value is bool) return value;
    if (value is String && value.toLowerCase() == 'true') return true;
  }
  return false;
}

bool _statusActive(JsonMap json) {
  return textOf(json, ['status'], fallback: '').toLowerCase() == 'active';
}
