import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data_topic.dart';

part 'data_revision.g.dart';

/// Monotonic counter per [DataTopic], bumped whenever a mutation touching that
/// topic succeeds.
///
/// Providers never read the value — they only `watch` it so Riverpod re-runs
/// them when it changes. Kept alive so the revision survives screens being
/// popped; otherwise a topic bumped while nothing is listening would reset and
/// the next screen would show stale data.
@Riverpod(keepAlive: true)
class DataRevision extends _$DataRevision {
  @override
  int build(DataTopic topic) => 0;

  void bump() => state++;
}

extension DataSyncRef on Ref {
  /// Declares that this provider's data goes stale when `topics` are mutated.
  ///
  /// Call it at the top of a provider's body — it is a `watch`, so it has to
  /// run during `build`, not from a callback:
  ///
  /// ```dart
  /// @riverpod
  /// Future<List<BodyweightLog>> bodyweightHistory(Ref ref) {
  ///   ref.syncOn(const [DataTopic.bodyweight]);
  ///   return ref.watch(profileRepositoryProvider).bodyweightHistory();
  /// }
  /// ```
  void syncOn(Iterable<DataTopic> topics) {
    for (final topic in topics) {
      watch(dataRevisionProvider(topic));
    }
  }
}
