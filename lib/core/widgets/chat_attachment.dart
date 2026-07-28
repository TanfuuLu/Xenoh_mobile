import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../app/theme/app_colors.dart';
import '../../app/theme/app_dimens.dart';
import '../../features/shared_api/xenoh_api.dart';
import '../config/app_config.dart';
import '../utils/safe_external_url.dart';

/// Resolves a signed, directly-usable download URL for a chat attachment.
/// `inline` mirrors the backend's `?inline=` flag: true for rendering an
/// image in place, false for a "download/open" tap target.
final attachmentDownloadUrlProvider = FutureProvider.autoDispose
    .family<String, ({String attachmentId, bool inline})>((ref, key) async {
      final res = await ref
          .watch(xenohApiProvider)
          .getObject(
            '/messages/attachments/${key.attachmentId}/download-url'
            '?inline=${key.inline}',
          );
      return res['url']?.toString() ?? '';
    });

/// An inline image thumbnail for an image chat attachment. Tapping opens a
/// full-screen zoomable view.
class ChatImageAttachment extends ConsumerWidget {
  const ChatImageAttachment({required this.attachmentId, super.key});

  final String attachmentId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final url = ref.watch(
      attachmentDownloadUrlProvider((attachmentId: attachmentId, inline: true)),
    );
    return ClipRRect(
      borderRadius: BorderRadius.circular(AppRadius.md),
      child: switch (url) {
        AsyncData(:final value) => GestureDetector(
          onTap: () => _openFullScreen(context, value),
          child: Image.network(
            value,
            width: 200,
            height: 200,
            fit: BoxFit.cover,
            loadingBuilder: (_, child, progress) =>
                progress == null ? child : const _AttachmentBox(),
            errorBuilder: (_, _, _) =>
                const _AttachmentBox(icon: Icons.broken_image_outlined),
          ),
        ),
        AsyncError() => const _AttachmentBox(icon: Icons.broken_image_outlined),
        _ => const _AttachmentBox(),
      },
    );
  }

  void _openFullScreen(BuildContext context, String url) {
    unawaited(
      Navigator.of(context).push(
        MaterialPageRoute<void>(
          builder: (_) => Scaffold(
            backgroundColor: Colors.black,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              iconTheme: const IconThemeData(color: Colors.white),
            ),
            body: Center(
              child: InteractiveViewer(child: Image.network(url)),
            ),
          ),
        ),
      ),
    );
  }
}

class _AttachmentBox extends StatelessWidget {
  const _AttachmentBox({this.icon});

  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 200,
      height: 200,
      color: AppColors.bg3,
      alignment: Alignment.center,
      child: icon == null
          ? const SizedBox(
              width: 22,
              height: 22,
              child: CircularProgressIndicator(strokeWidth: 2),
            )
          : Icon(icon, color: AppColors.fg3),
    );
  }
}

/// A non-image attachment: file icon + name + size, tap to download/open.
class ChatFileAttachment extends ConsumerWidget {
  const ChatFileAttachment({
    required this.attachmentId,
    required this.fileName,
    required this.sizeBytes,
    required this.mine,
    super.key,
  });

  final String attachmentId;
  final String fileName;
  final int sizeBytes;
  final bool mine;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fg = mine ? AppColors.fgOnClay : AppColors.fg1;
    final sub = mine ? AppColors.clay200 : AppColors.fg3;
    return InkWell(
      borderRadius: BorderRadius.circular(AppRadius.sm),
      onTap: () => _open(ref),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: AppSpacing.xs),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(_iconFor(fileName), size: 28, color: fg),
            const SizedBox(width: AppSpacing.sm),
            Flexible(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    fileName,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(color: fg, fontSize: 13),
                  ),
                  Text(
                    _formatBytes(sizeBytes),
                    style: TextStyle(color: sub, fontSize: 11),
                  ),
                ],
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Icon(Icons.download_rounded, size: 18, color: fg),
          ],
        ),
      ),
    );
  }

  Future<void> _open(WidgetRef ref) async {
    final url = await ref.read(
      attachmentDownloadUrlProvider((
        attachmentId: attachmentId,
        inline: false,
      )).future,
    );
    final apiHost = Uri.tryParse(AppConfig.apiBaseUrl)?.host.toLowerCase();
    final assetsHost = Uri.tryParse(
      AppConfig.assetsBaseUrl,
    )?.host.toLowerCase();
    final uri = safeExternalUri(
      url,
      allowedHosts: {
        ?apiHost,
        ?assetsHost,
      },
    );
    if (uri == null) return;
    await launchUrl(uri, mode: LaunchMode.externalApplication);
  }

  static IconData _iconFor(String fileName) {
    final ext = fileName.split('.').last.toLowerCase();
    return switch (ext) {
      'pdf' => Icons.picture_as_pdf_outlined,
      'doc' || 'docx' => Icons.description_outlined,
      'xls' || 'xlsx' => Icons.table_chart_outlined,
      _ => Icons.insert_drive_file_outlined,
    };
  }

  static String _formatBytes(int bytes) {
    if (bytes < 1024) return '$bytes B';
    if (bytes < 1024 * 1024) return '${(bytes / 1024).toStringAsFixed(1)} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}
