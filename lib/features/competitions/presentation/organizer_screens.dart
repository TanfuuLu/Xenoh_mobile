import 'dart:async';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_card.dart';
import '../../../l10n/app_localizations.dart';
import '../domain/competition_models.dart';
import 'competition_labels.dart';
import 'competition_providers.dart';

class OrganizerHomeScreen extends ConsumerWidget {
  const OrganizerHomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final profile = ref.watch(organizerProfileProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.organizerHomeTitle)),
      body: AsyncValueView(
        value: profile,
        onRetry: () => ref.invalidate(organizerProfileProvider),
        data: (organizer) {
          if (organizer == null) {
            return _OrganizerApplication(
              onSaved: () => ref.invalidate(organizerProfileProvider),
            );
          }
          if (!organizer.isApproved) {
            return _OrganizerReviewState(profile: organizer);
          }
          return const _OrganizerOverview();
        },
      ),
    );
  }
}

class OrganizerEventsScreen extends ConsumerWidget {
  const OrganizerEventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final events = ref.watch(managedCompetitionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.organizerEventsTitle),
        actions: [
          IconButton(
            tooltip: l10n.organizerCreateEvent,
            icon: const Icon(Icons.add_circle_outline_rounded),
            onPressed: () => _showCreateEvent(context, ref),
          ),
        ],
      ),
      body: AsyncValueView(
        value: events,
        onRetry: () => ref.invalidate(managedCompetitionsProvider),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.refresh(managedCompetitionsProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              if (items.isEmpty)
                _EmptyPanel(
                  icon: Icons.event_busy_outlined,
                  message: l10n.organizerNoEvents,
                ),
              for (final event in items) ...[
                _EventCard(
                  event: event,
                  onOpen: () => context.push(
                    '/organizer/events/${event.id}/${event.slug}',
                  ),
                  onPublish: event.status == 'Draft'
                      ? () => _publishEvent(context, ref, event.id)
                      : null,
                ),
                const SizedBox(height: AppSpacing.md),
              ],
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showCreateEvent(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.organizerCreateEvent),
      ),
    );
  }
}

class OrganizerRosterScreen extends ConsumerStatefulWidget {
  const OrganizerRosterScreen({super.key});

  @override
  ConsumerState<OrganizerRosterScreen> createState() =>
      _OrganizerRosterScreenState();
}

class _OrganizerRosterScreenState extends ConsumerState<OrganizerRosterScreen> {
  String? _eventId;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final eventsValue = ref.watch(managedCompetitionsProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.organizerRosterTitle),
        actions: [
          IconButton(
            tooltip: l10n.organizerAddGuest,
            onPressed: () => _addGuest(context),
            icon: const Icon(Icons.person_add_alt_1_outlined),
          ),
        ],
      ),
      body: AsyncValueView(
        value: eventsValue,
        onRetry: () => ref.invalidate(managedCompetitionsProvider),
        data: (events) {
          if (events.isEmpty) {
            return _EmptyPanel(
              icon: Icons.groups_outlined,
              message: l10n.organizerNoEvents,
            );
          }
          final selected = events.any((event) => event.id == _eventId)
              ? _eventId!
              : events.first.id;
          final roster = ref.watch(organizerRosterProvider(selected));
          return Column(
            children: [
              _EventPicker(
                events: events,
                value: selected,
                onChanged: (value) => setState(() => _eventId = value),
              ),
              Expanded(
                child: AsyncValueView(
                  value: roster,
                  onRetry: () => ref.invalidate(
                    organizerRosterProvider(selected),
                  ),
                  data: (registrations) => RefreshIndicator(
                    onRefresh: () => ref.refresh(
                      organizerRosterProvider(selected).future,
                    ),
                    child: ListView(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      children: [
                        if (registrations.isEmpty)
                          _EmptyPanel(
                            icon: Icons.person_search_outlined,
                            message: l10n.organizerNoRegistrations,
                          ),
                        for (final registration in registrations) ...[
                          _RegistrationCard(
                            registration: registration,
                            onDecision:
                                registration.status == 'Submitted' ||
                                    registration.status == 'Waitlisted'
                                ? (approve) => _decide(
                                    context,
                                    selected,
                                    registration.id,
                                    approve,
                                  )
                                : null,
                            onPromote: registration.status == 'Waitlisted'
                                ? () => _promote(
                                    context,
                                    selected,
                                    registration.id,
                                  )
                                : null,
                            onLink: registration.userId == null
                                ? () => _linkGuest(
                                    context,
                                    selected,
                                    registration.id,
                                  )
                                : null,
                            onOpenReceipt: registration.receipts.isEmpty
                                ? null
                                : () => _openReceipt(
                                    selected,
                                    registration.receipts.first.id,
                                  ),
                            onReceiptDecision:
                                registration.receipts.isNotEmpty &&
                                    registration.receipts.first.status ==
                                        'UnderReview'
                                ? (approve) => _reviewReceipt(
                                    context,
                                    selected,
                                    registration.receipts.first.id,
                                    approve,
                                  )
                                : null,
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                      ],
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _decide(
    BuildContext context,
    String eventId,
    String registrationId,
    bool approve,
  ) async {
    final l10n = AppLocalizations.of(context);
    await ref
        .read(competitionRepositoryProvider)
        .decideRegistration(
          eventId: eventId,
          registrationId: registrationId,
          approve: approve,
          reason: approve ? null : l10n.organizerRejectedTitle,
        );
    ref.invalidate(organizerRosterProvider(eventId));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.organizerDecisionSaved)),
      );
    }
  }

  Future<void> _addGuest(BuildContext context) async {
    final l10n = AppLocalizations.of(context);
    final events = await ref.read(managedCompetitionsProvider.future);
    if (events.isEmpty || !context.mounted) return;
    final event = events.firstWhere(
      (item) => item.id == _eventId,
      orElse: () => events.first,
    );
    final detail = await ref.read(competitionDetailProvider(event.slug).future);
    if (!context.mounted) return;
    final draft = await showDialog<_GuestDraft>(
      context: context,
      builder: (_) => _GuestRegistrationDialog(categories: detail.categories),
    );
    if (draft == null) return;
    await ref
        .read(competitionRepositoryProvider)
        .addGuestRegistration(
          event.id,
          categoryId: draft.categoryId,
          athleteName: draft.athleteName,
          contactEmail: draft.contactEmail,
          contactPhone: draft.contactPhone,
        );
    ref.invalidate(organizerRosterProvider(event.id));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.organizerGuestAdded)),
      );
    }
  }

  Future<void> _promote(
    BuildContext context,
    String eventId,
    String registrationId,
  ) async {
    final l10n = AppLocalizations.of(context);
    await ref
        .read(competitionRepositoryProvider)
        .promoteWaitlist(eventId, registrationId);
    ref.invalidate(organizerRosterProvider(eventId));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.organizerWaitlistPromoted)),
      );
    }
  }

  Future<void> _linkGuest(
    BuildContext context,
    String eventId,
    String registrationId,
  ) async {
    final l10n = AppLocalizations.of(context);
    final controller = TextEditingController();
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(l10n.organizerLinkGuest),
        content: TextField(
          controller: controller,
          decoration: InputDecoration(labelText: l10n.organizerUserId),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(l10n.commonCancel),
          ),
          FilledButton(
            onPressed: () {
              if (controller.text.trim().isNotEmpty) {
                Navigator.pop(dialogContext, true);
              }
            },
            child: Text(l10n.organizerLinkGuest),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(competitionRepositoryProvider)
          .linkGuestRegistration(
            eventId,
            registrationId,
            controller.text.trim(),
          );
      ref.invalidate(organizerRosterProvider(eventId));
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.organizerGuestLinked)),
        );
      }
    }
    controller.dispose();
  }

  Future<void> _openReceipt(String eventId, String receiptId) async {
    final raw = await ref
        .read(competitionRepositoryProvider)
        .getReceiptUrl(eventId, receiptId);
    final uri = Uri.tryParse(raw);
    if (uri != null && (uri.scheme == 'https' || uri.scheme == 'http')) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _reviewReceipt(
    BuildContext context,
    String eventId,
    String receiptId,
    bool approve,
  ) async {
    final l10n = AppLocalizations.of(context);
    await ref
        .read(competitionRepositoryProvider)
        .decideReceipt(
          eventId: eventId,
          receiptId: receiptId,
          approve: approve,
          reason: approve ? null : l10n.organizerRejectReceipt,
        );
    ref.invalidate(organizerRosterProvider(eventId));
    if (context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.organizerReceiptReviewed)),
      );
    }
  }
}

class OrganizerResultsScreen extends ConsumerStatefulWidget {
  const OrganizerResultsScreen({super.key});

  @override
  ConsumerState<OrganizerResultsScreen> createState() =>
      _OrganizerResultsScreenState();
}

class AdminOrganizerApplicationsScreen extends ConsumerStatefulWidget {
  const AdminOrganizerApplicationsScreen({super.key});

  @override
  ConsumerState<AdminOrganizerApplicationsScreen> createState() =>
      _AdminOrganizerApplicationsScreenState();
}

class _AdminOrganizerApplicationsScreenState
    extends ConsumerState<AdminOrganizerApplicationsScreen> {
  String? _status = 'Pending';

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final applications = ref.watch(adminOrganizerApplicationsProvider(_status));
    return Scaffold(
      appBar: AppBar(title: Text(l10n.adminOrganizerVerification)),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              AppSpacing.md,
              AppSpacing.lg,
              0,
            ),
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: SegmentedButton<String?>(
                segments: [
                  ButtonSegment(value: null, label: Text(l10n.commonAll)),
                  ButtonSegment(
                    value: 'Pending',
                    label: Text(l10n.competitionOrganizerPending),
                  ),
                  ButtonSegment(
                    value: 'Approved',
                    label: Text(l10n.competitionOrganizerApproved),
                  ),
                  ButtonSegment(
                    value: 'Rejected',
                    label: Text(l10n.competitionOrganizerRejected),
                  ),
                  ButtonSegment(
                    value: 'Suspended',
                    label: Text(l10n.competitionOrganizerSuspended),
                  ),
                ],
                selected: {_status},
                onSelectionChanged: (selection) =>
                    setState(() => _status = selection.first),
              ),
            ),
          ),
          Expanded(
            child: AsyncValueView(
              value: applications,
              onRetry: () => ref.invalidate(
                adminOrganizerApplicationsProvider(_status),
              ),
              data: (items) => RefreshIndicator(
                onRefresh: () => ref.refresh(
                  adminOrganizerApplicationsProvider(_status).future,
                ),
                child: ListView(
                  padding: const EdgeInsets.all(AppSpacing.lg),
                  children: [
                    XnCard(
                      color: AppColors.clay100,
                      child: Row(
                        children: [
                          const Icon(Icons.verified_user_rounded),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Text(
                              l10n.adminOrganizerVerificationSubtitle,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.lg),
                    if (items.isEmpty)
                      _EmptyPanel(
                        icon: Icons.fact_check_outlined,
                        message: l10n.adminOrganizerQueueEmpty,
                      ),
                    for (final profile in items) ...[
                      XnCard(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Text(
                                    profile.organizationName,
                                    style: Theme.of(
                                      context,
                                    ).textTheme.titleLarge,
                                  ),
                                ),
                                Chip(
                                  label: Text(
                                    organizerStatusLabel(l10n, profile.status),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: AppSpacing.xs),
                            Text(profile.contactEmail),
                            Text(profile.contactPhone),
                            if (profile.notes?.isNotEmpty == true) ...[
                              const SizedBox(height: AppSpacing.sm),
                              Text(profile.notes!),
                            ],
                            const SizedBox(height: AppSpacing.md),
                            Wrap(
                              spacing: AppSpacing.sm,
                              runSpacing: AppSpacing.sm,
                              children: [
                                OutlinedButton.icon(
                                  onPressed: profile.evidenceFileId == null
                                      ? null
                                      : () => _openEvidence(profile.id),
                                  icon: const Icon(Icons.file_open_outlined),
                                  label: Text(
                                    l10n.adminOrganizerEvidenceOpen,
                                  ),
                                ),
                                FilledButton.icon(
                                  onPressed: () => _showDecision(profile),
                                  icon: const Icon(Icons.gavel_rounded),
                                  label: Text(l10n.adminOrganizerSaveDecision),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: AppSpacing.md),
                    ],
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _openEvidence(String profileId) async {
    final repository = ref.read(competitionRepositoryProvider);
    final rawUrl = await repository.getOrganizerEvidenceUrl(profileId);
    final uri = Uri.tryParse(rawUrl);
    if (uri != null && (uri.scheme == 'https' || uri.scheme == 'http')) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    }
  }

  Future<void> _showDecision(OrganizerProfile profile) async {
    final l10n = AppLocalizations.of(context);
    final reason = TextEditingController();
    var decision = profile.status == 'Approved' ? 'Suspended' : 'Approved';
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(profile.organizationName),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: decision,
                items: [
                  DropdownMenuItem(
                    value: 'Approved',
                    child: Text(l10n.competitionOrganizerApproved),
                  ),
                  DropdownMenuItem(
                    value: 'Rejected',
                    child: Text(l10n.competitionOrganizerRejected),
                  ),
                  DropdownMenuItem(
                    value: 'Suspended',
                    child: Text(l10n.competitionOrganizerSuspended),
                  ),
                ],
                onChanged: (value) => setDialogState(
                  () => decision = value ?? decision,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: reason,
                minLines: 3,
                maxLines: 5,
                maxLength: 1000,
                decoration: InputDecoration(
                  labelText: l10n.adminOrganizerDecisionReason,
                  hintText: l10n.adminOrganizerDecisionReasonHint,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(dialogContext, false),
              child: Text(l10n.commonCancel),
            ),
            FilledButton(
              onPressed: () {
                if (reason.text.trim().isNotEmpty) {
                  Navigator.pop(dialogContext, true);
                }
              },
              child: Text(l10n.adminOrganizerSaveDecision),
            ),
          ],
        ),
      ),
    );
    if (saved == true) {
      await ref
          .read(competitionRepositoryProvider)
          .decideOrganizerApplication(
            profileId: profile.id,
            decision: decision,
            reason: reason.text.trim(),
          );
      ref.invalidate(adminOrganizerApplicationsProvider(_status));
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.adminOrganizerDecisionSaved)),
        );
      }
    }
    reason.dispose();
  }
}

class _OrganizerResultsScreenState
    extends ConsumerState<OrganizerResultsScreen> {
  String? _eventId;
  bool _publishing = false;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.organizerResultsTitle)),
      body: AsyncValueView(
        value: ref.watch(managedCompetitionsProvider),
        onRetry: () => ref.invalidate(managedCompetitionsProvider),
        data: (events) {
          if (events.isEmpty) {
            return _EmptyPanel(
              icon: Icons.emoji_events_outlined,
              message: l10n.organizerNoEvents,
            );
          }
          final selected = events.any((event) => event.id == _eventId)
              ? _eventId!
              : events.first.id;
          final event = events.firstWhere((item) => item.id == selected);
          final roster = ref.watch(organizerRosterProvider(selected));
          return Column(
            children: [
              _EventPicker(
                events: events,
                value: selected,
                onChanged: (value) => setState(() => _eventId = value),
              ),
              Expanded(
                child: AsyncValueView(
                  value: roster,
                  onRetry: () => ref.invalidate(
                    organizerRosterProvider(selected),
                  ),
                  data: (registrations) {
                    final approved = registrations
                        .where((item) => item.status == 'Approved')
                        .toList();
                    return ListView(
                      padding: const EdgeInsets.all(AppSpacing.lg),
                      children: [
                        XnCard(
                          color: AppColors.sage100,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.insights_rounded,
                                color: AppColors.sage700,
                              ),
                              const SizedBox(width: AppSpacing.md),
                              Expanded(child: Text(l10n.organizerResultsHint)),
                            ],
                          ),
                        ),
                        const SizedBox(height: AppSpacing.lg),
                        if (approved.isEmpty)
                          _EmptyPanel(
                            icon: Icons.leaderboard_outlined,
                            message: l10n.organizerNoRegistrations,
                          ),
                        for (final registration in approved) ...[
                          _ResultEntryCard(
                            registration: registration,
                            discipline: event.discipline,
                            onEdit: () => _showResultEditor(
                              context,
                              eventId: selected,
                              discipline: event.discipline,
                              registration: registration,
                            ),
                          ),
                          const SizedBox(height: AppSpacing.md),
                        ],
                        if (approved.isNotEmpty)
                          FilledButton.icon(
                            onPressed: _publishing
                                ? null
                                : () => _publishResults(context, selected),
                            icon: const Icon(Icons.publish_rounded),
                            label: Text(l10n.organizerPublishResults),
                          ),
                      ],
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Future<void> _publishResults(BuildContext context, String eventId) async {
    final l10n = AppLocalizations.of(context);
    setState(() => _publishing = true);
    try {
      await ref.read(competitionRepositoryProvider).publishResults(eventId);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.organizerResultsPublished)),
        );
      }
    } finally {
      if (mounted) setState(() => _publishing = false);
    }
  }

  Future<void> _showResultEditor(
    BuildContext context, {
    required String eventId,
    required String discipline,
    required CompetitionRegistration registration,
  }) async {
    final saved = await showDialog<bool>(
      context: context,
      builder: (_) => _ResultEditorDialog(
        eventId: eventId,
        discipline: discipline,
        registration: registration,
      ),
    );
    if (saved == true && context.mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(AppLocalizations.of(context).organizerResultSaved),
        ),
      );
    }
  }
}

class _OrganizerOverview extends ConsumerWidget {
  const _OrganizerOverview();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    return AsyncValueView(
      value: ref.watch(managedCompetitionsProvider),
      onRetry: () => ref.invalidate(managedCompetitionsProvider),
      data: (events) {
        final confirmed = events.fold<int>(
          0,
          (sum, event) => sum + event.confirmedCount,
        );
        final capacity = events.fold<int>(
          0,
          (sum, event) => sum + event.capacity,
        );
        return RefreshIndicator(
          onRefresh: () => ref.refresh(managedCompetitionsProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              Container(
                padding: const EdgeInsets.all(AppSpacing.xxl),
                decoration: BoxDecoration(
                  color: AppColors.clay100,
                  borderRadius: BorderRadius.circular(AppRadius.xxl),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      l10n.organizerHomeEyebrow,
                      style: Theme.of(context).textTheme.labelLarge?.copyWith(
                        color: AppColors.clay900,
                        letterSpacing: 1.2,
                      ),
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(
                      l10n.organizerHomeTitle,
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    Text(l10n.organizerHomeSubtitle),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Row(
                children: [
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.event_available_rounded,
                      value: '${events.length}',
                      label: l10n.organizerEventsTitle,
                      color: AppColors.dataBlue,
                    ),
                  ),
                  const SizedBox(width: AppSpacing.md),
                  Expanded(
                    child: _MetricCard(
                      icon: Icons.groups_rounded,
                      value: '$confirmed',
                      label: l10n.organizerApprovedAthletes,
                      color: AppColors.dataTeal,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: AppSpacing.md),
              _MetricCard(
                icon: Icons.donut_large_rounded,
                value: capacity == 0
                    ? '0%'
                    : '${(confirmed * 100 / capacity).round()}%',
                label: l10n.organizerCapacityFilled,
                color: AppColors.dataViolet,
              ),
              const SizedBox(height: AppSpacing.xl),
              FilledButton.icon(
                onPressed: () => context.go('/organizer/events'),
                icon: const Icon(Icons.arrow_forward_rounded),
                label: Text(l10n.organizerEventsTitle),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _OrganizerApplication extends ConsumerStatefulWidget {
  const _OrganizerApplication({required this.onSaved});
  final VoidCallback onSaved;

  @override
  ConsumerState<_OrganizerApplication> createState() =>
      _OrganizerApplicationState();
}

class _OrganizerApplicationState extends ConsumerState<_OrganizerApplication> {
  final _formKey = GlobalKey<FormState>();
  final _organization = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  final _website = TextEditingController();
  final _notes = TextEditingController();
  String? _evidencePath;
  bool _saving = false;

  @override
  void dispose() {
    _organization.dispose();
    _email.dispose();
    _phone.dispose();
    _website.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return ListView(
      padding: const EdgeInsets.all(AppSpacing.lg),
      children: [
        Text(
          l10n.organizerApplicationTitle,
          style: Theme.of(context).textTheme.headlineMedium,
        ),
        const SizedBox(height: AppSpacing.sm),
        Text(l10n.organizerApplicationSubtitle),
        const SizedBox(height: AppSpacing.xl),
        Form(
          key: _formKey,
          child: Column(
            children: [
              _field(_organization, l10n.organizerOrganizationName),
              _field(_email, l10n.organizerContactEmail),
              _field(_phone, l10n.organizerContactPhone),
              _field(_website, l10n.organizerWebsite, required: false),
              _field(_notes, l10n.organizerNotes, required: false, lines: 3),
              OutlinedButton.icon(
                onPressed: _pickEvidence,
                icon: const Icon(Icons.attach_file_rounded),
                label: Text(
                  _evidencePath?.split(RegExp(r'[/\\]')).last ??
                      l10n.organizerEvidence,
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              FilledButton(
                onPressed: _saving ? null : _submit,
                child: Text(l10n.organizerSubmitApplication),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _field(
    TextEditingController controller,
    String label, {
    bool required = true,
    int lines = 1,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: TextFormField(
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(labelText: label),
      validator: required
          ? (value) => (value?.trim().isEmpty ?? true) ? label : null
          : null,
    ),
  );

  Future<void> _pickEvidence() async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'jpg', 'jpeg', 'png'],
    );
    if (mounted && result?.files.single.path != null) {
      setState(() => _evidencePath = result!.files.single.path);
    }
  }

  Future<void> _submit() async {
    final l10n = AppLocalizations.of(context);
    if (!_formKey.currentState!.validate()) return;
    if (_evidencePath == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.organizerEvidenceRequired)),
      );
      return;
    }
    setState(() => _saving = true);
    try {
      final repository = ref.read(competitionRepositoryProvider);
      final evidenceId = await repository.uploadOrganizerEvidence(
        _evidencePath!,
      );
      await repository.applyAsOrganizer(
        organizationName: _organization.text.trim(),
        contactEmail: _email.text.trim(),
        contactPhone: _phone.text.trim(),
        websiteUrl: _website.text.trim().isEmpty ? null : _website.text.trim(),
        notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        evidenceFileId: evidenceId,
      );
      widget.onSaved();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l10n.organizerApplicationSaved)),
        );
      }
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _OrganizerReviewState extends StatelessWidget {
  const _OrganizerReviewState({required this.profile});
  final OrganizerProfile profile;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final title = switch (profile.status) {
      'Rejected' => l10n.organizerRejectedTitle,
      'Suspended' => l10n.organizerSuspendedTitle,
      _ => l10n.organizerPendingTitle,
    };
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(AppSpacing.xxl),
        child: XnCard(
          color: AppColors.clay100,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.hourglass_top_rounded, size: 48),
              const SizedBox(height: AppSpacing.lg),
              Text(title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: AppSpacing.sm),
              Text(
                profile.reviewReason ?? l10n.organizerPendingSubtitle,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _EventPicker extends StatelessWidget {
  const _EventPicker({
    required this.events,
    required this.value,
    required this.onChanged,
  });
  final List<CompetitionSummary> events;
  final String value;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) => Padding(
    padding: const EdgeInsets.fromLTRB(
      AppSpacing.lg,
      AppSpacing.md,
      AppSpacing.lg,
      0,
    ),
    child: DropdownButtonFormField<String>(
      initialValue: value,
      decoration: InputDecoration(
        labelText: AppLocalizations.of(context).organizerSelectEvent,
        prefixIcon: const Icon(Icons.event_outlined),
      ),
      items: events
          .map(
            (event) => DropdownMenuItem(
              value: event.id,
              child: Text(event.title, overflow: TextOverflow.ellipsis),
            ),
          )
          .toList(),
      onChanged: (value) {
        if (value != null) onChanged(value);
      },
    ),
  );
}

class _EventCard extends StatelessWidget {
  const _EventCard({
    required this.event,
    required this.onOpen,
    this.onPublish,
  });
  final CompetitionSummary event;
  final VoidCallback onOpen;
  final VoidCallback? onPublish;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final progress = event.capacity == 0
        ? 0.0
        : (event.confirmedCount / event.capacity).clamp(0.0, 1.0);
    return XnCard(
      onTap: onOpen,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  event.title,
                  style: Theme.of(context).textTheme.titleLarge,
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
            '${competitionDisciplineLabel(l10n, event.discipline)} · ${event.venueName}',
          ),
          const SizedBox(height: AppSpacing.lg),
          LinearProgressIndicator(value: progress),
          const SizedBox(height: AppSpacing.xs),
          Text('${event.confirmedCount}/${event.capacity}'),
          if (onPublish != null) ...[
            const SizedBox(height: AppSpacing.md),
            FilledButton.tonalIcon(
              onPressed: onPublish,
              icon: const Icon(Icons.publish_rounded),
              label: Text(l10n.organizerPublish),
            ),
          ],
        ],
      ),
    );
  }
}

class _RegistrationCard extends StatelessWidget {
  const _RegistrationCard({
    required this.registration,
    this.onDecision,
    this.onPromote,
    this.onLink,
    this.onOpenReceipt,
    this.onReceiptDecision,
  });
  final CompetitionRegistration registration;
  final ValueChanged<bool>? onDecision;
  final VoidCallback? onPromote;
  final VoidCallback? onLink;
  final VoidCallback? onOpenReceipt;
  final ValueChanged<bool>? onReceiptDecision;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            registration.athleteName,
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: AppSpacing.xs),
          Text('${registration.categoryName} · ${registration.contactEmail}'),
          const SizedBox(height: AppSpacing.md),
          Wrap(
            spacing: AppSpacing.sm,
            children: [
              Chip(
                label: Text(
                  competitionRegistrationStatusLabel(
                    l10n,
                    registration.status,
                  ),
                ),
              ),
              Chip(
                label: Text(
                  competitionPaymentStatusLabel(
                    l10n,
                    registration.paymentStatus,
                  ),
                ),
              ),
            ],
          ),
          if (onDecision != null) ...[
            const SizedBox(height: AppSpacing.md),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => onDecision!(false),
                    child: Text(l10n.organizerReject),
                  ),
                ),
                const SizedBox(width: AppSpacing.md),
                Expanded(
                  child: FilledButton(
                    onPressed: () => onDecision!(true),
                    child: Text(l10n.organizerApprove),
                  ),
                ),
              ],
            ),
          ],
          if (onPromote != null || onLink != null) ...[
            const SizedBox(height: AppSpacing.sm),
            Wrap(
              spacing: AppSpacing.sm,
              children: [
                if (onPromote != null)
                  FilledButton.tonalIcon(
                    onPressed: onPromote,
                    icon: const Icon(Icons.upgrade_rounded),
                    label: Text(l10n.organizerPromoteWaitlist),
                  ),
                if (onLink != null)
                  OutlinedButton.icon(
                    onPressed: onLink,
                    icon: const Icon(Icons.link_rounded),
                    label: Text(l10n.organizerLinkGuest),
                  ),
              ],
            ),
          ],
          if (onOpenReceipt != null) ...[
            const Divider(height: AppSpacing.xxl),
            Row(
              children: [
                Expanded(
                  child: TextButton.icon(
                    onPressed: onOpenReceipt,
                    icon: const Icon(Icons.receipt_long_outlined),
                    label: Text(l10n.organizerOpenReceipt),
                  ),
                ),
                if (onReceiptDecision != null) ...[
                  IconButton(
                    tooltip: l10n.organizerRejectReceipt,
                    onPressed: () => onReceiptDecision!(false),
                    icon: const Icon(Icons.close_rounded),
                  ),
                  IconButton(
                    tooltip: l10n.organizerApproveReceipt,
                    onPressed: () => onReceiptDecision!(true),
                    icon: const Icon(Icons.check_rounded),
                  ),
                ],
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _GuestRegistrationDialog extends StatefulWidget {
  const _GuestRegistrationDialog({required this.categories});
  final List<CompetitionCategory> categories;

  @override
  State<_GuestRegistrationDialog> createState() =>
      _GuestRegistrationDialogState();
}

class _GuestRegistrationDialogState extends State<_GuestRegistrationDialog> {
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _phone = TextEditingController();
  String? _categoryId;

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _phone.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(l10n.organizerAddGuest),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            DropdownButtonFormField<String>(
              initialValue: _categoryId,
              decoration: InputDecoration(labelText: l10n.competitionCategory),
              items: widget.categories
                  .map(
                    (category) => DropdownMenuItem(
                      value: category.id,
                      child: Text(category.name),
                    ),
                  )
                  .toList(),
              onChanged: (value) => setState(() => _categoryId = value),
            ),
            TextField(
              controller: _name,
              decoration: InputDecoration(labelText: l10n.organizerAthleteName),
            ),
            TextField(
              controller: _email,
              keyboardType: TextInputType.emailAddress,
              decoration: InputDecoration(
                labelText: l10n.organizerContactEmail,
              ),
            ),
            TextField(
              controller: _phone,
              keyboardType: TextInputType.phone,
              decoration: InputDecoration(
                labelText: l10n.organizerContactPhone,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.pop(context),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: () {
            if (_categoryId != null &&
                _name.text.trim().isNotEmpty &&
                _email.text.trim().isNotEmpty &&
                _phone.text.trim().length >= 7) {
              Navigator.pop(
                context,
                _GuestDraft(
                  categoryId: _categoryId!,
                  athleteName: _name.text.trim(),
                  contactEmail: _email.text.trim(),
                  contactPhone: _phone.text.trim(),
                ),
              );
            }
          },
          child: Text(l10n.organizerAddGuest),
        ),
      ],
    );
  }
}

class _GuestDraft {
  const _GuestDraft({
    required this.categoryId,
    required this.athleteName,
    required this.contactEmail,
    required this.contactPhone,
  });
  final String categoryId;
  final String athleteName;
  final String contactEmail;
  final String contactPhone;
}

class _ResultEntryCard extends StatelessWidget {
  const _ResultEntryCard({
    required this.registration,
    required this.discipline,
    required this.onEdit,
  });
  final CompetitionRegistration registration;
  final String discipline;
  final VoidCallback onEdit;

  @override
  Widget build(BuildContext context) => XnCard(
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: AppColors.clay100,
          child: Text(
            registration.athleteName.isEmpty
                ? '?'
                : registration.athleteName.characters.first,
          ),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                registration.athleteName,
                style: Theme.of(context).textTheme.titleMedium,
              ),
              Text('${registration.categoryName} · $discipline'),
            ],
          ),
        ),
        IconButton(
          tooltip: AppLocalizations.of(context).organizerResultsReady,
          onPressed: onEdit,
          icon: const Icon(Icons.edit_note_rounded),
        ),
      ],
    ),
  );
}

class _ResultEditorDialog extends ConsumerStatefulWidget {
  const _ResultEditorDialog({
    required this.eventId,
    required this.discipline,
    required this.registration,
  });

  final String eventId;
  final String discipline;
  final CompetitionRegistration registration;

  @override
  ConsumerState<_ResultEditorDialog> createState() =>
      _ResultEditorDialogState();
}

class _ResultEditorDialogState extends ConsumerState<_ResultEditorDialog> {
  final _formKey = GlobalKey<FormState>();
  final _bodyweight = TextEditingController();
  final _squat = TextEditingController();
  final _bench = TextEditingController();
  final _deadlift = TextEditingController();
  final _place = TextEditingController();
  final _notes = TextEditingController();
  String _state = 'Finished';
  bool _saving = false;

  @override
  void dispose() {
    _bodyweight.dispose();
    _squat.dispose();
    _bench.dispose();
    _deadlift.dispose();
    _place.dispose();
    _notes.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final powerlifting = widget.discipline == 'Powerlifting';
    return AlertDialog(
      title: Text(widget.registration.athleteName),
      content: SizedBox(
        width: 480,
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (powerlifting) ...[
                  _numberField(_bodyweight, l10n.organizerBodyweightKg),
                  _numberField(_squat, l10n.organizerBestSquatKg),
                  _numberField(_bench, l10n.organizerBestBenchKg),
                  _numberField(_deadlift, l10n.organizerBestDeadliftKg),
                ] else
                  _numberField(_place, l10n.organizerPlace, integer: true),
                DropdownButtonFormField<String>(
                  initialValue: _state,
                  decoration: InputDecoration(
                    labelText: l10n.organizerResultState,
                  ),
                  items: [
                    DropdownMenuItem(
                      value: 'Finished',
                      child: Text(l10n.competitionResultFinished),
                    ),
                    DropdownMenuItem(
                      value: 'Disqualified',
                      child: Text(l10n.competitionResultDisqualified),
                    ),
                    DropdownMenuItem(
                      value: 'DidNotFinish',
                      child: Text(l10n.competitionResultDidNotFinish),
                    ),
                  ],
                  onChanged: (value) => _state = value ?? _state,
                ),
                const SizedBox(height: AppSpacing.md),
                TextFormField(
                  controller: _notes,
                  decoration: InputDecoration(
                    labelText: l10n.organizerResultNotes,
                  ),
                  maxLines: 2,
                ),
              ],
            ),
          ),
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(l10n.organizerSaveResult),
        ),
      ],
    );
  }

  Widget _numberField(
    TextEditingController controller,
    String label, {
    bool integer = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: TextFormField(
      controller: controller,
      keyboardType: TextInputType.numberWithOptions(decimal: !integer),
      decoration: InputDecoration(labelText: label),
      validator: (value) {
        final parsed = integer
            ? int.tryParse(value ?? '')
            : double.tryParse(value ?? '');
        return parsed == null ? label : null;
      },
    ),
  );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final repository = ref.read(competitionRepositoryProvider);
    try {
      if (widget.discipline == 'Powerlifting') {
        await repository.upsertPowerliftingResult(
          eventId: widget.eventId,
          registrationId: widget.registration.id,
          bodyweightKg: double.parse(_bodyweight.text),
          bestSquatKg: double.parse(_squat.text),
          bestBenchKg: double.parse(_bench.text),
          bestDeadliftKg: double.parse(_deadlift.text),
          state: _state,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        );
      } else {
        await repository.upsertBodybuildingResult(
          eventId: widget.eventId,
          registrationId: widget.registration.id,
          place: int.tryParse(_place.text),
          state: _state,
          notes: _notes.text.trim().isEmpty ? null : _notes.text.trim(),
        );
      }
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

class _MetricCard extends StatelessWidget {
  const _MetricCard({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
  });
  final IconData icon;
  final String value;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) => XnCard(
    child: Row(
      children: [
        CircleAvatar(
          backgroundColor: color.withValues(alpha: .14),
          foregroundColor: color,
          child: Icon(icon),
        ),
        const SizedBox(width: AppSpacing.md),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(value, style: Theme.of(context).textTheme.headlineSmall),
              Text(label, maxLines: 2),
            ],
          ),
        ),
      ],
    ),
  );
}

class _EmptyPanel extends StatelessWidget {
  const _EmptyPanel({required this.icon, required this.message});
  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) => Center(
    child: Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 44, color: AppColors.fg3),
          const SizedBox(height: AppSpacing.md),
          Text(message, textAlign: TextAlign.center),
        ],
      ),
    ),
  );
}

Future<void> _publishEvent(
  BuildContext context,
  WidgetRef ref,
  String eventId,
) async {
  final l10n = AppLocalizations.of(context);
  await ref.read(competitionRepositoryProvider).publishEvent(eventId);
  ref.invalidate(managedCompetitionsProvider);
  if (context.mounted) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(l10n.organizerEventPublished)),
    );
  }
}

Future<void> _showCreateEvent(BuildContext context, WidgetRef ref) async {
  final created = await showModalBottomSheet<bool>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    builder: (_) => const _CreateEventSheet(),
  );
  if (created == true) ref.invalidate(managedCompetitionsProvider);
}

class _CreateEventSheet extends ConsumerStatefulWidget {
  const _CreateEventSheet();

  @override
  ConsumerState<_CreateEventSheet> createState() => _CreateEventSheetState();
}

class _CreateEventSheetState extends ConsumerState<_CreateEventSheet> {
  final _formKey = GlobalKey<FormState>();
  final _title = TextEditingController();
  final _description = TextEditingController();
  final _venue = TextEditingController();
  final _address = TextEditingController();
  final _contact = TextEditingController();
  final _capacity = TextEditingController(text: '100');
  final _fee = TextEditingController(text: '0');
  final _currency = TextEditingController(text: 'THB');
  final _bankName = TextEditingController();
  final _bankAccountNumber = TextEditingController();
  final _bankAccountName = TextEditingController();
  final _transferInstructions = TextEditingController();
  String _discipline = 'Powerlifting';
  late DateTime _starts = DateTime.now().toUtc().add(const Duration(days: 60));
  late DateTime _ends = _starts.add(const Duration(hours: 8));
  late DateTime _registrationOpens = DateTime.now().toUtc();
  late DateTime _registrationCloses = _starts.subtract(
    const Duration(days: 10),
  );
  bool _saving = false;

  @override
  void dispose() {
    _title.dispose();
    _description.dispose();
    _venue.dispose();
    _address.dispose();
    _contact.dispose();
    _capacity.dispose();
    _fee.dispose();
    _currency.dispose();
    _bankName.dispose();
    _bankAccountNumber.dispose();
    _bankAccountName.dispose();
    _transferInstructions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.lg,
      ),
      child: Form(
        key: _formKey,
        child: ListView(
          shrinkWrap: true,
          children: [
            Text(
              l10n.organizerCreateEvent,
              style: Theme.of(context).textTheme.headlineSmall,
            ),
            const SizedBox(height: AppSpacing.lg),
            _requiredField(_title, l10n.competitionTitleLabel),
            _requiredField(
              _description,
              l10n.organizerEventDescription,
              lines: 3,
            ),
            DropdownButtonFormField<String>(
              initialValue: _discipline,
              items: [
                DropdownMenuItem(
                  value: 'Powerlifting',
                  child: Text(l10n.competitionDisciplinePowerlifting),
                ),
                DropdownMenuItem(
                  value: 'Bodybuilding',
                  child: Text(l10n.competitionDisciplineBodybuilding),
                ),
              ],
              onChanged: (value) => _discipline = value ?? _discipline,
            ),
            const SizedBox(height: AppSpacing.md),
            _requiredField(_venue, l10n.organizerVenueName),
            _requiredField(_address, l10n.organizerAddress),
            _createDateTile(
              l10n.organizerStartsAt,
              _starts,
              (value) => _starts = value,
            ),
            _createDateTile(
              l10n.organizerEndsAt,
              _ends,
              (value) => _ends = value,
            ),
            _createDateTile(
              l10n.organizerRegistrationOpens,
              _registrationOpens,
              (value) => _registrationOpens = value,
            ),
            _createDateTile(
              l10n.organizerRegistrationCloses,
              _registrationCloses,
              (value) => _registrationCloses = value,
            ),
            _requiredField(_capacity, l10n.organizerCapacity, numeric: true),
            _requiredField(
              _fee,
              l10n.organizerRegistrationFee,
              numeric: true,
            ),
            _requiredField(_currency, l10n.organizerCurrency),
            _requiredField(_contact, l10n.organizerContactEmail),
            _optionalField(_bankName, l10n.organizerBankName),
            _optionalField(
              _bankAccountNumber,
              l10n.organizerBankAccountNumber,
            ),
            _optionalField(_bankAccountName, l10n.organizerBankAccountName),
            _optionalField(
              _transferInstructions,
              l10n.organizerTransferInstructions,
              lines: 2,
            ),
            FilledButton(
              onPressed: _saving ? null : _save,
              child: Text(l10n.organizerCreateEvent),
            ),
          ],
        ),
      ),
    );
  }

  Widget _requiredField(
    TextEditingController controller,
    String label, {
    int lines = 1,
    bool numeric = false,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: TextFormField(
      controller: controller,
      maxLines: lines,
      keyboardType: numeric
          ? const TextInputType.numberWithOptions(decimal: true)
          : null,
      decoration: InputDecoration(labelText: label),
      validator: (value) => (value?.trim().isEmpty ?? true) ? label : null,
    ),
  );

  Widget _optionalField(
    TextEditingController controller,
    String label, {
    int lines = 1,
  }) => Padding(
    padding: const EdgeInsets.only(bottom: AppSpacing.md),
    child: TextFormField(
      controller: controller,
      maxLines: lines,
      decoration: InputDecoration(labelText: label),
    ),
  );

  Widget _createDateTile(
    String label,
    DateTime value,
    ValueChanged<DateTime> onChanged,
  ) => ListTile(
    contentPadding: EdgeInsets.zero,
    leading: const Icon(Icons.calendar_month_outlined),
    title: Text(label),
    subtitle: Text(
      '${value.toLocal().day}/${value.toLocal().month}/${value.toLocal().year}',
    ),
    onTap: () async {
      final selected = await showDatePicker(
        context: context,
        initialDate: value.toLocal(),
        firstDate: DateTime.now().subtract(const Duration(days: 1)),
        lastDate: DateTime.now().add(const Duration(days: 3650)),
      );
      if (selected != null) {
        setState(() {
          onChanged(
            DateTime(
              selected.year,
              selected.month,
              selected.day,
              value.hour,
              value.minute,
            ).toUtc(),
          );
        });
      }
    },
  );

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;
    setState(() => _saving = true);
    final capacity = int.tryParse(_capacity.text);
    final fee = double.tryParse(_fee.text);
    if (capacity == null || capacity < 1 || fee == null || fee < 0) return;
    try {
      await ref
          .read(competitionRepositoryProvider)
          .createEvent(
            CompetitionEventInput(
              title: _title.text.trim(),
              description: _description.text.trim(),
              discipline: _discipline,
              venueName: _venue.text.trim(),
              address: _address.text.trim(),
              timeZoneId: 'Asia/Bangkok',
              startsAtUtc: _starts,
              endsAtUtc: _ends,
              registrationOpensAtUtc: _registrationOpens,
              registrationClosesAtUtc: _registrationCloses,
              capacity: capacity,
              registrationFee: fee,
              currency: _currency.text.trim(),
              organizerContact: _contact.text.trim(),
              bankName: _nullable(_bankName),
              bankAccountNumber: _nullable(_bankAccountNumber),
              bankAccountName: _nullable(_bankAccountName),
              transferInstructions: _nullable(_transferInstructions),
              powerliftingScoringFormula: 'Dots',
            ),
          );
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }

  String? _nullable(TextEditingController controller) =>
      controller.text.trim().isEmpty ? null : controller.text.trim();
}
