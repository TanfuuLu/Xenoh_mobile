import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/widgets/community_dashboard_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('shows community shortcuts and incoming request badge', (
    tester,
  ) async {
    var openedCommunity = false;
    var openedFriends = false;
    var openedChallenges = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: CommunityDashboardCard(
            incomingRequestCount: 3,
            onOpenCommunity: () => openedCommunity = true,
            onOpenFriends: () => openedFriends = true,
            onOpenChallenges: () => openedChallenges = true,
          ),
        ),
      ),
    );

    expect(find.text('Community'), findsOneWidget);
    expect(find.text('3'), findsOneWidget);

    await tester.tap(find.text('Community'));
    await tester.tap(find.text('Friends'));
    await tester.tap(find.text('Fitness challenges'));

    expect(openedCommunity, isTrue);
    expect(openedFriends, isTrue);
    expect(openedChallenges, isTrue);
  });
}
