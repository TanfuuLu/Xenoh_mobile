import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

/// A square thumbnail for an exercise. Shows the backend image when
/// [imageUrl] resolves, otherwise a muscle-kind icon fallback.
///
/// [imageUrl] is expected to be an absolute URL (relative R2 object keys are
/// resolved to the configured assets origin in the training repository before
/// reaching the UI).
class ExerciseThumbnail extends StatelessWidget {
  const ExerciseThumbnail({
    required this.imageUrl,
    required this.exerciseKind,
    this.size = 42,
    super.key,
  });

  final String? imageUrl;
  final String exerciseKind; // "Strength" | "Cardio"
  final double size;

  @override
  Widget build(BuildContext context) {
    final url = imageUrl?.trim();
    final hasImage = url != null && url.isNotEmpty;
    // Exercise artwork is displayed only as a small thumbnail. Requesting a
    // target decode size prevents full-resolution source images from causing
    // frame drops while the library list is built.
    final cacheWidth = (size * MediaQuery.devicePixelRatioOf(context)).round();

    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: SizedBox(
        width: size,
        height: size,
        child: DecoratedBox(
          decoration: BoxDecoration(
            color: AppColors.bg2,
            border: Border.all(color: AppColors.surfaceBorderSoft),
          ),
          child: Padding(
            padding: EdgeInsets.all(hasImage ? 0 : 4),
            child: !hasImage
                ? _Fallback(exerciseKind: exerciseKind, size: size)
                : Image.network(
                    url,
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    cacheWidth: cacheWidth,
                    errorBuilder: (_, _, _) =>
                        _Fallback(exerciseKind: exerciseKind, size: size),
                  ),
          ),
        ),
      ),
    );
  }
}

class _Fallback extends StatelessWidget {
  const _Fallback({required this.exerciseKind, required this.size});

  final String exerciseKind;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        ColoredBox(color: AppColors.bg3.withValues(alpha: 0.7)),
        Center(
          child: Icon(
            exerciseKind == 'Cardio'
                ? Icons.directions_run_rounded
                : Icons.fitness_center_rounded,
            size: size * 0.46,
            color: AppColors.fg3,
          ),
        ),
      ],
    );
  }
}
