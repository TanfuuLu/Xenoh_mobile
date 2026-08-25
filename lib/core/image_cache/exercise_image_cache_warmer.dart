typedef ExerciseImageDownload = Future<void> Function(String url);

/// Downloads exercise artwork into a persistent cache without overwhelming the
/// device or network connection.
class ExerciseImageCacheWarmer {
  ExerciseImageCacheWarmer({
    required ExerciseImageDownload download,
    this.maxConcurrentDownloads = 4,
  }) : assert(
         maxConcurrentDownloads > 0,
         'maxConcurrentDownloads must be greater than zero',
       ),
       _download = download;

  final ExerciseImageDownload _download;
  final int maxConcurrentDownloads;

  Future<void> warm(Iterable<String?> imageUrls) async {
    final urls = <String>{
      for (final imageUrl in imageUrls)
        if (imageUrl?.trim().isNotEmpty ?? false) imageUrl!.trim(),
    }.toList(growable: false);

    for (var index = 0; index < urls.length; index += maxConcurrentDownloads) {
      final end = (index + maxConcurrentDownloads).clamp(0, urls.length);
      await Future.wait([
        for (final url in urls.sublist(index, end)) _downloadSafely(url),
      ]);
    }
  }

  Future<void> _downloadSafely(String url) async {
    try {
      await _download(url);
    } catch (_) {
      // Cache warming is best-effort and must never affect application startup.
    }
  }
}
