import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Tracks whether a portfolio refresh simulation is currently running.
class PortfolioRefreshingNotifier extends Notifier<bool> {
  /// Returns false when the provider is first watched.
  @override
  bool build() => false;

  /// Updates whether a portfolio refresh is in progress.
  void setRefreshing(bool isRefreshing) {
    state = isRefreshing;
  }
}

/// Whether a portfolio refresh simulation is currently running.
final portfolioRefreshingProvider =
    NotifierProvider<PortfolioRefreshingNotifier, bool>(
  PortfolioRefreshingNotifier.new,
);
