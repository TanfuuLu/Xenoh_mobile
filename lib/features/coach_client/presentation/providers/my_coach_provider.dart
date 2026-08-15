import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../shared_api/xenoh_api.dart';

final myCoachProvider = FutureProvider.autoDispose<JsonMap?>((ref) {
  return ref
      .watch(xenohApiProvider)
      .getNullableObject('/coach-client/my-coach');
});

/// Full coach profile enrichment available during an active relationship.
final coachProfileProvider = FutureProvider.autoDispose.family<JsonMap, String>(
  (ref, coachId) {
    return ref.watch(xenohApiProvider).getObject('/users/$coachId');
  },
);
