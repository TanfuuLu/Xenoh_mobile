/// Web/desktop stub — ongoing notifications are an Android-only concept here.
abstract final class WorkoutNotificationService {
  static void configureChannelLabels({
    required String name,
    required String description,
  }) {}

  static Future<void> showOrUpdate({
    required String title,
    required String setInfo,
    DateTime? timerStartedAtUtc,
    String? dailyWorkoutId,
    String? imageUrl,
  }) async {}

  static Future<void> stop() async {}

  static Future<bool> isLockScreenConsentGranted() async => false;

  static Future<bool> requestNotificationAccess() async => false;

  static Future<void> openLockScreenChannelSettings() async {}

  static void addNotificationTapListener(
    void Function(String dailyWorkoutId) onTap,
  ) {}

  static void addNotificationDismissListener(
    void Function(String dailyWorkoutId) onDismiss,
  ) {}
}
