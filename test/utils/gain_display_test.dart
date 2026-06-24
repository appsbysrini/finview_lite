import 'package:finview_lite/providers/return_toggle_provider.dart';
import 'package:finview_lite/utils/app_themes.dart';
import 'package:finview_lite/utils/gain_display.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('gainColorFor', () {
    test('returns primary color for non-negative gain', () {
      // Arrange
      final theme = AppThemes.light;

      // Act
      final color = gainColorFor(theme, 100);

      // Assert
      expect(color, theme.colorScheme.primary);
    });

    test('returns error color for negative gain', () {
      // Arrange
      final theme = AppThemes.light;

      // Act
      final color = gainColorFor(theme, -50);

      // Assert
      expect(color, theme.colorScheme.error);
    });
  });

  group('formatReturnValue', () {
    test('formats amount mode using currency gain formatter', () {
      // Act
      final result = formatReturnValue(
        gainAmount: 1000,
        gainPercent: 6.25,
        displayMode: ReturnDisplayMode.amount,
      );

      // Assert
      expect(result, '+₹1,000');
    });

    test('formats percent mode using percent formatter', () {
      // Act
      final result = formatReturnValue(
        gainAmount: 1000,
        gainPercent: 6.25,
        displayMode: ReturnDisplayMode.percent,
      );

      // Assert
      expect(result, '+6.3%');
    });
  });
}
