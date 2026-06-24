import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_portfolio.dart';

/// Asset path for the bundled portfolio JSON file.
const portfolioAssetPath = 'assets/portfolio.json';

/// Loads and exposes the user's portfolio from local assets.
class PortfolioNotifier extends AsyncNotifier<UserPortfolio> {
  @override
  Future<UserPortfolio> build() async {
    return _loadPortfolio();
  }

  /// Reloads portfolio data from [portfolioAssetPath].
  Future<void> refresh() async {
    state = const AsyncLoading<UserPortfolio>();
    state = await AsyncValue.guard(_loadPortfolio);
  }

  Future<UserPortfolio> _loadPortfolio() async {
    final jsonString = await rootBundle.loadString(portfolioAssetPath);
    final decoded = jsonDecode(jsonString);

    if (decoded is! Map<String, dynamic>) {
      throw FormatException(
        'Expected portfolio JSON object, got ${decoded.runtimeType}',
      );
    }

    return UserPortfolio.fromJson(decoded);
  }
}

/// Provider that asynchronously loads [UserPortfolio] from assets.
final portfolioProvider =
    AsyncNotifierProvider<PortfolioNotifier, UserPortfolio>(
  PortfolioNotifier.new,
);
