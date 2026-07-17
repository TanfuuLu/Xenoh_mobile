import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final blocklistProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  return ref.watch(xenohApiProvider).getList('/users/me/blocks');
});

class BlocklistScreen extends ConsumerWidget {
  const BlocklistScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final blocks = ref.watch(blocklistProvider);
    return FeatureScreenFrame(
      title: l10n.blocksBlocklistTitle,
      onRefresh: () => ref.refresh(blocklistProvider.future),
      children: [
        FeatureHeader(
          title: l10n.blocksBlockedUsersTitle,
          subtitle: l10n.blocksBlockedUsersSubtitle,
          icon: Icons.block_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (blocks) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.blocksNoBlockedUsersTitle,
            message: l10n.blocksNoBlockedUsersMessage,
          ),
          AsyncData(:final value) => XnSectionList(
            children: [
              for (final item in value)
                DataCard(
                  title: textOf(item, ['fullName', 'blockedUserId']),
                  subtitle: optionalTextOf(item, ['reason', 'createdAt']),
                  trailing: IconButton(
                    tooltip: l10n.blocksUnblockTooltip,
                    icon: const Icon(Icons.lock_open_rounded),
                    onPressed: () async {
                      await ref
                          .read(xenohApiProvider)
                          .delete('/users/${item['blockedUserId']}/block');
                      ref.invalidate(blocklistProvider);
                    },
                  ),
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(blocklistProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}
