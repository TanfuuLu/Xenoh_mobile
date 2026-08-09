import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:xenoh_mobile/features/subscription/data/datasources/subscription_remote_data_source.dart';
import 'package:xenoh_mobile/features/subscription/domain/entities/billing.dart';

void main() {
  test('loads and parses the server subscription catalog', () async {
    final adapter = _SubscriptionAdapter();
    final source = SubscriptionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final catalog = await source.getCatalog();

    expect(adapter.lastRequest?.method, 'GET');
    expect(adapter.lastRequest?.path, '/subscriptions/catalog');
    expect(catalog.termsVersion, '2026-07-01');
    expect(catalog.offers.single.tier, 'ProIndividual');
    expect(catalog.offers.single.price, 499000);
    expect(catalog.offers.single.automaticallyRenews, isFalse);
  });

  test('validates a promotion with the selected tier and duration', () async {
    final adapter = _SubscriptionAdapter();
    final source = SubscriptionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final result = await source.validatePromotion(
      code: 'save20',
      requestedTier: 'ProIndividual',
      durationMonths: 6,
    );

    expect(adapter.lastRequest?.path, '/subscriptions/promotions/validate');
    expect(adapter.lastBody, {
      'code': 'save20',
      'requestedTier': 'ProIndividual',
      'durationMonths': 6,
    });
    expect(result.valid, isTrue);
    expect(result.code, 'SAVE20');
    expect(result.finalAmount, 399000);
  });

  test('creates a payment order with accepted server terms', () async {
    final adapter = _SubscriptionAdapter();
    final source = SubscriptionRemoteDataSource(
      Dio()..httpClientAdapter = adapter,
    );

    final order = await source.createPaymentOrder(
      const CreatePaymentOrderInput(
        requestedTier: 'ProIndividual',
        durationMonths: 6,
        promotionCode: 'SAVE20',
        termsVersion: '2026-07-01',
      ),
    );

    expect(adapter.lastRequest?.path, '/subscriptions/payment-orders');
    expect(adapter.lastBody, {
      'requestedTier': 'ProIndividual',
      'durationMonths': 6,
      'promotionCode': 'SAVE20',
      'acceptedTerms': true,
      'termsVersion': '2026-07-01',
    });
    expect(order.orderId, 'order-1');
    expect(order.transferCode, 'XENOH-ABC');
    expect(order.amount, 399000);
    expect(order.bankName, 'Demo Bank');
  });
}

class _SubscriptionAdapter implements HttpClientAdapter {
  RequestOptions? lastRequest;
  Map<String, dynamic>? lastBody;

  @override
  Future<ResponseBody> fetch(
    RequestOptions options,
    Stream<List<int>>? requestStream,
    Future<void>? cancelFuture,
  ) async {
    lastRequest = options;
    lastBody = options.data is Map
        ? Map<String, dynamic>.from(options.data as Map)
        : null;

    final response = switch (options.path) {
      '/subscriptions/catalog' => {
        'termsVersion': '2026-07-01',
        'offers': [
          {
            'tier': 'ProIndividual',
            'durationMonths': 6,
            'price': 499000,
            'currency': 'VND',
            'isPrepaid': true,
            'automaticallyRenews': false,
            'hasUnlimitedClients': false,
          },
        ],
      },
      '/subscriptions/promotions/validate' => {
        'valid': true,
        'message': null,
        'code': 'SAVE20',
        'discountType': 'Percent',
        'discountValue': 20,
        'appliesToTier': 'ProIndividual',
        'originalAmount': 499000,
        'discountAmount': 100000,
        'finalAmount': 399000,
      },
      '/subscriptions/payment-orders' => {
        'orderId': 'order-1',
        'transferCode': 'XENOH-ABC',
        'amount': 399000,
        'originalAmount': 499000,
        'discountAmount': 100000,
        'promotionCode': 'SAVE20',
        'durationMonths': 6,
        'requestedTier': 'ProIndividual',
        'expiresAt': '2026-08-03T12:30:00Z',
        'bankAccountNumber': '0123456789',
        'bankAccountName': 'XENOH',
        'bankName': 'Demo Bank',
        'transferDescription': 'XENOH-ABC',
      },
      _ => throw StateError('Unexpected request: ${options.path}'),
    };

    return ResponseBody.fromString(
      jsonEncode(response),
      200,
      headers: {
        Headers.contentTypeHeader: [Headers.jsonContentType],
      },
    );
  }

  @override
  void close({bool force = false}) {}
}
