import 'package:flutter/material.dart';

import '../models/user_portfolio.dart';
import '../utils/formatters.dart';

/// Horizontal padding applied inside the portfolio summary card.
const _cardPadding = 20.0;

/// Vertical spacing between sections inside the card.
const _sectionSpacing = 8.0;

/// Corner radius for the portfolio summary card.
const _cardRadius = 16.0;

/// Card displaying portfolio owner, total value, and overall gain metrics.
class PortfolioHeader extends StatelessWidget {
  /// Creates a header for the given [portfolio].
  const PortfolioHeader({
    super.key,
    required this.portfolio,
  });

  /// Portfolio data shown in the summary card.
  final UserPortfolio portfolio;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final gainPercent = _portfolioGainPercent(portfolio);
    final isPositiveGain = portfolio.totalGain >= 0;
    final gainColor = isPositiveGain
        ? theme.colorScheme.primary
        : theme.colorScheme.error;

    return Card(
      elevation: 0,
      color: theme.colorScheme.primaryContainer.withValues(alpha: 0.35),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Portfolio',
              style: theme.textTheme.labelLarge?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: _sectionSpacing),
            Text(
              portfolio.user,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: _sectionSpacing * 2),
            Text(
              formatCurrency(portfolio.portfolioValue),
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: _sectionSpacing * 1.5),
            Row(
              children: [
                Icon(
                  isPositiveGain ? Icons.trending_up : Icons.trending_down,
                  size: theme.textTheme.titleMedium?.fontSize,
                  color: gainColor,
                ),
                const SizedBox(width: _sectionSpacing),
                Text(
                  '${formatGainAmount(portfolio.totalGain)} (${formatPercent(gainPercent)})',
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: gainColor,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
            const SizedBox(height: _sectionSpacing),
            Text(
              'Total return',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      ),
    );
  }

  double _portfolioGainPercent(UserPortfolio portfolio) {
    final investedValue = portfolio.portfolioValue - portfolio.totalGain;
    if (investedValue == 0) {
      return 0.0;
    }
    return (portfolio.totalGain / investedValue) * 100;
  }
}
