import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_dropdown.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import 'admin_users_screen.dart';

final adminUserDetailProvider = FutureProvider.autoDispose
    .family<JsonMap, String>((ref, userId) {
      return ref.watch(xenohApiProvider).getObject('/admin/users/$userId');
    });

class AdminUserDetailScreen extends ConsumerStatefulWidget {
  const AdminUserDetailScreen({required this.userId, super.key});

  final String userId;

  @override
  ConsumerState<AdminUserDetailScreen> createState() =>
      _AdminUserDetailScreenState();
}

class _AdminUserDetailScreenState extends ConsumerState<AdminUserDetailScreen> {
  final _reason = TextEditingController();
  String _tier = 'Free';
  String _duration = '';
  var _saving = false;
  var _initialized = false;

  @override
  void dispose() {
    _reason.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final detail = ref.watch(adminUserDetailProvider(widget.userId));
    return FeatureScreenFrame(
      title: l10n.adminUserDetailTitle,
      onRefresh: () => ref.refresh(
        adminUserDetailProvider(widget.userId).future,
      ),
      children: [
        FeatureHeader(
          title: l10n.adminUserDetailTitle,
          subtitle: l10n.adminUserDetailSubtitle,
          icon: Icons.person_search_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        switch (detail) {
          AsyncData(:final value) => _body(value, l10n),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () =>
                ref.invalidate(adminUserDetailProvider(widget.userId)),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }

  Widget _body(JsonMap value, AppLocalizations l10n) {
    if (!_initialized) {
      _tier = textOf(value, ['subscriptionTier', 'tier'], fallback: 'Free');
      _initialized = true;
    }
    final suspended = value['isSuspended'] == true;
    return Column(
      children: [
        KeyValueGrid(
          items: {
            l10n.adminNameLabel: textOf(value, ['fullName', 'userName']),
            l10n.adminEmailLabel: textOf(value, ['email', 'userEmail']),
            l10n.adminTierLabel: textOf(value, ['subscriptionTier', 'tier']),
            l10n.adminActiveLabel: textOf(
              value,
              ['isSubscriptionActive', 'isActive'],
            ),
            l10n.adminAccountStatusLabel: suspended
                ? l10n.adminSuspendedLabel
                : l10n.adminAccountActiveLabel,
            l10n.adminPlansLabel: textOf(value, ['planCount']),
            l10n.adminReportsStatLabel: textOf(
              value,
              ['reportsReceivedCount'],
            ),
          },
        ),
        const SizedBox(height: AppSpacing.lg),
        XnDropdown<String>(
          label: l10n.adminSubscriptionTierLabel,
          value: _tier,
          options: [
            XnDropdownOption(value: 'Free', label: l10n.subscriptionTierFree),
            XnDropdownOption(
              value: 'ProIndividual',
              label: l10n.subscriptionTierProIndividual,
            ),
            XnDropdownOption(
              value: 'ProCoach',
              label: l10n.subscriptionTierProCoach,
            ),
          ],
          onChanged: _saving ? null : (value) => setState(() => _tier = value!),
        ),
        const SizedBox(height: AppSpacing.md),
        XnDropdown<String>(
          label: l10n.adminDurationLabel,
          value: _duration,
          options: [
            XnDropdownOption(value: '', label: l10n.subscriptionNoExpiryLabel),
            XnDropdownOption(
              value: '1',
              label: l10n.subscriptionMonthsLabel(1),
            ),
            XnDropdownOption(
              value: '3',
              label: l10n.subscriptionMonthsLabel(3),
            ),
            XnDropdownOption(
              value: '6',
              label: l10n.subscriptionMonthsLabel(6),
            ),
            XnDropdownOption(
              value: '12',
              label: l10n.subscriptionMonthsLabel(12),
            ),
          ],
          onChanged: _saving
              ? null
              : (value) => setState(() => _duration = value ?? ''),
        ),
        const SizedBox(height: AppSpacing.md),
        XnInput(
          label: l10n.adminReasonLabel,
          controller: _reason,
          hint: l10n.adminReasonHint,
        ),
        const SizedBox(height: AppSpacing.lg),
        XnButton(
          label: l10n.adminAdjustSubscriptionCta,
          icon: Icons.save_outlined,
          loading: _saving,
          onPressed: () => unawaited(_save(l10n)),
        ),
        const SizedBox(height: AppSpacing.md),
        XnButton(
          label: suspended
              ? l10n.adminUnsuspendUserTooltip
              : l10n.adminSuspendUserTooltip,
          icon: suspended ? Icons.lock_open_rounded : Icons.block_rounded,
          variant: suspended
              ? XnButtonVariant.secondary
              : XnButtonVariant.danger,
          loading: _saving,
          onPressed: () => unawaited(_toggleSuspension(suspended, l10n)),
        ),
      ],
    );
  }

  Future<void> _save(AppLocalizations l10n) async {
    setState(() => _saving = true);
    try {
      await ref.read(xenohApiProvider).patchObject(
        '/admin/users/${widget.userId}/subscription',
        {
          'tier': _tier,
          'durationMonths': _duration.isEmpty ? null : int.parse(_duration),
          'reason': _reason.text.trim().isEmpty
              ? l10n.adminManualAdjustmentDefaultReason
              : _reason.text.trim(),
        },
      );
      ref.invalidate(adminUserDetailProvider(widget.userId));
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminSubscriptionAdjustedSnackbar)),
      );
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  Future<void> _toggleSuspension(
    bool currentlySuspended,
    AppLocalizations l10n,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          currentlySuspended
              ? l10n.adminUnsuspendConfirmTitle
              : l10n.adminSuspendConfirmTitle,
        ),
        content: Text(
          currentlySuspended
              ? l10n.adminUnsuspendConfirmMessage
              : l10n.adminSuspendConfirmMessage,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(
              currentlySuspended
                  ? l10n.adminUnsuspendUserTooltip
                  : l10n.adminSuspendUserTooltip,
            ),
          ),
        ],
      ),
    );
    if (confirmed != true || !mounted) {
      return;
    }
    setState(() => _saving = true);
    final action = currentlySuspended ? 'unsuspend' : 'suspend';
    try {
      await ref
          .read(xenohApiProvider)
          .postVoid('/admin/users/${widget.userId}/$action');
      ref
        ..invalidate(adminUserDetailProvider(widget.userId))
        ..invalidate(adminUsersProvider);
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.adminSuspensionUpdatedSnackbar)),
      );
    } catch (error) {
      if (!mounted) {
        return;
      }
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) {
        setState(() => _saving = false);
      }
    }
  }
}
