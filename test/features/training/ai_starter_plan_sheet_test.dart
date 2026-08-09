import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/features/training/presentation/widgets/ai_starter_plan_sheet.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _FakeXenohApi extends XenohApi {
  _FakeXenohApi() : super(Dio());

  String? postedPath;
  JsonMap? postedBody;

  @override
  Future<JsonMap> postObject(String path, JsonMap data) async {
    postedPath = path;
    postedBody = data;
    return {'id': 'generated-plan'};
  }
}

void main() {
  testWidgets('AI starter sends the backend split wire value', (tester) async {
    tester.view.physicalSize = const Size(450, 1200);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);
    final api = _FakeXenohApi();

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: Scaffold(body: AiStarterPlanSheet()),
        ),
      ),
    );

    final submit = find.text('Generate plan');
    await tester.ensureVisible(submit);
    await tester.tap(submit);
    await tester.pumpAndSettle();

    expect(api.postedPath, '/plans/starter-ai');
    expect(api.postedBody?['splitPreference'], 'full_body');
  });
}
