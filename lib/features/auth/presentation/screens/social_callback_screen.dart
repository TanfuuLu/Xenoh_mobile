import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../l10n/app_localizations.dart';
import '../providers/auth_controller.dart';

class SocialCallbackScreen extends ConsumerStatefulWidget {
  const SocialCallbackScreen({
    required this.ticket,
    required this.errorCode,
    super.key,
  });

  final String? ticket;
  final String? errorCode;

  @override
  ConsumerState<SocialCallbackScreen> createState() =>
      _SocialCallbackScreenState();
}

class _SocialCallbackScreenState extends ConsumerState<SocialCallbackScreen> {
  String? _error;
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    unawaited(_handleCallback());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.lg),
            child: _loading
                ? const CircularProgressIndicator(color: AppColors.accent)
                : Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(
                        Icons.error_outline_rounded,
                        color: AppColors.danger,
                        size: 40,
                      ),
                      const SizedBox(height: AppSpacing.md),
                      Text(
                        _error ??
                            AppLocalizations.of(
                              context,
                            ).authSocialSignInFailedError,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: AppColors.fg2),
                      ),
                      const SizedBox(height: AppSpacing.lg),
                      XnButton(
                        label: AppLocalizations.of(context).authBackToLoginCta,
                        onPressed: () => context.go('/login'),
                      ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  Future<void> _handleCallback() async {
    await Future<void>.delayed(Duration.zero);
    if (!mounted) return;

    if (widget.errorCode != null) {
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).authSocialSignInFailedError;
      });
      return;
    }

    final ticket = widget.ticket;
    if (ticket == null || ticket.trim().isEmpty) {
      setState(() {
        _loading = false;
        _error = AppLocalizations.of(context).authMissingSocialTicketError;
      });
      return;
    }
    final failure = await ref
        .read(authControllerProvider.notifier)
        .exchangeExternalTicket(ticket);
    if (!mounted) return;
    if (failure == null) {
      context.go('/dashboard');
      return;
    }
    setState(() {
      _loading = false;
      _error = AppLocalizations.of(context).authExpiredSocialTicketError;
    });
  }
}
