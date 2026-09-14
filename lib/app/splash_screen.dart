import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import 'branding/app_brand.dart';
import 'startup/opening_animation_gate.dart';
import 'theme/app_colors.dart';

/// Shown while the app resolves the initial auth state (silent refresh).
///
/// Matches the native splash background. Flutter owns the full, unmasked logo
/// and waits for its images before painting the circle from left to right.
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
    if (!mounted) return;
    try {
      await Future.wait([
        precacheImage(
          const AssetImage(AppBrand.openingEmblemWhiteCircleAsset),
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
                          _openingLightController.isCompleted
                              ? AppBrand.emblemAsset
                              : AppBrand.openingEmblemWhiteCircleAsset,
                          key: const Key('splash-circle-base'),
                          fit: BoxFit.contain,
                          filterQuality: FilterQuality.medium,
                        ),
                        AnimatedBuilder(
                          animation: _openingLightController,
                          child: Image.asset(
                            AppBrand.emblemAsset,
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

                            return ClipRect(
                              key: const Key('splash-circle-reveal'),
                              clipper: CircleStrokeRevealClipper(
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

/// Reveals the original image horizontally without imposing a circular crop.
class CircleStrokeRevealClipper extends CustomClipper<Rect> {
  const CircleStrokeRevealClipper({required this.progress});

  final double progress;

  @override
  Rect getClip(Size size) => Rect.fromLTWH(
    0,
    0,
    size.width * progress.clamp(0.0, 1.0),
    size.height,
  );

  @override
  bool shouldReclip(covariant CircleStrokeRevealClipper oldClipper) =>
      oldClipper.progress != progress;
}
