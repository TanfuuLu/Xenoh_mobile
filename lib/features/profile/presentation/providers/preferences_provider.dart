import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/network/api_language.dart';
import '../../../../core/utils/weight_units.dart';
import '../../../auth/presentation/providers/auth_controller.dart';
import '../../../shared_api/xenoh_api.dart';

part 'preferences_provider.g.dart';

final preferencesProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  return ref.watch(xenohApiProvider).getObject('/users/me/preferences');
});

/// Whether workout logging should collect an RPE value for each completed set.
/// Matches the website preference and the backend default.
final trackRpeProvider = Provider<bool>((ref) {
  final prefs = ref.watch(preferencesProvider);
  return prefs.value?['trackRpe'] as bool? ?? true;
});

/// The app's active [Locale] override, derived from the user's saved
/// `language` preference. `null` means "no override yet" — MaterialApp
/// falls back to system-locale negotiation against `supportedLocales`,
/// which is the desired behavior before the preference has loaded.
@riverpod
class AppLocale extends _$AppLocale {
  @override
  Locale? build() {
    // Wait for the startup silent-refresh to resolve before listening (and
    // thus before `preferencesProvider` fires its first request). Listening
    // eagerly at app boot — before the access token is ready — sends a
    // guaranteed-401 request that then sits cached (autoDispose is pinned
    // alive by this very listener) until the user manually retries the first
    // time they open Preferences. Watches the cheap `authBootstrappedProvider`
    // flag rather than `authControllerProvider` itself, since several other
    // screens also read this provider directly (e.g. to pick the AI request
    // language) and shouldn't be forced to build the whole auth/token/dio
    // bootstrap chain just to check readiness.
    if (ref.watch(authBootstrappedProvider)) {
      ref.listen(preferencesProvider, (previous, next) {
        final language = next.value?['language'] as String?;
        if (language != null) {
          setApiLanguageCode(language);
          state = Locale(apiLanguageCode);
        }
      });
    }
    return null;
  }

  void setLocale(String languageCode) {
    setApiLanguageCode(languageCode);
    state = Locale(apiLanguageCode);
  }
}

@riverpod
WeightUnit weightUnit(Ref ref) {
  final prefs = ref.watch(preferencesProvider);
  return weightUnitFromString(prefs.value?['weightUnit'] as String?);
}
