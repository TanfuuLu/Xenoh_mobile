import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/shared_api/api_presentation.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('does not expose low-level Dio messages to users', (
    tester,
  ) async {
    late BuildContext context;
    await tester.pumpWidget(
      MaterialApp(
        localizationsDelegates: const [
          AppLocalizations.delegate,
          GlobalMaterialLocalizations.delegate,
          GlobalWidgetsLocalizations.delegate,
          GlobalCupertinoLocalizations.delegate,
        ],
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (value) {
            context = value;
            return const SizedBox();
          },
        ),
      ),
    );
    final error = DioException(
      requestOptions: RequestOptions(path: '/private'),
      message: 'socket details and private host',
    );

    expect(
      apiErrorMessage(error, context),
      AppLocalizations.of(context).commonRequestFailed,
    );
  });

  test('JSON text helpers use the first useful value', () {
    const value = <String, dynamic>{'empty': '', 'name': 'Xenoh'};

    expect(textOf(value, const ['missing', 'empty', 'name']), 'Xenoh');
    expect(optionalTextOf(value, const ['missing']), isNull);
  });
}
