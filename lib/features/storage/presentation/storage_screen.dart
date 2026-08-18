import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../app/theme/app_colors.dart';
import '../../../app/theme/app_dimens.dart';
import '../../../core/widgets/async_value_view.dart';
import '../../../core/widgets/xn_button.dart';
import '../../../core/widgets/xn_card.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/providers/auth_controller.dart';
import '../../auth/presentation/providers/auth_state.dart';
import '../../coach_client/presentation/screens/clients_screen.dart';
import '../../shared_api/xenoh_api.dart';
import '../domain/storage_models.dart';
import 'storage_providers.dart';

class StorageScreen extends ConsumerStatefulWidget {
  const StorageScreen({super.key});
  @override
  ConsumerState<StorageScreen> createState() => _StorageScreenState();
}

class _StorageScreenState extends ConsumerState<StorageScreen> {
  double? _uploadProgress;
  @override
  Widget build(BuildContext context) {
    final mine = ref.watch(myFilesProvider);
    final shared = ref.watch(sharedFilesProvider);
    final isCoach =
        ref.watch(authControllerProvider).sessionOrNull?.user.isCoach ?? false;
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(title: Text(l10n.storageTitle)),
      body: AsyncValueView(
        value: mine,
        onRetry: () => ref.invalidate(myFilesProvider),
        data: (data) => RefreshIndicator(
          color: AppColors.accent,
          onRefresh: () async {
            ref
              ..invalidate(myFilesProvider)
              ..invalidate(sharedFilesProvider);
          },
          child: ListView(
            padding: const EdgeInsets.all(AppSpacing.lg),
            children: [
              XnCard(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(child: Text(l10n.storageUsed)),
                        Text(
                          '${_bytes(data.usedBytes)} / ${_bytes(data.quotaBytes)}',
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.sm),
                    LinearProgressIndicator(
                      value: data.quotaBytes == 0
                          ? 0
                          : (data.usedBytes / data.quotaBytes).clamp(0, 1),
                    ),
                    const SizedBox(height: AppSpacing.md),
                    XnButton(
                      label: l10n.storageUpload,
                      loading: _uploadProgress != null,
                      icon: Icons.upload_file_outlined,
                      onPressed: () => _upload(data),
                    ),
                    if (_uploadProgress != null) ...[
                      const SizedBox(height: AppSpacing.sm),
                      LinearProgressIndicator(value: _uploadProgress),
                    ],
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      l10n.storageMaxFileSize(_bytes(data.maxFileSizeBytes)),
                      style: const TextStyle(
                        color: AppColors.fg3,
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppSpacing.lg),
              Text(
                l10n.storageMyFiles,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              if (data.files.isEmpty)
                XnCard(
                  child: Center(
                    child: Padding(
                      padding: const EdgeInsets.all(AppSpacing.xl),
                      child: Text(l10n.storageEmpty),
                    ),
                  ),
                )
              else
                for (final file in data.files) ...[
                  _OwnedFileCard(file: file, canShare: isCoach),
                  const SizedBox(height: AppSpacing.sm),
                ],
              if (shared.value?.isNotEmpty == true) ...[
                const SizedBox(height: AppSpacing.lg),
                Text(
                  l10n.storageSharedWithMe,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.sm),
                for (final file in shared.value!) ...[
                  _SharedFileCard(file: file),
                  const SizedBox(height: AppSpacing.sm),
                ],
              ],
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _upload(MyFiles files) async {
    final picked = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: const ['pdf', 'doc', 'docx'],
    );
    final item = picked?.files.single;
    if (item?.path == null) {
      return;
    }
    if (item!.size > files.maxFileSizeBytes ||
        item.size > files.quotaBytes - files.usedBytes) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(AppLocalizations.of(context).storageFileTooLarge),
          ),
        );
      }
      return;
    }
    setState(() => _uploadProgress = 0);
    try {
      await ref
          .read(storageRepositoryProvider)
          .upload(
            item.path!,
            onProgress: (sent, total) {
              if (mounted && total > 0) {
                setState(() => _uploadProgress = sent / total);
              }
            },
          );
    } catch (error) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
      }
    } finally {
      if (mounted) setState(() => _uploadProgress = null);
    }
  }
}

class _OwnedFileCard extends ConsumerWidget {
  const _OwnedFileCard({required this.file, required this.canShare});
  final StoredFile file;
  final bool canShare;
  @override
  Widget build(BuildContext context, WidgetRef ref) => XnCard(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const Icon(Icons.description_outlined),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: Text(
                file.fileName,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
            Text(
              _bytes(file.sizeBytes),
              style: const TextStyle(color: AppColors.fg3),
            ),
          ],
        ),
        if (file.sharedWith.isNotEmpty)
          Wrap(
            spacing: 4,
            children: [
              for (final share in file.sharedWith)
                InputChip(
                  label: Text(share.sharedWithName),
                  onDeleted: () => _unshare(context, ref, share.shareId),
                ),
            ],
          ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            IconButton(
              tooltip: AppLocalizations.of(context).storageDownload,
              onPressed: () => _download(context, ref, file.id),
              icon: const Icon(Icons.download_outlined),
            ),
            if (canShare)
              IconButton(
                tooltip: AppLocalizations.of(context).storageShare,
                onPressed: () => _share(context, ref),
                icon: const Icon(Icons.share_outlined),
              ),
            IconButton(
              tooltip: AppLocalizations.of(context).commonDelete,
              onPressed: () => _delete(context, ref),
              icon: const Icon(Icons.delete_outline),
            ),
          ],
        ),
      ],
    ),
  );
  Future<void> _delete(BuildContext context, WidgetRef ref) async {
    final ok = await _confirm(
      context,
      AppLocalizations.of(context).storageDeleteConfirm(file.fileName),
    );
    if (ok && context.mounted) {
      await _run(
        context,
        ref,
        () => ref.read(storageRepositoryProvider).delete(file.id),
      );
    }
  }

  Future<void> _unshare(BuildContext context, WidgetRef ref, String shareId) =>
      _run(
        context,
        ref,
        () => ref.read(storageRepositoryProvider).unshare(file.id, shareId),
      );
  Future<void> _share(BuildContext context, WidgetRef ref) async {
    final clients = await ref.read(coachClientsProvider.future);
    if (!context.mounted) {
      return;
    }
    final clientId = await showDialog<String>(
      context: context,
      builder: (dialogContext) => SimpleDialog(
        title: Text(AppLocalizations.of(context).storageShare),
        children: [
          for (final client in clients)
            SimpleDialogOption(
              onPressed: () => Navigator.pop(
                context,
                client['clientId']?.toString() ?? client['id']?.toString(),
              ),
              child: Text(
                client['clientName']?.toString() ??
                    client['fullName']?.toString() ??
                    client['name']?.toString() ??
                    'Client',
              ),
            ),
        ],
      ),
    );
    if (clientId != null && context.mounted) {
      await _run(
        context,
        ref,
        () => ref.read(storageRepositoryProvider).share(file.id, clientId),
      );
    }
  }

  Future<void> _run(
    BuildContext context,
    WidgetRef ref,
    Future<void> Function() action,
  ) async {
    try {
      await action();
    } catch (error) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(apiErrorMessage(error, context))),
        );
      }
    }
  }
}

class _SharedFileCard extends ConsumerWidget {
  const _SharedFileCard({required this.file});
  final SharedFile file;
  @override
  Widget build(BuildContext context, WidgetRef ref) => XnCard(
    child: ListTile(
      contentPadding: EdgeInsets.zero,
      leading: const Icon(Icons.description_outlined),
      title: Text(file.fileName),
      subtitle: Text('${_bytes(file.sizeBytes)} · ${file.ownerName}'),
      trailing: IconButton(
        onPressed: () => _download(context, ref, file.id),
        icon: const Icon(Icons.download_outlined),
      ),
    ),
  );
}

Future<void> _download(BuildContext context, WidgetRef ref, String id) async {
  try {
    final url = await ref.read(storageRepositoryProvider).downloadUrl(id);
    final opened = await launchUrl(
      Uri.parse(url),
      mode: LaunchMode.externalApplication,
    );
    if (!opened) throw StateError('Could not open file.');
  } catch (error) {
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(apiErrorMessage(error, context))));
    }
  }
}

Future<bool> _confirm(BuildContext context, String message) async =>
    await showDialog<bool>(
      context: context,
      builder: (dialogContext) => AlertDialog(
        title: Text(message),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context).commonCancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context).commonDelete),
          ),
        ],
      ),
    ) ??
    false;
String _bytes(int bytes) {
  if (bytes >= 1024 * 1024) {
    return '${(bytes / 1024 / 1024).toStringAsFixed(1)} MB';
  }
  if (bytes >= 1024) {
    return '${(bytes / 1024).toStringAsFixed(1)} KB';
  }
  return '$bytes B';
}
