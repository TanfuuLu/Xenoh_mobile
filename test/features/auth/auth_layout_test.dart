import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/features/auth/presentation/widgets/auth_layout.dart';

void main() {
  testWidgets('auth layout keeps the title flat on the page background', (
    tester,
  ) async {
    await _pumpAuthLayout(tester, const Size(390, 844));

    expect(find.byKey(AuthLayout.headerKey), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(AuthLayout.headerKey),
        matching: find.byType(CustomPaint),
      ),
      findsNothing,
    );
    expect(find.byKey(AuthLayout.formKey), findsOneWidget);
    expect(
      find.descendant(
        of: find.byKey(AuthLayout.formKey),
        matching: find.text('Welcome back'),
      ),
      findsNothing,
    );
    expect(tester.takeException(), isNull);
  });

  testWidgets(
    'auth layout adapts without overflow on narrow and wide windows',
    (
      tester,
    ) async {
      await _pumpAuthLayout(tester, const Size(320, 700));
      expect(find.byKey(AuthLayout.wideKey), findsNothing);
      expect(tester.takeException(), isNull);

      await _pumpAuthLayout(tester, const Size(1000, 800));
      expect(find.byKey(AuthLayout.wideKey), findsOneWidget);
      expect(tester.takeException(), isNull);
    },
  );
}

Future<void> _pumpAuthLayout(WidgetTester tester, Size size) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: const AuthLayout(
        title: 'Welcome back',
        subtitle: 'Sign in to continue your training plan.',
        child: TextField(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
