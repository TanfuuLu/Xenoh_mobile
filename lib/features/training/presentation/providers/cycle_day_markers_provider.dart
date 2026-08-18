import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/utils/date_only.dart';
import '../../../shared_api/xenoh_api.dart';

/// Inclusive date-range key for [cycleDayMarkersProvider].
typedef CycleDayMarkersRange = ({DateTime from, DateTime to});

/// "Menstrual" / "PreMenstrual" markers for each day in the requested range,
/// keyed by `yyyy-MM-dd` (`GET /cycle/day-markers`) — used to overlay cycle
/// awareness onto the week's day list, mirroring the web app's
/// `useCycleDayMarkers`.
///
/// Female-only on the backend (`CycleGuard.EnsureFemaleAsync` throws
/// otherwise) — callers must gate on the user's gender before watching this,
/// the same way `home_shell.dart` gates the Cycle tab.
final cycleDayMarkersProvider = FutureProvider.autoDispose
    .family<Map<String, String>, CycleDayMarkersRange>((ref, range) async {
      ref.syncOn(const [DataTopic.cycle]);
      final json = await ref
          .watch(xenohApiProvider)
          .getObject(
            '/cycle/day-markers'
            '?from=${DateOnly.format(range.from)}&to=${DateOnly.format(range.to)}',
          );
      final days = json['days'];
      if (days is! List) return const {};
      return {
        for (final day in days.whereType<JsonMap>())
          textOf(day, ['date']): textOf(day, ['marker']),
      };
    });
