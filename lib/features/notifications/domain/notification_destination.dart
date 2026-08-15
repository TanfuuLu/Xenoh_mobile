import '../../../core/utils/app_routes.dart';

class NotificationDestination {
  const NotificationDestination.route(this.route) : hasFallback = false;

  const NotificationDestination.fallback() : route = null, hasFallback = true;

  final String? route;
  final bool hasFallback;
}

/// Resolves a payload to an existing route or an explicit safe fallback.
NotificationDestination notificationDestination(
  Map<String, dynamic> item, {
  required bool isCoach,
}) {
  final type = item['type']?.toString();
  final relatedType = item['relatedEntityType']?.toString();
  final id = item['relatedEntityId']?.toString();
  final isChatNotification =
      type == 'NewMessage' || relatedType == 'Relationship';
  if (isChatNotification) {
    if (id == null || id.isEmpty) {
      return NotificationDestination.route(
        isCoach ? '/coach/chat' : '/coach/messages',
      );
    }
    return NotificationDestination.route(
      relationshipChatLocation(
        coachInbox: isCoach,
        relationshipId: id,
        peerName:
            item['peerName']?.toString() ??
            item['senderName']?.toString() ??
            '',
      ),
    );
  }
  if (relatedType == null || id == null || id.isEmpty) {
    return const NotificationDestination.fallback();
  }

  if (relatedType == 'Day') {
    return NotificationDestination.route('/days/$id');
  }
  if (relatedType == 'Plan') {
    return NotificationDestination.route(
      type == 'NewComment' ? '/plans/$id/comments' : '/plans/$id',
    );
  }
  if (relatedType.startsWith('Week:')) {
    return NotificationDestination.route('/weeks/$id/comments');
  }
  if (relatedType == 'Friendship') {
    return const NotificationDestination.route('/community/friends');
  }
  if (relatedType == 'CoachRequest') {
    return NotificationDestination.route(
      isCoach ? '/coach/clients' : '/coach',
    );
  }
  if (relatedType == 'Subscription') {
    return const NotificationDestination.route('/subscription');
  }
  if (relatedType == 'CompetitionEvent') {
    return const NotificationDestination.route('/competitions/mine');
  }

  return const NotificationDestination.fallback();
}
