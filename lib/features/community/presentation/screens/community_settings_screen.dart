import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../domain/entities/community_models.dart';
import '../providers/community_controllers.dart';

class CommunitySettingsScreen extends ConsumerWidget {
  const CommunitySettingsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final settings = ref.watch(communitySettingsControllerProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.communityPrivacyTitle)),
      body: AsyncValueView(
        value: settings,
        onRetry: () => ref.invalidate(communitySettingsControllerProvider),
        data: (value) => _CommunitySettingsForm(
          initialVisibility: value.statsVisibility,
          saving: settings.isLoading,
        ),
      ),
    );
  }
}

class _CommunitySettingsForm extends ConsumerStatefulWidget {
  const _CommunitySettingsForm({
    required this.initialVisibility,
    required this.saving,
  });

  final CommunityStatsVisibility initialVisibility;
  final bool saving;

  @override
  ConsumerState<_CommunitySettingsForm> createState() =>
      _CommunitySettingsFormState();
}

class _CommunitySettingsFormState
    extends ConsumerState<_CommunitySettingsForm> {
  late CommunityStatsVisibility _visibility = widget.initialVisibility;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          l10n.communityPrivacyDescription,
          style: const TextStyle(color: AppColors.fg2),
        ),
        const SizedBox(height: AppSpacing.lg),
        XnCard(
          padding: EdgeInsets.zero,
          child: RadioGroup<CommunityStatsVisibility>(
            groupValue: _visibility,
            onChanged: _select,
            child: Column(
              children: [
                RadioListTile<CommunityStatsVisibility>(
                  value: CommunityStatsVisibility.friends,
                  title: Text(l10n.communityPrivacyFriendsTitle),
                  subtitle: Text(l10n.communityPrivacyFriendsDescription),
                ),
                const Divider(height: 1),
                RadioListTile<CommunityStatsVisibility>(
                  value: CommunityStatsVisibility.onlyMe,
                  title: Text(l10n.communityPrivacyOnlyMeTitle),
                  subtitle: Text(l10n.communityPrivacyOnlyMeDescription),
                ),
              ],
            ),
          ),
        ),
        const SizedBox(height: AppSpacing.lg),
        XnButton(
          label: l10n.commonSave,
          loading: widget.saving,
          onPressed: _save,
        ),
      ],
    );
  }

  void _select(CommunityStatsVisibility? value) {
    if (value != null) setState(() => _visibility = value);
  }

  Future<void> _save() async {
    final controller = ref.read(
      communitySettingsControllerProvider.notifier,
    );
    final success = await controller.save(_visibility);
    if (!mounted) return;
    final l10n = AppLocalizations.of(context);
    final message = success
        ? l10n.communityPrivacySavedMessage
        : apiErrorMessage(
            ref.read(communitySettingsControllerProvider).error!,
            context,
          );
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }
}
