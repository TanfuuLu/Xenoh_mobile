import 'dart:io';

import 'package:flutter_test/flutter_test.dart';

void main() {
  final screensRoot = Directory('lib/features');
  final screenFiles =
      screensRoot
          .listSync(recursive: true)
          .whereType<File>()
          .where(
            (file) =>
                file.path.endsWith('_screen.dart') ||
                file.path.endsWith('_screens.dart'),
          )
          .toList()
        ..sort((a, b) => a.path.compareTo(b.path));

  test('every screen declares a supported page frame', () {
    expect(screenFiles, isNotEmpty);
    for (final file in screenFiles) {
      final source = file.readAsStringSync();
      final hasPageFrame =
          source.contains('FeatureScreenFrame(') ||
          source.contains('AuthLayout(') ||
          source.contains('Scaffold(');
      expect(
        hasPageFrame,
        isTrue,
        reason: '${file.path} has no supported page frame',
      );
    }
  });

  test('every authenticated shell root exposes its menu button', () {
    const rootScreens = [
      'lib/features/dashboard/presentation/screens/dashboard_screen.dart',
      'lib/features/training/presentation/screens/plans_screen.dart',
      'lib/features/nutrition/presentation/screens/nutrition_screen.dart',
      'lib/features/supplements/presentation/screens/supplements_screen.dart',
      'lib/features/profile/presentation/screens/profile_screen.dart',
      'lib/features/community/presentation/screens/community_screen.dart',
      'lib/features/cycle/presentation/screens/cycle_screen.dart',
      'lib/features/coach_client/presentation/screens/clients_screen.dart',
    ];

    for (final path in rootScreens) {
      expect(
        File(path).readAsStringSync(),
        contains('HomeShellMenuButton('),
        reason: '$path must expose the application menu',
      );
    }
  });

  test('router avoids fragile extras and dashboard error fallbacks', () {
    final router = File('lib/app/router/router.dart').readAsStringSync();

    expect(router, isNot(contains('state.extra!')));
    expect(router, contains('NotFoundScreen('));
    expect(
      router,
      isNot(
        contains('errorBuilder: (_, state) {\n      return const Dashboard'),
      ),
    );
  });
}
