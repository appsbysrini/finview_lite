import 'package:finview_lite/utils/json_parser.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('parseJsonDouble', () {
    test('returns fallback when value is null', () {
      // Act
      final result = parseJsonDouble(null);

      // Assert
      expect(result, 0.0);
    });

    test('returns custom fallback when value is null', () {
      // Act
      final result = parseJsonDouble(null, fallback: 99.0);

      // Assert
      expect(result, 99.0);
    });

    test('converts int values to double', () {
      // Act
      final result = parseJsonDouble(42);

      // Assert
      expect(result, 42.0);
    });

    test('returns double values unchanged', () {
      // Act
      final result = parseJsonDouble(12.34);

      // Assert
      expect(result, 12.34);
    });

    test('parses numeric strings', () {
      // Act
      final result = parseJsonDouble('1500.75');

      // Assert
      expect(result, 1500.75);
    });

    test('returns fallback for invalid strings', () {
      // Act
      final result = parseJsonDouble('not-a-number');

      // Assert
      expect(result, 0.0);
    });

    test('returns fallback for unsupported types', () {
      // Act
      final result = parseJsonDouble(<String>['1']);

      // Assert
      expect(result, 0.0);
    });
  });
}
