import 'dart:ui';

import 'package:flutter_foreground_task/utils/color_extension.dart';

/// A data class for dynamically changing the notification icon.
class NotificationIcon {
  /// Constructs an instance of [NotificationIcon].
  const NotificationIcon({
    this.metaDataName = '',
    this.backgroundColor,
    this.largeIconPath,
  });

  /// The name of the meta-data in the manifest that contains the drawable icon resource identifier.
  /// Leave empty to keep the app's default small icon.
  final String metaDataName;

  /// The background color for the notification icon.
  final Color? backgroundColor;

  /// Absolute path to a local image file to show as the notification's large
  /// icon (e.g. a photo relevant to what the notification is about).
  ///
  /// Fork-only addition (not part of upstream `flutter_foreground_task`,
  /// which has no way to set a bitmap large icon — only a build-time bundled
  /// small-icon drawable via [metaDataName]).
  final String? largeIconPath;

  /// Returns the data fields of [NotificationIcon] in JSON format.
  Map<String, dynamic> toJson() {
    return {
      'metaDataName': metaDataName,
      'backgroundColorRgb': backgroundColor?.toRgbString,
      'largeIconPath': largeIconPath,
    };
  }

  /// Creates a copy of the object replaced with new values.
  NotificationIcon copyWith({
    String? metaDataName,
    Color? backgroundColor,
    String? largeIconPath,
  }) =>
      NotificationIcon(
        metaDataName: metaDataName ?? this.metaDataName,
        backgroundColor: backgroundColor ?? this.backgroundColor,
        largeIconPath: largeIconPath ?? this.largeIconPath,
      );
}
