import 'package:finview_lite/utils/portfolio_simulator.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  group('simulatePriceRefresh', () {
    test('returns portfolio with recalculated totals', () {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      final refreshed = simulatePriceRefresh(portfolio);

      // Assert
      expect(refreshed.user, portfolio.user);
      expect(refreshed.holdings, hasLength(portfolio.holdings.length));
      expect(refreshed.portfolioValue, greaterThan(0));
      expect(
        refreshed.portfolioValue,
        closeTo(
          refreshed.holdings.fold<double>(
            0,
            (sum, holding) => sum + holding.currentValue,
          ),
          0.001,
        ),
      );
      expect(
        refreshed.totalGain,
        closeTo(
          refreshed.holdings.fold<double>(
            0,
            (sum, holding) => sum + holding.gainAmount,
          ),
          0.001,
        ),
      );
    });

    test('keeps prices non-negative after refresh', () {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      final refreshed = simulatePriceRefresh(portfolio);

      // Assert
      for (final holding in refreshed.holdings) {
        expect(holding.currentPrice, greaterThanOrEqualTo(0));
      }
    });

    test('preserves holding identity fields', () {
      // Arrange
      const portfolio = TestData.samplePortfolio;

      // Act
      final refreshed = simulatePriceRefresh(portfolio);

      // Assert
      for (var index = 0; index < portfolio.holdings.length; index++) {
        expect(refreshed.holdings[index].symbol,
            portfolio.holdings[index].symbol);
        expect(
          refreshed.holdings[index].name,
          portfolio.holdings[index].name,
        );
        expect(
          refreshed.holdings[index].units,
          portfolio.holdings[index].units,
        );
        expect(
          refreshed.holdings[index].avgCost,
          portfolio.holdings[index].avgCost,
        );
      }
    });
  });

  group('simulateRefreshDelay', () {
    test('completes after the configured delay', () async {
      // Act
      final future = simulateRefreshDelay();

      // Assert
      await expectLater(future, completes);
    });
  });
}
