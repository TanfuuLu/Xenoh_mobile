import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:xenoh_mobile/core/error/failure.dart';
import 'package:xenoh_mobile/core/error/failure_l10n.dart';
import 'package:xenoh_mobile/core/utils/date_labels.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  late AppLocalizations vi;
  late AppLocalizations en;

  setUpAll(() async {
    vi = await AppLocalizations.delegate.load(const Locale('vi'));
    en = await AppLocalizations.delegate.load(const Locale('en'));
    await initializeDateFormatting('vi');
  });

  group('localizedFailureMessage', () {
    test('generic failures use translated copy, not the English default', () {
      expect(
        localizedFailureMessage(const NetworkFailure(), vi),
        vi.commonNetworkError,
      );
      expect(
        localizedFailureMessage(const AuthFailure(), vi),
        vi.commonSessionExpiredError,
      );
      expect(
        localizedFailureMessage(const ServerFailure(), vi),
        vi.commonServerError,
      );
      expect(
        localizedFailureMessage(const NotFoundFailure(), vi),
        vi.commonNotFoundError,
      );
      expect(
        localizedFailureMessage(const UnknownFailure(), en),
        en.commonSomethingWentWrong,
      );
    });

    test('cancelled and certificate transports read differently', () {
      const cancelled = NetworkFailure(
        'Request cancelled.',
        NetworkFailureKind.cancelled,
      );
      expect(
        localizedFailureMessage(cancelled, vi),
        vi.commonRequestCancelledError,
      );
      expect(
        localizedFailureMessage(cancelled, vi),
        isNot(localizedFailureMessage(const NetworkFailure(), vi)),
      );
    });

    test('a message from the API body is shown as-is', () {
      const failure = ValidationFailure(
        'Plan limit reached.',
        isServerMessage: true,
      );
      expect(localizedFailureMessage(failure, vi), 'Plan limit reached.');
    });
  });

  group('DateLabels', () {
    test('month and weekday labels follow the locale', () {
      final date = DateTime(2026, 8, 20);
      expect(
        DateLabels.monthDay(date, 'en'),
        isNot(DateLabels.monthDay(date, 'vi')),
      );
      expect(DateLabels.weekday(date, 'en'), 'Thursday');
      expect(DateLabels.weekday(date, 'vi'), isNot('Thursday'));
    });
  });
}
