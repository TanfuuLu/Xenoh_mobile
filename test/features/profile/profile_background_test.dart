import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:xenoh_mobile/features/profile/data/repositories/profile_background_repository.dart';

class _FakeBackgrounds extends ProfileBackgroundRepository {
  _FakeBackgrounds(this.paths);

  final Map<String, String> paths;

  @override
  Future<String?> getPath(String userId) async => paths[userId];

  @override
  Future<Alignment> getAlignment(String userId) async => Alignment.center;
}

void main() {
  test('the header background follows the signed-in account', () async {
    final container = ProviderContainer(
      overrides: [
        profileBackgroundRepositoryProvider.overrideWithValue(
          _FakeBackgrounds({'user-a': '/a.jpg', 'user-b': '/b.jpg'}),
        ),
      ],
    );
    addTearDown(container.dispose);
    final backgroundUser = container.read(backgroundUserIdProvider.notifier);

    backgroundUser.useAccount('user-a');
    expect(
      (await container.read(currentUserBackgroundProvider.future)).path,
      '/a.jpg',
    );

    // Logging out drops the previous account's image immediately...
    backgroundUser.useAccount(null);
    expect(
      (await container.read(currentUserBackgroundProvider.future)).path,
      isNull,
    );

    // ...and the next account gets its own, not the one before it.
    backgroundUser.useAccount('user-b');
    expect(
      (await container.read(currentUserBackgroundProvider.future)).path,
      '/b.jpg',
    );

    // An account that never set one falls back to the default gradient.
    backgroundUser.useAccount('user-c');
    expect(
      (await container.read(currentUserBackgroundProvider.future)).path,
      isNull,
    );
  });

  test('the legacy device-wide background entry is purged on read', () async {
    SharedPreferences.setMockInitialValues({
      'profile_background_image_path_current_device': '/old-account.jpg',
      'profile_background_image_alignment_current_device': '0.0,-1.0',
    });

    expect(await ProfileBackgroundRepository().getPath('user-b'), isNull);

    final prefs = await SharedPreferences.getInstance();
    expect(
      prefs.getString('profile_background_image_path_current_device'),
      isNull,
    );
    expect(
      prefs.getString('profile_background_image_alignment_current_device'),
      isNull,
    );
  });
}
