import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/user_portfolio.dart';
import '../providers/auth_provider.dart';
import '../providers/portfolio_provider.dart';
import '../providers/portfolio_refresh_provider.dart';
import '../providers/theme_provider.dart';
import '../utils/app_design_tokens.dart';
import '../utils/layout_constants.dart';
import '../widgets/dashboard_body.dart';
import '../widgets/dashboard_header.dart';
import '../widgets/dashboard_loading_view.dart';
import '../widgets/portfolio_error_view.dart';
import '../widgets/portfolio_header.dart';

/// Main dashboard screen showing portfolio summary data.
class DashboardScreen extends ConsumerWidget {
  /// Creates the dashboard that watches [portfolioProvider].
  const DashboardScreen({super.key});

  /// Builds the dashboard scaffold with header and portfolio body.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);
    final isRefreshing = ref.watch(portfolioRefreshingProvider);
    final isDarkMode = ref.watch(isDarkModeProvider);

    return Scaffold(
      appBar: DashboardHeader(
        isDarkMode: isDarkMode,
        isRefreshing: isRefreshing,
        onToggleTheme: () {
          ref.read(themeModeProvider.notifier).toggle();
        },
        onSignOut: () {
          ref.read(authProvider.notifier).logout();
        },
      ),
      body: portfolioAsync.when(
        loading: () => const DashboardLoadingView(),
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

/// Scrollable portfolio content with pull-to-refresh support.
class _PortfolioContent extends ConsumerWidget {
  /// Creates scrollable content for [portfolio].
  const _PortfolioContent({
    required this.portfolio,
    required this.isRefreshing,
  });

  final UserPortfolio portfolio;
  final bool isRefreshing;

  /// Builds the refreshable portfolio summary and dashboard sections.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Stack(
      children: [
        RefreshIndicator(
          onRefresh: () => ref.read(portfolioProvider.notifier).refresh(),
          semanticsLabel: 'Refresh portfolio',
          color: theme.colorScheme.secondary,
          child: SafeArea(
            child: CustomScrollView(
              physics: const AlwaysScrollableScrollPhysics(),
              slivers: [
                SliverPadding(
                  padding: const EdgeInsets.fromLTRB(
                    LayoutConstants.screenPadding,
                    AppDesignTokens.spaceSm,
                    LayoutConstants.screenPadding,
                    LayoutConstants.screenPadding,
                  ),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        PortfolioHeader(portfolio: portfolio),
                        const SizedBox(
                          height: AppDesignTokens.spaceSection,
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
          Positioned(
            left: 0,
            right: 0,
            top: 0,
            child: LinearProgressIndicator(
              minHeight: 2,
              color: theme.colorScheme.secondary,
              backgroundColor: theme.finView.borderSubtle,
            ),
          ),
      ],
    );
  }
}
