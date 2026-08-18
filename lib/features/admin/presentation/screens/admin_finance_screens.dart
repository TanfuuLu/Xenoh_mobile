import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/sync/data_revision.dart';
import '../../../../core/sync/data_topic.dart';
import '../../../../core/widgets/async_value_view.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

final adminPaymentSummaryProvider = FutureProvider.autoDispose<JsonMap>((ref) {
  ref.syncOn(const [DataTopic.admin, DataTopic.subscription]);
  return ref.watch(xenohApiProvider).getObject('/admin/payments/summary');
});

final adminPaymentsProvider = FutureProvider.autoDispose<List<JsonMap>>((ref) {
  ref.syncOn(const [DataTopic.admin, DataTopic.subscription]);
  return ref.watch(xenohApiProvider).getList('/admin/payments');
});

final adminSubscriptionsProvider = FutureProvider.autoDispose<List<JsonMap>>((
  ref,
) {
  ref.syncOn(const [DataTopic.admin, DataTopic.subscription]);
  return ref.watch(xenohApiProvider).getList('/admin/subscriptions');
});

final adminPromotionCodesProvider = FutureProvider.autoDispose<List<JsonMap>>((
  ref,
) {
  ref.syncOn(const [DataTopic.admin]);
  return ref.watch(xenohApiProvider).getList('/admin/promotion-codes');
});

class AdminPaymentsScreen extends ConsumerWidget {
  const AdminPaymentsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final summary = ref.watch(adminPaymentSummaryProvider);
    final payments = ref.watch(adminPaymentsProvider);
    final subscriptions = ref.watch(adminSubscriptionsProvider);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.adminPaymentsTitle)),
      body: RefreshIndicator(
        onRefresh: () async {
          ref
            ..invalidate(adminPaymentSummaryProvider)
            ..invalidate(adminPaymentsProvider)
            ..invalidate(adminSubscriptionsProvider);
          await ref.read(adminPaymentSummaryProvider.future);
        },
        child: ListView(
          padding: const EdgeInsets.all(AppSpacing.lg),
          children: [
            FeatureHeader(
              title: l10n.adminPaymentsTitle,
              subtitle: l10n.adminPaymentsSubtitle,
              icon: Icons.account_balance_wallet_outlined,
            ),
            const SizedBox(height: AppSpacing.lg),
            switch (summary) {
              AsyncData(:final value) => KeyValueGrid(
                items: {
                  l10n.adminTotalRevenueLabel: _money(value['totalRevenue']),
                  l10n.adminRevenueMonthLabel: _money(
                    value['revenueThisMonth'],
                  ),
                  l10n.adminPendingAmountLabel: _money(value['pendingAmount']),
                  l10n.adminCompletedOrdersLabel: textOf(value, [
                    'completedOrders',
                  ]),
                  l10n.adminPaidSubsLabel: textOf(value, [
                    'activePaidSubscriptions',
                  ]),
                },
              ),
              AsyncError(:final error) => FeatureError(
                error: error,
                onRetry: () => ref.invalidate(adminPaymentSummaryProvider),
              ),
              _ => const LoadingList(),
            },
            const SizedBox(height: AppSpacing.xxl),
            Text(
              l10n.adminPaymentOrdersTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            switch (payments) {
              AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
                title: l10n.adminNoPaymentsTitle,
                message: l10n.adminNoPaymentsMessage,
              ),
              AsyncData(:final value) => Column(
                children: [
                  for (final payment in value) ...[
                    DataCard(
                      title: textOf(payment, ['userName', 'userEmail']),
                      subtitle: optionalTextOf(payment, [
                        'userEmail',
                        'transferCode',
                      ]),
                      meta: [
                        textOf(payment, ['requestedTier']),
                        _money(payment['amount']),
                        textOf(payment, ['status']),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
              AsyncError(:final error) => FeatureError(
                error: error,
                onRetry: () => ref.invalidate(adminPaymentsProvider),
              ),
              _ => const LoadingList(),
            },
            const SizedBox(height: AppSpacing.xxl),
            Text(
              l10n.adminSubscriptionsTitle,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: AppSpacing.md),
            switch (subscriptions) {
              AsyncData(:final value) when value.isEmpty => EmptyFeatureState(
                title: l10n.adminNoSubscriptionsTitle,
                message: l10n.adminNoSubscriptionsMessage,
              ),
              AsyncData(:final value) => Column(
                children: [
                  for (final subscription in value) ...[
                    XnCard(
                      child: Row(
                        children: [
                          const CircleAvatar(
                            backgroundColor: AppColors.sage100,
                            child: Icon(Icons.workspace_premium_outlined),
                          ),
                          const SizedBox(width: AppSpacing.md),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  textOf(subscription, [
                                    'userName',
                                    'userEmail',
                                  ]),
                                  style: Theme.of(
                                    context,
                                  ).textTheme.titleMedium,
                                ),
                                Text(
                                  '${textOf(subscription, ['tier'])} · ${subscription['isActive'] == true ? l10n.commonActive : l10n.commonInactive}',
                                ),
                              ],
                            ),
                          ),
                          IconButton(
                            tooltip: l10n.adminAdjustSubscription,
                            onPressed: () => _adjustSubscription(
                              context,
                              ref,
                              subscription,
                            ),
                            icon: const Icon(Icons.manage_accounts_outlined),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: AppSpacing.md),
                  ],
                ],
              ),
              AsyncError(:final error) => FeatureError(
                error: error,
                onRetry: () => ref.invalidate(adminSubscriptionsProvider),
              ),
              _ => const LoadingList(),
            },
          ],
        ),
      ),
    );
  }

  Future<void> _adjustSubscription(
    BuildContext context,
    WidgetRef ref,
    JsonMap subscription,
  ) async {
    final l10n = AppLocalizations.of(context);
    final reason = TextEditingController();
    final months = TextEditingController(text: '1');
    var tier = textOf(subscription, ['tier']);
    final saved = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => StatefulBuilder(
        builder: (context, setDialogState) => AlertDialog(
          title: Text(l10n.adminAdjustSubscription),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              DropdownButtonFormField<String>(
                initialValue: tier,
                items: const [
                  DropdownMenuItem(value: 'Free', child: Text('Free')),
                  DropdownMenuItem(
                    value: 'ProIndividual',
                    child: Text('ProIndividual'),
                  ),
                  DropdownMenuItem(
                    value: 'ProCoach',
                    child: Text('ProCoach'),
                  ),
                  DropdownMenuItem(
                    value: 'Organizer',
                    child: Text('Organizer'),
                  ),
                ],
                onChanged: (value) =>
                    setDialogState(() => tier = value ?? tier),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: months,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(
                  labelText: l10n.adminDurationMonths,
                ),
              ),
              const SizedBox(height: AppSpacing.md),
              TextField(
                controller: reason,
                maxLines: 3,
                decoration: InputDecoration(labelText: l10n.adminAuditReason),
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
              child: Text(l10n.commonSave),
            ),
          ],
        ),
      ),
    );
    if (saved == true) {
      await ref.read(xenohApiProvider).patchObject(
        '/admin/users/${subscription['userId']}/subscription',
        {
          'tier': tier,
          'durationMonths': tier == 'Free' ? null : int.tryParse(months.text),
          'reason': reason.text.trim(),
        },
      );
    }
    reason.dispose();
    months.dispose();
  }
}

class AdminPromotionsScreen extends ConsumerWidget {
  const AdminPromotionsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final promotions = ref.watch(adminPromotionCodesProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.adminPromotionsTitle),
        actions: [
          IconButton(
            tooltip: l10n.adminNewPromotion,
            onPressed: () => _editPromotion(context, ref),
            icon: const Icon(Icons.add_circle_outline_rounded),
          ),
        ],
      ),
      body: AsyncValueView(
        value: promotions,
        onRetry: () => ref.invalidate(adminPromotionCodesProvider),
        data: (items) => RefreshIndicator(
          onRefresh: () => ref.refresh(adminPromotionCodesProvider.future),
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              FeatureHeader(
                title: l10n.adminPromotionsTitle,
                subtitle: l10n.adminPromotionsSubtitle,
                icon: Icons.percent_rounded,
              ),
              const SizedBox(height: AppSpacing.lg),
              if (items.isEmpty)
                EmptyFeatureState(
                  title: l10n.adminNoPromotionsTitle,
                  message: l10n.adminNoPromotionsMessage,
                ),
              for (final promotion in items) ...[
                XnCard(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              textOf(promotion, ['code']),
                              style: Theme.of(context).textTheme.titleLarge,
                            ),
                          ),
                          Switch.adaptive(
                            value: promotion['isActive'] == true,
                            onChanged: (active) => _setActive(
                              ref,
                              promotion,
                              active,
                            ),
                          ),
                        ],
                      ),
                      Text(optionalTextOf(promotion, ['description']) ?? ''),
                      const SizedBox(height: AppSpacing.md),
                      Wrap(
                        spacing: AppSpacing.sm,
                        children: [
                          Chip(
                            label: Text(
                              '${textOf(promotion, ['discountType'])} ${textOf(promotion, ['discountValue'])}',
                            ),
                          ),
                          Chip(
                            label: Text(
                              textOf(promotion, ['appliesToTier']),
                            ),
                          ),
                          Chip(
                            label: Text(
                              '${textOf(promotion, ['completedRedemptions'])}/${textOf(promotion, ['maxRedemptions'])}',
                            ),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          IconButton(
                            tooltip: l10n.commonEdit,
                            onPressed: () => _editPromotion(
                              context,
                              ref,
                              promotion: promotion,
                            ),
                            icon: const Icon(Icons.edit_outlined),
                          ),
                          IconButton(
                            tooltip: l10n.commonDelete,
                            onPressed: () => _deletePromotion(
                              context,
                              ref,
                              promotion,
                            ),
                            icon: const Icon(Icons.delete_outline_rounded),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _editPromotion(context, ref),
        icon: const Icon(Icons.add_rounded),
        label: Text(l10n.adminNewPromotion),
      ),
    );
  }

  Future<void> _setActive(
    WidgetRef ref,
    JsonMap promotion,
    bool active,
  ) async {
    await ref.read(xenohApiProvider).putObject(
      '/admin/promotion-codes/${promotion['id']}',
      {..._promotionPayload(promotion), 'isActive': active},
    );
  }

  Future<void> _deletePromotion(
    BuildContext context,
    WidgetRef ref,
    JsonMap promotion,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(
          '${AppLocalizations.of(context).commonDelete} ${promotion['code']}?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(dialogContext, false),
            child: Text(AppLocalizations.of(context).commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(dialogContext, true),
            child: Text(AppLocalizations.of(context).commonDelete),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      await ref
          .read(xenohApiProvider)
          .delete('/admin/promotion-codes/${promotion['id']}');
    }
  }

  Future<void> _editPromotion(
    BuildContext context,
    WidgetRef ref, {
    JsonMap? promotion,
  }) async {
    await showDialog<bool>(
      context: context,
      builder: (_) => _PromotionDialog(promotion: promotion),
    );
  }
}

class _PromotionDialog extends ConsumerStatefulWidget {
  const _PromotionDialog({this.promotion});
  final JsonMap? promotion;

  @override
  ConsumerState<_PromotionDialog> createState() => _PromotionDialogState();
}

class _PromotionDialogState extends ConsumerState<_PromotionDialog> {
  late final TextEditingController _code;
  late final TextEditingController _description;
  late final TextEditingController _value;
  late final TextEditingController _maxRedemptions;
  String _type = 'Percent';
  String? _tier;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    final item = widget.promotion;
    _code = TextEditingController(text: item?['code']?.toString());
    _description = TextEditingController(
      text: item?['description']?.toString(),
    );
    _value = TextEditingController(text: item?['discountValue']?.toString());
    _maxRedemptions = TextEditingController(
      text: item?['maxRedemptions']?.toString(),
    );
    _type = item?['discountType']?.toString() ?? 'Percent';
    _tier = item?['appliesToTier']?.toString();
  }

  @override
  void dispose() {
    _code.dispose();
    _description.dispose();
    _value.dispose();
    _maxRedemptions.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return AlertDialog(
      title: Text(
        widget.promotion == null
            ? l10n.adminNewPromotion
            : l10n.adminEditPromotion,
      ),
      content: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _code,
              decoration: InputDecoration(labelText: l10n.adminPromotionCode),
            ),
            TextField(
              controller: _description,
              decoration: InputDecoration(labelText: l10n.commonDescription),
            ),
            DropdownButtonFormField<String>(
              initialValue: _type,
              items: const [
                DropdownMenuItem(value: 'Percent', child: Text('Percent')),
                DropdownMenuItem(value: 'Fixed', child: Text('Fixed')),
              ],
              onChanged: (value) => setState(() => _type = value ?? _type),
            ),
            TextField(
              controller: _value,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              decoration: InputDecoration(
                labelText: l10n.adminDiscountValue,
              ),
            ),
            DropdownButtonFormField<String?>(
              initialValue: _tier,
              decoration: InputDecoration(labelText: l10n.adminAppliesToTier),
              items: const [
                DropdownMenuItem(value: null, child: Text('Any paid')),
                DropdownMenuItem(
                  value: 'ProIndividual',
                  child: Text('ProIndividual'),
                ),
                DropdownMenuItem(value: 'ProCoach', child: Text('ProCoach')),
                DropdownMenuItem(value: 'Organizer', child: Text('Organizer')),
              ],
              onChanged: (value) => setState(() => _tier = value),
            ),
            TextField(
              controller: _maxRedemptions,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: l10n.adminMaxRedemptions,
              ),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: _saving ? null : () => Navigator.pop(context, false),
          child: Text(l10n.commonCancel),
        ),
        FilledButton(
          onPressed: _saving ? null : _save,
          child: Text(l10n.commonSave),
        ),
      ],
    );
  }

  Future<void> _save() async {
    if (_code.text.trim().isEmpty || double.tryParse(_value.text) == null) {
      return;
    }
    setState(() => _saving = true);
    final payload = <String, dynamic>{
      'code': _code.text.trim().toUpperCase(),
      'description': _description.text.trim(),
      'discountType': _type,
      'discountValue': double.parse(_value.text),
      'appliesToTier': _tier,
      'maxRedemptions': int.tryParse(_maxRedemptions.text),
      'maxRedemptionsPerUser': 1,
      'startsAt': widget.promotion?['startsAt'],
      'expiresAt': widget.promotion?['expiresAt'],
      'isActive': widget.promotion?['isActive'] ?? true,
    };
    final api = ref.read(xenohApiProvider);
    try {
      if (widget.promotion == null) {
        await api.postObject('/admin/promotion-codes', payload);
      } else {
        await api.putObject(
          '/admin/promotion-codes/${widget.promotion!['id']}',
          payload,
        );
      }
      if (mounted) Navigator.pop(context, true);
    } finally {
      if (mounted) setState(() => _saving = false);
    }
  }
}

JsonMap _promotionPayload(JsonMap item) => {
  'code': item['code'],
  'description': item['description'],
  'discountType': item['discountType'],
  'discountValue': item['discountValue'],
  'appliesToTier': item['appliesToTier'],
  'maxRedemptions': item['maxRedemptions'],
  'maxRedemptionsPerUser': item['maxRedemptionsPerUser'],
  'startsAt': item['startsAt'],
  'expiresAt': item['expiresAt'],
  'isActive': item['isActive'],
};

String _money(Object? value) {
  final amount = value is num ? value : num.tryParse(value?.toString() ?? '');
  return amount == null ? '—' : '${amount.toStringAsFixed(0)} VND';
}
