import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../app/theme/app_dimens.dart';
import 'error_view.dart';

/// Standard way to render a Riverpod [AsyncValue] across the app.
///
/// Keeps the last data on screen during refreshes/reloads — the loading
/// spinner and error view only appear on the **first** load (when there's no
/// value yet). After an `invalidate`/`refresh` the previous data stays visible
/// and is swapped in place when the new value arrives, so the UI never flashes
/// a full-screen spinner.
///
/// Use this instead of `asyncValue.when(...)` for screen/section content.
class AsyncValueView<T> extends StatelessWidget {
  const AsyncValueView({
    required this.value,
    required this.data,
    this.onRetry,
    this.errorBuilder,
    this.loading,
    super.key,
  });

  final AsyncValue<T> value;

  /// Builds the UI for the current (possibly stale during refresh) value.
  final Widget Function(T data) data;

  /// Retry action for the first-load error state.
  final VoidCallback? onRetry;

  /// Optional feature-specific first-load error state.
  final Widget Function(Object error)? errorBuilder;

  /// Optional override for the first-load spinner.
  final Widget? loading;

  @override
  Widget build(BuildContext context) {
    if (value.hasValue) {
      return _MotionSwitcher(
        child: KeyedSubtree(
          key: const ValueKey('data'),
          child: data(value.requireValue),
        ),
      );
    }

    if (value.hasError) {
      // ListView so the error state still supports pull-to-refresh.
      return _MotionSwitcher(
        child: ListView(
          key: const ValueKey('error'),
          children: [
            SizedBox(
              height: MediaQuery.sizeOf(context).height * 0.7,
              child:
                  errorBuilder?.call(value.error!) ??
                  ErrorView.from(value.error!, context, onRetry: onRetry),
            ),
          ],
        ),
      );
    }

    return _MotionSwitcher(
      child: KeyedSubtree(
        key: const ValueKey('loading'),
        child: loading ?? const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}

class _MotionSwitcher extends StatelessWidget {
  const _MotionSwitcher({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AppMotion.fast,
      reverseDuration: AppMotion.fast,
      switchInCurve: Curves.easeOutCubic,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        final offset = Tween<Offset>(
          begin: const Offset(0, 0.015),
          end: Offset.zero,
        ).animate(animation);

        return FadeTransition(
          opacity: animation,
          child: SlideTransition(position: offset, child: child),
        );
      },
      child: child,
    );
  }
}
