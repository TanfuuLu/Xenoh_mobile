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
import '../../shared_api/xenoh_api.dart';
import '../domain/competition_models.dart';
import 'competition_labels.dart';
import 'competition_providers.dart';

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
        XnSectionList(
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
    final category = ValueNotifier<String?>(null);
    final email = TextEditingController(text: user.email);
    final phone = TextEditingController();
    final facebook = TextEditingController();
    final formKey = GlobalKey<FormState>();
    final submitted = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => ValueListenableBuilder<String?>(
        valueListenable: category,
        builder: (context, selected, _) => AlertDialog(
          title: Text(AppLocalizations.of(context).competitionApply),
          content: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  DropdownButtonFormField<String>(
                    initialValue: selected,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(
                        context,
                      ).competitionCategory,
                    ),
                    items: [
                      for (final item in event.categories)
                        DropdownMenuItem(
                          value: item.id,
                          child: Text(item.name),
                        ),
                    ],
                    onChanged: (value) => category.value = value,
                    validator: (value) => value == null
                        ? AppLocalizations.of(context).competitionChooseCategory
                        : null,
                  ),
                  TextFormField(
                    controller: email,
                    decoration: const InputDecoration(labelText: 'Email'),
                    validator: (value) => value != null && value.contains('@')
                        ? null
                        : AppLocalizations.of(
                            context,
                          ).accountDeletionInvalidEmail,
                  ),
                  TextFormField(
                    controller: phone,
                    decoration: InputDecoration(
                      labelText: AppLocalizations.of(context).competitionPhone,
                    ),
                    validator: (value) => (value?.trim().length ?? 0) >= 7
                        ? null
                        : AppLocalizations.of(
                            context,
                          ).competitionPhoneValidation,
                  ),
                  TextFormField(
                    controller: facebook,
                    decoration: const InputDecoration(labelText: 'Facebook'),
                  ),
                ],
              ),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppLocalizations.of(context).commonCancel),
            ),
            FilledButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  Navigator.pop(context, true);
                }
              },
              child: Text(AppLocalizations.of(context).competitionSubmit),
            ),
          ],
        ),
      ),
    );
    if (submitted == true && context.mounted) {
      try {
        await ref
            .read(competitionRepositoryProvider)
            .register(
              eventId: event.id,
              categoryId: category.value!,
              contactEmail: email.text.trim(),
              contactPhone: phone.text.trim(),
              contactFacebook: facebook.text.trim().isEmpty
                  ? null
                  : facebook.text.trim(),
            );
        ref.invalidate(myCompetitionsProvider);
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(AppLocalizations.of(context).competitionSubmitted),
            ),
          );
        }
      } catch (error) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(apiErrorMessage(error, context))),
          );
        }
      }
    }
    category.dispose();
    email.dispose();
    phone.dispose();
    facebook.dispose();
  }
}
