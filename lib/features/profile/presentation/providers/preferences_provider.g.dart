// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'preferences_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// The app's active [Locale] override, derived from the user's saved
/// `language` preference. `null` means "no override yet" — MaterialApp
/// falls back to system-locale negotiation against `supportedLocales`,
/// which is the desired behavior before the preference has loaded.

@ProviderFor(AppLocale)
final appLocaleProvider = AppLocaleProvider._();

/// The app's active [Locale] override, derived from the user's saved
/// `language` preference. `null` means "no override yet" — MaterialApp
/// falls back to system-locale negotiation against `supportedLocales`,
/// which is the desired behavior before the preference has loaded.
final class AppLocaleProvider extends $NotifierProvider<AppLocale, Locale?> {
  /// The app's active [Locale] override, derived from the user's saved
  /// `language` preference. `null` means "no override yet" — MaterialApp
  /// falls back to system-locale negotiation against `supportedLocales`,
  /// which is the desired behavior before the preference has loaded.
  AppLocaleProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'appLocaleProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$appLocaleHash();

  @$internal
  @override
  AppLocale create() => AppLocale();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale?>(value),
    );
  }
}

String _$appLocaleHash() => r'3544aaf667f7804a0b65aa61347a4df96848bcab';

/// The app's active [Locale] override, derived from the user's saved
/// `language` preference. `null` means "no override yet" — MaterialApp
/// falls back to system-locale negotiation against `supportedLocales`,
/// which is the desired behavior before the preference has loaded.

abstract class _$AppLocale extends $Notifier<Locale?> {
  Locale? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<Locale?, Locale?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale?, Locale?>,
              Locale?,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}

@ProviderFor(weightUnit)
final weightUnitProvider = WeightUnitProvider._();

final class WeightUnitProvider
    extends $FunctionalProvider<WeightUnit, WeightUnit, WeightUnit>
    with $Provider<WeightUnit> {
  WeightUnitProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'weightUnitProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$weightUnitHash();

  @$internal
  @override
  $ProviderElement<WeightUnit> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  WeightUnit create(Ref ref) {
    return weightUnit(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(WeightUnit value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<WeightUnit>(value),
    );
  }
}

String _$weightUnitHash() => r'f3d44f0feec69df9c6dded249abde61d7fe2d1a3';
