import 'package:dio/dio.dart';

class ChatUnreadRemoteDataSource {
  ChatUnreadRemoteDataSource(this._dio);

  final Dio _dio;

  Future<Map<String, int>> getUnreadCounts() async {
    final response = await _dio.get<Map<String, dynamic>>(
      '/messages/unread-counts',
    );
    return (response.data ?? const <String, dynamic>{}).map(
      (relationshipId, count) => MapEntry(
        relationshipId,
        count is num ? count.toInt() : int.tryParse(count.toString()) ?? 0,
      ),
    );
  }

  Future<void> markRead(String relationshipId) =>
      _dio.post<void>('/messages/relationships/$relationshipId/read');
}
