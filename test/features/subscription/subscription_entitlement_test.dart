import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/subscription/data/dtos/subscription_dto.dart';
import 'package:xenoh_mobile/features/subscription/presentation/providers/tier_labels.dart';
import 'package:xenoh_mobile/l10n/app_localizations_en.dart';

/// Xenoh sells subscriptions on the website only, so `GET /subscriptions/me`
/// is the single path by which anyone becomes Pro in the mobile app. A change
/// to the tier strings or the response shape would strand paying customers on
/// "Free" with no error surfaced and no in-app recourse, so the contract is
/// pinned here rather than discovered in production.

Map<String, dynamic> _response({
  required String tier,
  required bool isActive,
}) => {
  'id': 'sub-1',
  'tier': tier,
  'isActive': isActive,
  'createdAt': '2026-08-01T09:00:00Z',
  'expiresAt': '2027-08-01T09:00:00Z',
  'aiQuota': {
    'monthlyLimit': 500,
    'usedRequests': 12,
    'remainingRequests': 488,
    'periodStart': '2026-08-01',
  },
};

void main() {
  group('GET /subscriptions/me contract', () {
    test('an active ProIndividual response grants Pro', () {
      final sub = SubscriptionDto.fromJson(
        _response(tier: 'ProIndividual', isActive: true),
      ).toEntity();

      expect(sub.isPro, isTrue);
      expect(sub.isFree, isFalse);
      expect(sub.expiresAt, isNotNull);
      expect(sub.aiQuota.monthlyLimit, 500);
      expect(sub.aiQuota.remainingRequests, 488);
      expect(sub.aiQuota.periodStart, DateTime(2026, 8));
    });

    test('an active ProCoach response grants Pro and coach capability', () {
      final sub = SubscriptionDto.fromJson(
        _response(tier: 'ProCoach', isActive: true),
      ).toEntity();

      expect(sub.isPro, isTrue);
      expect(sub.isProCoach, isTrue);
    });

    test('an active Organizer response grants Pro and organizer nav', () {
      final sub = SubscriptionDto.fromJson(
        _response(tier: 'Organizer', isActive: true),
      ).toEntity();

      expect(sub.isPro, isTrue);
      expect(sub.isOrganizer, isTrue);
    });

    test('an expired Pro record does not grant access', () {
      final sub = SubscriptionDto.fromJson(
        _response(tier: 'ProIndividual', isActive: false),
      ).toEntity();

      expect(sub.isPro, isFalse);
      expect(sub.isFree, isTrue);
    });
  });

  group('tier matching tolerates server casing', () {
    // A paying customer must not silently read as Free because the tier
    // string arrived in a different case or with stray whitespace.
    for (final tier in const [
      'ProIndividual',
      'proindividual',
      'PROINDIVIDUAL',
      ' ProIndividual ',
    ]) {
      test('"$tier" is recognised as Pro', () {
        final sub = SubscriptionDto.fromJson(
          _response(tier: tier, isActive: true),
        ).toEntity();

        expect(sub.isPro, isTrue);
      });
    }

    test('an unknown tier is not silently treated as Pro', () {
      final sub = SubscriptionDto.fromJson(
        _response(tier: 'Enterprise', isActive: true),
      ).toEntity();

      expect(sub.isPro, isFalse);
    });
  });

  group('tier labels', () {
    test('labels are case-insensitive and fall back to the raw value', () {
      final l10n = AppLocalizationsEn();

      expect(tierLabel('ProIndividual', l10n), 'Pro Individual');
      expect(tierLabel('procoach', l10n), 'Pro Coach');
      expect(tierLabel(' Free ', l10n), 'Free');
      expect(tierLabel('Enterprise', l10n), 'Enterprise');
    });
  });
}
