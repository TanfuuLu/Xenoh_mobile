import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/features/training/presentation/screens/plan_ai_review_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class MockXenohApi extends Mock implements XenohApi {}

DioException _dio(int status) => DioException(
  requestOptions: RequestOptions(path: '/x'),
  response: Response(
    requestOptions: RequestOptions(path: '/x'),
    statusCode: status,
  ),
);

void main() {
  testWidgets('balance check renders headline, summary, and warnings', (
    tester,
  ) async {
    final api = MockXenohApi();
    when(() => api.postObject(any(), any())).thenAnswer(
      (_) async => {
        'headline': 'Push-dominant week',
        'severity': 'Warning',
        'summary': 'Your plan favors pressing over pulling.',
        'warnings': ['Back volume is low'],
        'suggestions': ['Add a row variation'],
      },
    );

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanBalanceCheckScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(tester.takeException(), isNull);
    expect(find.text('Push-dominant week'), findsOneWidget);
    expect(
      find.text('Your plan favors pressing over pulling.'),
      findsOneWidget,
    );
    expect(find.text('Back volume is low'), findsOneWidget);
    expect(find.text('Add a row variation'), findsOneWidget);
  });

  testWidgets('403 shows the Pro upgrade prompt, not a generic error', (
    tester,
  ) async {
    final api = MockXenohApi();
    when(() => api.postObject(any(), any())).thenThrow(_dio(403));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanBalanceCheckScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Pro feature'), findsOneWidget);
    expect(find.text('Upgrade to Pro'), findsOneWidget);
  });

  testWidgets('429 shows the AI quota notice', (tester) async {
    final api = MockXenohApi();
    when(() => api.postObject(any(), any())).thenThrow(_dio(429));

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: PlanBalanceCheckScreen(planId: 'p1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('AI limit reached'), findsOneWidget);
  });
}
