import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/insights/presentation/screens/insights_screen.dart';
import 'package:xenoh_mobile/features/shared_api/xenoh_api.dart';

class _MockApi extends Mock implements XenohApi {}

void main() {
  setUpAll(() => registerFallbackValue(Duration.zero));

  test('AI Coach Review allows enough time for insight generation', () async {
    final api = _MockApi();
    when(
      () => api.getObjectWithTimeout(
        any(),
        receiveTimeout: any(named: 'receiveTimeout'),
      ),
    ).thenAnswer((_) async => <String, dynamic>{});
    final container = ProviderContainer(
      overrides: [xenohApiProvider.overrideWithValue(api)],
    );
    addTearDown(container.dispose);

    await container.read(personalInsightsProvider('vi').future);

    verify(
      () => api.getObjectWithTimeout(
        '/insights/me?lang=vi',
        receiveTimeout: const Duration(seconds: 60),
      ),
    ).called(1);
  });
}
