import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/core/network/xenoh_api.dart';
import 'package:xenoh_mobile/features/admin/presentation/screens/admin_finance_screens.dart';
import 'package:xenoh_mobile/l10n/app_localizations.dart';

void main() {
  testWidgets('payments screen renders summary orders and subscriptions', (
    tester,
  ) async {
    tester.view.physicalSize = const Size(390, 844);
    tester.view.devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(_AdminFinanceApi())],
        child: const _TestApp(home: AdminPaymentsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Payments & subscriptions'), findsWidgets);
    expect(find.text('Mai Nguyen'), findsWidgets);
    expect(find.text('1,000 VND'), findsNothing);
    expect(tester.takeException(), isNull);
  });

  testWidgets('promotions screen renders code and management actions', (
    tester,
  ) async {
    await tester.pumpWidget(
      ProviderScope(
        overrides: [xenohApiProvider.overrideWithValue(_AdminFinanceApi())],
        child: const _TestApp(home: AdminPromotionsScreen()),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('WELCOME20'), findsOneWidget);
    expect(find.byType(Switch), findsOneWidget);
    expect(find.byIcon(Icons.edit_outlined), findsOneWidget);
  });
}

class _TestApp extends StatelessWidget {
  const _TestApp({required this.home});
  final Widget home;

  @override
  Widget build(BuildContext context) => MaterialApp(
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: AppLocalizations.supportedLocales,
    home: home,
  );
}

class _AdminFinanceApi extends XenohApi {
  _AdminFinanceApi() : super(Dio());

  @override
  Future<JsonMap> getObject(String path) async => {
    'totalRevenue': 1000,
    'revenueThisMonth': 500,
    'pendingAmount': 100,
    'completedOrders': 2,
    'activePaidSubscriptions': 1,
  };

  @override
  Future<List<JsonMap>> getList(String path) async => switch (path) {
    '/admin/payments' => [
      {
        'id': 'payment-1',
        'userName': 'Mai Nguyen',
        'userEmail': 'mai@example.test',
        'requestedTier': 'ProIndividual',
        'amount': 500,
        'status': 'Completed',
        'transferCode': 'XN-001',
      },
    ],
    '/admin/subscriptions' => [
      {
        'userId': 'user-1',
        'userName': 'Mai Nguyen',
        'userEmail': 'mai@example.test',
        'tier': 'ProIndividual',
        'isActive': true,
      },
    ],
    '/admin/promotion-codes' => [
      {
        'id': 'promo-1',
        'code': 'WELCOME20',
        'description': 'Welcome offer',
        'discountType': 'Percent',
        'discountValue': 20,
        'appliesToTier': 'ProIndividual',
        'maxRedemptions': 100,
        'maxRedemptionsPerUser': 1,
        'completedRedemptions': 12,
        'isActive': true,
      },
    ],
    _ => [],
  };
}
