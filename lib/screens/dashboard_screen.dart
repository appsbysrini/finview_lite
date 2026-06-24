import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_portfolio.dart';
import '../providers/portfolio_provider.dart';
import '../utils/layout_constants.dart';
import '../widgets/dashboard_body.dart';
import '../widgets/portfolio_error_view.dart';
import '../widgets/portfolio_header.dart';

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
        error: (error, stackTrace) => PortfolioErrorView(
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
        padding: const EdgeInsets.all(LayoutConstants.screenPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            PortfolioHeader(portfolio: portfolio),
            const SizedBox(height: LayoutConstants.sectionSpacing),
            DashboardBody(portfolio: portfolio),
          ],
        ),
      ),
    );
  }
}
