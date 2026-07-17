import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/current_date_provider.dart';
import '../features/profile/presentation/providers/preferences_provider.dart';
import '../l10n/app_localizations.dart';
import 'router/router.dart';
import 'theme/app_theme.dart';

class XenohApp extends ConsumerWidget {
  const XenohApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp.router(
      title: 'Xenoh',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      // Localization delegates + locales so the IME (incl. Vietnamese Telex/VNI)
      // and Material widgets behave correctly for non-English input.
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [Locale('en'), Locale('vi')],
      // Null until the user's saved language preference loads, in which case
      // MaterialApp falls back to system-locale negotiation above.
      locale: ref.watch(appLocaleProvider),
      routerConfig: ref.watch(routerProvider),
      // Keeps date-sensitive providers in sync when the app resumes or stays
      // open across midnight.
      builder: (context, child) {
        final mediaQuery = MediaQuery.of(context);
        return MediaQuery(
          data: mediaQuery.copyWith(
            textScaler: _CompactTextScaler(mediaQuery.textScaler),
          ),
          child: _AppLifecycleLayer(child: child),
        );
      },
    );
  }
}

/// Keeps platform accessibility scaling while making the app's base type
/// scale slightly denser than Material's default.
final class _CompactTextScaler extends TextScaler {
  const _CompactTextScaler(this.delegate);

  static const _factor = 0.92;

  final TextScaler delegate;

  @override
  double scale(double fontSize) => delegate.scale(fontSize) * _factor;

  @override
  double get textScaleFactor => scale(14) / 14;

  @override
  bool operator ==(Object other) =>
      other is _CompactTextScaler && other.delegate == delegate;

  @override
  int get hashCode => Object.hash(_CompactTextScaler, delegate);
}

class _AppLifecycleLayer extends ConsumerStatefulWidget {
  const _AppLifecycleLayer({required this.child});

  final Widget? child;

  @override
  ConsumerState<_AppLifecycleLayer> createState() => _AppLifecycleLayerState();
}

class _AppLifecycleLayerState extends ConsumerState<_AppLifecycleLayer>
    with WidgetsBindingObserver {
  Timer? _midnightPoll;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // Catches the rarer case — the app stays open continuously through
    // midnight without ever backgrounding. `didChangeAppLifecycleState`
    // below handles the far more common "backgrounded overnight, resumed
    // the next day" case; this is just a low-frequency safety net.
    _midnightPoll = Timer.periodic(
      const Duration(minutes: 1),
      (_) => ref.read(currentDateProvider.notifier).refreshIfChanged(),
    );
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    _midnightPoll?.cancel();
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    // Catches the common case — app backgrounded overnight, resumed the next
    // day — so "today"-scoped screens (dashboard, nutrition, ...) refetch
    // instead of showing yesterday's cached data. See `currentDateProvider`.
    if (state == AppLifecycleState.resumed) {
      ref.read(currentDateProvider.notifier).refreshIfChanged();
    }
  }

  @override
  Widget build(BuildContext context) => widget.child ?? const SizedBox.shrink();
}
