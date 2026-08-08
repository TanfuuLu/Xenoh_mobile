abstract interface class ChatUnreadRepository {
  Future<Map<String, int>> getUnreadCounts();
  Future<void> markRead(String relationshipId);
}
