import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/insights/presentation/screens/ai_coach_chat_screen.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

class _MockApi extends Mock implements XenohApi {}

void main() {
  testWidgets('coach chat exposes backend conversations and history', (
    tester,
  ) async {
    final api = _MockApi();
    when(() => api.getObject(any())).thenAnswer((invocation) async {
      final path = invocation.positionalArguments.first as String;
      if (path.contains('/messages')) {
        return {
          'items': [
            {
              'id': 'm1',
              'conversationId': 'c1',
              'role': 'assistant',
              'content': 'Keep today easy.',
              'createdAt': '2026-08-02T08:00:00Z',
            },
          ],
          'hasMore': false,
        };
      }
      return {
        'items': [
          {
            'id': 'c1',
            'title': 'Current block',
            'messageCount': 3,
            'lastMessageAt': '2026-08-02T08:00:00Z',
            'isArchived': false,
            'createdAt': '2026-08-01T08:00:00Z',
            'updatedAt': '2026-08-02T08:00:00Z',
          },
          {
            'id': 'c2',
            'title': 'Previous check-in',
            'messageCount': 8,
            'lastMessageAt': '2026-07-25T08:00:00Z',
            'isArchived': false,
            'createdAt': '2026-07-20T08:00:00Z',
            'updatedAt': '2026-07-25T08:00:00Z',
          },
        ],
        'hasMore': false,
      };
    });

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(api)],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: AiCoachChatScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Keep today easy.'), findsOneWidget);
    await tester.tap(find.byTooltip('Conversations'));
    await tester.pumpAndSettle();
    expect(find.text('Current block'), findsOneWidget);
    expect(find.text('Previous check-in'), findsOneWidget);
  });
}
