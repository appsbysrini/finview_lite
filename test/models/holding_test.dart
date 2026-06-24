import 'dart:convert';

import 'package:finview_lite/models/holding.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  group('Holding computed fields', () {
    test('calculates currentValue as units times currentPrice', () {
      // Arrange
      const holding = TestData.tcs;

      // Act
      final result = holding.currentValue;

      // Assert
      expect(result, 17000);
    });

    test('calculates investedValue as units times avgCost', () {
      // Arrange
      const holding = TestData.tcs;

      // Act
      final result = holding.investedValue;

      // Assert
      expect(result, 16000);
    });

    test('calculates gainAmount as currentValue minus investedValue', () {
      // Arrange
      const holding = TestData.tcs;

      // Act
      final result = holding.gainAmount;

      // Assert
      expect(result, 1000);
    });

    test('calculates negative gainAmount for a loss', () {
      // Arrange
      const holding = TestData.lossHolding;

      // Act
      final result = holding.gainAmount;

      // Assert
      expect(result, -400);
    });

    test('calculates gainPercent relative to investedValue', () {
      // Arrange
      const holding = TestData.tcs;

      // Act
      final result = holding.gainPercent;

      // Assert
      expect(result, closeTo(6.25, 0.001));
    });

    test('returns zero gainPercent when investedValue is zero', () {
      // Arrange
      const holding = TestData.zeroInvested;

      // Act
      final result = holding.gainPercent;

      // Assert
      expect(result, 0.0);
    });
  });

  group('Holding.fromJson', () {
    test('parses valid JSON fields', () {
      // Arrange
      final json = jsonDecode('''
        {
          "symbol": "TCS",
          "name": "Tata Consultancy",
          "units": 5,
          "avg_cost": 3200,
          "current_price": 3400
        }
      ''') as Map<String, dynamic>;

      // Act
      final holding = Holding.fromJson(json);

      // Assert
      expect(holding.symbol, 'TCS');
      expect(holding.name, 'Tata Consultancy');
      expect(holding.units, 5);
      expect(holding.avgCost, 3200);
      expect(holding.currentPrice, 3400);
    });

    test('falls back to defaults for null fields', () {
      // Arrange
      final json = jsonDecode('''
        {
          "symbol": null,
          "name": null,
          "units": null,
          "avg_cost": null,
          "current_price": null
        }
      ''') as Map<String, dynamic>;

      // Act
      final holding = Holding.fromJson(json);

      // Assert
      expect(holding.symbol, '');
      expect(holding.name, '');
      expect(holding.units, 0.0);
      expect(holding.avgCost, 0.0);
      expect(holding.currentPrice, 0.0);
      expect(holding.gainPercent, 0.0);
    });

    test('parses numeric values provided as strings', () {
      // Arrange
      final json = jsonDecode('''
        {
          "symbol": "ABC",
          "name": "ABC Ltd",
          "units": "12.5",
          "avg_cost": "100",
          "current_price": "110"
        }
      ''') as Map<String, dynamic>;

      // Act
      final holding = Holding.fromJson(json);

      // Assert
      expect(holding.units, 12.5);
      expect(holding.avgCost, 100);
      expect(holding.currentPrice, 110);
      expect(holding.currentValue, closeTo(1375, 0.001));
    });
  });
}
