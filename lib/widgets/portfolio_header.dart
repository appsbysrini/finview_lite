import 'package:flutter/material.dart';

import '../models/user_portfolio.dart';
import '../utils/app_design_tokens.dart';
import '../utils/formatters.dart';
import '../utils/gain_display.dart';
import 'animated_appearance.dart';
import 'finview_card.dart';
import 'gain_pill.dart';

/// Portfolio summary showing owner, total value, and return statistics.
class PortfolioHeader extends StatelessWidget {
  /// Creates a header for the given [portfolio].
  const PortfolioHeader({
    super.key,
    required this.portfolio,
  });

  /// Portfolio data shown in the summary card.
  final UserPortfolio portfolio;

  /// Builds the portfolio summary card with value and statistics.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;
    final gainSummary =
        '${formatGainAmount(portfolio.totalGain)} (${formatPercent(portfolio.gainPercent)})';

    return AnimatedAppearance(
      child: Semantics(
        label: 'Portfolio summary for ${portfolio.user}',
        container: true,
        explicitChildNodes: true,
        child: FinViewCard(
          padding: const EdgeInsets.all(AppDesignTokens.spaceLg),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                portfolio.user,
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spaceSm),
              AnimatedValueText(
                valueKey: portfolio.portfolioValue,
                text: formatCurrency(portfolio.portfolioValue),
                style: AppDesignTokens.tabularFigures(
                  theme.textTheme.headlineMedium!,
                ),
              ),
              const SizedBox(height: AppDesignTokens.spaceMd),
              GainPill(
                amount: portfolio.totalGain,
                label: gainSummary,
              ),
              const SizedBox(height: AppDesignTokens.spaceLg),
              Divider(color: finView.borderSubtle, height: 1),
              const SizedBox(height: AppDesignTokens.spaceMd),
              _PortfolioStatsRow(portfolio: portfolio),
            ],
          ),
        ),
      ),
    );
  }
}

/// Secondary statistics shown beneath the portfolio value.
class _PortfolioStatsRow extends StatelessWidget {
  /// Creates a row of invested, return, and holdings stats.
  const _PortfolioStatsRow({required this.portfolio});

  final UserPortfolio portfolio;

  /// Builds the three-column statistics row.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final investedValue = portfolio.investedValue;

    return Row(
      children: [
        Expanded(
          child: _StatTile(
            label: 'Total return',
            value: formatPercent(portfolio.gainPercent),
            valueColor: gainColorFor(theme, portfolio.totalGain),
          ),
        ),
        _StatDivider(),
        Expanded(
          child: _StatTile(
            label: 'Invested',
            value: formatCurrency(investedValue),
          ),
        ),
        _StatDivider(),
        Expanded(
          child: _StatTile(
            label: 'Holdings',
            value: '${portfolio.holdings.length}',
          ),
        ),
      ],
    );
  }
}

/// Vertical divider separating stat tiles in the stats row.
class _StatDivider extends StatelessWidget {
  /// Builds a subtle vertical rule between stat columns.
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 1,
      height: 32,
      margin: const EdgeInsets.symmetric(horizontal: AppDesignTokens.spaceSm),
      color: Theme.of(context).finView.borderSubtle,
    );
  }
}

/// Single label-value pair in the portfolio statistics row.
class _StatTile extends StatelessWidget {
  /// Creates a stat tile with optional [valueColor] override.
  const _StatTile({
    required this.label,
    required this.value,
    this.valueColor,
  });

  final String label;
  final String value;
  final Color? valueColor;

  /// Builds the label and value column for one statistic.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: theme.textTheme.labelSmall,
        ),
        const SizedBox(height: AppDesignTokens.spaceXs),
        Text(
          value,
          style: AppDesignTokens.tabularFigures(
            theme.textTheme.titleSmall!.copyWith(
              color: valueColor,
            ),
          ),
        ),
      ],
    );
  }
}
