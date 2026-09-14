import 'package:flutter/foundation.dart';

/// Keeps the first protected route on the splash screen until its opening
/// animation has finished. The notifier lives for the app process, so the
/// animation is shown only for the initial launch.
final openingAnimationCompletedNotifier = ValueNotifier<bool>(false);

void completeOpeningAnimation() {
  openingAnimationCompletedNotifier.value = true;
}
