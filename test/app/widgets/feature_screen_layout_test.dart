import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/home_shell.dart';
import 'package:xenoh_mobile/app/theme/app_theme.dart';
import 'package:xenoh_mobile/core/widgets/xn_card.dart';
import 'package:xenoh_mobile/features/shared_api/api_widgets.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  const viewports = [
    Size(320, 640),
    Size(390, 844),
    Size(768, 1024),
  ];

  for (final locale in const [Locale('en'), Locale('vi')]) {
    for (final viewport in viewports) {
      testWidgets(
        'feature frame fits ${locale.languageCode} at '
        '${viewport.width.toInt()}x${viewport.height.toInt()}',
        (tester) async {
          tester.view
            ..physicalSize = viewport
            ..devicePixelRatio = 1;
          addTearDown(tester.view.reset);

          await tester.pumpWidget(
            MaterialApp(
              locale: locale,
              theme: AppTheme.light(),
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              supportedLocales: AppLocalizations.supportedLocales,
              builder: (context, child) => MediaQuery(
                data: MediaQuery.of(
                  context,
                ).copyWith(textScaler: const TextScaler.linear(1.3)),
                child: child!,
              ),
              home: const FeatureScreenFrame(
                title: 'Training overview and recovery',
                leading: HomeShellMenuButton(),
                children: [
                  FeatureHeader(
                    title: 'Training overview and recovery',
                    subtitle:
                        'Review recent work, recovery signals, and the next '
                        'recommended action.',
                    icon: Icons.fitness_center_outlined,
                  ),
                ],
              ),
            ),
          );

          expect(tester.takeException(), isNull);
          expect(find.byType(HomeShellMenuButton), findsOneWidget);
          expect(find.byType(XnCard), findsOneWidget);
          final headerCard = tester.widget<XnCard>(find.byType(XnCard));
          expect(headerCard.color, isNot(Colors.transparent));
        },
      );
    }
  }

  testWidgets('feature frame can opt into a wide desktop canvas', (
    tester,
  ) async {
    tester.view
      ..physicalSize = const Size(1400, 900)
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      const MaterialApp(
        home: FeatureScreenFrame(
          title: 'Client information',
          contentMaxWidth: 1120,
          children: [SizedBox()],
        ),
      ),
    );

    expect(tester.getSize(find.byType(ListView)).width, 1120);
  });
}
