import 'package:flutter/material.dart';

import '../models/user_portfolio.dart';
import '../utils/animation_constants.dart';
import '../utils/formatters.dart';
import '../utils/gain_display.dart';
import 'animated_appearance.dart';

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
    final gainColor = gainColorFor(theme, portfolio.totalGain);
    final isPositiveGain = portfolio.totalGain >= 0;
    final gainSummary =
        '${formatGainAmount(portfolio.totalGain)} (${formatPercent(portfolio.gainPercent)})';

    return AnimatedAppearance(
      child: Semantics(
        container: true,
        label: 'Portfolio summary for ${portfolio.user}',
        child: Card(
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
                AnimatedValueText(
                  valueKey: portfolio.user,
                  text: portfolio.user,
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: _sectionSpacing * 2),
                AnimatedValueText(
                  valueKey: portfolio.portfolioValue,
                  text: formatCurrency(portfolio.portfolioValue),
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: _sectionSpacing * 1.5),
                Row(
                  children: [
                    AnimatedSwitcher(
                      duration: AnimationConstants.medium,
                      child: Icon(
                        isPositiveGain
                            ? Icons.trending_up
                            : Icons.trending_down,
                        key: ValueKey<bool>(isPositiveGain),
                        size: theme.textTheme.titleMedium?.fontSize,
                        color: gainColor,
                        semanticLabel: isPositiveGain
                            ? 'Portfolio gain'
                            : 'Portfolio loss',
                      ),
                    ),
                    const SizedBox(width: _sectionSpacing),
                    Flexible(
                      child: AnimatedValueText(
                        valueKey: gainSummary,
                        text: gainSummary,
                        style: theme.textTheme.titleMedium?.copyWith(
                          color: gainColor,
                          fontWeight: FontWeight.w600,
                        ),
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
        ),
      ),
    );
  }
}
