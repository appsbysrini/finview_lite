import 'dart:math';

import '../models/holding.dart';
import '../models/user_portfolio.dart';
import 'prefs_keys.dart';

/// Applies a simulated market move to each holding in [portfolio].
UserPortfolio simulatePriceRefresh(UserPortfolio portfolio) {
  final random = Random();
  final updatedHoldings = portfolio.holdings.map((holding) {
    final delta = (random.nextDouble() * RefreshConstants.maxPriceDelta * 2) -
        RefreshConstants.maxPriceDelta;
    final updatedPrice = holding.currentPrice * (1 + delta);

    return Holding(
      symbol: holding.symbol,
      name: holding.name,
      units: holding.units,
      avgCost: holding.avgCost,
      currentPrice: max(updatedPrice, 0),
    );
  }).toList();

  final portfolioValue = updatedHoldings.fold<double>(
    0,
    (sum, holding) => sum + holding.currentValue,
  );
  final totalGain = updatedHoldings.fold<double>(
    0,
    (sum, holding) => sum + holding.gainAmount,
  );

  return UserPortfolio(
    user: portfolio.user,
    portfolioValue: portfolioValue,
    totalGain: totalGain,
    holdings: updatedHoldings,
  );
}

/// Artificial delay used to mimic a network refresh call.
Future<void> simulateRefreshDelay() {
  return Future<void>.delayed(RefreshConstants.simulatedDelay);
}
