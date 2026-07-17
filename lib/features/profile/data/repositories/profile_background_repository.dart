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

class ProfileBackgroundRepository {
  static const _keyPrefix = 'profile_background_image_path';
  static const _alignmentKeyPrefix = 'profile_background_image_alignment';
  static const deviceKey = 'current_device';

  Future<String?> getPath(String userId) async {
    final prefs = await SharedPreferences.getInstance();
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
    await prefs.setString(_key(deviceKey), destination.path);
    await _saveAlignment(prefs, userId, alignment);
    await _deletePrevious(previousPath, exceptPath: destination.path);
    return destination.path;
  }

  Future<void> clear(String userId) async {
    final prefs = await SharedPreferences.getInstance();
    final previousPath = prefs.getString(_key(userId));
    await prefs.remove(_key(userId));
    await prefs.remove(_key(deviceKey));
    await prefs.remove(_alignmentKey(userId));
    await prefs.remove(_alignmentKey(deviceKey));
    await _deletePrevious(previousPath);
  }

  Future<void> _saveAlignment(
    SharedPreferences prefs,
    String userId,
    Alignment alignment,
  ) async {
    final value = '${alignment.x},${alignment.y}';
    await prefs.setString(_alignmentKey(userId), value);
    await prefs.setString(_alignmentKey(deviceKey), value);
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
