import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/app_routes.dart';

void main() {
  test('chat locations survive names containing URL characters', () {
    final location = relationshipChatLocation(
      coachInbox: true,
      relationshipId: 'relationship/42',
      peerName: 'An & Bình',
    );
    final uri = Uri.parse(location);

    expect(uri.path, '/coach/chat/messages');
    expect(uri.queryParameters['relationshipId'], 'relationship/42');
    expect(uri.queryParameters['peerName'], 'An & Bình');
  });
}
