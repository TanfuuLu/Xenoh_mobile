import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../providers/my_coach_provider.dart';
import 'relationship_chat_screen.dart';

/// Resolves the client's single active coach relationship before opening chat.
class ClientChatEntryScreen extends ConsumerWidget {
  const ClientChatEntryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final relationship = ref.watch(myCoachProvider);
    final value = relationship.value;
    final relationshipId = _relationshipText(value, const [
      'id',
      'relationshipId',
    ]);

    if (relationship.hasValue && value != null && relationshipId.isNotEmpty) {
      return RelationshipChatScreen(
        relationshipId: relationshipId,
        peerName: _relationshipText(value, const [
          'coachName',
          'fullName',
          'name',
        ], fallback: l10n.coachDefaultName),
      );
    }

    return FeatureScreenFrame(
      title: l10n.coachChatTitle,
      onRefresh: () => ref.refresh(myCoachProvider.future),
      children: [
        switch (relationship) {
          AsyncData() => EmptyFeatureState(
            title: l10n.coachNoCoachConnectedTitle,
            message: l10n.coachNoCoachConnectedMessage,
            icon: Icons.forum_outlined,
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(myCoachProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }
}

String _relationshipText(
  Map<String, dynamic>? relationship,
  List<String> keys, {
  String fallback = '',
}) {
  if (relationship == null) return fallback;
  for (final key in keys) {
    final value = relationship[key]?.toString().trim();
    if (value != null && value.isNotEmpty) return value;
  }
  return fallback;
}
