import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_portfolio.dart';
import '../providers/auth_provider.dart';
import '../providers/portfolio_provider.dart';
import '../providers/portfolio_refresh_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/layout_constants.dart';
import '../widgets/app_loading_indicator.dart';
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
    final isRefreshing = ref.watch(portfolioRefreshingProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('FinView Lite'),
        actions: [
          if (isRefreshing)
            const Padding(
              padding: EdgeInsets.only(right: 8),
              child: AppLoadingIndicator(),
            ),
          IconButton(
            tooltip: isDarkMode ? 'Switch to light mode' : 'Switch to dark mode',
            onPressed: () {
              ref.read(themeModeProvider.notifier).toggle();
            },
            icon: Icon(
              isDarkMode ? Icons.light_mode_outlined : Icons.dark_mode_outlined,
            ),
          ),
          IconButton(
            tooltip: 'Sign out',
            onPressed: () {
              ref.read(authProvider.notifier).logout();
            },
            icon: const Icon(Icons.logout),
          ),
        ],
      ),
      body: portfolioAsync.when(
        loading: () => const Center(
          child: AppLoadingIndicator(),
        ),
        error: (error, stackTrace) => PortfolioErrorView(
          message: error.toString(),
        ),
        data: (portfolio) => _PortfolioContent(
          portfolio: portfolio,
          isRefreshing: isRefreshing,
        ),
      ),
    );
  }
}

class _PortfolioContent extends ConsumerWidget {
  const _PortfolioContent({
    required this.portfolio,
    required this.isRefreshing,
  });

  final UserPortfolio portfolio;
  final bool isRefreshing;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => ref.read(portfolioProvider.notifier).refresh(),
          semanticsLabel: 'Refresh portfolio',
          child: SafeArea(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.all(LayoutConstants.screenPadding),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PortfolioHeader(portfolio: portfolio),
                        const SizedBox(
                          height: LayoutConstants.sectionSpacing,
                        ),
                        DashboardBody(portfolio: portfolio),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        if (isRefreshing)
          const Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: LinearProgressIndicator(minHeight: 3),
          ),
      ],
    );
  }
}
