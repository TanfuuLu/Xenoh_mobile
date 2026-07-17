// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'current_date_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's current calendar day (date-only, local time).
///
/// Kept alive for the whole app lifetime and refreshed via
/// [refreshIfChanged] whenever the app resumes from the background (wired in
/// `app.dart`'s `_AppLifecycleLayer`). Anything that shows "today"-scoped
/// data (dashboard's today workout, nutrition's daily log, etc.) should watch
/// this instead of computing `DateTime.now()` once and caching it in a
/// field — otherwise the UI keeps showing yesterday's data if the app was
/// left open, or just backgrounded, across midnight.

@ProviderFor(CurrentDate)
final currentDateProvider = CurrentDateProvider._();

/// The app's current calendar day (date-only, local time).
///
/// Kept alive for the whole app lifetime and refreshed via
/// [refreshIfChanged] whenever the app resumes from the background (wired in
/// `app.dart`'s `_AppLifecycleLayer`). Anything that shows "today"-scoped
/// data (dashboard's today workout, nutrition's daily log, etc.) should watch
/// this instead of computing `DateTime.now()` once and caching it in a
/// field — otherwise the UI keeps showing yesterday's data if the app was
/// left open, or just backgrounded, across midnight.
final class CurrentDateProvider
    extends $NotifierProvider<CurrentDate, DateTime> {
  /// The app's current calendar day (date-only, local time).
  ///
  /// Kept alive for the whole app lifetime and refreshed via
  /// [refreshIfChanged] whenever the app resumes from the background (wired in
  /// `app.dart`'s `_AppLifecycleLayer`). Anything that shows "today"-scoped
  /// data (dashboard's today workout, nutrition's daily log, etc.) should watch
  /// this instead of computing `DateTime.now()` once and caching it in a
  /// field — otherwise the UI keeps showing yesterday's data if the app was
  /// left open, or just backgrounded, across midnight.
  CurrentDateProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'currentDateProvider',
        isAutoDispose: false,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$currentDateHash();

  @$internal
  @override
  CurrentDate create() => CurrentDate();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DateTime value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<DateTime>(value),
    );
  }
}

String _$currentDateHash() => r'82f7686ad9e6ccb8424a21afa71bb76324a4cc08';

/// The app's current calendar day (date-only, local time).
///
/// Kept alive for the whole app lifetime and refreshed via
/// [refreshIfChanged] whenever the app resumes from the background (wired in
/// `app.dart`'s `_AppLifecycleLayer`). Anything that shows "today"-scoped
/// data (dashboard's today workout, nutrition's daily log, etc.) should watch
/// this instead of computing `DateTime.now()` once and caching it in a
/// field — otherwise the UI keeps showing yesterday's data if the app was
/// left open, or just backgrounded, across midnight.

abstract class _$CurrentDate extends $Notifier<DateTime> {
  DateTime build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<DateTime, DateTime>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<DateTime, DateTime>,
              DateTime,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
