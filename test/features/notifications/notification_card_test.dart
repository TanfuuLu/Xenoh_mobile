import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/notifications/presentation/widgets/notification_card.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('unread card shows a localized category and explicit state', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        NotificationCard(
          notification: const {
            'message': 'Your registration was approved.',
            'type': 'CompetitionRegistrationApproved',
            'relatedEntityType': 'CompetitionEvent',
            'createdAt': '2026-08-14T08:30:00Z',
            'isRead': false,
          },
          onTap: () {},
          onMarkRead: () {},
        ),
      ),
    );

    expect(find.text('Competition'), findsOneWidget);
    expect(find.text('Unread'), findsOneWidget);
    expect(find.text('CompetitionRegistrationApproved'), findsNothing);
    expect(find.byTooltip('Mark read'), findsOneWidget);
  });

  testWidgets('read card has an explicit state and opens from the card tap', (
    tester,
  ) async {
    var openCount = 0;
    await tester.pumpWidget(
      _app(
        NotificationCard(
          notification: const {
            'message': 'Demo Coach accepted your friend request.',
            'type': 'FriendRequestAccepted',
            'relatedEntityType': 'Friendship',
            'isRead': true,
          },
          onTap: () => openCount++,
        ),
      ),
    );

    expect(find.text('Community'), findsOneWidget);
    expect(find.text('Read'), findsOneWidget);
    expect(find.byTooltip('Mark read'), findsNothing);

    await tester.tap(find.text('Demo Coach accepted your friend request.'));
    await tester.pump();
    expect(openCount, 1);
  });

  testWidgets('unknown notification metadata uses a safe generic category', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        NotificationCard(
          notification: const {
            'type': 'FutureBackendEvent',
            'relatedEntityType': 'FutureEntity',
            'isRead': true,
          },
          onTap: () {},
        ),
      ),
    );

    expect(find.text('General'), findsOneWidget);
    expect(find.text('You have a new notification.'), findsOneWidget);
    expect(find.text('FutureBackendEvent'), findsNothing);
    expect(find.text('FutureEntity'), findsNothing);
  });

  testWidgets('long messages fit on a narrow phone without overflow', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(320, 640);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      _app(
        NotificationCard(
          notification: const {
            'message':
                'Your registration for the international powerlifting championship has been reviewed and approved.',
            'type': 'CompetitionRegistrationApproved',
            'relatedEntityType': 'CompetitionEvent',
            'createdAt': '2026-08-14T08:30:00Z',
            'isRead': false,
          },
          onTap: () {},
          onMarkRead: () {},
        ),
      ),
    );

    expect(tester.takeException(), isNull);
  });

  testWidgets('mark-read action does not also open the notification', (
    tester,
  ) async {
    var openCount = 0;
    var markReadCount = 0;
    await tester.pumpWidget(
      _app(
        NotificationCard(
          notification: const {
            'message': 'You have a new message.',
            'type': 'NewMessage',
            'relatedEntityType': 'Relationship',
            'createdAt': '2026-08-14T08:30:00Z',
            'isRead': false,
          },
          onTap: () => openCount++,
          onMarkRead: () => markReadCount++,
        ),
      ),
    );

    await tester.tap(find.byTooltip('Mark read'));
    await tester.pump();

    expect(markReadCount, 1);
    expect(openCount, 0);
  });

  testWidgets('card uses Vietnamese category and read-state labels', (
    tester,
  ) async {
    await tester.pumpWidget(
      _app(
        NotificationCard(
          notification: const {
            'message': 'Bạn có tin nhắn mới.',
            'type': 'NewMessage',
            'relatedEntityType': 'Relationship',
            'isRead': false,
          },
          onTap: () {},
          onMarkRead: () {},
        ),
        locale: const Locale('vi'),
      ),
    );

    expect(find.text('Huấn luyện'), findsOneWidget);
    expect(find.text('Chưa đọc'), findsOneWidget);
  });
}

Widget _app(Widget child, {Locale locale = const Locale('en')}) {
  return MaterialApp(
    theme: AppTheme.light(),
    locale: locale,
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: Scaffold(
      body: Center(
        child: SizedBox(width: 420, child: child),
      ),
    ),
  );
}
