import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';
import '../utils/gain_display.dart';

/// Compact pill badge showing a formatted gain or loss value.
class GainPill extends StatelessWidget {
  /// Creates a gain pill for the given [amount] and [label].
  const GainPill({
    super.key,
    required this.amount,
    required this.label,
    this.showIcon = true,
    this.compact = false,
  });

  /// Numeric gain or loss used to pick semantic colors.
  final double amount;

  /// Formatted text shown inside the pill.
  final String label;

  /// Whether to show a trending icon beside the label.
  final bool showIcon;

  /// Whether to use a lighter, border-only style.
  final bool compact;

  /// Builds a compact or filled pill styled by gain/loss semantics.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final finView = theme.finView;
    final isPositive = amount >= 0;
    final foregroundColor = gainColorFor(theme, amount);

    if (compact) {
      return Text(
        label,
        style: AppDesignTokens.tabularFigures(
          theme.textTheme.labelMedium!.copyWith(
            color: foregroundColor,
            fontWeight: FontWeight.w600,
          ),
        ),
      );
    }

    final backgroundColor =
        isPositive ? finView.profitContainer : finView.lossContainer;

    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDesignTokens.spaceSm,
        vertical: AppDesignTokens.spaceXs,
      ),
      decoration: BoxDecoration(
        color: backgroundColor,
        borderRadius: BorderRadius.circular(AppDesignTokens.radiusPill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (showIcon) ...[
            Icon(
              isPositive
                  ? Icons.trending_up_rounded
                  : Icons.trending_down_rounded,
              size: 14,
              color: foregroundColor,
              semanticLabel: isPositive ? 'Gain' : 'Loss',
            ),
            const SizedBox(width: AppDesignTokens.spaceXs),
          ],
          Text(
            label,
            style: AppDesignTokens.tabularFigures(
              theme.textTheme.labelMedium!.copyWith(
                color: foregroundColor,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
