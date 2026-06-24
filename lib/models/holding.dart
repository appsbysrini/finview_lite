/// A single investment holding with computed value and gain metrics.
class Holding {
  /// Creates a [Holding] with the given market and cost data.
  const Holding({
    required this.symbol,
    required this.name,
    required this.units,
    required this.avgCost,
    required this.currentPrice,
  });

  /// Ticker symbol for the holding.
  final String symbol;

  /// Full company or fund name.
  final String name;

  /// Number of units held.
  final double units;

  /// Average purchase price per unit.
  final double avgCost;

  /// Latest market price per unit.
  final double currentPrice;

  /// Current market value: units × current_price.
  double get currentValue => units * currentPrice;

  /// Total amount invested: units × avg_cost.
  double get investedValue => units * avgCost;

  /// Absolute gain or loss: currentValue − investedValue.
  double get gainAmount => currentValue - investedValue;

  /// Percentage gain or loss relative to invested value.
  double get gainPercent {
    if (investedValue == 0) {
      return 0.0;
    }
    return (gainAmount / investedValue) * 100;
  }

  /// Parses a [Holding] from JSON, falling back to safe defaults for null fields.
  factory Holding.fromJson(Map<String, dynamic> json) {
    return Holding(
      symbol: json['symbol'] as String? ?? '',
      name: json['name'] as String? ?? '',
      units: _parseDouble(json['units']),
      avgCost: _parseDouble(json['avg_cost']),
      currentPrice: _parseDouble(json['current_price']),
    );
  }

  static double _parseDouble(dynamic value) {
    if (value == null) {
      return 0.0;
    }
    if (value is num) {
      return value.toDouble();
    }
    return double.tryParse(value.toString()) ?? 0.0;
  }
}
