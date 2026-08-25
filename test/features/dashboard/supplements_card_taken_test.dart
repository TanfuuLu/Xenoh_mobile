import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/utils/current_date_provider.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/supplements_card.dart';
import 'package:xenoh_mobile/features/supplements/data/repositories/supplement_repository_provider.dart';
import 'package:xenoh_mobile/features/supplements/domain/entities/supplement_models.dart';
import 'package:xenoh_mobile/features/supplements/domain/repositories/supplement_repository.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockSupplementRepository extends Mock implements SupplementRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(SupplementIntakeStatus.taken);
  });

  testWidgets('marks a pending dose taken from the dashboard', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.reset);

    final repository = _MockSupplementRepository();
    final today = DateTime(2030, 1, 2);
    when(
      () => repository.getDaily(any(), clientId: any(named: 'clientId')),
    ).thenAnswer((_) async => _daily(SupplementDoseStatus.pending));
    when(
      () => repository.recordDose(
        doseSlotId: any(named: 'doseSlotId'),
        date: any(named: 'date'),
        status: any(named: 'status'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async => _dose(SupplementDoseStatus.taken));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          currentDateProvider.overrideWithValue(today),
          supplementRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SupplementsCard()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    // The API sends HH:mm:ss; the card trims it.
    expect(find.textContaining('5 g · 08:00'), findsOneWidget);
    expect(find.textContaining('08:00:00'), findsNothing);

    // The pending action is a bare checkbox; its name lives in the tooltip.
    await tester.tap(find.byTooltip('Mark taken'));
    await tester.pumpAndSettle();

    final recorded =
        verify(
              () => repository.recordDose(
                doseSlotId: 'slot-1',
                date: captureAny(named: 'date'),
                status: SupplementIntakeStatus.taken,
                note: any(named: 'note'),
              ),
            ).captured.single
            as DateTime;
    expect(recorded, today);
  });

  testWidgets('an already recorded dose shows its state, not a button', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(360, 800);
    addTearDown(tester.view.reset);

    final repository = _MockSupplementRepository();
    when(
      () => repository.getDaily(any(), clientId: any(named: 'clientId')),
    ).thenAnswer((_) async => _daily(SupplementDoseStatus.taken));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          supplementRepositoryProvider.overrideWithValue(repository),
        ],
        child: MaterialApp(
          theme: AppTheme.light(),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const Scaffold(body: SupplementsCard()),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.byTooltip('Mark taken'), findsNothing);
    expect(find.text('Taken'), findsOneWidget);
  });
}

SupplementDailyDose _dose(SupplementDoseStatus status) => SupplementDailyDose(
  doseSlotId: 'slot-1',
  regimenId: 'regimen-1',
  regimenName: 'Creatine',
  amount: 5,
  unit: 'g',
  time: '08:00:00',
  status: status,
);

SupplementDaily _daily(SupplementDoseStatus status) => SupplementDaily(
  userId: 'user-1',
  date: DateTime.now(),
  doses: [_dose(status)],
  totals: SupplementAdherenceTotals(
    planned: 1,
    taken: status == SupplementDoseStatus.taken ? 1 : 0,
    skipped: 0,
    missed: 0,
    pending: status == SupplementDoseStatus.pending ? 1 : 0,
  ),
);
