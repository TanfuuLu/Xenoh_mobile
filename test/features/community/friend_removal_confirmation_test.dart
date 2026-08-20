import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/community/domain/entities/community_models.dart';
import 'package:xenoh_mobile/features/community/presentation/widgets/community_widgets.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  group('unfriending', () {
    testWidgets('asks before removing and honours cancel', (tester) async {
      var removed = false;
      await tester.pumpWidget(_app(onRemove: () => removed = true));

      await tester.tap(find.text('Friends'));
      await tester.pumpAndSettle();

      expect(find.text('Remove friend?'), findsOneWidget);
      expect(
        find.textContaining('Remove Demo Coach from your friends?'),
        findsOneWidget,
      );
      expect(removed, isFalse);

      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();

      expect(find.text('Remove friend?'), findsNothing);
      expect(removed, isFalse);
    });

    testWidgets('removes once confirmed', (tester) async {
      var removed = false;
      await tester.pumpWidget(_app(onRemove: () => removed = true));

      await tester.tap(find.text('Friends'));
      await tester.pumpAndSettle();
      await tester.tap(find.widgetWithText(TextButton, 'Remove'));
      await tester.pumpAndSettle();

      expect(removed, isTrue);
    });
  });
}

Widget _app({required VoidCallback onRemove}) => MaterialApp(
  localizationsDelegates: const [
    AppLocalizations.delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
  ],
  supportedLocales: AppLocalizations.supportedLocales,
  home: Scaffold(
    body: Center(
      child: FriendActionButton(
        user: const CommunityUserSummary(
          id: 'user-1',
          fullName: 'Demo Coach',
          friendStatus: FriendStatus.accepted,
        ),
        pending: false,
        onSend: () {},
        onAccept: () {},
        onReject: () {},
        onRemove: onRemove,
      ),
    ),
  ),
);
