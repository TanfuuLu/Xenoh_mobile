import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/dashboard/domain/entities/personal_dashboard.dart';
import 'package:xenoh_mobile/features/dashboard/presentation/utils/dashboard_localization.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('dashboard next actions and insights localize in Vietnamese', (
    tester,
  ) async {
    const action = NextAction(
      type: 'StartWorkout',
      label: "Start today's workout",
      description: '0/14 sets completed.',
      route: '/training',
      priority: 1,
    );
    const insight = ProInsightItem(
      type: 'PlanProgress',
      severity: 'Info',
      title: 'Active plan progress',
      message: '40/64 training days completed.',
    );

    await tester.pumpWidget(
      MaterialApp(
        locale: const Locale('vi'),
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        supportedLocales: AppLocalizations.supportedLocales,
        home: Builder(
          builder: (context) {
            final l10n = AppLocalizations.of(context);
            final localizedAction = localizeDashboardNextAction(
              action,
              l10n,
              Localizations.localeOf(context).languageCode,
            );
            final localizedInsight = localizeDashboardInsight(
              insight,
              l10n,
              Localizations.localeOf(context).languageCode,
            );
            return Text(
              '${localizedAction.label}\n'
              '${localizedAction.description}\n'
              '${localizedInsight.title}\n'
              '${localizedInsight.message}',
            );
          },
        ),
      ),
    );

    expect(find.textContaining('Bắt đầu buổi tập hôm nay'), findsOneWidget);
    expect(find.textContaining('Đã hoàn thành 0/14 set.'), findsOneWidget);
    expect(
      find.textContaining('Tiến độ kế hoạch đang hoạt động'),
      findsOneWidget,
    );
    expect(
      find.textContaining('Đã hoàn thành 40/64 ngày tập.'),
      findsOneWidget,
    );
  });
}
