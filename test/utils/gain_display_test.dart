import 'package:finview_lite/providers/return_toggle_provider.dart';
import 'package:finview_lite/utils/app_design_tokens.dart';
import 'package:finview_lite/utils/gain_display.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

ThemeData _testTheme(FinViewColors colors) {
  return ThemeData(extensions: [colors]);
}

void main() {
  group('gainColorFor', () {
    test('returns profit color for non-negative gain', () {
      // Arrange
      final theme = _testTheme(FinViewColors.light);

      // Act
      final color = gainColorFor(theme, 100);

      // Assert
      expect(color, FinViewColors.light.profit);
    });

    test('returns loss color for negative gain', () {
      // Arrange
      final theme = _testTheme(FinViewColors.light);

      // Act
      final color = gainColorFor(theme, -50);

      // Assert
      expect(color, FinViewColors.light.loss);
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
