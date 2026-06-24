import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_portfolio.dart';
import '../providers/portfolio_provider.dart';
import '../widgets/holdings_list.dart';
import '../widgets/portfolio_header.dart';

/// Outer padding around dashboard content.
const _screenPadding = 16.0;

/// Main dashboard screen showing portfolio summary data.
class DashboardScreen extends ConsumerWidget {
  /// Creates the dashboard that watches [portfolioProvider].
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinView Lite'),
      ),
      body: portfolioAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stackTrace) => _PortfolioErrorView(
          message: error.toString(),
        ),
        data: (portfolio) => _PortfolioContent(portfolio: portfolio),
      ),
    );
  }
}

class _PortfolioContent extends StatelessWidget {
  const _PortfolioContent({required this.portfolio});

  final UserPortfolio portfolio;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(_screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PortfolioHeader(portfolio: portfolio),
            const SizedBox(height: _screenPadding),
            HoldingsList(holdings: portfolio.holdings),
          ],
        ),
      ),
    );
  }
}

class _PortfolioErrorView extends StatelessWidget {
  const _PortfolioErrorView({required this.message});

  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(_screenPadding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: theme.textTheme.headlineMedium?.fontSize,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: _screenPadding),
            Text(
              'Unable to load portfolio',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: _screenPadding / 2),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
