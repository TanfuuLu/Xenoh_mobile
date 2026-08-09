import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/subscription/data/datasources/subscription_remote_data_source.dart';
import 'package:xenoh_mobile/features/subscription/data/repositories/subscription_repository_impl.dart';
import 'package:xenoh_mobile/features/subscription/domain/entities/billing.dart';

class _MockRemote extends Mock implements SubscriptionRemoteDataSource {}

void main() {
  late _MockRemote remote;
  late SubscriptionRepositoryImpl repository;

  setUp(() {
    remote = _MockRemote();
    repository = SubscriptionRepositoryImpl(remote);
  });

  test('exposes the server catalog through the repository', () async {
    const catalog = SubscriptionCatalog(
      termsVersion: 'terms-v2',
      offers: [],
    );
    when(remote.getCatalog).thenAnswer((_) async => catalog);

    expect(await repository.getCatalog(), same(catalog));
  });

  test('returns invalid promotion responses without throwing', () async {
    const invalid = PromotionValidation(
      valid: false,
      message: 'Expired code.',
      discountValue: 0,
    );
    when(
      () => remote.validatePromotion(
        code: 'OLD',
        requestedTier: 'ProIndividual',
        durationMonths: 3,
      ),
    ).thenAnswer((_) async => invalid);

    final result = await repository.validatePromotion(
      code: 'OLD',
      requestedTier: 'ProIndividual',
      durationMonths: 3,
    );

    expect(result.valid, isFalse);
    expect(result.message, 'Expired code.');
  });

  test('creates payment orders through the repository', () async {
    const input = CreatePaymentOrderInput(
      requestedTier: 'ProCoach',
      durationMonths: 12,
      termsVersion: 'terms-v2',
    );
    final order = PaymentOrder(
      orderId: 'id',
      transferCode: 'CODE',
      amount: 1000,
      originalAmount: 1000,
      discountAmount: 0,
      durationMonths: 12,
      requestedTier: 'ProCoach',
      expiresAt: DateTime(2026),
      bankAccountNumber: '123',
      bankAccountName: 'XENOH',
      bankName: 'Bank',
      transferDescription: 'CODE',
    );
    when(() => remote.createPaymentOrder(input)).thenAnswer((_) async => order);

    expect(await repository.createPaymentOrder(input), same(order));
  });
}
