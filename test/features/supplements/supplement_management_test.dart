import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/utils/current_date_provider.dart';
import 'package:xenoh_mobile/core/utils/date_only.dart';
import 'package:xenoh_mobile/features/supplements/data/datasources/supplement_remote_data_source.dart';
import 'package:xenoh_mobile/features/supplements/data/repositories/supplement_repository_provider.dart';
import 'package:xenoh_mobile/features/supplements/domain/entities/supplement_models.dart';
import 'package:xenoh_mobile/features/supplements/domain/repositories/supplement_repository.dart';
import 'package:xenoh_mobile/features/supplements/presentation/screens/supplements_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockSupplementRepository extends Mock implements SupplementRepository {}

void main() {
  group('permanent delete', () {
    test('targets the /permanent route for the signed-in user', () async {
      final adapter = _RecordingAdapter();
      final source = SupplementRemoteDataSource(
        Dio()..httpClientAdapter = adapter,
      );

      await source.deleteRegimen('regimen-1');

      expect(adapter.method, 'DELETE');
      expect(adapter.path, '/supplements/regimens/regimen-1/permanent');
    });

    test('targets the coach route when a client is supplied', () async {
      final adapter = _RecordingAdapter();
      final source = SupplementRemoteDataSource(
        Dio()..httpClientAdapter = adapter,
      );

      await source.deleteRegimen('regimen-1', clientId: 'client-9');

      expect(
        adapter.path,
        '/supplements/clients/client-9/regimens/regimen-1/permanent',
      );
    });
  });

  test('recordDose sends the dose note', () async {
    final adapter = _RecordingAdapter(
      body: jsonEncode({
        'doseSlotId': 'slot-1',
        'regimenId': 'regimen-1',
        'regimenName': 'Creatine',
        'amount': 5,
        'unit': 'g',
        'time': '08:00:00',
        'status': 'Taken',
        'note': 'with breakfast',
      }),
    );
    final source = SupplementRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    await source.recordDose(
      doseSlotId: 'slot-1',
      date: DateTime(2026, 8, 20),
      status: SupplementIntakeStatus.taken,
      note: 'with breakfast',
    );

    expect(adapter.path, '/supplements/doses/slot-1/2026-08-20');
    expect(adapter.requestBody?['status'], 'Taken');
    expect(adapter.requestBody?['note'], 'with breakfast');
  });

  testWidgets(
    'editing a regimen defaults the new schedule to tomorrow',
    (tester) async {
      tester.view.devicePixelRatio = 1;
      tester.view.physicalSize = const Size(400, 1400);
      addTearDown(tester.view.reset);

      final today = DateOnly.truncate(DateTime.now());
      final tomorrow = today.add(const Duration(days: 1));

      await tester.pumpWidget(
        ProviderScope(
          child: MaterialApp(
            theme: AppTheme.light(),
            localizationsDelegates: AppLocalizations.localizationsDelegates,
            supportedLocales: AppLocalizations.supportedLocales,
            home: SupplementRegimenSheet(
              clientId: null,
              initial: _regimen(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();

      // The server rejects a schedule change dated today or earlier.
      expect(find.text(DateOnly.format(tomorrow)), findsOneWidget);
      expect(find.text(DateOnly.format(today)), findsNothing);
    },
  );

  testWidgets('future days are read-only', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(400, 1600);
    addTearDown(tester.view.reset);

    final repository = _MockSupplementRepository();
    when(
      () => repository.getDaily(any(), clientId: any(named: 'clientId')),
    ).thenAnswer((invocation) async {
      final date = invocation.positionalArguments.first as DateTime;
      return _daily(date);
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          supplementRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SupplementsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Taken'), findsWidgets);

    await tester.tap(find.byTooltip('Next day'));
    await tester.pumpAndSettle();

    expect(
      find.text('Doses can only be recorded once the day has arrived.'),
      findsOneWidget,
    );
    expect(find.text('Skip'), findsNothing);
  });

  testWidgets('opens on the shared local calendar day', (tester) async {
    final repository = _MockSupplementRepository();
    final today = DateTime(2030, 1, 2);
    final tomorrow = DateTime(2030, 1, 3);
    when(
      () => repository.getDaily(any(), clientId: any(named: 'clientId')),
    ).thenAnswer((invocation) async {
      final date = invocation.positionalArguments.first as DateTime;
      return _daily(date);
    });

    final container = ProviderContainer(
      overrides: [
        currentDateProvider.overrideWithValue(today),
        supplementRepositoryProvider.overrideWithValue(repository),
      ],
    );
    addTearDown(container.dispose);

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const SupplementsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    verify(
      () => repository.getDaily(today, clientId: any(named: 'clientId')),
    ).called(1);
    expect(find.textContaining('2030'), findsOneWidget);

    container.updateOverrides([
      currentDateProvider.overrideWithValue(tomorrow),
      supplementRepositoryProvider.overrideWithValue(repository),
    ]);
    await tester.pumpAndSettle();

    verify(
      () => repository.getDaily(tomorrow, clientId: any(named: 'clientId')),
    ).called(1);
  });
}

SupplementRegimen _regimen() => SupplementRegimen(
  id: 'regimen-1',
  userId: 'user-1',
  name: 'Creatine',
  isArchived: false,
  doseSlots: const [
    SupplementDoseSlot(
      id: 'slot-1',
      amount: 5,
      unit: 'g',
      time: '08:00:00',
      daysOfWeek: SupplementWeekday.values,
    ),
  ],
  createdAt: DateTime(2026, 8, 1),
  updatedAt: DateTime(2026, 8, 1),
);

SupplementDaily _daily(DateTime date) => SupplementDaily(
  userId: 'user-1',
  date: date,
  doses: const [
    SupplementDailyDose(
      doseSlotId: 'slot-1',
      regimenId: 'regimen-1',
      regimenName: 'Creatine',
      amount: 5,
      unit: 'g',
      time: '08:00:00',
      status: SupplementDoseStatus.pending,
    ),
  ],
  totals: const SupplementAdherenceTotals(
    planned: 1,
    taken: 0,
    skipped: 0,
    missed: 0,
    pending: 1,
  ),
);

class _RecordingAdapter implements HttpClientAdapter {
  _RecordingAdapter({this.body = ''});

  final String body;
  String? path;
  String? method;
  Map<String, dynamic>? requestBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    path = options.path;
    method = options.method;
    final bytes = await requestStream?.expand((chunk) => chunk).toList();
    if (bytes != null && bytes.isNotEmpty) {
      requestBody = jsonDecode(utf8.decode(bytes)) as Map<String, dynamic>;
    }
    return ResponseBody.fromString(
      body,
      body.isEmpty ? 204 : 200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
