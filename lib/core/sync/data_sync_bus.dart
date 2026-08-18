import 'dart:async';

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'data_revision.dart';
import 'data_topic.dart';

part 'data_sync_bus.g.dart';

/// Collects topics touched by successful mutations and bumps their revisions.
///
/// Bumps are coalesced over a short window so a burst of writes (saving a week
/// of meal plans, deleting several sets in a row) costs the listening screens
/// one re-fetch instead of one per request.
class DataSyncBus {
  DataSyncBus({
    required void Function(Set<DataTopic> topics) onFlush,
    Duration window = const Duration(milliseconds: 120),
  }) : _onFlush = onFlush,
       _window = window;

  final void Function(Set<DataTopic> topics) _onFlush;
  final Duration _window;
  final Set<DataTopic> _pending = {};
  Timer? _timer;
  bool _disposed = false;

  void notify(Set<DataTopic> topics) {
    if (_disposed || topics.isEmpty) return;
    _pending.addAll(topics);
    _timer ??= Timer(_window, flush);
  }

  /// Applies pending bumps immediately. Exposed for tests.
  void flush() {
    _timer?.cancel();
    _timer = null;
    if (_pending.isEmpty) return;
    final topics = Set<DataTopic>.from(_pending);
    _pending.clear();
    _onFlush(topics);
  }

  void dispose() {
    _disposed = true;
    _timer?.cancel();
    _timer = null;
    _pending.clear();
  }
}

@Riverpod(keepAlive: true)
DataSyncBus dataSyncBus(Ref ref) {
  final bus = DataSyncBus(
    onFlush: (topics) {
      for (final topic in topics) {
        ref.read(dataRevisionProvider(topic).notifier).bump();
      }
    },
  );
  ref.onDispose(bus.dispose);
  return bus;
}
