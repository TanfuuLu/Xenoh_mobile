import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'date_only.dart';

part 'current_date_provider.g.dart';

/// The app's current calendar day (date-only, local time).
///
/// Kept alive for the whole app lifetime and refreshed via
/// [refreshIfChanged] whenever the app resumes from the background (wired in
/// `app.dart`'s `_AppLifecycleLayer`). Anything that shows "today"-scoped
/// data (dashboard's today workout, nutrition's daily log, etc.) should watch
/// this instead of computing `DateTime.now()` once and caching it in a
/// field — otherwise the UI keeps showing yesterday's data if the app was
/// left open, or just backgrounded, across midnight.
@Riverpod(keepAlive: true)
class CurrentDate extends _$CurrentDate {
  @override
  DateTime build() => DateOnly.truncate(DateTime.now());

  void refreshIfChanged() {
    final now = DateOnly.truncate(DateTime.now());
    if (now != state) state = now;
  }
}
