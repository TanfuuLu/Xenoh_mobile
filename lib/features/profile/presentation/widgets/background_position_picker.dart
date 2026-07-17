import 'dart:io';
import 'dart:math' as math;

import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../l10n/app_localizations.dart';

/// Lets the user drag a freshly-picked photo around a card-shaped viewport
/// to choose which part of it stays visible once cropped to [BoxFit.cover].
/// Returns the chosen [Alignment], or `null` if the user backed out.
class BackgroundPositionPicker extends StatefulWidget {
  const BackgroundPositionPicker({
    required this.imagePath,
    this.initialAlignment = Alignment.center,
    super.key,
  });

  final String imagePath;
  final Alignment initialAlignment;

  @override
  State<BackgroundPositionPicker> createState() =>
      _BackgroundPositionPickerState();
}

class _BackgroundPositionPickerState extends State<BackgroundPositionPicker> {
  Size? _imageSize;
  Offset _offset = Offset.zero;
  bool _offsetInitialized = false;

  @override
  void initState() {
    super.initState();
    _resolveImageSize();
  }

  void _resolveImageSize() {
    final stream = FileImage(
      File(widget.imagePath),
    ).resolve(ImageConfiguration.empty);
    late ImageStreamListener listener;
    listener = ImageStreamListener((info, _) {
      if (!mounted) return;
      setState(() {
        _imageSize = Size(
          info.image.width.toDouble(),
          info.image.height.toDouble(),
        );
      });
      stream.removeListener(listener);
    });
    stream.addListener(listener);
  }

  ({double maxDx, double maxDy, double scaledWidth, double scaledHeight})
  _boundsFor(Size viewport) {
    final imageSize = _imageSize!;
    final scale = math.max(
      viewport.width / imageSize.width,
      viewport.height / imageSize.height,
    );
    final scaledWidth = imageSize.width * scale;
    final scaledHeight = imageSize.height * scale;
    return (
      maxDx: math.max(0, (scaledWidth - viewport.width) / 2),
      maxDy: math.max(0, (scaledHeight - viewport.height) / 2),
      scaledWidth: scaledWidth,
      scaledHeight: scaledHeight,
    );
  }

  void _initializeOffset(Size viewport) {
    if (_offsetInitialized || _imageSize == null) return;
    final bounds = _boundsFor(viewport);
    _offsetInitialized = true;
    _offset = Offset(
      -widget.initialAlignment.x * bounds.maxDx,
      -widget.initialAlignment.y * bounds.maxDy,
    );
  }

  void _onPanUpdate(DragUpdateDetails details, Size viewport) {
    final bounds = _boundsFor(viewport);
    setState(() {
      _offset = Offset(
        (_offset.dx + details.delta.dx).clamp(-bounds.maxDx, bounds.maxDx),
        (_offset.dy + details.delta.dy).clamp(-bounds.maxDy, bounds.maxDy),
      );
    });
  }

  void _save(Size viewport) {
    final bounds = _boundsFor(viewport);
    final alignmentX = bounds.maxDx == 0 ? 0.0 : -_offset.dx / bounds.maxDx;
    final alignmentY = bounds.maxDy == 0 ? 0.0 : -_offset.dy / bounds.maxDy;
    Navigator.of(context).pop(Alignment(alignmentX, alignmentY));
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final viewport = Size(
      MediaQuery.sizeOf(context).width - AppSpacing.xl * 2,
      AppLayout.heroCardMinHeight,
    );
    _initializeOffset(viewport);
    final bounds = _imageSize == null ? null : _boundsFor(viewport);

    return Scaffold(
      backgroundColor: AppColors.bgPage,
      appBar: AppBar(title: Text(l10n.profileBackgroundPositionTitle)),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: Column(
            children: [
              Text(
                l10n.profileBackgroundPositionSubtitle,
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.fg2, fontSize: 13),
              ),
              const SizedBox(height: AppSpacing.xl),
              Expanded(
                child: Center(
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.xxl),
                    child: GestureDetector(
                      onPanUpdate: (details) => _onPanUpdate(details, viewport),
                      child: Container(
                        width: viewport.width,
                        height: viewport.height,
                        color: AppColors.bg3,
                        child: _imageSize == null || bounds == null
                            ? const Center(child: CircularProgressIndicator())
                            : Stack(
                                children: [
                                  Positioned(
                                    left:
                                        (viewport.width - bounds.scaledWidth) /
                                            2 +
                                        _offset.dx,
                                    top:
                                        (viewport.height -
                                                bounds.scaledHeight) /
                                            2 +
                                        _offset.dy,
                                    width: bounds.scaledWidth,
                                    height: bounds.scaledHeight,
                                    child: Image.file(
                                      File(widget.imagePath),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ],
                              ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: AppSpacing.xl),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.of(context).pop(),
                      child: Text(l10n.commonCancel),
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: FilledButton(
                      onPressed: _imageSize == null
                          ? null
                          : () => _save(viewport),
                      child: Text(l10n.commonSave),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
