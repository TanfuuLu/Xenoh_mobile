/// Helpers for the backend `DateOnly` wire format (`"yyyy-MM-dd"`), which is
/// distinct from full ISO-8601 `DateTime` timestamps (see API ref §1 / §6).
abstract final class DateOnly {
  /// Parse `"yyyy-MM-dd"` into a local [DateTime] at midnight. Returns null on
  /// null/blank input; throws [FormatException] on malformed non-null input.
  static DateTime? tryParse(String? value) {
    if (value == null || value.isEmpty) return null;
    final parts = value.split('-');
    if (parts.length != 3) {
      throw FormatException('Invalid DateOnly: $value');
    }
    return DateTime(
      int.parse(parts[0]),
      int.parse(parts[1]),
      int.parse(parts[2]),
    );
  }

  /// Format a [DateTime] as `"yyyy-MM-dd"` (date component only).
  static String format(DateTime date) {
    final m = date.month.toString().padLeft(2, '0');
    final d = date.day.toString().padLeft(2, '0');
    return '${date.year}-$m-$d';
  }

  /// Drops the time-of-day component, keeping year/month/day only — the
  /// stable, comparable key most date-keyed providers (food logs, meal
  /// plans, `currentDateProvider`) use.
  static DateTime truncate(DateTime value) =>
      DateTime(value.year, value.month, value.day);
}
