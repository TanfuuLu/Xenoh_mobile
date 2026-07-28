import 'package:flutter/material.dart';

import '../../app/theme/app_dimens.dart';

/// Standard scrollable page body used by feature screens.
class XnPageList extends StatelessWidget {
  const XnPageList({
    required this.children,
    this.onRefresh,
    super.key,
  });

  final List<Widget> children;
  final Future<void> Function()? onRefresh;

  @override
  Widget build(BuildContext context) {
    final bottomInset = MediaQuery.viewPaddingOf(context).bottom;
    final list = ListView(
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      padding: EdgeInsets.fromLTRB(
        AppSpacing.lg,
        AppSpacing.md,
        AppSpacing.lg,
        AppSpacing.xxl + bottomInset,
      ),
      children: children,
    );
    final content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: AppLayout.contentMaxWidth,
        ),
        child: list,
      ),
    );
    return onRefresh == null
        ? content
        : RefreshIndicator(
            onRefresh: onRefresh!,
            child: content,
          );
  }
}
