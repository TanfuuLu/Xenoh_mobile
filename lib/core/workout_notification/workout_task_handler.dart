import 'dart:async';

import 'package:flutter_foreground_task/flutter_foreground_task.dart';

/// Registers [WorkoutTaskHandler] as the foreground service's task handler.
/// Must be a top-level function per the plugin's contract.
@pragma('vm:entry-point')
void startWorkoutTaskCallback() {
  FlutterForegroundTask.setTaskHandler(WorkoutTaskHandler());
}

/// Keeps the ongoing "current exercise" notification updated while the
/// foreground service runs, and relays a tap on the notification back to the
/// main isolate so it can open the workout day screen.
class WorkoutTaskHandler extends TaskHandler {
  String _title = 'Workout in progress';
  String _setInfo = '';
  DateTime? _timerStartedAtUtc;
  String? _dailyWorkoutId;

  @override
  Future<void> onStart(DateTime timestamp, TaskStarter starter) async {}

  @override
  void onRepeatEvent(DateTime timestamp) {
    unawaited(
      FlutterForegroundTask.updateService(
        notificationTitle: _title,
        notificationText: _notificationText(timestamp),
      ),
    );
  }

  @override
  void onReceiveData(Object data) {
    if (data is! Map) return;
    final title = data['title'];
    final setInfo = data['setInfo'];
    final timerStartedAtUtc = data['timerStartedAtUtc'];
    final dailyWorkoutId = data['dailyWorkoutId'];

    if (title is String) _title = title;
    if (setInfo is String) _setInfo = setInfo;
    _timerStartedAtUtc = timerStartedAtUtc is String
        ? DateTime.tryParse(timerStartedAtUtc)
        : null;
    if (dailyWorkoutId is String) _dailyWorkoutId = dailyWorkoutId;

    unawaited(
      FlutterForegroundTask.updateService(
        notificationTitle: _title,
        notificationText: _notificationText(DateTime.now().toUtc()),
      ),
    );
  }

  @override
  Future<void> onDestroy(DateTime timestamp, bool isTimeout) async {}

  @override
  void onNotificationPressed() {
    final dailyWorkoutId = _dailyWorkoutId;
    if (dailyWorkoutId == null) return;
    FlutterForegroundTask.sendDataToMain({
      'type': 'notificationPressed',
      'dailyWorkoutId': dailyWorkoutId,
    });
  }

  @override
  void onNotificationDismissed() {
    final dailyWorkoutId = _dailyWorkoutId;
    if (dailyWorkoutId != null) {
      FlutterForegroundTask.sendDataToMain({
        'type': 'notificationDismissed',
        'dailyWorkoutId': dailyWorkoutId,
      });
    }
    unawaited(FlutterForegroundTask.stopService());
  }

  String _notificationText(DateTime nowUtc) {
    final startedAt = _timerStartedAtUtc;
    if (startedAt == null) return _setInfo;
    final elapsed = nowUtc.difference(startedAt);
    return '$_setInfo · ${_formatElapsed(elapsed)}';
  }

  String _formatElapsed(Duration d) {
    final minutes = d.inMinutes.clamp(0, 999);
    final seconds = d.inSeconds % 60;
    return '${minutes.toString().padLeft(2, '0')}:'
        '${seconds.toString().padLeft(2, '0')}';
  }
}
