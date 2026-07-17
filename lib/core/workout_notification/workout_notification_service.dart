// `flutter_foreground_task` only declares Android/iOS platform support (no
// web/desktop) and its Dart side touches `dart:isolate`'s `IsolateNameServer`,
// which isn't available on web — so the real implementation is only ever
// compiled for `dart.library.io` targets; web gets a no-op stub.
export 'workout_notification_service_stub.dart'
    if (dart.library.io) 'workout_notification_service_io.dart';
