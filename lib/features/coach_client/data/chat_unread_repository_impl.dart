import 'package:dio/dio.dart';

import '../../../core/error/api_exception.dart';
import '../domain/chat_unread_repository.dart';
import 'chat_unread_remote_data_source.dart';

class ChatUnreadRepositoryImpl implements ChatUnreadRepository {
  ChatUnreadRepositoryImpl(this._remote);

  final ChatUnreadRemoteDataSource _remote;

  @override
  Future<Map<String, int>> getUnreadCounts() => _call(
    _remote.getUnreadCounts,
  );

  @override
  Future<void> markRead(String relationshipId) =>
      _call(() => _remote.markRead(relationshipId));

  Future<T> _call<T>(Future<T> Function() action) async {
    try {
      return await action();
    } on DioException catch (error) {
      throw failureFromDio(error);
    }
  }
}
