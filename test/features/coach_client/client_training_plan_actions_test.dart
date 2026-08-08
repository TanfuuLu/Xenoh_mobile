import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/widgets/client_training_plan_actions.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('only exposes the create plan action on a narrow screen', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(280, 600);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    var createdPlan = false;

    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ClientTrainingPlanActions(
            onCreatePlan: () => createdPlan = true,
          ),
        ),
      ),
    );

    expect(
      find.byKey(ClientTrainingPlanActions.createPlanKey),
      findsOneWidget,
    );
    expect(find.text("Today's workout"), findsNothing);
    expect(find.byType(ActionChip), findsNothing);
    expect(tester.takeException(), isNull);

    await tester.tap(find.byKey(ClientTrainingPlanActions.createPlanKey));

    expect(createdPlan, isTrue);
  });

  testWidgets('create plan remains available without an active plan', (
    tester,
  ) async {
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Scaffold(
          body: ClientTrainingPlanActions(
            onCreatePlan: () {},
          ),
        ),
      ),
    );

    expect(
      find.byKey(ClientTrainingPlanActions.createPlanKey),
      findsOneWidget,
    );
  });
}
