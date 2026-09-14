import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'branding/app_brand.dart';
import 'startup/opening_animation_gate.dart';
import 'theme/app_colors.dart';

/// Shown while the app resolves the initial auth state (silent refresh).
///
/// Deliberately mirrors `flutter_native_splash.yaml`'s native splash (same
/// Ascend emblem, same [AppColors.bgPage]
/// background) so there's no visible logo swap or background flash the
/// instant the Flutter engine takes over from the native splash. Uses an
/// explicit background color rather than the app's usual transparent
/// Scaffold, so it never shows the user's custom background photo before
/// preferences have even loaded.
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _openingLightController;

  @override
  void initState() {
    super.initState();
    _openingLightController = AnimationController(
      duration: const Duration(milliseconds: 1800),
      vsync: this,
    )..addStatusListener(_onOpeningAnimationStatus);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      unawaited(_startOpeningAnimation());
    });
  }

  Future<void> _startOpeningAnimation() async {
    try {
      await Future.wait([
        precacheImage(
          const AssetImage(AppBrand.openingEmblemWhiteCircleAsset),
          context,
        ),
        precacheImage(
          const AssetImage(AppBrand.openingEmblemGoldCircleAsset),
          context,
        ),
        precacheImage(const AssetImage(AppBrand.emblemAsset), context),
      ]);
    } catch (_) {
      // The base screen remains visible if an asset cannot be cached. Continue
      // instead of keeping the user on the startup route indefinitely.
    }

    if (mounted) {
      await _openingLightController.forward();
    }
  }

  void _onOpeningAnimationStatus(AnimationStatus status) {
    if (status != AnimationStatus.completed) return;

    if (mounted) {
      completeOpeningAnimation();
      setState(() {});
    }
  }

  @override
  void dispose() {
    _openingLightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.sizeOf(context);
    final emblemSize = math.min(
      AppBrand.splashEmblemSize,
      screenSize.shortestSide - 48,
    );

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                RepaintBoundary(
                  child: SizedBox.square(
                    dimension: emblemSize,
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        Image.asset(
                          AppBrand.openingEmblemWhiteCircleAsset,
                          key: const Key('splash-circle-base'),
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                        AnimatedBuilder(
                          animation: _openingLightController,
                          child: Image.asset(
                            AppBrand.openingEmblemGoldCircleAsset,
                            key: const Key('splash-gold-circle'),
                            fit: BoxFit.contain,
                            filterQuality: FilterQuality.medium,
                            excludeFromSemantics: true,
                          ),
                          builder: (context, originalEmblem) {
                            if (_openingLightController.isCompleted) {
                              return Image.asset(
                                AppBrand.emblemAsset,
                                key: const Key('splash-original-emblem'),
                                fit: BoxFit.contain,
                                filterQuality: FilterQuality.medium,
                                excludeFromSemantics: true,
                              );
                            }

                            return ClipPath(
                              key: const Key('splash-circle-reveal'),
                              clipper: _CircleStrokeRevealClipper(
                                progress: _openingLightController.value,
                              ),
                              child: originalEmblem,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 28),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(strokeWidth: 2),
            ),
          ],
        ),
      ),
    );
  }
}

/// Reveals the original brushstroke from its left edge, across the top, and
/// then clockwise until the white starter circle is fully painted gold.
class _CircleStrokeRevealClipper extends CustomClipper<Path> {
  const _CircleStrokeRevealClipper({required this.progress});

  final double progress;

  @override
  Path getClip(Size size) {
    if (progress >= 1) return Path()..addRect(Offset.zero & size);

    final center = Offset(size.width / 2, size.height * 0.49);
    final radius = size.width * 0.51;
    final sweep = math.pi * 2 * progress;
    return Path()
      ..moveTo(center.dx, center.dy)
      ..arcTo(
        Rect.fromCircle(center: center, radius: radius),
        math.pi,
        sweep,
        false,
      )
      ..close();
  }

  @override
  bool shouldReclip(covariant _CircleStrokeRevealClipper oldClipper) =>
      oldClipper.progress != progress;
}
