import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_button.dart';
import '../../../core/widgets/xn_section.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/providers/auth_controller.dart';
import '../../auth/presentation/providers/auth_state.dart';
import '../domain/competition_models.dart';
import 'competition_labels.dart';
import 'competition_providers.dart';
import 'widgets/competition_apply_sheet.dart';

class CompetitionDetailScreen extends ConsumerWidget {
  const CompetitionDetailScreen({required this.slug, super.key});
  final String slug;
  @override
  Widget build(BuildContext context, WidgetRef ref) => Scaffold(
    appBar: AppBar(
      title: Text(AppLocalizations.of(context).competitionDetailTitle),
    ),
    body: AsyncValueView(
      value: ref.watch(competitionDetailProvider(slug)),
      onRetry: () => ref.invalidate(competitionDetailProvider(slug)),
      data: (event) => _EventDetail(event: event),
    ),
  );
}

class _EventDetail extends ConsumerWidget {
  const _EventDetail({required this.event});
  final CompetitionEvent event;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        XnSectionGroup(
          children: [
            Text(
              event.title,
              style: Theme.of(context).textTheme.headlineMedium,
            ),
            const SizedBox(height: AppSpacing.sm),
            Text(event.description),
            const SizedBox(height: AppSpacing.md),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                Chip(
                  label: Text(
                    competitionDisciplineLabel(l10n, event.discipline),
                  ),
                ),
                Chip(
                  label: Text(
                    competitionEventStatusLabel(l10n, event.status),
                  ),
                ),
              ],
            ),
            Text(
              '${event.venueName} · ${event.address}',
              style: const TextStyle(color: AppColors.fg2),
            ),
            const SizedBox(height: AppSpacing.xs),
            Text(
              '${event.confirmedCount}/${event.capacity} · ${event.registrationFee.toStringAsFixed(0)} ${event.currency}',
              style: const TextStyle(color: AppColors.fg3),
            ),
            const SizedBox(height: AppSpacing.lg),
            XnButton(
              label: l10n.competitionApply,
              onPressed: event.status == 'Published'
                  ? () => _register(context, ref)
                  : null,
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.lg),
        Text(
          l10n.competitionCategories,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.sm),
        XnCardStack(
          children: [
            for (final category in event.categories)
              XnSection(
                child: ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(category.name),
                  subtitle: Text(category.eligibilityNotes ?? category.code),
                  trailing: Text(category.code),
                ),
              ),
          ],
        ),
      ],
    );
  }

  Future<void> _register(BuildContext context, WidgetRef ref) async {
    final user = ref.read(authControllerProvider).sessionOrNull?.user;
    if (user == null) {
      await context.push<void>('/login');
      return;
    }
    final submitted = await CompetitionApplySheet.show(
      context,
      event: event,
      initialEmail: user.email,
    );
    if (submitted != true || !context.mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(AppLocalizations.of(context).competitionSubmitted),
      ),
    );
  }
}
