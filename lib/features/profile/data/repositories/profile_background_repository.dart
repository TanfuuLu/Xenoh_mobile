import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

final profileBackgroundRepositoryProvider =
    Provider<ProfileBackgroundRepository>((_) => ProfileBackgroundRepository());

final profileBackgroundPathProvider = FutureProvider.family<String?, String>((
  ref,
  userId,
) {
  return ref.watch(profileBackgroundRepositoryProvider).getPath(userId);
});

final profileBackgroundAlignmentProvider =
    FutureProvider.family<Alignment, String>((ref, userId) {
      return ref
          .watch(profileBackgroundRepositoryProvider)
          .getAlignment(userId);
    });

/// The account whose background the header cards show. Kept as plain state,
/// pushed from the auth session at the app root, so a decorative header card
/// never drags the auth/network graph into the screen it sits on.
///
/// Every read and write of a background must agree on this key: backgrounds
/// are stored per user, and a shared key is what used to leak one account's
/// image into the next account signed in on the device.
final backgroundUserIdProvider = NotifierProvider<BackgroundUserId, String?>(
  BackgroundUserId.new,
);

class BackgroundUserId extends Notifier<String?> {
  @override
  String? build() => null;

  /// Points the header cards at a session's account. Logging out passes null,
  /// which drops them back to the default gradient. Dependents re-resolve on
  /// their own, so nothing has to be invalidated by hand.
  void useAccount(String? userId) {
    if (state == userId) return;
    state = userId;
  }
}

/// The signed-in user's hero-card background, shared by every header card.
/// Derived from the auth session, so logging out and into another account
/// re-resolves it instead of leaving the previous account's image on screen.
final currentUserBackgroundProvider = FutureProvider<UserBackground>((
  ref,
) async {
  final userId = ref.watch(backgroundUserIdProvider);
  if (userId == null) return const UserBackground.none();
  final repository = ref.watch(profileBackgroundRepositoryProvider);
  return UserBackground(
    path: await repository.getPath(userId),
    alignment: await repository.getAlignment(userId),
  );
});

/// A resolved background: the stored image (null for the default gradient)
/// and how it is framed inside the card.
@immutable
class UserBackground {
  const UserBackground({required this.path, required this.alignment});

  const UserBackground.none() : path = null, alignment = Alignment.center;

  final String? path;
  final Alignment alignment;

  @override
  bool operator ==(Object other) =>
      other is UserBackground &&
      other.path == path &&
      other.alignment == alignment;

  @override
  int get hashCode => Object.hash(path, alignment);
}

class ProfileBackgroundRepository {
  static const _keyPrefix = 'profile_background_image_path';
  static const _alignmentKeyPrefix = 'profile_background_image_alignment';

  /// Backgrounds used to be mirrored under one device-wide key so screens
  /// outside the profile could read them without knowing the user. That
  /// mirror survived a logout and showed the previous account's image, so it
  /// is gone — and purged on read, since old installs still carry it.
  static const _legacyDeviceKey = 'current_device';

  Future<String?> getPath(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    await _purgeLegacyDeviceEntries(prefs);
    final path = prefs.getString(_key(userId));
    if (path == null || path.isEmpty) return null;

    if (!File(path).existsSync()) {
      await prefs.remove(_key(userId));
      return null;
    }
    return path;
  }

  Future<Alignment> getAlignment(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final raw = prefs.getString(_alignmentKey(userId));
    if (raw == null) return Alignment.center;

    final parts = raw.split(',');
    if (parts.length != 2) return Alignment.center;
    final x = double.tryParse(parts[0]);
    final y = double.tryParse(parts[1]);
    if (x == null || y == null) return Alignment.center;
    return Alignment(x, y);
  }

  Future<String> saveFromPath({
    required String userId,
    required String sourcePath,
    Alignment alignment = Alignment.center,
  }) async {
    final source = File(sourcePath);
    if (!source.existsSync()) {
      throw StateError('Selected image could not be found.');
    }

    final prefs = await SharedPreferences.getInstance();
    final previousPath = prefs.getString(_key(userId));
    final directory = await _backgroundDirectory();
    final destination = File(
      '${directory.path}${Platform.pathSeparator}'
      '${_safeUserId(userId)}_${DateTime.now().millisecondsSinceEpoch}'
      '${_extension(sourcePath)}',
    );

    await source.copy(destination.path);
    await prefs.setString(_key(userId), destination.path);
    await _saveAlignment(prefs, userId, alignment);
    await _deletePrevious(previousPath, exceptPath: destination.path);
    return destination.path;
  }

  Future<void> clear(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final previousPath = prefs.getString(_key(userId));
    await prefs.remove(_key(userId));
    await prefs.remove(_alignmentKey(userId));
    await _deletePrevious(previousPath);
  }

  Future<void> _saveAlignment(
    SharedPreferences prefs,
    String userId,
    Alignment alignment,
  ) async {
    final value = '${alignment.x},${alignment.y}';
    await prefs.setString(_alignmentKey(userId), value);
  }

  /// Drops the pre-per-account mirror. The image file itself is left alone:
  /// it is still referenced by the owning account's own key.
  Future<void> _purgeLegacyDeviceEntries(SharedPreferences prefs) async {
    for (final key in [
      _key(_legacyDeviceKey),
      _alignmentKey(_legacyDeviceKey),
    ]) {
      if (prefs.containsKey(key)) await prefs.remove(key);
    }
  }

  String _key(String userId) => '${_keyPrefix}_${_safeUserId(userId)}';

  String _alignmentKey(String userId) =>
      '${_alignmentKeyPrefix}_${_safeUserId(userId)}';

  Future<Directory> _backgroundDirectory() async {
    final root = await getApplicationSupportDirectory();
    final directory = Directory(
      '${root.path}${Platform.pathSeparator}profile_backgrounds',
    );
    if (!directory.existsSync()) {
      await directory.create(recursive: true);
    }
    return directory;
  }

  Future<void> _deletePrevious(String? path, {String? exceptPath}) async {
    if (path == null || path == exceptPath) return;
    final file = File(path);
    if (file.existsSync()) {
      await file.delete();
    }
  }

  String _safeUserId(String userId) =>
      userId.replaceAll(RegExp('[^a-zA-Z0-9_-]'), '_');

  String _extension(String path) {
    final dot = path.lastIndexOf('.');
    if (dot < 0 || dot == path.length - 1) return '.jpg';
    final ext = path.substring(dot).toLowerCase();
    return ext.length <= 6 ? ext : '.jpg';
  }
}
