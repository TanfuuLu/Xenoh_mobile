import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/supplements/data/repositories/supplement_repository_provider.dart';
import 'package:xenoh_mobile/features/supplements/domain/entities/supplement_models.dart';
import 'package:xenoh_mobile/features/supplements/domain/repositories/supplement_repository.dart';
import 'package:xenoh_mobile/features/supplements/presentation/screens/supplements_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockSupplementRepository extends Mock implements SupplementRepository {}

void main() {
  setUpAll(() {
    registerFallbackValue(DateTime(2026));
    registerFallbackValue(SupplementIntakeStatus.taken);
  });

  testWidgets('saving a dose note does not tear down the dialog badly', (
    tester,
  ) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(420, 1200);
    addTearDown(tester.view.reset);

    final repository = _MockSupplementRepository();
    when(
      () => repository.getDaily(any(), clientId: any(named: 'clientId')),
    ).thenAnswer((_) async => _daily());
    when(
      () => repository.recordDose(
        doseSlotId: any(named: 'doseSlotId'),
        date: any(named: 'date'),
        status: any(named: 'status'),
        note: any(named: 'note'),
      ),
    ).thenAnswer((_) async => _dose());

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

    await tester.tap(find.byIcon(Icons.edit_note_rounded));
    await tester.pumpAndSettle();
    expect(find.text('Dose note'), findsOneWidget);

    await tester.enterText(find.byType(TextField), 'with breakfast');
    await tester.tap(find.widgetWithText(FilledButton, 'Save'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    verify(
      () => repository.recordDose(
        doseSlotId: 'slot-1',
        date: any(named: 'date'),
        status: SupplementIntakeStatus.taken,
        note: 'with breakfast',
      ),
    ).called(1);
  });

  testWidgets('dismissing the note dialog records nothing', (tester) async {
    tester.view.devicePixelRatio = 1;
    tester.view.physicalSize = const Size(420, 1200);
    addTearDown(tester.view.reset);

    final repository = _MockSupplementRepository();
    when(
      () => repository.getDaily(any(), clientId: any(named: 'clientId')),
    ).thenAnswer((_) async => _daily());

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

    await tester.tap(find.byIcon(Icons.edit_note_rounded));
    await tester.pumpAndSettle();
    await tester.tap(find.widgetWithText(TextButton, 'Cancel'));
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    verifyNever(
      () => repository.recordDose(
        doseSlotId: any(named: 'doseSlotId'),
        date: any(named: 'date'),
        status: any(named: 'status'),
        note: any(named: 'note'),
      ),
    );
  });
}

SupplementDailyDose _dose() => const SupplementDailyDose(
  doseSlotId: 'slot-1',
  regimenId: 'regimen-1',
  regimenName: 'Creatine',
  amount: 5,
  unit: 'g',
  time: '08:00:00',
  status: SupplementDoseStatus.taken,
);

SupplementDaily _daily() => SupplementDaily(
  userId: 'user-1',
  date: DateTime.now(),
  doses: [_dose()],
  totals: const SupplementAdherenceTotals(
    planned: 1,
    taken: 1,
    skipped: 0,
    missed: 0,
    pending: 0,
  ),
);
