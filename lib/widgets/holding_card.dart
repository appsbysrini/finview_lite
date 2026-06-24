import 'package:flutter/material.dart';

import '../models/holding.dart';
import '../providers/return_toggle_provider.dart';
import '../utils/animation_constants.dart';
import '../utils/app_design_tokens.dart';
import '../utils/formatters.dart';
import '../utils/gain_display.dart';
import 'gain_pill.dart';
import 'ticker_avatar.dart';

/// Row showing a single holding's value and return inside a grouped list.
class HoldingCard extends StatelessWidget {
  /// Creates a row for [holding] using the given [displayMode].
  const HoldingCard({
    super.key,
    required this.holding,
    required this.displayMode,
    this.showDivider = true,
  });

  /// Holding data rendered in the row.
  final Holding holding;

  /// Whether to show return as currency or percentage.
  final ReturnDisplayMode displayMode;

  /// Whether to render a bottom divider after the row.
  final bool showDivider;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;
    final returnText = formatReturnValue(
      gainAmount: holding.gainAmount,
      gainPercent: holding.gainPercent,
      displayMode: displayMode,
    );

    return Semantics(
      label:
          '${holding.symbol}, ${holding.name}, value ${formatCurrency(holding.currentValue)}, return $returnText',
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDesignTokens.spaceMd,
              vertical: AppDesignTokens.spaceMd,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                TickerAvatar(symbol: holding.symbol),
                const SizedBox(width: AppDesignTokens.spaceMd),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        holding.symbol,
                        style: theme.textTheme.titleSmall,
                      ),
                      const SizedBox(height: AppDesignTokens.spaceXs),
                      Text(
                        holding.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: AppDesignTokens.spaceSm),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      formatCurrency(holding.currentValue),
                      style: AppDesignTokens.tabularFigures(
                        theme.textTheme.titleSmall!,
                      ),
                    ),
                    const SizedBox(height: AppDesignTokens.spaceXs),
                    AnimatedSwitcher(
                      duration: AnimationConstants.medium,
                      switchInCurve: AnimationConstants.entranceCurve,
                      child: GainPill(
                        key: ValueKey<String>(returnText),
                        amount: holding.gainAmount,
                        label: returnText,
                        showIcon: false,
                        compact: true,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          if (showDivider)
            Divider(
              height: 1,
              thickness: AppDesignTokens.borderWidth,
              color: finView.borderSubtle,
              indent: AppDesignTokens.spaceMd,
              endIndent: AppDesignTokens.spaceMd,
            ),
        ],
      ),
    );
  }
}
