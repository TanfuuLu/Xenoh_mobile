import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/image_cache/exercise_image_cache_warmer.dart';

void main() {
  test('trims and downloads each non-empty exercise image URL once', () async {
    final downloaded = <String>[];
    final warmer = ExerciseImageCacheWarmer(
      download: (url) async => downloaded.add(url),
    );

    await warmer.warm([
      null,
      '',
      '  ',
      ' https://assets.xenoh.online/exercises/squat.webp ',
      'https://assets.xenoh.online/exercises/squat.webp',
      'https://assets.xenoh.online/exercises/deadlift.webp',
    ]);

    expect(downloaded, [
      'https://assets.xenoh.online/exercises/squat.webp',
      'https://assets.xenoh.online/exercises/deadlift.webp',
    ]);
  });

  test('limits concurrent exercise image downloads', () async {
    var activeDownloads = 0;
    var peakDownloads = 0;
    final releaseDownloads = Completer<void>();
    final warmer = ExerciseImageCacheWarmer(
      maxConcurrentDownloads: 2,
      download: (url) async {
        activeDownloads++;
        peakDownloads = activeDownloads > peakDownloads
            ? activeDownloads
            : peakDownloads;
        await releaseDownloads.future;
        activeDownloads--;
      },
    );

    final warming = warmer.warm([
      'https://example.test/1.webp',
      'https://example.test/2.webp',
      'https://example.test/3.webp',
      'https://example.test/4.webp',
    ]);
    await Future<void>.delayed(Duration.zero);

    expect(activeDownloads, 2);
    releaseDownloads.complete();
    await warming;
    expect(peakDownloads, 2);
  });

  test('continues warming when one exercise image fails', () async {
    final downloaded = <String>[];
    final warmer = ExerciseImageCacheWarmer(
      download: (url) async {
        downloaded.add(url);
        if (url.endsWith('broken.webp')) {
          throw StateError('download failed');
        }
      },
    );

    await warmer.warm([
      'https://example.test/broken.webp',
      'https://example.test/working.webp',
    ]);

    expect(downloaded, [
      'https://example.test/broken.webp',
      'https://example.test/working.webp',
    ]);
  });
}
