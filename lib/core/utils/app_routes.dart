String relationshipChatLocation({
  required bool coachInbox,
  required String relationshipId,
  required String peerName,
}) {
  return Uri(
    path: coachInbox ? '/coach/chat/messages' : '/coach/messages',
    queryParameters: {
      'relationshipId': relationshipId,
      'peerName': peerName,
    },
  ).toString();
}
