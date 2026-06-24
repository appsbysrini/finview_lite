import '../utils/json_parser.dart';
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

  /// Total amount invested, derived from value and gain.
  double get investedValue => portfolioValue - totalGain;

  /// Percentage gain or loss relative to [investedValue].
  double get gainPercent {
    if (investedValue == 0) {
      return 0.0;
    }
    return (totalGain / investedValue) * 100;
  }

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
      portfolioValue: parseJsonDouble(json['portfolio_value']),
      totalGain: parseJsonDouble(json['total_gain']),
      holdings: holdings,
    );
  }
}
