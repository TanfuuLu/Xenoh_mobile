import 'package:flutter/material.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/config/app_config.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';

class PrShareScreen extends StatelessWidget {
  const PrShareScreen({
    required this.userId,
    required this.exerciseTemplateId,
    super.key,
  });

  final String userId;
  final String exerciseTemplateId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final imageUrl =
        '${AppConfig.apiBaseUrl}/share/pr/$userId/$exerciseTemplateId/image.png';
    return FeatureScreenFrame(
      title: l10n.sharingPrShareTitle,
      children: [
        FeatureHeader(
          title: l10n.sharingPersonalRecordTitle,
          subtitle: l10n.sharingPersonalRecordSubtitle,
          icon: Icons.emoji_events_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        ClipRRect(
          borderRadius: BorderRadius.circular(AppRadius.md),
          child: Image.network(
            imageUrl,
            fit: BoxFit.contain,
            errorBuilder: (_, _, _) => EmptyFeatureState(
              title: l10n.sharingImageUnavailableTitle,
              message: l10n.sharingImageUnavailableMessage,
              icon: Icons.broken_image_outlined,
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.md),
        SelectableText(
          imageUrl,
          style: const TextStyle(color: AppColors.fg3),
        ),
      ],
    );
  }
}
