import 'package:flutter/material.dart';

import 'branding/app_brand.dart';
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
class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.bgPage,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              AppBrand.emblemAsset,
              width: AppBrand.splashEmblemSize,
              fit: BoxFit.contain,
              filterQuality: FilterQuality.medium,
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
