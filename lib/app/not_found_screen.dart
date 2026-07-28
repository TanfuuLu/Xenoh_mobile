import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../core/widgets/xn_button.dart';
import '../l10n/app_localizations.dart';
import 'theme/app_dimens.dart';

class NotFoundScreen extends StatelessWidget {
  const NotFoundScreen({required this.isAuthenticated, super.key});

  final bool isAuthenticated;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    final destination = isAuthenticated ? '/dashboard' : '/';
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          tooltip: l10n.notFoundHomeAction,
          onPressed: () => context.go(destination),
          icon: const Icon(Icons.home_outlined),
        ),
      ),
      body: SafeArea(
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 480),
            child: Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.explore_off_outlined, size: 64),
                  const SizedBox(height: AppSpacing.lg),
                  Text(
                    l10n.notFoundTitle,
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.sm),
                  Text(
                    l10n.notFoundMessage,
                    style: Theme.of(context).textTheme.bodyLarge,
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(height: AppSpacing.xl),
                  XnButton(
                    label: l10n.notFoundHomeAction,
                    icon: Icons.home_outlined,
                    onPressed: () => context.go(destination),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
