import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/competitions/data/competition_remote_data_source.dart';
import 'package:xenoh_mobile/features/competitions/domain/competition_models.dart';

void main() {
  test(
    'loads public events and registers with the exact athlete contract',
    () async {
      final adapter = _CompetitionAdapter();
      final source = CompetitionRemoteDataSource(
        Dio()..httpClientAdapter = adapter,
      );

      final events = await source.list(discipline: 'Powerlifting');
      await source.register(
        eventId: 'event-1',
        categoryId: 'cat-1',
        contactEmail: 'athlete@example.test',
        contactPhone: '0900000000',
      );

      expect(events.single.slug, 'open-2026');
      expect(
        adapter.requests.first,
        'GET /events?discipline=Powerlifting&pageSize=50',
      );
      expect(adapter.requests.last, 'POST /events/event-1/registrations');
      expect(adapter.lastBody?['categoryId'], 'cat-1');
    },
  );

  test('uses athlete-owned withdrawal and receipt routes', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.withdraw('event-1');

    expect(
      adapter.requests.single,
      'POST /events/event-1/registrations/me/withdraw',
    );
  });

  test(
    'loads organizer identity and managed events from website contracts',
    () async {
      final adapter = _CompetitionAdapter();
      final source = CompetitionRemoteDataSource(
        Dio()..httpClientAdapter = adapter,
      );

      final profile = await source.getOrganizerProfile();
      final events = await source.getManagedEvents();

      expect(profile?.status, 'Approved');
      expect(events.single.title, 'Open 2026');
      expect(adapter.requests, [
        'GET /organizers/me',
        'GET /competition-management/events',
      ]);
    },
  );

  test('submits organizer application with the website contract', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.applyAsOrganizer(
      organizationName: 'Xenoh Open',
      contactEmail: 'events@xenoh.app',
      contactPhone: '0900000000',
      websiteUrl: 'https://xenoh.app',
      notes: 'National federation partner',
      evidenceFileId: 'file-1',
    );

    expect(adapter.requests.single, 'PUT /organizers/me/application');
    expect(adapter.lastBody, {
      'organizationName': 'Xenoh Open',
      'contactEmail': 'events@xenoh.app',
      'contactPhone': '0900000000',
      'websiteUrl': 'https://xenoh.app',
      'notes': 'National federation partner',
      'evidenceFileId': 'file-1',
    });
  });

  test('uses organizer event lifecycle and roster contracts', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final registrations = await source.getRoster('event-1');
    await source.decideRegistration(
      eventId: 'event-1',
      registrationId: 'r1',
      approve: true,
    );
    await source.publishEvent('event-1');
    await source.publishResults('event-1');

    expect(registrations.single.athleteName, 'Mai Nguyen');
    expect(adapter.requests, [
      'GET /competition-management/events/event-1/registrations?pageSize=100',
      'POST /competition-management/events/event-1/registrations/r1/decision',
      'POST /competition-management/events/event-1/publish',
      'POST /competition-management/events/event-1/results/publish',
    ]);
    expect(adapter.lastDecisionBody, {'approve': true, 'reason': null});
  });

  test('creates an organizer event with the backend input shape', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.createEvent(
      CompetitionEventInput(
        title: 'Open 2027',
        description: 'National open',
        discipline: 'Powerlifting',
        venueName: 'Arena',
        address: 'Bangkok',
        timeZoneId: 'Asia/Bangkok',
        startsAtUtc: DateTime.utc(2027, 3, 2, 2),
        endsAtUtc: DateTime.utc(2027, 3, 2, 10),
        registrationOpensAtUtc: DateTime.utc(2026, 12),
        registrationClosesAtUtc: DateTime.utc(2027, 2, 20),
        capacity: 120,
        registrationFee: 650,
        currency: 'THB',
        organizerContact: 'events@xenoh.app',
        powerliftingScoringFormula: 'Dots',
      ),
    );

    expect(adapter.requests.single, 'POST /competition-management/events');
    expect(adapter.lastBody?['discipline'], 'Powerlifting');
    expect(adapter.lastBody?['powerliftingScoringFormula'], 'Dots');
    expect(adapter.lastBody?['capacity'], 120);
  });

  test('records discipline-specific organizer results', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.upsertPowerliftingResult(
      eventId: 'event-1',
      registrationId: 'r1',
      bodyweightKg: 63.4,
      bestSquatKg: 140,
      bestBenchKg: 80,
      bestDeadliftKg: 170,
      state: 'Finished',
      notes: 'National record',
    );
    expect(
      adapter.requests.last,
      'PUT /competition-management/events/event-1/results/powerlifting/r1',
    );
    expect(adapter.lastBody?['bestDeadliftKg'], 170);

    await source.upsertBodybuildingResult(
      eventId: 'event-1',
      registrationId: 'r1',
      place: 2,
      state: 'Finished',
      notes: null,
    );
    expect(
      adapter.requests.last,
      'PUT /competition-management/events/event-1/results/bodybuilding/r1',
    );
    expect(adapter.lastBody?['place'], 2);
  });

  test('uses admin organizer verification contracts', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final applications = await source.getOrganizerApplications();
    await source.decideOrganizerApplication(
      profileId: 'organizer-1',
      decision: 'Approved',
      reason: 'Evidence verified',
    );

    expect(applications.single.organizationName, 'Xenoh Open');
    expect(adapter.requests, [
      'GET /admin/organizers?page=1&pageSize=100',
      'POST /admin/organizers/organizer-1/decision',
    ]);
    expect(adapter.lastBody, {
      'decision': 'Approved',
      'reason': 'Evidence verified',
    });
  });

  test('uses complete organizer event operations contracts', () async {
    final adapter = _CompetitionAdapter();
    final source = CompetitionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.closeRegistration('event-1');
    await source.cancelEvent('event-1', 'Venue unavailable');
    await source.addCategory(
      'event-1',
      code: 'OPEN-M',
      name: 'Open men',
      capacity: 50,
      displayOrder: 1,
    );
    await source.addGuestRegistration(
      'event-1',
      categoryId: 'cat-1',
      athleteName: 'Guest Athlete',
      contactEmail: 'guest@example.test',
      contactPhone: '0900000000',
    );
    await source.promoteWaitlist('event-1', 'r1');
    await source.decideReceipt(
      eventId: 'event-1',
      receiptId: 'receipt-1',
      approve: true,
    );

    expect(
      adapter.requests,
      containsAllInOrder([
        'POST /competition-management/events/event-1/close-registration',
        'POST /competition-management/events/event-1/cancel',
        'POST /competition-management/events/event-1/categories',
        'POST /competition-management/events/event-1/registrations/guest',
        'POST /competition-management/events/event-1/registrations/r1/promote',
        'POST /competition-management/events/event-1/receipts/receipt-1/decision',
      ]),
    );
  });
}

class _CompetitionAdapter implements HttpClientAdapter {
  final requests = <String>[];
  Map<String, dynamic>? lastBody;
  Map<String, dynamic>? lastDecisionBody;
  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    final query = options.queryParameters.entries
        .map((entry) => '${entry.key}=${entry.value}')
        .join('&');
    requests.add(
      '${options.method} ${options.path}${query.isEmpty ? '' : '?$query'}',
    );
    if (requestStream != null) {
      final bytes = await requestStream.expand((chunk) => chunk).toList();
      if (bytes.isNotEmpty) {
        lastBody = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
        if (options.path.endsWith('/decision')) {
          lastDecisionBody = lastBody;
        }
      }
    }
    final data = options.path == '/admin/organizers'
        ? [_organizer]
        : options.path == '/organizers/me'
        ? _organizer
        : options.path == '/competition-management/events' &&
              options.method == 'POST'
        ? _event
        : options.path == '/competition-management/events'
        ? [_event]
        : options.path.endsWith('/registrations') &&
              options.path.startsWith('/competition-management/')
        ? [_organizerRegistration]
        : options.path == '/events'
        ? {
            'items': [_event],
          }
        : options.path.endsWith('/registrations')
        ? _registration
        : <String, dynamic>{};
    return ResponseBody.fromString(
      jsonEncode(data),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}

final _event = <String, dynamic>{
  'id': 'event-1',
  'slug': 'open-2026',
  'title': 'Open 2026',
  'discipline': 'Powerlifting',
  'status': 'Published',
  'venueName': 'Arena',
  'address': 'Bangkok',
  'startsAtUtc': '2026-10-01T02:00:00Z',
  'endsAtUtc': '2026-10-01T10:00:00Z',
  'registrationFee': 500,
  'currency': 'THB',
  'capacity': 100,
  'confirmedCount': 12,
};
final _registration = <String, dynamic>{
  'id': 'r1',
  'eventId': 'event-1',
  'eventTitle': 'Open 2026',
  'eventSlug': 'open-2026',
  'categoryName': 'Open',
  'status': 'Submitted',
  'paymentStatus': 'AwaitingReceipt',
  'isConfirmed': false,
  'expectedFee': 500,
  'currency': 'THB',
  'submittedAt': '2026-08-03T00:00:00Z',
};
final _organizerRegistration = <String, dynamic>{
  ..._registration,
  'categoryId': 'cat-1',
  'athleteName': 'Mai Nguyen',
  'contactEmail': 'mai@example.test',
  'receipts': <dynamic>[],
};
final _organizer = <String, dynamic>{
  'id': 'organizer-1',
  'organizationName': 'Xenoh Open',
  'contactEmail': 'events@xenoh.app',
  'contactPhone': '0900000000',
  'status': 'Approved',
};
