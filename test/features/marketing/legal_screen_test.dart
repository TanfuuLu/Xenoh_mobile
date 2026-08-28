import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/marketing/presentation/screens/legal_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('privacy screen mirrors the published Xenoh policy', (
    tester,
  ) async {
    await _pumpLegalScreen(tester, LegalPageKind.privacy);

    expect(find.text('Last updated 2 August 2026'), findsOneWidget);
    expect(find.text('What we collect'), findsOneWidget);
    expect(find.text('Keeping and deleting your data'), findsOneWidget);
    expect(find.textContaining('retained for up to 7 years'), findsOneWidget);
    expect(find.textContaining('privacy@xenoh.app'), findsOneWidget);
  });

  testWidgets('terms screen mirrors the published Xenoh terms', (tester) async {
    await _pumpLegalScreen(tester, LegalPageKind.terms);

    expect(find.text('Last updated 2 August 2026'), findsOneWidget);
    expect(find.text('Plans and billing'), findsOneWidget);
    expect(find.text('Health disclaimer'), findsOneWidget);
    expect(find.text('Limits of liability'), findsOneWidget);
    expect(find.textContaining('support@xenoh.app'), findsOneWidget);
  });

  testWidgets('refund policy keeps its existing launch disclaimer', (
    tester,
  ) async {
    await _pumpLegalScreen(tester, LegalPageKind.refund);

    expect(
      find.textContaining('should be replaced with finalized legal copy'),
      findsOneWidget,
    );
  });

  test(
    'privacy and terms routes do not use the public bottom menu wrapper',
    () {
      final routerSource = File(
        'lib/app/router/router.dart',
      ).readAsStringSync();

      expect(
        _routeBlock(routerSource, '/privacy'),
        isNot(contains('_withMenu')),
      );
      expect(_routeBlock(routerSource, '/terms'), isNot(contains('_withMenu')));
    },
  );
}

String _routeBlock(String routerSource, String path) {
  final pathIndex = routerSource.indexOf("path: '$path'");
  final routeStart = routerSource.lastIndexOf('GoRoute(', pathIndex);
  final nextRoute = routerSource.indexOf('GoRoute(', pathIndex + 1);
  return routerSource.substring(routeStart, nextRoute);
}

Future<void> _pumpLegalScreen(
  WidgetTester tester,
  LegalPageKind kind,
) async {
  await tester.binding.setSurfaceSize(const Size(420, 900));
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: AppLocalizations.supportedLocales,
      home: LegalScreen(kind: kind),
    ),
  );
  await tester.pumpAndSettle();
}
