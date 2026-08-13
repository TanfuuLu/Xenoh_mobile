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

  testWidgets('featured login keeps the flat hero clear of the form card', (
    tester,
  ) async {
    await _pumpAuthLayout(
      tester,
      const Size(320, 700),
      variant: AuthLayoutVariant.featured,
    );
    expect(find.byKey(AuthLayout.featuredKey), findsOneWidget);
    expect(find.byKey(AuthLayout.wideKey), findsNothing);
    expect(find.byKey(AuthLayout.formSurfaceKey), findsOneWidget);
    final headerRect = tester.getRect(find.byKey(AuthLayout.headerKey));
    final formRect = tester.getRect(find.byKey(AuthLayout.formKey));
    expect(formRect.top, greaterThanOrEqualTo(headerRect.bottom));

    final formSurface = tester.widget<DecoratedBox>(
      find.byKey(AuthLayout.formSurfaceKey),
    );
    final formDecoration = formSurface.decoration as BoxDecoration;
    expect(formDecoration.color, isNotNull);
    expect(formDecoration.border, isNotNull);
    expect(tester.takeException(), isNull);

    await _pumpAuthLayout(
      tester,
      const Size(1000, 800),
      variant: AuthLayoutVariant.featured,
    );
    expect(find.byKey(AuthLayout.wideKey), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

Future<void> _pumpAuthLayout(
  WidgetTester tester,
  Size size, {
  AuthLayoutVariant variant = AuthLayoutVariant.standard,
}) async {
  await tester.binding.setSurfaceSize(size);
  addTearDown(() => tester.binding.setSurfaceSize(null));
  await tester.pumpWidget(
    MaterialApp(
      theme: AppTheme.light(),
      home: AuthLayout(
        title: 'Welcome back',
        subtitle: 'Sign in to continue your training plan.',
        variant: variant,
        child: const TextField(),
      ),
    ),
  );
  await tester.pumpAndSettle();
}
