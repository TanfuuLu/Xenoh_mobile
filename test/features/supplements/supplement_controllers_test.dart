import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:xenoh_mobile/features/supplements/data/repositories/supplement_repository_provider.dart';
import 'package:xenoh_mobile/features/supplements/domain/repositories/supplement_repository.dart';
import 'package:xenoh_mobile/features/supplements/presentation/providers/supplement_controllers.dart';

class _MockSupplementRepository extends Mock implements SupplementRepository {}

void main() {
  test(
    'resetDose completes safely when the mutation provider is disposed in flight',
    () async {
      final repository = _MockSupplementRepository();
      final response = Completer<void>();
      final date = DateTime(2026, 8, 6);
      when(
        () => repository.resetDose(doseSlotId: 'dose-1', date: date),
      ).thenAnswer((_) => response.future);
      final container = ProviderContainer(
        overrides: [
          supplementRepositoryProvider.overrideWithValue(repository),
        ],
      );
      addTearDown(container.dispose);
      final subscription = container.listen(
        supplementMutationControllerProvider,
        (_, _) {},
      );
      final controller = container.read(
        supplementMutationControllerProvider.notifier,
      );

      final mutation = controller.resetDose(
        doseSlotId: 'dose-1',
        date: date,
      );
      subscription.close();
      await container.pump();
      response.complete();

      await expectLater(mutation, completion(isTrue));
    },
  );
}
