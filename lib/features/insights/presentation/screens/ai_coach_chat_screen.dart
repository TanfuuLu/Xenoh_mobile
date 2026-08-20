import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../app/theme/app_colors.dart';
import '../../../../app/theme/app_dimens.dart';
import '../../../../core/widgets/chat_bubble.dart';
import '../../../../core/widgets/chat_composer.dart';
import '../../../../l10n/app_localizations.dart';
import '../../../blocks_reports/presentation/widgets/moderation_dialogs.dart';
import '../../../profile/presentation/providers/preferences_provider.dart';
import '../../../shared_api/ai_widgets.dart';
import '../../../shared_api/api_widgets.dart';
import '../../../shared_api/xenoh_api.dart';

/// Chats via `/insights/me/coach-chat/conversations` — a real conversation
/// resource (list/create/messages), not the flat stateless endpoint this
/// screen used to call (that route no longer exists on the backend; every
/// coach-chat route also requires an active Pro subscription, unlike the
/// other `/insights/me` routes).
class AiCoachChatScreen extends ConsumerStatefulWidget {
  const AiCoachChatScreen({super.key});

  @override
  ConsumerState<AiCoachChatScreen> createState() => _AiCoachChatScreenState();
}

class _AiCoachChatScreenState extends ConsumerState<AiCoachChatScreen> {
  final _prompt = TextEditingController();
  final _messages = <({String role, String content})>[];
  final _conversations = <JsonMap>[];
  String? _conversationId;
  bool _initializing = true;
  Object? _initError;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    unawaited(_init());
  }

  @override
  void dispose() {
    _prompt.dispose();
    super.dispose();
  }

  Future<void> _init() async {
    setState(() {
      _initializing = true;
      _initError = null;
    });
    try {
      final api = ref.read(xenohApiProvider);
      final page = await api.getObject(
        '/insights/me/coach-chat/conversations?take=20',
      );
      final items = page['items'];
      final conversations = items is List
          ? items
                .whereType<JsonMap>()
                .where((item) => item['isArchived'] != true)
                .toList()
          : <JsonMap>[];
      var conversation = conversations.isEmpty ? null : conversations.first;
      conversation ??= await api.postObject(
        '/insights/me/coach-chat/conversations',
        const {},
      );
      if (conversations.isEmpty) conversations.add(conversation);
      final id = textOf(conversation, ['id'], fallback: '');
      if (id.isEmpty) throw const FormatException('Missing conversation id');
      final history = await api.getObject(
        '/insights/me/coach-chat/conversations/$id/messages?take=30',
      );
      final historyItems = history['items'];
      final messages =
          (historyItems is List
                ? historyItems.whereType<JsonMap>().toList()
                : <JsonMap>[])
            ..sort(
              (a, b) => _createdAt(
                a['createdAt'],
              ).compareTo(_createdAt(b['createdAt'])),
            );
      if (!mounted) return;
      setState(() {
        _conversations
          ..clear()
          ..addAll(conversations);
        _conversationId = id;
        _messages
          ..clear()
          ..addAll([
            for (final m in messages)
              (
                role: textOf(m, ['role'], fallback: 'assistant'),
                content: textOf(m, ['content']),
              ),
          ]);
        _initializing = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        _initError = e;
        _initializing = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.aiCoachChatTitle),
        actions: [
          if (!_initializing && _conversations.isNotEmpty)
            IconButton(
              tooltip: l10n.aiCoachChatConversationsTooltip,
              icon: const Icon(Icons.history_rounded),
              onPressed: () => unawaited(_showConversations()),
            ),
          if (!_initializing)
            IconButton(
              tooltip: l10n.aiCoachChatNewConversationTooltip,
              icon: const Icon(Icons.add_comment_outlined),
              onPressed: () => unawaited(_createConversation()),
            ),
          // Long-pressing a bubble reports that specific response; this menu
          // exists so the affordance is discoverable without the gesture.
          if (_lastAssistantMessage != null)
            PopupMenuButton<String>(
              tooltip: l10n.moderationActionsTooltip,
              onSelected: (_) =>
                  unawaited(_reportResponse(_lastAssistantMessage!)),
              itemBuilder: (_) => [
                PopupMenuItem(
                  value: 'report_ai',
                  child: ListTile(
                    leading: const Icon(Icons.flag_outlined),
                    title: Text(l10n.moderationReportAiAction),
                    contentPadding: EdgeInsets.zero,
                  ),
                ),
              ],
            ),
        ],
      ),
      body: Column(
        children: [
          Expanded(child: _body(l10n)),
          if (_loading)
            Align(
              alignment: Alignment.centerLeft,
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.lg,
                  0,
                  AppSpacing.lg,
                  AppSpacing.sm,
                ),
                child: Text(
                  l10n.aiCoachChatThinkingMessage,
                  style: const TextStyle(color: AppColors.fg3, fontSize: 12),
                ),
              ),
            ),
          if (_conversationId != null)
            ChatComposer(
              controller: _prompt,
              hint: l10n.aiCoachChatComposerHint,
              sending: _loading,
              onSend: () => unawaited(_send()),
            ),
        ],
      ),
    );
  }

  String? get _lastAssistantMessage {
    for (var i = _messages.length - 1; i >= 0; i--) {
      if (_messages[i].role != 'user') return _messages[i].content;
    }
    return null;
  }

  Future<void> _reportResponse(String content) =>
      showReportAiResponseDialog(context, ref, content: content);

  Widget _body(AppLocalizations l10n) {
    if (_initializing) {
      return const Center(child: LoadingList());
    }
    if (_initError != null) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: AiErrorView(
            error: _initError!,
            onRetry: () => unawaited(_init()),
          ),
        ),
      );
    }
    if (_messages.isEmpty) {
      return Center(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.xl),
          child: EmptyFeatureState(
            title: l10n.aiCoachChatEmptyTitle,
            message: l10n.aiCoachChatEmptyMessage,
            icon: Icons.forum_outlined,
          ),
        ),
      );
    }
    return ListView.builder(
      reverse: true,
      padding: const EdgeInsets.all(AppSpacing.lg),
      itemCount: _messages.length,
      itemBuilder: (_, i) {
        final msg = _messages[_messages.length - 1 - i];
        return ChatBubble(
          text: msg.content,
          mine: msg.role == 'user',
          author: msg.role == 'user' ? null : l10n.aiCoachChatAuthorLabel,
          markdown: msg.role != 'user',
          onReport: msg.role == 'user'
              ? null
              : () => unawaited(_reportResponse(msg.content)),
        );
      },
    );
  }

  Future<void> _send() async {
    final l10n = AppLocalizations.of(context);
    final prompt = _prompt.text.trim();
    final conversationId = _conversationId;
    if (prompt.isEmpty || conversationId == null) return;
    setState(() {
      _loading = true;
      _messages.add((role: 'user', content: prompt));
      _prompt.clear();
    });
    try {
      final lang = ref.read(appLocaleProvider)?.languageCode ?? 'en';
      final response = await ref.read(xenohApiProvider).postObject(
        '/insights/me/coach-chat/conversations/$conversationId/messages',
        {'content': prompt, 'language': lang},
      );
      final assistantMessage = response['assistantMessage'];
      final reply = assistantMessage is JsonMap
          ? textOf(
              assistantMessage,
              ['content'],
              fallback: l10n.aiCoachChatNoResponseMessage,
            )
          : l10n.aiCoachChatNoResponseMessage;
      setState(() => _messages.add((role: 'assistant', content: reply)));
    } catch (e) {
      if (!mounted) return;
      final gate = aiGate(e);
      final message = gate.isPro
          ? l10n.aiCoachChatProRequiredMessage
          : gate.isQuota
          ? l10n.aiCoachChatQuotaReachedMessage
          : apiErrorMessage(e, context);
      setState(() => _messages.add((role: 'assistant', content: message)));
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  Future<void> _showConversations() async {
    final selected = await showModalBottomSheet<JsonMap>(
      context: context,
      backgroundColor: AppColors.bgPage,
      showDragHandle: true,
      builder: (context) {
        final l10n = AppLocalizations.of(context);
        return SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.lg,
              0,
              AppSpacing.lg,
              AppSpacing.lg,
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  l10n.aiCoachChatConversationsTitle,
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: AppSpacing.md),
                Flexible(
                  child: ListView.separated(
                    shrinkWrap: true,
                    itemCount: _conversations.length,
                    separatorBuilder: (_, _) => const Divider(height: 1),
                    itemBuilder: (context, index) {
                      final item = _conversations[index];
                      final id = textOf(item, ['id'], fallback: '');
                      final count = textOf(item, [
                        'messageCount',
                      ], fallback: '0');
                      return ListTile(
                        contentPadding: EdgeInsets.zero,
                        leading: Icon(
                          id == _conversationId
                              ? Icons.chat_rounded
                              : Icons.chat_bubble_outline_rounded,
                          color: id == _conversationId
                              ? AppColors.accent
                              : AppColors.fg3,
                        ),
                        title: Text(
                          textOf(
                            item,
                            ['title'],
                            fallback: l10n.aiCoachChatUntitledConversation,
                          ),
                        ),
                        subtitle: Text(
                          l10n.aiCoachChatMessageCount(count),
                          style: const TextStyle(color: AppColors.fg3),
                        ),
                        trailing: id == _conversationId
                            ? const Icon(Icons.check_rounded)
                            : null,
                        onTap: () => Navigator.of(context).pop(item),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
    if (selected == null || !mounted) return;
    final id = textOf(selected, ['id'], fallback: '');
    if (id.isEmpty || id == _conversationId) return;
    await _loadConversation(id);
  }

  Future<void> _loadConversation(String id) async {
    setState(() {
      _initializing = true;
      _initError = null;
    });
    try {
      final history = await ref
          .read(xenohApiProvider)
          .getObject(
            '/insights/me/coach-chat/conversations/$id/messages?take=30',
          );
      final items = history['items'];
      final messages =
          (items is List ? items.whereType<JsonMap>().toList() : <JsonMap>[])
            ..sort(
              (a, b) => _createdAt(
                a['createdAt'],
              ).compareTo(_createdAt(b['createdAt'])),
            );
      if (!mounted) return;
      setState(() {
        _conversationId = id;
        _messages
          ..clear()
          ..addAll([
            for (final message in messages)
              (
                role: textOf(message, ['role'], fallback: 'assistant'),
                content: textOf(message, ['content']),
              ),
          ]);
        _initializing = false;
      });
    } catch (error) {
      if (!mounted) return;
      setState(() {
        _initError = error;
        _initializing = false;
      });
    }
  }

  Future<void> _createConversation() async {
    if (_loading) return;
    setState(() => _loading = true);
    try {
      final conversation = await ref
          .read(xenohApiProvider)
          .postObject(
            '/insights/me/coach-chat/conversations',
            const {},
          );
      final id = textOf(conversation, ['id'], fallback: '');
      if (id.isEmpty) throw const FormatException('Missing conversation id');
      if (!mounted) return;
      setState(() {
        _conversations.insert(0, conversation);
        _conversationId = id;
        _messages.clear();
      });
    } catch (error) {
      if (!mounted) return;
      setState(() => _initError = error);
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }
}

DateTime _createdAt(Object? value) =>
    value is String ? DateTime.tryParse(value) ?? DateTime(0) : DateTime(0);
