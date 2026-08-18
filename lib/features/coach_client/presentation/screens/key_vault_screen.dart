import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../app/theme/app_typography.dart';
import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/utils/date_only.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_section.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final inviteCodesProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  ref.syncOn(const [DataTopic.coaching]);
  return ref.watch(xenohApiProvider).getList('/coach-client/invite-codes');
});

class KeyVaultScreen extends ConsumerWidget {
  const KeyVaultScreen({super.key});

  Future<void> _createInviteCode(BuildContext context, WidgetRef ref) async {
    final created = await showModalBottomSheet<bool>(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _CreateCoachKeySheet(),
    );
    if (created == true) {
      if (!context.mounted) return;
      final l10n = AppLocalizations.of(context);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(SnackBar(content: Text(l10n.coachKeyCreatedSnackbar)));
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final codes = ref.watch(inviteCodesProvider);
    return FeatureScreenFrame(
      title: l10n.coachKeyVaultTitle,
      actions: [
        IconButton(
          tooltip: l10n.coachGenerateInviteCodeTooltip,
          icon: const Icon(Icons.add_rounded),
          onPressed: () => _createInviteCode(context, ref),
        ),
      ],
      onRefresh: () => ref.refresh(inviteCodesProvider.future),
      children: [
        FeatureHeader(
          title: l10n.coachInviteCodesTitle,
          subtitle: l10n.coachInviteCodesSubtitle,
          icon: Icons.key_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (codes) {
          AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
            title: l10n.coachNoActiveCodesTitle,
            message: l10n.coachNoActiveCodesMessage,
            icon: Icons.key_off_outlined,
          ),
          AsyncData(:final value) => XnCardStack(
            children: [
              for (final item in value)
                Column(
                  children: [
                    DataCard(
                      title: textOf(item, ['code', 'inviteCode']),
                      subtitle: optionalTextOf(item, [
                        'expiresAt',
                        'createdAt',
                      ]),
                      meta: [
                        if (item['isActive'] != false)
                          l10n.coachActiveStatus
                        else
                          l10n.coachInactiveStatus,
                      ],
                      trailing: IconButton(
                        tooltip: l10n.coachCopyCodeTooltip,
                        icon: const Icon(Icons.copy_rounded),
                        onPressed: () => _copyCode(context, item),
                      ),
                      onTap: () => _copyCode(context, item),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton.icon(
                        onPressed: () async {
                          await ref
                              .read(xenohApiProvider)
                              .delete(
                                '/coach-client/invite-codes/${item['id']}',
                              );
                        },
                        icon: const Icon(
                          Icons.delete_outline_rounded,
                          size: 18,
                        ),
                        label: Text(l10n.coachRevokeButton),
                      ),
                    ),
                  ],
                ),
            ],
          ),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(inviteCodesProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }

  Future<void> _copyCode(BuildContext context, JsonMap item) async {
    final code = textOf(item, ['code', 'inviteCode'], fallback: '');
    if (code.isEmpty) return;
    await Clipboard.setData(ClipboardData(text: code));
    if (!context.mounted) return;
    final l10n = AppLocalizations.of(context);
    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(SnackBar(content: Text(l10n.coachKeyCopiedSnackbar)));
  }
}

class _CreateCoachKeySheet extends ConsumerStatefulWidget {
  const _CreateCoachKeySheet();

  @override
  ConsumerState<_CreateCoachKeySheet> createState() =>
      _CreateCoachKeySheetState();
}

class _CreateCoachKeySheetState extends ConsumerState<_CreateCoachKeySheet> {
  DateTime? _start = DateTime.now();
  DateTime? _end = DateTime.now().add(const Duration(days: 30));
  bool _submitting = false;

  Future<void> _pick({required bool isStart}) async {
    final now = DateTime.now();
    final initial = isStart ? (_start ?? now) : (_end ?? _start ?? now);
    final picked = await showDatePicker(
      context: context,
      initialDate: initial,
      firstDate: DateTime(now.year - 1),
      lastDate: DateTime(now.year + 3),
    );
    if (picked == null) return;
    setState(() {
      if (isStart) {
        _start = picked;
        if (_end != null && _end!.isBefore(picked)) {
          _end = picked.add(const Duration(days: 30));
        }
      } else {
        _end = picked;
      }
    });
  }

  Future<void> _submit() async {
    final start = _start;
    final end = _end;
    final l10n = AppLocalizations.of(context);
    if (start == null || end == null) {
      _toast(l10n.coachPickStartEndDatesError);
      return;
    }
    if (end.isBefore(start)) {
      _toast(l10n.coachEndDateAfterStartError);
      return;
    }

    setState(() => _submitting = true);
    try {
      await ref.read(xenohApiProvider).postObject(
        '/coach-client/invite-codes',
        {
          'coachingStartDate': DateOnly.format(start),
          'coachingEndDate': DateOnly.format(end),
        },
      );
      if (!mounted) return;
      Navigator.pop(context, true);
    } catch (e) {
      if (!mounted) return;
      setState(() => _submitting = false);
      _toast(apiErrorMessage(e, context));
    }
  }

  void _toast(String message) => ScaffoldMessenger.of(context)
    ..hideCurrentSnackBar()
    ..showSnackBar(SnackBar(content: Text(message)));

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: AppSpacing.xl,
        right: AppSpacing.xl,
        top: AppSpacing.xl,
        bottom: MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.coachCreateKeyTitle,
            style: AppTypography.display(22, letterSpacing: 0),
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.coachCreateKeySubtitle,
            style: const TextStyle(color: AppColors.fg2, height: 1.35),
          ),
          const SizedBox(height: AppSpacing.lg),
          Row(
            children: [
              Expanded(
                child: _DateField(
                  label: l10n.coachStartLabel,
                  value: _start,
                  onTap: () => _pick(isStart: true),
                ),
              ),
              const SizedBox(width: AppSpacing.md),
              Expanded(
                child: _DateField(
                  label: l10n.coachEndLabel,
                  value: _end,
                  onTap: () => _pick(isStart: false),
                ),
              ),
            ],
          ),
          const SizedBox(height: AppSpacing.xl),
          XnButton(
            label: l10n.coachCreateKeyButton,
            icon: Icons.key_rounded,
            loading: _submitting,
            onPressed: _submit,
          ),
        ],
      ),
    );
  }
}

class _DateField extends StatelessWidget {
  const _DateField({
    required this.label,
    required this.value,
    required this.onTap,
  });

  final String label;
  final DateTime? value;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: AppColors.fg2,
            fontSize: 13,
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 6),
        OutlinedButton.icon(
          onPressed: onTap,
          icon: const Icon(Icons.calendar_today_rounded, size: 16),
          label: Text(
            value == null ? l10n.coachPickDateButton : DateOnly.format(value!),
          ),
        ),
      ],
    );
  }
}
