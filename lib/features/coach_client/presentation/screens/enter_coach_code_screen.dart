import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/xn_button.dart';
import '../../../../core/widgets/xn_input.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

class EnterCoachCodeScreen extends ConsumerStatefulWidget {
  const EnterCoachCodeScreen({super.key});

  @override
  ConsumerState<EnterCoachCodeScreen> createState() =>
      _EnterCoachCodeScreenState();
}

class _EnterCoachCodeScreenState extends ConsumerState<EnterCoachCodeScreen> {
  final _code = TextEditingController();
  bool _loading = false;

  @override
  void dispose() {
    _code.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return FeatureScreenFrame(
      title: l10n.coachEnterCodeTitle,
      children: [
        FeatureHeader(
          title: l10n.coachEnterCodeHeaderTitle,
          subtitle: l10n.coachEnterCodeHeaderSubtitle,
          icon: Icons.vpn_key_outlined,
        ),
        const SizedBox(height: AppSpacing.lg),
        XnInput(controller: _code, label: l10n.coachInviteCodeLabel),
        const SizedBox(height: AppSpacing.md),
        XnButton(
          label: l10n.coachConnectButton,
          icon: Icons.link_rounded,
          loading: _loading,
          onPressed: _connect,
        ),
      ],
    );
  }

  Future<void> _connect() async {
    setState(() => _loading = true);
    try {
      await ref.read(xenohApiProvider).postVoid(
        '/coach-client/connect-by-code',
        {'code': _code.text.trim()},
      );
      if (!mounted) return;
      final l10n = AppLocalizations.of(context);
      // A redeemed invite code creates an Active relationship server-side —
      // there is no acceptance step for the coach — so this confirms the
      // connection instead of announcing a pending request, and returns to
      // the screen the user came from. The coaching data topic refreshes
      // itself off the write.
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(l10n.coachConnectedSnackbar)),
      );
      if (context.canPop()) context.pop();
    } catch (e) {
      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(apiErrorMessage(e, context))),
      );
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}
