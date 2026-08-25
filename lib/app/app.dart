import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/utils/current_date_provider.dart';
import '../features/auth/presentation/providers/auth_controller.dart';
import '../features/auth/presentation/providers/auth_state.dart';
import '../features/coach_client/presentation/providers/chat_unread_controller.dart';
import '../features/profile/data/repositories/profile_background_repository.dart';
import '../features/profile/presentation/providers/preferences_provider.dart';
import '../features/subscription/presentation/providers/subscription_controllers.dart';
import '../l10n/app_localizations.dart';
import 'router/router.dart';
import 'theme/app_density.dart';
import 'theme/app_theme.dart';
import 'widgets/xn_grid_background.dart';

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
        return AppDensityScope(
          child: _AppLifecycleLayer(
            child: XnGridBackground(child: child ?? const SizedBox.shrink()),
          ),
        );
      },
    );
  }
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
      // Subscriptions are bought outside the app, so the entitlement can
      // change while it is backgrounded. `subscriptionProvider` is kept alive
      // for the whole session by the home shell (organizer nav watches it),
      // so without this a user who subscribes in their browser and switches
      // back keeps seeing their old tier until they force-quit.
      ref
        ..invalidate(chatUnreadControllerProvider)
        ..invalidate(subscriptionProvider);
    }
  }

  void _syncBackgroundUser(AuthState auth) {
    ref
        .read(backgroundUserIdProvider.notifier)
        .useAccount(auth.sessionOrNull?.user.id);
  }

  @override
  Widget build(BuildContext context) {
    // Header-card backgrounds are stored per account. Pushing the session's
    // user id here — rather than having each card read the session — keeps
    // one source of truth and makes a logout/login swap re-resolve every
    // header card at once instead of leaving the previous account's image up.
    _syncBackgroundUser(ref.watch(authControllerProvider));
    ref.listen(authControllerProvider, (_, next) => _syncBackgroundUser(next));

    return widget.child ?? const SizedBox.shrink();
  }
}
