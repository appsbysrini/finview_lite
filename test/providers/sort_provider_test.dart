import 'package:finview_lite/providers/sort_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('sortProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('defaults to sorting by value', () {
      // Act
      final sort = container.read(sortProvider);

      // Assert
      expect(sort, HoldingSort.byValue);
    });

    test('updates when notifier state changes', () {
      // Act
      container.read(sortProvider.notifier).state = HoldingSort.byGain;

      // Assert
      expect(container.read(sortProvider), HoldingSort.byGain);
    });

    test('supports all sort options', () {
      // Act & Assert
      for (final option in HoldingSort.values) {
        container.read(sortProvider.notifier).state = option;
        expect(container.read(sortProvider), option);
      }
    });
  });
}
