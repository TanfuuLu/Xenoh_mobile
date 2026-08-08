import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/challenges/domain/challenge_models.dart';
import 'package:xenoh_mobile/features/challenges/presentation/challenge_detail_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('challenge standings show rank, score, and baseline state', (
    tester,
  ) async {
    await tester.pumpWidget(
      const MaterialApp(
        localizationsDelegates: [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ChallengeStandings(
            members: [
              ChallengeMember(
                userId: 'one',
                fullName: 'Mai Nguyen',
                status: 'Accepted',
                isCreator: true,
                checkedInToday: false,
                completedSessions: 3,
                targetSessions: 4,
                score: 412.5,
                rank: 1,
                scoreUnit: 'DOTS',
                baselineReady: true,
              ),
              ChallengeMember(
                userId: 'two',
                fullName: 'An Tran',
                status: 'Accepted',
                isCreator: false,
                checkedInToday: false,
                completedSessions: 0,
                targetSessions: 4,
                scoreUnit: 'kg',
                baselineReady: false,
              ),
            ],
          ),
        ),
      ),
    );

    expect(find.text('Standings'), findsOneWidget);
    expect(find.text('#1'), findsOneWidget);
    expect(find.text('412.5 DOTS'), findsOneWidget);
    expect(find.text('Baseline required'), findsOneWidget);
    expect(find.text('Invited member'), findsNothing);
  });
}
