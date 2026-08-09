import 'package:flutter/material.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';

/// Renders a network-backed user avatar with an initials fallback.
class XnUserAvatar extends StatelessWidget {
  const XnUserAvatar({
    required this.name,
    required this.size,
    super.key,
    this.imageUrl,
    this.backgroundColor = AppColors.accentSoft,
    this.foregroundColor = AppColors.clay900,
    this.borderColor = AppColors.surfaceBorderSoft,
    this.borderRadius = AppRadius.lg,
  });

  final String name;
  final String? imageUrl;
  final double size;
  final Color backgroundColor;
  final Color foregroundColor;
  final Color borderColor;
  final double borderRadius;

  @override
  Widget build(BuildContext context) {
    final normalizedUrl = imageUrl?.trim();
    final hasImage = normalizedUrl?.isNotEmpty == true;
    final fallback = ColoredBox(
      color: backgroundColor,
      child: Center(
        child: Text(
          _initials(name),
          style: TextStyle(
            color: foregroundColor,
            fontSize: size >= 52 ? 18 : 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );

    return Semantics(
      image: true,
      label: name,
      child: Container(
        width: size,
        height: size,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(borderRadius),
          border: Border.all(color: borderColor),
        ),
        child: hasImage
            ? Image.network(
                normalizedUrl!,
                fit: BoxFit.cover,
                errorBuilder: (_, _, _) => fallback,
              )
            : fallback,
      ),
    );
  }
}

String _initials(String name) {
  final parts = name
      .trim()
      .split(RegExp(r'\s+'))
      .where((part) => part.isNotEmpty)
      .toList();
  if (parts.isEmpty) return '?';
  if (parts.length == 1) return parts.first.characters.first.toUpperCase();
  return '${parts.first.characters.first}${parts.last.characters.first}'
      .toUpperCase();
}
