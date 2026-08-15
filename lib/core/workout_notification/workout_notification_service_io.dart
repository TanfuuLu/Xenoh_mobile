import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_foreground_task/flutter_foreground_task.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../app/theme/app_colors.dart';
import '../config/app_config.dart';
import '../network/http_client.dart';
import 'workout_task_handler.dart';

/// Thin facade over [FlutterForegroundTask] for the "current exercise"
/// ongoing notification. Android only: a genuinely persistent, ticking
/// notification that survives backgrounding requires a foreground service,
/// which iOS doesn't support the same way (background execution there is
/// capped to short OS-scheduled windows) — an iOS equivalent would need a
/// Live Activity (ActivityKit), which requires an Xcode project target this
/// environment can't create or build.
abstract final class WorkoutNotificationService {
  static const _channelId = 'workout_progress_lockscreen_v3';
  static const _consentKey = 'workout_lock_screen_notifications_enabled';
  static bool _initialized = false;

  static void _init() {
    if (_initialized || !Platform.isAndroid) return;
    _initialized = true;
    FlutterForegroundTask.initCommunicationPort();
    FlutterForegroundTask.init(
      androidNotificationOptions: AndroidNotificationOptions(
        // Android notification-channel behavior is immutable after the first
        // creation. Keep this ID versioned when visibility/importance changes
        // so existing installs receive the updated lock-screen behavior.
        channelId: _channelId,
        channelName: 'Workout progress',
        channelDescription:
            'Shows your current exercise on the notification shade and lock screen.',
        channelImportance: NotificationChannelImportance.DEFAULT,
        priority: NotificationPriority.DEFAULT,
        visibility: NotificationVisibility.VISIBILITY_PUBLIC,
        dismissible: true,
        enableVibration: false,
        playSound: false,
        onlyAlertOnce: true,
        showWhen: true,
      ),
      iosNotificationOptions: const IOSNotificationOptions(
        showNotification: false,
      ),
      foregroundTaskOptions: ForegroundTaskOptions(
        eventAction: ForegroundTaskEventAction.repeat(1000),
        autoRunOnBoot: false,
        allowWifiLock: false,
      ),
    );
  }

  /// Starts the ongoing notification if it isn't running, or just pushes an
  /// update if it already is. Safe to call every time the current
  /// exercise/set changes. [dailyWorkoutId] backs tapping the notification to
  /// open that workout day (see [addNotificationTapListener]). [imageUrl]
  /// (the exercise's photo) is downloaded and cached locally, since Android
  /// notifications need a local file path for a large-icon bitmap, not a
  /// network URL.
  static Future<void> showOrUpdate({
    required String title,
    required String setInfo,
    DateTime? timerStartedAtUtc,
    String? dailyWorkoutId,
    String? imageUrl,
  }) async {
    if (!Platform.isAndroid) return;
    if (!await isLockScreenConsentGranted()) return;
    _init();

    final imagePath = await _resolveImagePath(imageUrl);
    final icon = NotificationIcon(
      backgroundColor: AppColors.accent,
      largeIconPath: imagePath,
    );

    if (!await FlutterForegroundTask.isRunningService) {
      var permission =
          await FlutterForegroundTask.checkNotificationPermission();
      debugPrint('[WorkoutNotification] permission check: $permission');
      if (permission != NotificationPermission.granted) {
        permission =
            await FlutterForegroundTask.requestNotificationPermission();
        debugPrint(
          '[WorkoutNotification] permission request result: $permission',
        );
      }
      if (permission != NotificationPermission.granted) {
        debugPrint(
          '[WorkoutNotification] notification permission not granted, aborting start',
        );
        return;
      }

      final result = await FlutterForegroundTask.startService(
        serviceTypes: const [ForegroundServiceTypes.dataSync],
        serviceId: 8420,
        notificationTitle: title,
        notificationText: setInfo,
        notificationIcon: icon,
        notificationInitialRoute: '/dashboard',
        callback: startWorkoutTaskCallback,
      );
      if (result is ServiceRequestFailure) {
        debugPrint(
          '[WorkoutNotification] startService failed: ${result.error}',
        );
        return;
      }
      debugPrint('[WorkoutNotification] service started: $title / $setInfo');
    } else {
      debugPrint(
        '[WorkoutNotification] service already running, sending update: $title / $setInfo',
      );
      await FlutterForegroundTask.updateService(notificationIcon: icon);
    }

    FlutterForegroundTask.sendDataToTask({
      'title': title,
      'setInfo': setInfo,
      'timerStartedAtUtc': timerStartedAtUtc?.toIso8601String(),
      'dailyWorkoutId': dailyWorkoutId,
    });
  }

  static Future<bool> isLockScreenConsentGranted() async {
    if (!Platform.isAndroid) return false;
    final preferences = await SharedPreferences.getInstance();
    return preferences.getBool(_consentKey) ?? false;
  }

  static Future<bool> requestNotificationAccess() async {
    if (!Platform.isAndroid) return false;
    _init();
    var permission = await FlutterForegroundTask.checkNotificationPermission();
    if (permission != NotificationPermission.granted) {
      permission = await FlutterForegroundTask.requestNotificationPermission();
    }
    if (permission != NotificationPermission.granted) return false;

    final preferences = await SharedPreferences.getInstance();
    await preferences.setBool(_consentKey, true);
    return true;
  }

  static Future<void> openLockScreenChannelSettings() async {
    if (!Platform.isAndroid) return;
    await FlutterForegroundTask.openNotificationChannelSettings(_channelId);
  }

  static String? _cachedImageUrl;
  static String? _cachedImagePath;
  static Dio? _imageDio;

  /// Downloads [imageUrl] to a local cache file and returns its path, or null
  /// if there's no URL or the download fails. Keeps only the most recently
  /// requested image on disk (one exercise is "current" at a time).
  static Future<String?> _resolveImagePath(String? imageUrl) async {
    if (imageUrl == null || imageUrl.isEmpty) {
      _cachedImageUrl = null;
      _cachedImagePath = null;
      return null;
    }
    if (imageUrl == _cachedImageUrl) {
      final path = _cachedImagePath;
      if (path != null && File(path).existsSync()) return path;
      _cachedImageUrl = null;
      _cachedImagePath = null;
    }

    try {
      final dio = _imageDio ?? _createImageDio();
      final response = await dio.get<List<int>>(
        imageUrl,
        options: Options(responseType: ResponseType.bytes),
      );
      final bytes = response.data;
      if (bytes == null) return null;

      final dir = await getTemporaryDirectory();
      final file = File('${dir.path}/workout_notification_icon.png');
      await file.writeAsBytes(bytes, flush: true);

      _cachedImageUrl = imageUrl;
      _cachedImagePath = file.path;
      return file.path;
    } catch (e) {
      debugPrint('[WorkoutNotification] failed to download image: $e');
      return null;
    }
  }

  static Dio _createImageDio() {
    final dio = Dio(
      BaseOptions(
        connectTimeout: const Duration(seconds: 10),
        receiveTimeout: const Duration(seconds: 15),
      ),
    );
    configureHttpClient(
      dio,
      allowBadCertificate: AppConfig.allowBadCertificate,
    );
    _imageDio = dio;
    return dio;
  }

  static Future<void> stop() async {
    if (!Platform.isAndroid) return;
    if (!await FlutterForegroundTask.isRunningService) return;
    await FlutterForegroundTask.stopService();
  }

  static void Function(String dailyWorkoutId)? _onNotificationTap;
  static void Function(String dailyWorkoutId)? _onNotificationDismiss;
  static bool _tapListenerRegistered = false;

  /// Registers [onTap] to fire when the user taps the ongoing notification,
  /// so the app can open that workout day. Safe to call on every rebuild:
  /// the plugin's `addTaskDataCallback` only deduplicates identical function
  /// *references*, so this keeps a single static forwarder registered once
  /// and just repoints where it forwards to.
  static void addNotificationTapListener(
    void Function(String dailyWorkoutId) onTap,
  ) {
    if (!Platform.isAndroid) return;
    _init();
    _onNotificationTap = onTap;
    if (_tapListenerRegistered) return;
    _tapListenerRegistered = true;
    FlutterForegroundTask.addTaskDataCallback(_handleTaskData);
  }

  static void addNotificationDismissListener(
    void Function(String dailyWorkoutId) onDismiss,
  ) {
    if (!Platform.isAndroid) return;
    _init();
    _onNotificationDismiss = onDismiss;
    if (_tapListenerRegistered) return;
    _tapListenerRegistered = true;
    FlutterForegroundTask.addTaskDataCallback(_handleTaskData);
  }

  static void _handleTaskData(Object data) {
    if (data is Map && data['type'] == 'notificationPressed') {
      final dailyWorkoutId = data['dailyWorkoutId'];
      if (dailyWorkoutId is String) _onNotificationTap?.call(dailyWorkoutId);
    } else if (data is Map && data['type'] == 'notificationDismissed') {
      final dailyWorkoutId = data['dailyWorkoutId'];
      if (dailyWorkoutId is String) {
        _onNotificationDismiss?.call(dailyWorkoutId);
      }
    }
  }
}
