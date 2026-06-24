import 'package:finview_lite/models/holding.dart';
import 'package:finview_lite/models/user_portfolio.dart';

/// Sample holdings used across unit and widget tests.
abstract final class TestData {
  /// Holding with a positive gain.
  static const tcs = Holding(
    symbol: 'TCS',
    name: 'Tata Consultancy',
    units: 5,
    avgCost: 3200,
    currentPrice: 3400,
  );

  /// Holding with a smaller positive gain.
  static const infy = Holding(
    symbol: 'INFY',
    name: 'Infosys Ltd',
    units: 10,
    avgCost: 1400,
    currentPrice: 1500,
  );

  /// Holding with a loss.
  static const lossHolding = Holding(
    symbol: 'LOSS',
    name: 'Loss Corp',
    units: 2,
    avgCost: 1000,
    currentPrice: 800,
  );

  /// Holding with zero invested value for division-by-zero checks.
  static const zeroInvested = Holding(
    symbol: 'FREE',
    name: 'Free Shares',
    units: 10,
    avgCost: 0,
    currentPrice: 100,
  );

  /// Portfolio with multiple holdings.
  static const samplePortfolio = UserPortfolio(
    user: 'Test User',
    portfolioValue: 100000,
    totalGain: 5000,
    holdings: [tcs, infy],
  );

  /// Portfolio with no holdings.
  static const emptyPortfolio = UserPortfolio(
    user: 'Empty User',
    portfolioValue: 0,
    totalGain: 0,
    holdings: [],
  );

  /// Portfolio with a net loss.
  static const lossPortfolio = UserPortfolio(
    user: 'Loss User',
    portfolioValue: 1600,
    totalGain: -400,
    holdings: [lossHolding],
  );

  /// Valid portfolio JSON matching bundled asset structure.
  static const validPortfolioJson = '''
{
  "user": "Aarav Patel",
  "portfolio_value": 150000,
  "total_gain": 12000,
  "holdings": [
    {
      "symbol": "TCS",
      "name": "Tata Consultancy",
      "units": 5,
      "avg_cost": 3200,
      "current_price": 3400
    }
  ]
}
''';

  /// JSON with null and missing numeric fields.
  static const sparsePortfolioJson = '''
{
  "user": null,
  "portfolio_value": null,
  "total_gain": null,
  "holdings": [
    {
      "symbol": null,
      "name": null,
      "units": null,
      "avg_cost": null,
      "current_price": null
    }
  ]
}
''';

  /// JSON with an invalid holdings payload.
  static const invalidHoldingsJson = '''
{
  "user": "User",
  "portfolio_value": 1000,
  "total_gain": 100,
  "holdings": "not-a-list"
}
''';
}
