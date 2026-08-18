import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../shared_api/xenoh_api.dart';

final myCoachProvider = FutureProvider.autoDispose<JsonMap?>((ref) {
  ref.syncOn(const [DataTopic.coaching]);
  return ref
      .watch(xenohApiProvider)
      .getNullableObject('/coach-client/my-coach');
});

/// Full coach profile enrichment available during an active relationship.
final coachProfileProvider = FutureProvider.autoDispose.family<JsonMap, String>(
  (ref, coachId) {
    ref.syncOn(const [DataTopic.coaching]);
    return ref.watch(xenohApiProvider).getObject('/users/$coachId');
  },
);
