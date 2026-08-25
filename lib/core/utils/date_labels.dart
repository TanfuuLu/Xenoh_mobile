import 'package:intl/intl.dart' as intl;

/// Locale-aware short date labels for charts, chips, and list captions.
///
/// These replace the per-file `['Jan', 'Feb', ...]` tables that used to render
/// English month names regardless of the app locale. Pass the locale from
/// `Localizations.localeOf(context).toString()` so Vietnamese reads "thg 8"
/// instead of "Aug".
abstract final class DateLabels {
  /// `"Aug 17"` / `"17 thg 8"`.
  static String monthDay(DateTime date, String locale) =>
      intl.DateFormat.MMMd(locale).format(date);

  /// `"Aug 17, 2026"` / `"17 thg 8, 2026"`.
  static String monthDayYear(DateTime date, String locale) =>
      intl.DateFormat.yMMMd(locale).format(date);

  /// `"Aug 17, 14:05"` / `"17 thg 8, 14:05"`.
  static String monthDayTime(DateTime date, String locale) =>
      '${monthDay(date, locale)}, ${intl.DateFormat.Hm(locale).format(date)}';

  /// `"Aug 17, 2026, 14:05"`.
  static String monthDayYearTime(DateTime date, String locale) =>
      '${monthDayYear(date, locale)}, '
      '${intl.DateFormat.Hm(locale).format(date)}';

  /// Full weekday name ("Thursday" / "Thứ Năm").
  ///
  /// Training payloads carry an English `dayOfWeek` string; always derive the
  /// label from the date instead so it follows the app locale.
  static String weekday(DateTime date, String locale) =>
      intl.DateFormat.EEEE(locale).format(date);

  /// Abbreviated weekday name ("Thu" / "Th 5").
  static String weekdayShort(DateTime date, String locale) =>
      intl.DateFormat.E(locale).format(date);
}
