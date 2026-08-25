import 'package:flutter_cache_manager/flutter_cache_manager.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/image_cache/exercise_image_cache_warmer.dart';
import 'exercise_templates_controller.dart';

final exerciseImageCacheManagerProvider = Provider<BaseCacheManager>(
  (_) => DefaultCacheManager(),
);

final exerciseImageCacheWarmerProvider = Provider<ExerciseImageCacheWarmer>((
  ref,
) {
  final cacheManager = ref.watch(exerciseImageCacheManagerProvider);
  return ExerciseImageCacheWarmer(
    download: (url) async {
      await cacheManager.downloadFile(url);
    },
  );
});

/// Fetches exercise metadata and warms its image disk cache in the background.
///
/// Cache-manager freshness rules make this safe to run on every authenticated
/// app launch: valid files are reused and only missing or stale files use the
/// network.
final exerciseImageCacheWarmupProvider = FutureProvider<void>((ref) async {
  final templates = await ref.watch(
    exerciseTemplatesControllerProvider().future,
  );
  await ref
      .read(exerciseImageCacheWarmerProvider)
      .warm(templates.map((template) => template.imageUrl));
});
