import 'dart:convert';

import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_portfolio.dart';
import '../utils/portfolio_simulator.dart';
import 'portfolio_refresh_provider.dart';

/// Asset path for the bundled portfolio JSON file.
const portfolioAssetPath = 'assets/portfolio.json';

/// Loads and exposes the user's portfolio from local assets.
class PortfolioNotifier extends AsyncNotifier<UserPortfolio> {
  /// Loads the bundled portfolio JSON when the provider is first watched.
  @override
  Future<UserPortfolio> build() async {
    return _loadPortfolio();
  }

  /// Simulates a portfolio refresh with updated holding prices.
  Future<void> refresh() async {
    final currentPortfolio = state.value;
    if (currentPortfolio == null) {
      state = const AsyncLoading<UserPortfolio>();
      state = await AsyncValue.guard(_loadPortfolio);
      return;
    }

    ref.read(portfolioRefreshingProvider.notifier).setRefreshing(true);

    try {
      await simulateRefreshDelay();
      final refreshedPortfolio = simulatePriceRefresh(currentPortfolio);
      state = AsyncData(refreshedPortfolio);
    } catch (error, stackTrace) {
      state = AsyncError(error, stackTrace);
    } finally {
      ref.read(portfolioRefreshingProvider.notifier).setRefreshing(false);
    }
  }

  /// Reads and parses [portfolioAssetPath] into a [UserPortfolio].
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
