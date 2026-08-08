import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_card.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';
import '../../data/repositories/subscription_repository_provider.dart';
import '../../domain/entities/billing.dart';
import '../providers/subscription_controllers.dart';
import '../providers/tier_labels.dart';

class SubscriptionCheckoutSection extends ConsumerStatefulWidget {
  const SubscriptionCheckoutSection({super.key});

  static const termsCheckboxKey = ValueKey('subscription-terms-checkbox');
  static const promotionInputKey = ValueKey('subscription-promotion-input');
  static const applyPromotionKey = ValueKey('subscription-apply-promotion');

  @override
  ConsumerState<SubscriptionCheckoutSection> createState() =>
      _SubscriptionCheckoutSectionState();
}

class _SubscriptionCheckoutSectionState
    extends ConsumerState<SubscriptionCheckoutSection> {
  final _promotionController = TextEditingController();
  SubscriptionOffer? _selectedOffer;
  PromotionValidation? _promotion;
  String? _promotionError;
  var _acceptedTerms = false;
  var _checkingPromotion = false;
  var _creatingOrder = false;

  @override
  void dispose() {
    _promotionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final catalog = ref.watch(subscriptionCatalogProvider);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          l10n.subscriptionChoosePlanTitle,
          style: Theme.of(context).textTheme.titleLarge,
        ),
        const SizedBox(height: AppSpacing.xs),
        Text(
          l10n.subscriptionChoosePlanSubtitle,
          style: const TextStyle(color: AppColors.fg3, height: 1.4),
        ),
        const SizedBox(height: AppSpacing.md),
        switch (catalog) {
          AsyncData(:final value) => _catalogBody(value, l10n),
          AsyncError(:final error) => FeatureError(
            error: error,
            onRetry: () => ref.invalidate(subscriptionCatalogProvider),
          ),
          _ => const LoadingList(),
        },
      ],
    );
  }

  Widget _catalogBody(
    SubscriptionCatalog catalog,
    AppLocalizations l10n,
  ) {
    if (catalog.offers.isEmpty) {
      return XnCard(child: Text(l10n.subscriptionCatalogEmpty));
    }
    final selected = _selectedOffer ?? catalog.offers.first;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        for (final offer in catalog.offers) ...[
          _OfferCard(
            offer: offer,
            selected: offer == selected,
            onTap: () => setState(() {
              _selectedOffer = offer;
              _promotion = null;
              _promotionError = null;
            }),
          ),
          if (offer != catalog.offers.last)
            const SizedBox(height: AppSpacing.sm),
        ],
        const SizedBox(height: AppSpacing.md),
        _promotionField(selected, l10n),
        if (_promotion case final promotion?) ...[
          const SizedBox(height: AppSpacing.sm),
          XnCard(
            color: AppColors.successBg,
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Text(
              l10n.subscriptionPromotionApplied(
                promotion.code ?? '',
                _formatMoney(context, promotion.finalAmount ?? selected.price),
              ),
              style: const TextStyle(
                color: AppColors.success,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
        if (_promotionError case final error?) ...[
          const SizedBox(height: AppSpacing.xs),
          Text(
            error,
            style: const TextStyle(color: AppColors.danger, fontSize: 12),
          ),
        ],
        const SizedBox(height: AppSpacing.md),
        CheckboxListTile(
          key: SubscriptionCheckoutSection.termsCheckboxKey,
          value: _acceptedTerms,
          contentPadding: EdgeInsets.zero,
          controlAffinity: ListTileControlAffinity.leading,
          title: Text(l10n.subscriptionAcceptTerms),
          onChanged: _creatingOrder
              ? null
              : (value) => setState(() => _acceptedTerms = value ?? false),
        ),
        Wrap(
          spacing: AppSpacing.sm,
          children: [
            TextButton(
              onPressed: () => context.push('/terms'),
              child: Text(l10n.subscriptionViewTerms),
            ),
            TextButton(
              onPressed: () => context.push('/refund-policy'),
              child: Text(l10n.subscriptionViewRefundPolicy),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.sm),
        FilledButton.icon(
          key: ValueKey(
            'subscription-order-${selected.tier}-${selected.durationMonths}',
          ),
          onPressed: !_acceptedTerms || _creatingOrder
              ? null
              : () => unawaited(_createOrder(catalog, selected)),
          icon: _creatingOrder
              ? const SizedBox.square(
                  dimension: 18,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : const Icon(Icons.account_balance_outlined, size: 18),
          label: Text(l10n.subscriptionCreateOrder),
        ),
      ],
    );
  }

  Widget _promotionField(
    SubscriptionOffer selected,
    AppLocalizations l10n,
  ) {
    final input = XnInput(
      key: SubscriptionCheckoutSection.promotionInputKey,
      label: l10n.subscriptionPromotionLabel,
      hint: l10n.subscriptionPromotionHint,
      controller: _promotionController,
      enabled: !_checkingPromotion && !_creatingOrder,
      textInputAction: TextInputAction.done,
      onChanged: (_) => setState(() {
        _promotion = null;
        _promotionError = null;
      }),
    );
    final apply = XnButton(
      key: SubscriptionCheckoutSection.applyPromotionKey,
      label: l10n.subscriptionApplyPromotion,
      variant: XnButtonVariant.secondary,
      loading: _checkingPromotion,
      onPressed: _promotionController.text.trim().isEmpty
          ? null
          : () => unawaited(_validatePromotion(selected)),
    );
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth < 380) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              input,
              const SizedBox(height: AppSpacing.sm),
              apply,
            ],
          );
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Expanded(child: input),
            const SizedBox(width: AppSpacing.sm),
            apply,
          ],
        );
      },
    );
  }

  Future<void> _validatePromotion(SubscriptionOffer selected) async {
    final code = _promotionController.text.trim().toUpperCase();
    if (code.isEmpty) return;
    setState(() {
      _checkingPromotion = true;
      _promotionError = null;
    });
    try {
      final result = await ref
          .read(subscriptionRepositoryProvider)
          .validatePromotion(
            code: code,
            requestedTier: selected.tier,
            durationMonths: selected.durationMonths,
          );
      if (!mounted) return;
      setState(() {
        _promotion = result.valid ? result : null;
        _promotionError = result.valid
            ? null
            : result.message ??
                  AppLocalizations.of(context).subscriptionPromotionInvalid;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _promotionError = apiErrorMessage(error, context));
    } finally {
      if (mounted) setState(() => _checkingPromotion = false);
    }
  }

  Future<void> _createOrder(
    SubscriptionCatalog catalog,
    SubscriptionOffer selected,
  ) async {
    setState(() => _creatingOrder = true);
    try {
      final order = await ref
          .read(subscriptionRepositoryProvider)
          .createPaymentOrder(
            CreatePaymentOrderInput(
              requestedTier: selected.tier,
              durationMonths: selected.durationMonths,
              termsVersion: catalog.termsVersion,
              promotionCode: _promotion?.code,
            ),
          );
      if (!mounted) return;
      await showModalBottomSheet<void>(
        context: context,
        isScrollControlled: true,
        useSafeArea: true,
        builder: (_) => _PaymentOrderSheet(order: order),
      );
      ref.invalidate(subscriptionProvider);
    } catch (error) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(error, context))),
      );
    } finally {
      if (mounted) setState(() => _creatingOrder = false);
    }
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.offer,
    required this.selected,
    required this.onTap,
  });

  final SubscriptionOffer offer;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return XnCard(
      onTap: onTap,
      color: selected ? AppColors.accentSoft : AppColors.bg2,
      border: Border.all(
        color: selected ? AppColors.accent : AppColors.border1,
      ),
      child: Row(
        children: [
          Icon(
            selected
                ? Icons.radio_button_checked_rounded
                : Icons.radio_button_unchecked_rounded,
            color: selected ? AppColors.accent : AppColors.fg3,
          ),
          const SizedBox(width: AppSpacing.sm),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  tierLabel(offer.tier, l10n),
                  style: const TextStyle(fontWeight: FontWeight.w700),
                ),
                const SizedBox(height: AppSpacing.xs),
                Text(l10n.subscriptionMonthsLabel(offer.durationMonths)),
                if (offer.hasUnlimitedClients)
                  Text(
                    l10n.subscriptionUnlimitedClients,
                    style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                  ),
              ],
            ),
          ),
          Text(
            _formatMoney(context, offer.price),
            style: const TextStyle(fontWeight: FontWeight.w700),
          ),
        ],
      ),
    );
  }
}

class _PaymentOrderSheet extends StatelessWidget {
  const _PaymentOrderSheet({required this.order});

  final PaymentOrder order;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return SingleChildScrollView(
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.lg,
        AppSpacing.lg,
        MediaQuery.viewInsetsOf(context).bottom + AppSpacing.xl,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(
            l10n.subscriptionPaymentTitle,
            style: Theme.of(context).textTheme.headlineSmall,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            l10n.subscriptionPaymentInstruction,
            style: const TextStyle(color: AppColors.fg3),
          ),
          const SizedBox(height: AppSpacing.lg),
          _CopyField(
            label: l10n.subscriptionPaymentBank,
            value: order.bankName,
          ),
          _CopyField(
            label: l10n.subscriptionPaymentAccountNumber,
            value: order.bankAccountNumber,
          ),
          _CopyField(
            label: l10n.subscriptionPaymentAccountName,
            value: order.bankAccountName,
          ),
          _CopyField(
            label: l10n.subscriptionPaymentAmount,
            value: _formatMoney(context, order.amount),
          ),
          _CopyField(
            label: l10n.subscriptionPaymentContent,
            value: order.transferCode,
            highlight: true,
          ),
          _CopyField(
            label: l10n.subscriptionPaymentExpires,
            value: DateFormat.yMd(
              Localizations.localeOf(context).toLanguageTag(),
            ).add_Hm().format(order.expiresAt),
          ),
          const SizedBox(height: AppSpacing.md),
          XnButton(
            label: l10n.subscriptionPaymentClose,
            onPressed: () => Navigator.of(context).pop(),
          ),
        ],
      ),
    );
  }
}

class _CopyField extends StatelessWidget {
  const _CopyField({
    required this.label,
    required this.value,
    this.highlight = false,
  });

  final String label;
  final String value;
  final bool highlight;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Padding(
      padding: const EdgeInsets.only(bottom: AppSpacing.sm),
      child: XnCard(
        color: highlight ? AppColors.accentSoft : AppColors.bg2,
        padding: const EdgeInsets.all(AppSpacing.md),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    label,
                    style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                  ),
                  const SizedBox(height: AppSpacing.xs),
                  SelectableText(
                    value,
                    style: TextStyle(
                      fontWeight: highlight ? FontWeight.w700 : FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            IconButton(
              tooltip: l10n.subscriptionPaymentCopy,
              onPressed: () async {
                await Clipboard.setData(ClipboardData(text: value));
                if (!context.mounted) return;
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l10n.subscriptionPaymentCopied)),
                );
              },
              icon: const Icon(Icons.copy_rounded),
            ),
          ],
        ),
      ),
    );
  }
}

String _formatMoney(BuildContext context, num amount) {
  final locale = Localizations.localeOf(context).languageCode == 'vi'
      ? 'vi_VN'
      : 'en_US';
  return NumberFormat.currency(
    locale: locale,
    name: 'VND',
    symbol: '₫',
    decimalDigits: 0,
  ).format(amount);
}
