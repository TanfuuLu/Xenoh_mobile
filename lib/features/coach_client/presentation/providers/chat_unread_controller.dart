import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/network/dio_provider.dart';
import '../../data/chat_unread_remote_data_source.dart';
import '../../data/chat_unread_repository_impl.dart';
import '../../domain/chat_unread_repository.dart';

final chatUnreadRepositoryProvider = Provider<ChatUnreadRepository>((ref) {
  return ChatUnreadRepositoryImpl(
    ChatUnreadRemoteDataSource(ref.watch(dioProvider)),
  );
});

class ChatUnreadController extends AsyncNotifier<Map<String, int>> {
  var _revision = 0;

  ChatUnreadRepository get _repository =>
      ref.read(chatUnreadRepositoryProvider);

  @override
  Future<Map<String, int>> build() => _repository.getUnreadCounts();

  /// Re-fetches the authoritative server counts. SignalR events deliberately
  /// call this instead of incrementing locally so duplicate or missed events
  /// cannot drift the badge state.
  Future<void> reconcile() async {
    final previous = state.value;
    final revision = ++_revision;
    try {
      final counts = await _repository.getUnreadCounts();
      if (revision == _revision) {
        state = AsyncData(counts);
      }
    } catch (error, stackTrace) {
      if (revision == _revision && previous == null) {
        state = AsyncError(error, stackTrace);
      }
    }
  }

  Future<void> markRead(String relationshipId) async {
    _revision++;
    final previous = state.value ?? const <String, int>{};
    state = AsyncData({...previous, relationshipId: 0});
    try {
      await _repository.markRead(relationshipId);
      await reconcile();
    } catch (_) {
      state = AsyncData(previous);
      rethrow;
    }
  }
}

final chatUnreadControllerProvider =
    AsyncNotifierProvider<ChatUnreadController, Map<String, int>>(
      ChatUnreadController.new,
    );
