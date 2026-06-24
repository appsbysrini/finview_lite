import 'holding.dart';

/// The user's complete portfolio loaded from local JSON.
class UserPortfolio {
  /// Creates a [UserPortfolio] with summary metrics and holdings.
  const UserPortfolio({
    required this.user,
    required this.portfolioValue,
    required this.totalGain,
    required this.holdings,
  });

  /// Display name of the portfolio owner.
  final String user;

  /// Total current portfolio value from JSON.
  final double portfolioValue;

  /// Total gain across the portfolio from JSON.
  final double totalGain;

  /// List of individual holdings; may be empty.
  final List<Holding> holdings;

  /// Parses a [UserPortfolio] from JSON, falling back to safe defaults for null fields.
  factory UserPortfolio.fromJson(Map<String, dynamic> json) {
    final holdingsJson = json['holdings'];
    final holdings = holdingsJson is List
        ? holdingsJson
            .whereType<Map<String, dynamic>>()
            .map(Holding.fromJson)
            .toList()
        : <Holding>[];

    return UserPortfolio(
      user: json['user'] as String? ?? '',
      portfolioValue: _parseDouble(json['portfolio_value']),
      totalGain: _parseDouble(json['total_gain']),
      holdings: holdings,
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
