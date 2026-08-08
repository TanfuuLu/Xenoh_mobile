import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/app/home_shell.dart';
import 'package:xenoh_mobile/features/auth/domain/entities/user.dart';
import 'package:xenoh_mobile/features/profile/domain/entities/user_profile.dart';

void main() {
  const user = User(
    id: 'user-1',
    email: 'user@xenoh.app',
    fullName: 'Old Name',
    roles: ['Individual'],
    avatarUrl: 'https://assets.xenoh.online/avatars/old.webp',
  );

  const profile = UserProfile(
    id: 'user-1',
    email: 'user@xenoh.app',
    firstName: 'Updated',
    lastName: 'User',
    currentStreak: 0,
    level: 1,
    totalXp: 0,
    xpToNextLevel: 100,
    title: 'Beginner',
    big3Prs: Big3Prs(),
    avatarUrl: 'https://assets.xenoh.online/avatars/new.webp',
  );

  test('drawer user follows the latest server profile avatar', () {
    final synced = mergeAuthenticatedUserProfile(user, profile);

    expect(synced.fullName, 'Updated User');
    expect(
      synced.avatarUrl,
      'https://assets.xenoh.online/avatars/new.webp',
    );
    expect(synced.roles, ['Individual']);
  });

  test('profile data from another account is ignored', () {
    final synced = mergeAuthenticatedUserProfile(
      user,
      profile.copyWith(id: 'user-2'),
    );

    expect(synced, user);
  });
}
