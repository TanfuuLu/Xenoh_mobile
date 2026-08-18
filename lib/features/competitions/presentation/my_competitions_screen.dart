import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_button.dart';
import '../../../core/widgets/xn_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../shared_api/xenoh_api.dart';
import '../domain/competition_models.dart';
import 'competition_labels.dart';
import 'competition_providers.dart';

class MyCompetitionsScreen extends ConsumerWidget {
  const MyCompetitionsScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(title: Text(AppLocalizations.of(context).competitionsMine)),
    body: AsyncValueView(
      value: ref.watch(myCompetitionsProvider),
      onRetry: () => ref.invalidate(myCompetitionsProvider),
      data: (items) => RefreshIndicator(
        color: AppColors.accent,
        onRefresh: () => ref.refresh(myCompetitionsProvider.future),
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: items.isEmpty
              ? [
                  SizedBox(
                    height: 360,
                    child: Center(
                      child: Text(
                        AppLocalizations.of(context).competitionsMineEmpty,
                      ),
                    ),
                  ),
                ]
              : [
                  for (final item in items) ...[
                    _RegistrationCard(registration: item),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
        ),
      ),
    ),
  );
}

class _RegistrationCard extends ConsumerWidget {
  const _RegistrationCard({required this.registration});
  final CompetitionRegistration registration;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: () =>
                context.push('/competitions/${registration.eventSlug}'),
            child: Text(
              registration.eventTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
          const SizedBox(height: AppSpacing.xs),
          Text(
            '${registration.categoryName} · ${competitionRegistrationStatusLabel(l10n, registration.status)} · ${competitionPaymentStatusLabel(l10n, registration.paymentStatus)}',
            style: const TextStyle(color: AppColors.fg3),
          ),
          if (registration.decisionReason != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Text(registration.decisionReason!),
          ],
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              if (registration.expectedFee > 0 &&
                  registration.paymentStatus != 'Paid')
                XnButton(
                  label: AppLocalizations.of(context).competitionUploadReceipt,
                  variant: XnButtonVariant.secondary,
                  onPressed: () => _upload(context, ref),
                ),
              if (registration.status == 'Submitted' ||
                  registration.status == 'Waitlisted')
                XnButton(
                  label: AppLocalizations.of(context).competitionWithdraw,
                  variant: XnButtonVariant.danger,
                  onPressed: () => _withdraw(context, ref),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Future<void> _upload(BuildContext context, WidgetRef ref) async {
    final selected = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['jpg', 'jpeg', 'png', 'webp', 'pdf'],
    );
    final path = selected?.files.single.path;
    if (path == null) return;
    if (!context.mounted) return;
    final success = AppLocalizations.of(context).competitionReceiptSubmitted;
    await _run(
      context,
      ref,
      () => ref
          .read(competitionRepositoryProvider)
          .uploadReceipt(registration.eventId, path),
      success,
    );
  }

  Future<void> _withdraw(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(AppLocalizations.of(context).competitionWithdrawConfirm),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).competitionWithdraw),
          ),
        ],
      ),
    );
    if (confirmed == true && context.mounted) {
      await _run(
        context,
        ref,
        () => ref
            .read(competitionRepositoryProvider)
            .withdraw(registration.eventId),
        AppLocalizations.of(context).competitionWithdrawn,
      );
    }
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() action,
    String success,
  ) async {
    try {
      await action();
      if (context.mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text(success)));
      }
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
      }
    }
  }
}
