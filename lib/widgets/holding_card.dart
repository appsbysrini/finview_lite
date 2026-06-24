import 'package:flutter/material.dart';

import '../models/holding.dart';
import '../providers/return_toggle_provider.dart';
import '../utils/animation_constants.dart';
import '../utils/formatters.dart';

/// Internal padding for a holding card.
const _cardPadding = 16.0;

/// Corner radius for a holding card.
const _cardRadius = 12.0;

/// Spacing between symbol and company name rows.
const _rowSpacing = 4.0;

/// Card showing a single holding's value and return.
class HoldingCard extends StatelessWidget {
  /// Creates a card for [holding] using the given [displayMode].
  const HoldingCard({
    super.key,
    required this.holding,
    required this.displayMode,
  });

  /// Holding data rendered in the card.
  final Holding holding;

  /// Whether to show return as currency or percentage.
  final ReturnDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isPositiveGain = holding.gainAmount >= 0;
    final gainColor = isPositiveGain
        ? theme.colorScheme.primary
        : theme.colorScheme.error;
    final returnText = displayMode == ReturnDisplayMode.amount
        ? formatGainAmount(holding.gainAmount)
        : formatPercent(holding.gainPercent);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_cardPadding),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    holding.symbol,
                    style: theme.textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: _rowSpacing),
                  Text(
                    holding.name,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  formatCurrency(holding.currentValue),
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: _rowSpacing),
                AnimatedSwitcher(
                  duration: AnimationConstants.medium,
                  switchInCurve: AnimationConstants.entranceCurve,
                  child: Text(
                    returnText,
                    key: ValueKey<String>(returnText),
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: gainColor,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
