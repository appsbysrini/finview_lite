import 'dart:convert';

import 'package:finview_lite/models/holding.dart';
import 'package:finview_lite/models/user_portfolio.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  group('UserPortfolio computed fields', () {
    test('calculates investedValue from portfolioValue minus totalGain', () {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      final result = portfolio.investedValue;

      // Assert
      expect(result, 95000);
    });

    test('calculates gainPercent relative to investedValue', () {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      final result = portfolio.gainPercent;

      // Assert
      expect(result, closeTo(5.2631578947, 0.0001));
    });

    test('returns zero gainPercent when investedValue is zero', () {
      // Arrange
      const portfolio = TestData.emptyPortfolio;

      // Act
      final result = portfolio.gainPercent;

      // Assert
      expect(result, 0.0);
    });

    test('supports negative totalGain for portfolio loss', () {
      // Arrange
      const portfolio = TestData.lossPortfolio;

      // Act
      final invested = portfolio.investedValue;
      final gainPercent = portfolio.gainPercent;

      // Assert
      expect(invested, 2000);
      expect(gainPercent, -20.0);
    });
  });

  group('UserPortfolio.fromJson', () {
    test('parses valid portfolio JSON with holdings', () {
      // Arrange
      final json =
          jsonDecode(TestData.validPortfolioJson) as Map<String, dynamic>;

      // Act
      final portfolio = UserPortfolio.fromJson(json);

      // Assert
      expect(portfolio.user, 'Aarav Patel');
      expect(portfolio.portfolioValue, 150000);
      expect(portfolio.totalGain, 12000);
      expect(portfolio.holdings, hasLength(1));
      expect(portfolio.holdings.first.symbol, 'TCS');
    });

    test('falls back to safe defaults for null fields', () {
      // Arrange
      final json =
          jsonDecode(TestData.sparsePortfolioJson) as Map<String, dynamic>;

      // Act
      final portfolio = UserPortfolio.fromJson(json);

      // Assert
      expect(portfolio.user, '');
      expect(portfolio.portfolioValue, 0.0);
      expect(portfolio.totalGain, 0.0);
      expect(portfolio.holdings, hasLength(1));
      expect(portfolio.holdings.first.symbol, '');
      expect(portfolio.holdings.first.gainPercent, 0.0);
    });

    test('returns empty holdings when holdings is not a list', () {
      // Arrange
      final json =
          jsonDecode(TestData.invalidHoldingsJson) as Map<String, dynamic>;

      // Act
      final portfolio = UserPortfolio.fromJson(json);

      // Assert
      expect(portfolio.holdings, isEmpty);
    });

    test('ignores non-map entries inside holdings list', () {
      // Arrange
      final json = jsonDecode('''
        {
          "user": "User",
          "portfolio_value": 1000,
          "total_gain": 100,
          "holdings": [
            "invalid-entry",
            {
              "symbol": "OK",
              "name": "Valid Holding",
              "units": 1,
              "avg_cost": 10,
              "current_price": 12
            }
          ]
        }
      ''') as Map<String, dynamic>;

      // Act
      final portfolio = UserPortfolio.fromJson(json);

      // Assert
      expect(portfolio.holdings, hasLength(1));
      expect(portfolio.holdings.first, isA<Holding>());
      expect(portfolio.holdings.first.symbol, 'OK');
    });
  });
}
