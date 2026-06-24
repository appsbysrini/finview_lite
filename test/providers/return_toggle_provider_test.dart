import 'package:finview_lite/providers/return_toggle_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('returnToggleProvider', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    test('defaults to amount display mode', () {
      // Act
      final mode = container.read(returnToggleProvider);

      // Assert
      expect(mode, ReturnDisplayMode.amount);
    });

    test('updates when notifier state changes', () {
      // Act
      container.read(returnToggleProvider.notifier).state =
          ReturnDisplayMode.percent;

      // Assert
      expect(container.read(returnToggleProvider), ReturnDisplayMode.percent);
    });

    test('supports toggling between display modes', () {
      // Act
      container.read(returnToggleProvider.notifier).state =
          ReturnDisplayMode.percent;
      container.read(returnToggleProvider.notifier).state =
          ReturnDisplayMode.amount;

      // Assert
      expect(container.read(returnToggleProvider), ReturnDisplayMode.amount);
    });
  });
}
