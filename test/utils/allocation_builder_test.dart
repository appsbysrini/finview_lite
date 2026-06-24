import 'package:finview_lite/models/holding.dart';
import 'package:finview_lite/utils/allocation_builder.dart';
import 'package:finview_lite/utils/app_design_tokens.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  final palette = FinViewColors.light.chartPalette;

  group('buildAllocationSlices', () {
    test('builds slices with percentages for valued holdings', () {
      // Arrange
      const holdings = [TestData.tcs, TestData.infy];

      // Act
      final slices = buildAllocationSlices(holdings, palette: palette);

      // Assert
      expect(slices, hasLength(2));
      expect(slices.first.symbol, 'TCS');
      expect(slices.last.symbol, 'INFY');
      expect(
        slices.fold<double>(0, (sum, slice) => sum + slice.percentage),
        closeTo(100, 0.001),
      );
    });

    test('excludes zero-value holdings', () {
      // Arrange
      const zeroValue = Holding(
        symbol: 'ZERO',
        name: 'Zero Value',
        units: 5,
        avgCost: 100,
        currentPrice: 0,
      );

      // Act
      final slices = buildAllocationSlices(
        [TestData.tcs, zeroValue],
        palette: palette,
      );

      // Assert
      expect(slices, hasLength(1));
      expect(slices.first.symbol, 'TCS');
      expect(slices.first.percentage, 100);
    });

    test('returns empty list when all holdings are zero value', () {
      // Arrange
      const zeroValue = Holding(
        symbol: 'ZERO',
        name: 'Zero Value',
        units: 5,
        avgCost: 100,
        currentPrice: 0,
      );

      // Act
      final slices = buildAllocationSlices([zeroValue], palette: palette);

      // Assert
      expect(slices, isEmpty);
    });

    test('returns empty list for empty holdings input', () {
      // Act
      final slices = buildAllocationSlices(const [], palette: palette);

      // Assert
      expect(slices, isEmpty);
    });
  });

  group('hasAllocationData', () {
    test('returns true when at least one slice has positive value', () {
      // Arrange
      final slices = buildAllocationSlices([TestData.tcs], palette: palette);

      // Act
      final result = hasAllocationData(slices);

      // Assert
      expect(result, isTrue);
    });

    test('returns false for empty slices', () {
      // Act
      final result = hasAllocationData(const []);

      // Assert
      expect(result, isFalse);
    });
  });
}
