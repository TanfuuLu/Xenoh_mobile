import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/cycle/data/repositories/cycle_repository_provider.dart';
import 'package:xenoh_mobile/features/cycle/domain/entities/cycle_models.dart';
import 'package:xenoh_mobile/features/cycle/domain/repositories/cycle_repository.dart';
import 'package:xenoh_mobile/features/cycle/presentation/screens/cycle_screen.dart';
import 'package:xenoh_mobile/features/cycle/presentation/widgets/cycle_phase_guidance_panel.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/user_profile.dart';
import 'package:xenoh_mobile/features/profile/presentation/providers/profile_controller.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

/// Number of cells the calendar must render for [month]: whole weeks from the
/// Monday on or before the 1st to the Sunday on or after the last day.
int _gridCells(DateTime month) {
  final first = DateTime(month.year, month.month);
  final last = DateTime(month.year, month.month + 1, 0);
  final start = first.subtract(Duration(days: first.weekday - DateTime.monday));
  final end = last.add(Duration(days: DateTime.sunday - last.weekday));
  return end.difference(start).inDays + 1;
}

String _key(DateTime date) =>
    'cycle-day-${date.year.toString().padLeft(4, '0')}-'
    '${date.month.toString().padLeft(2, '0')}-'
    '${date.day.toString().padLeft(2, '0')}';

class _FakeCycleRepository implements CycleRepository {
  _FakeCycleRepository(this.overview, this.logs);

  final CycleOverview overview;
  final List<CycleDailyLog> logs;

  @override
  dynamic noSuchMethod(Invocation invocation) =>
      throw UnimplementedError('${invocation.memberName} not stubbed');

  @override
  Future<CycleOverview> getOverview() async => overview;

  @override
  Future<List<CycleDailyLog>> getLogs({
    required DateTime from,
    required DateTime to,
  }) async => logs;

  @override
  Future<CycleSettings> getSettings() async =>
      const CycleSettings(shareWithCoach: false);
}

class _StubProfile extends MyProfileController {
  @override
  Future<UserProfile> build() async => const UserProfile(
    id: 'u1',
    email: 'a@b.c',
    firstName: 'Athlete',
    lastName: 'One',
    currentStreak: 1,
    level: 3,
    totalXp: 120,
    xpToNextLevel: 400,
    title: 'Lifter',
    big3Prs: Big3Prs(),
    gender: 'Female',
  );
}

void main() {
  final today = DateTime.now();
  final periodStart = DateTime(today.year, today.month, today.day);
  final fertileStart = periodStart.add(const Duration(days: 8));
  final fertileEnd = fertileStart.add(const Duration(days: 5));

  final overview = CycleOverview(
    currentPhase: 'Luteal',
    effectiveCycleLengthDays: 28,
    effectivePeriodLengthDays: 5,
    isRegular: true,
    confidence: 'Medium',
    needsData: false,
    cycleDay: 1,
    lastPeriodStart: periodStart,
    currentPeriodPredictedEnd: periodStart.add(const Duration(days: 4)),
    predictedPeriods: const [],
    ovulationDates: [fertileEnd],
    fertileWindows: [FertileWindow(start: fertileStart, end: fertileEnd)],
  );

  final logs = [
    CycleDailyLog(date: periodStart, symptoms: const [], flow: 'Heavy'),
  ];

  Future<void> pumpScreen(WidgetTester tester, {Locale? locale}) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          cycleRepositoryProvider.overrideWithValue(
            _FakeCycleRepository(overview, logs),
          ),
          myProfileControllerProvider.overrideWith(_StubProfile.new),
        ],
        child: MaterialApp(
          locale: locale ?? const Locale('en'),
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: const CycleScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();
  }

  testWidgets('calendar renders whole weeks, including 6-row months', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpScreen(tester);

    // Step forward to the next month that needs six rows — the case a
    // hardcoded 35-cell grid used to truncate, dropping its final day.
    var offset = 0;
    var target = DateTime(today.year, today.month);
    while (_gridCells(target) != 42 && offset < 12) {
      offset++;
      target = DateTime(today.year, today.month + offset);
    }
    expect(offset, lessThan(12), reason: 'no 6-row month within a year');

    for (var i = 0; i < offset; i++) {
      await tester.tap(find.byIcon(Icons.chevron_right_rounded));
      await tester.pumpAndSettle();
    }

    final lastDay = DateTime(target.year, target.month + 1, 0);
    expect(
      find.byKey(ValueKey(_key(lastDay))),
      findsOneWidget,
      reason: 'the last day of a 6-row month must still be rendered',
    );
  });

  testWidgets('the period in progress fills through its predicted end', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpScreen(tester);

    // Only day 1 is logged, but the backend's predicted end covers 5 days, so
    // the remaining four must already be shaded.
    for (var i = 0; i < 5; i++) {
      final day = periodStart.add(Duration(days: i));
      if (day.month != periodStart.month) continue;
      expect(find.byKey(ValueKey(_key(day))), findsOneWidget);
    }
    expect(find.byType(Divider), findsNothing);
  });

  testWidgets('legend names the ovulation day and fertile window length', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpScreen(tester);

    expect(find.text('Ovulation day'), findsOneWidget);
    // The fixture's window is 6 days inclusive.
    expect(find.text('Fertile window (6 days)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  testWidgets('phase guidance opens on the current phase and swaps content', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpScreen(tester);

    expect(find.text('Phase guidance'), findsOneWidget);
    // Overview says Luteal, so the luteal tips show without any interaction.
    expect(
      find.text('Energy may dip — moderate the load and focus on consistency.'),
      findsOneWidget,
    );

    await tester.tap(find.text('Follicular'));
    await tester.pumpAndSettle();

    expect(
      find.text('Energy may dip — moderate the load and focus on consistency.'),
      findsNothing,
    );
    expect(
      find.text('A great window for strength PRs and progressive overload.'),
      findsOneWidget,
    );
  });

  testWidgets('phase name and guidance are localized', (tester) async {
    await tester.binding.setSurfaceSize(const Size(390, 2400));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    await pumpScreen(tester, locale: const Locale('vi'));

    // The hero used to print the API's raw English phase name.
    expect(find.text('Luteal'), findsNothing);
    expect(find.text('Hoàng thể'), findsWidgets);
    expect(find.text('Hướng dẫn theo giai đoạn'), findsOneWidget);
    expect(find.text('Cửa sổ thụ thai (6 ngày)'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });

  test('guidance covers every phase the chips offer', () {
    expect(cycleGuidancePhases, [
      'Menstrual',
      'Follicular',
      'Ovulation',
      'Luteal',
    ]);
    for (final phase in cycleGuidancePhases) {
      expect(cyclePhaseColor(phase), isNot(const Color(0xFF94A3B8)));
    }
  });
}
