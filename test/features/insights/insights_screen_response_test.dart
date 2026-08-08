import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/coach_client/presentation/screens/client_detail_screen.dart';
import 'package:xenoh_mobile/features/insights/presentation/screens/insights_screen.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('renders every field from the expanded AI responses', (
    tester,
  ) async {
    await tester.binding.setSurfaceSize(const Size(390, 844));
    addTearDown(() => tester.binding.setSurfaceSize(null));
    final analysis = <String, dynamic>{
      'language': 'en',
      'generatedAt': '2026-08-02T08:00:00Z',
      'cached': false,
      'content': {
        'trainingAdherence': {
          'headline': 'Consistency is improving',
          'detail': 'You completed four sessions this week.',
        },
        'recommendation': {
          'headline': 'Protect recovery',
          'actions': ['Keep one full rest day'],
        },
        'planReview': {
          'headline': 'Hold load progression',
          'dataSummary':
              'RPE rose while completion stayed stable. Main-lift completion remains consistent.',
          'goalFit': 'The plan still fits your strength goal.',
          'deload': {
            'verdict': 'recommended',
            'rationale':
                'Fatigue is accumulating. Recovery markers need monitoring.',
            'prescription':
                'Reduce accessory sets by 30%. Keep the main lifts stable.',
          },
          'loadProgression': {
            'verdict': 'hold',
            'rationale': 'Recovery is not complete.',
            'prescription': 'Keep main lift loads unchanged.',
          },
          'rpeGuidance': 'Keep working sets at RPE 7-8.',
          'volumeGuidance': 'Trim optional isolation work.',
          'priorities': ['Sleep eight hours', 'Track session RPE'],
        },
      },
    };
    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          personalInsightsProvider.overrideWith((ref, lang) async => analysis),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: InsightsScreen(),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Protect recovery'), findsOneWidget);
    expect(find.text('Keep one full rest day'), findsOneWidget);
    expect(
      find.text('RPE rose while completion stayed stable.'),
      findsOneWidget,
    );
    expect(
      find.text('Main-lift completion remains consistent.'),
      findsOneWidget,
    );
    expect(find.text('Reduce accessory sets by 30%.'), findsOneWidget);
    expect(find.text('Keep the main lifts stable.'), findsOneWidget);
    expect(find.text('Keep main lift loads unchanged.'), findsOneWidget);
    expect(find.text('Sleep eight hours'), findsOneWidget);
    expect(
      tester.getTopLeft(find.text('Protect recovery')).dy,
      lessThan(tester.getTopLeft(find.text('Consistency is improving')).dy),
    );
  });

  testWidgets('coach client AI screen renders suggested outreach message', (
    tester,
  ) async {
    final brief = <String, dynamic>{
      'language': 'en',
      'generatedAt': '2026-08-02T08:00:00Z',
      'cached': false,
      'headline': 'Recovery needs attention',
      'attentionLevel': 'medium',
      'progressSummary': 'Training is consistent but RPE is rising.',
      'risks': ['Sleep duration is trending down'],
      'opportunities': ['Keep the current schedule'],
      'suggestedMessage': 'Keep the load steady this week.',
    };

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          clientAiInsightProvider.overrideWith((ref, id) async => brief),
        ],
        child: const MaterialApp(
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          home: ClientAiInsightsScreen(clientId: 'c1'),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      find.text('Training is consistent but RPE is rising.'),
      findsOneWidget,
    );
    expect(find.text('Sleep duration is trending down'), findsOneWidget);
    expect(find.text('Keep the current schedule'), findsOneWidget);
    expect(find.text('Keep the load steady this week.'), findsOneWidget);
  });
}
