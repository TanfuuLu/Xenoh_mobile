import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/utils/app_routes.dart';
import 'package:xenoh_mobile/features/notifications/domain/notification_destination.dart';

void main() {
  test('maps every supported backend entity type to a real mobile route', () {
    expect(
      notificationDestination(
        const {
          'type': 'ExerciseWarning',
          'relatedEntityType': 'Day',
          'relatedEntityId': 'd1',
        },
        isCoach: true,
      ).route,
      '/days/d1',
    );
    expect(
      notificationDestination(
        const {
          'type': 'NewComment',
          'relatedEntityType': 'Plan',
          'relatedEntityId': 'p1',
        },
        isCoach: false,
      ).route,
      '/plans/p1/comments',
    );
    expect(
      notificationDestination(
        const {
          'type': 'PlanAssigned',
          'relatedEntityType': 'Plan',
          'relatedEntityId': 'p1',
        },
        isCoach: false,
      ).route,
      '/plans/p1',
    );
    expect(
      notificationDestination(
        const {
          'type': 'NewComment',
          'relatedEntityType': 'Week:p1',
          'relatedEntityId': 'w1',
        },
        isCoach: false,
      ).route,
      '/weeks/w1/comments',
    );
    expect(
      notificationDestination(
        const {
          'type': 'FriendRequestReceived',
          'relatedEntityType': 'Friendship',
          'relatedEntityId': 'f1',
        },
        isCoach: false,
      ).route,
      '/community/friends',
    );
    expect(
      notificationDestination(
        const {
          'type': 'CoachAccepted',
          'relatedEntityType': 'CoachRequest',
          'relatedEntityId': 'r1',
        },
        isCoach: false,
      ).route,
      '/coach',
    );
    expect(
      notificationDestination(
        const {
          'type': 'TerminationRequested',
          'relatedEntityType': 'CoachRequest',
          'relatedEntityId': 'r1',
        },
        isCoach: true,
      ).route,
      '/coach/clients',
    );
    expect(
      notificationDestination(
        const {
          'type': 'NewMessage',
          'relatedEntityType': 'Relationship',
          'relatedEntityId': 'r 1',
        },
        isCoach: true,
      ).route,
      relationshipChatLocation(
        coachInbox: true,
        relationshipId: 'r 1',
        peerName: '',
      ),
    );
    expect(
      notificationDestination(
        const {
          'type': 'NewMessage',
          'relatedEntityType': 'Relationship',
          'relatedEntityId': 'r1',
        },
        isCoach: false,
      ).route,
      relationshipChatLocation(
        coachInbox: false,
        relationshipId: 'r1',
        peerName: '',
      ),
    );
    expect(
      notificationDestination(
        const {
          'type': 'SubscriptionExpired',
          'relatedEntityType': 'Subscription',
          'relatedEntityId': 's1',
        },
        isCoach: false,
      ).route,
      '/subscription',
    );
  });

  test('returns an explicit fallback for capabilities not built yet', () {
    for (final relatedType in const [
      'TrainingDayShare',
      'FutureEntity',
    ]) {
      final destination = notificationDestination(
        {
          'type': 'AnyType',
          'relatedEntityType': relatedType,
          'relatedEntityId': '1',
        },
        isCoach: false,
      );
      expect(destination.route, isNull, reason: relatedType);
      expect(destination.hasFallback, isTrue, reason: relatedType);
    }
  });

  test('challenge notifications safely fall back', () {
    final destination = notificationDestination(
      const {
        'relatedEntityType': 'FitnessChallenge',
        'relatedEntityId': 'challenge-1',
      },
      isCoach: false,
    );

    expect(destination.route, isNull);
    expect(destination.hasFallback, isTrue);
  });

  test('competition notifications open my native registrations', () {
    expect(
      notificationDestination(
        const {
          'relatedEntityType': 'CompetitionEvent',
          'relatedEntityId': 'event-1',
        },
        isCoach: false,
      ).route,
      '/competitions/mine',
    );
  });

  test('missing entity metadata safely falls back', () {
    expect(
      notificationDestination(const {}, isCoach: false).hasFallback,
      isTrue,
    );
  });

  test('chat notifications without a relationship id open a safe entry', () {
    expect(
      notificationDestination(
        const {'type': 'NewMessage'},
        isCoach: false,
      ).route,
      '/coach/messages',
    );
    expect(
      notificationDestination(
        const {'type': 'NewMessage'},
        isCoach: true,
      ).route,
      '/coach/chat',
    );
  });

  test(
    'new-message payload routes even when related entity type is absent',
    () {
      expect(
        notificationDestination(
          const {
            'type': 'NewMessage',
            'relatedEntityId': 'relationship/42',
          },
          isCoach: false,
        ).route,
        relationshipChatLocation(
          coachInbox: false,
          relationshipId: 'relationship/42',
          peerName: '',
        ),
      );
    },
  );
}
