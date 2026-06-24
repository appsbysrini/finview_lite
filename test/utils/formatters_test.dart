import 'package:finview_lite/utils/formatters.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('formatCurrency', () {
    test('formats positive values with Indian rupee grouping (lakh/crore)', () {
      // 1,00,000 — Indian grouping: last 3 digits, then groups of 2.
      // Act
      final result = formatCurrency(100000);

      // Assert
      expect(result, '₹1,00,000');
    });

    test('formats crore-range values with correct Indian grouping', () {
      // 1,09,64,000
      // Act
      final result = formatCurrency(10964000);

      // Assert
      expect(result, '₹1,09,64,000');
    });

    test('formats negative values with leading minus sign', () {
      // Act
      final result = formatCurrency(-1500);

      // Assert
      expect(result, '-₹1,500');
    });
  });

  group('formatGainAmount', () {
    test('returns unsigned zero for zero gain', () {
      // Act
      final result = formatGainAmount(0);

      // Assert
      expect(result, '₹0');
    });

    test('prefixes positive gains with plus sign', () {
      // Act
      final result = formatGainAmount(5000);

      // Assert
      expect(result, '+₹5,000');
    });

    test('prefixes losses with minus sign', () {
      // Act
      final result = formatGainAmount(-400);

      // Assert
      expect(result, '-₹400');
    });
  });

  group('formatPercent', () {
    test('returns neutral zero percent string', () {
      // Act
      final result = formatPercent(0);

      // Assert
      expect(result, '0.0%');
    });

    test('prefixes positive values with plus sign', () {
      // Act
      final result = formatPercent(6.25);

      // Assert
      expect(result, '+6.3%');
    });

    test('formats negative values without double minus', () {
      // Act
      final result = formatPercent(-12.5);

      // Assert
      expect(result, '-12.5%');
    });
  });

  group('formatSharePercent', () {
    test('formats allocation share without sign prefix', () {
      // Act
      final result = formatSharePercent(33.333);

      // Assert
      expect(result, '33.3%');
    });
  });
}
