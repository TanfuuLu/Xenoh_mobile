import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/competitions/domain/competition_models.dart';
import 'package:xenoh_mobile/features/competitions/domain/competition_repository.dart';
import 'package:xenoh_mobile/features/competitions/presentation/competition_providers.dart';
import 'package:xenoh_mobile/features/competitions/presentation/organizer_event_manage_screen.dart';
import 'package:xenoh_mobile/features/competitions/presentation/organizer_screens.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('events screen exposes managed event operations', (tester) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          competitionRepositoryProvider.overrideWithValue(_OrganizerRepo()),
        ],
        child: const _TestApp(home: OrganizerEventsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Open 2027'), findsOneWidget);
    expect(find.text('Create event'), findsWidgets);
    expect(find.text('Publish event'), findsOneWidget);
    expect(find.byIcon(Icons.event_rounded), findsNothing);

    await tester.tap(find.byType(FloatingActionButton));
    await tester.pumpAndSettle();
    expect(find.text('Starts at'), findsOneWidget);
    await tester.drag(find.byType(ListView).last, const Offset(0, -420));
    await tester.pumpAndSettle();
    expect(find.text('Registration closes'), findsOneWidget);
    await tester.drag(find.byType(ListView).last, const Offset(0, -420));
    await tester.pumpAndSettle();
    expect(find.text('Bank name'), findsOneWidget);
  });

  testWidgets('roster screen displays athlete and decision controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          competitionRepositoryProvider.overrideWithValue(_OrganizerRepo()),
        ],
        child: const _TestApp(home: OrganizerRosterScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Mai Nguyen'), findsOneWidget);
    expect(find.text('Approve'), findsOneWidget);
    expect(find.text('Reject'), findsOneWidget);
  });

  testWidgets('results screen opens discipline-specific entry form', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          competitionRepositoryProvider.overrideWithValue(
            _OrganizerRepo(approved: true),
          ),
        ],
        child: const _TestApp(home: OrganizerResultsScreen()),
      ),
    );
    await tester.pumpAndSettle();
    await tester.tap(find.byIcon(Icons.edit_note_rounded));
    await tester.pumpAndSettle();

    expect(find.text('Bodyweight (kg)'), findsOneWidget);
    expect(find.text('Best squat (kg)'), findsOneWidget);
    expect(find.text('Save result'), findsOneWidget);
  });

  testWidgets('event management exposes overview categories and staff', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          competitionRepositoryProvider.overrideWithValue(_OrganizerRepo()),
        ],
        child: const _TestApp(
          home: OrganizerEventManageScreen(
            eventId: 'event-1',
            slug: 'open-2027',
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Overview'), findsOneWidget);
    expect(find.text('Categories'), findsOneWidget);
    expect(find.text('Staff'), findsOneWidget);
    await tester.tap(find.text('Categories'));
    await tester.pumpAndSettle();
    expect(find.text('Open men'), findsOneWidget);
    expect(find.text('Add category'), findsOneWidget);
  });

  testWidgets('admin organizer review exposes evidence and decision controls', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          competitionRepositoryProvider.overrideWithValue(_OrganizerRepo()),
        ],
        child: const _TestApp(home: AdminOrganizerApplicationsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Iron House Events'), findsOneWidget);
    expect(find.text('Review evidence'), findsOneWidget);
    expect(find.text('Save decision'), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});
  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

class _OrganizerRepo extends Fake implements CompetitionRepository {
  _OrganizerRepo({this.approved = false});
  final bool approved;
  @override
  Future<List<CompetitionSummary>> getManagedEvents() async => [_event];

  @override
  Future<CompetitionEvent> getBySlug(String slug) async => _eventDetail;

  @override
  Future<List<CompetitionRegistration>> getRoster(
    String eventId, {
    String? status,
    String? paymentStatus,
  }) async => [if (approved) _approvedRegistration else _registration];

  @override
  Future<List<OrganizerProfile>> getOrganizerApplications({
    String? status,
  }) async => const [
    OrganizerProfile(
      id: 'organizer-1',
      organizationName: 'Iron House Events',
      contactEmail: 'events@example.test',
      contactPhone: '+66 80 000 0000',
      status: 'Pending',
      evidenceFileId: 'file-1',
    ),
  ];
}

final _event = CompetitionSummary(
  id: 'event-1',
  slug: 'open-2027',
  title: 'Open 2027',
  discipline: 'Powerlifting',
  status: 'Draft',
  venueName: 'Arena',
  address: 'Bangkok',
  startsAtUtc: DateTime.utc(2027, 3, 2),
  endsAtUtc: DateTime.utc(2027, 3, 2, 8),
  registrationFee: 650,
  currency: 'THB',
  capacity: 120,
  confirmedCount: 20,
);

final _registration = CompetitionRegistration(
  id: 'registration-1',
  eventId: 'event-1',
  eventTitle: 'Open 2027',
  eventSlug: 'open-2027',
  categoryName: 'Open',
  athleteName: 'Mai Nguyen',
  contactEmail: 'mai@example.test',
  status: 'Submitted',
  paymentStatus: 'UnderReview',
  isConfirmed: false,
  expectedFee: 650,
  currency: 'THB',
  submittedAt: DateTime.utc(2026, 12),
);

final _approvedRegistration = CompetitionRegistration(
  id: 'registration-1',
  eventId: 'event-1',
  eventTitle: 'Open 2027',
  eventSlug: 'open-2027',
  categoryName: 'Open',
  athleteName: 'Mai Nguyen',
  contactEmail: 'mai@example.test',
  status: 'Approved',
  paymentStatus: 'Paid',
  isConfirmed: true,
  expectedFee: 650,
  currency: 'THB',
  submittedAt: DateTime.utc(2026, 12),
);

final _eventDetail = CompetitionEvent.fromJson({
  'id': 'event-1',
  'slug': 'open-2027',
  'title': 'Open 2027',
  'description': 'National open',
  'discipline': 'Powerlifting',
  'status': 'Draft',
  'venueName': 'Arena',
  'address': 'Bangkok',
  'timeZoneId': 'Asia/Bangkok',
  'startsAtUtc': '2027-03-02T02:00:00Z',
  'endsAtUtc': '2027-03-02T10:00:00Z',
  'registrationOpensAtUtc': '2026-12-01T00:00:00Z',
  'registrationClosesAtUtc': '2027-02-20T00:00:00Z',
  'registrationFee': 650,
  'currency': 'THB',
  'capacity': 120,
  'confirmedCount': 20,
  'organizerContact': 'events@example.test',
  'powerliftingScoringFormula': 'Dots',
  'canManage': true,
  'categories': [
    {
      'id': 'cat-1',
      'code': 'OPEN-M',
      'name': 'Open men',
      'capacity': 60,
      'displayOrder': 0,
    },
  ],
});
