import 'package:flutter/material.dart';

import '../models/allocation_slice.dart';
import '../utils/app_design_tokens.dart';
import '../utils/formatters.dart';

/// Legend listing allocation symbols, values, and percentages.
class AllocationLegend extends StatelessWidget {
  /// Creates a legend for the given [slices].
  const AllocationLegend({
    super.key,
    required this.slices,
  });

  /// Allocation slices shown in the legend.
  final List<AllocationSlice> slices;

  /// Builds the symbol, percentage, and value rows for each slice.
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: slices.map((slice) {
        return Padding(
          padding: const EdgeInsets.only(bottom: AppDesignTokens.spaceSm),
          child: Row(
            children: [
              Container(
                width: 8,
                height: 8,
                decoration: BoxDecoration(
                  color: slice.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
              const SizedBox(width: AppDesignTokens.spaceSm),
              Expanded(
                child: Text(
                  slice.symbol,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              Text(
                formatSharePercent(slice.percentage),
                style: AppDesignTokens.tabularFigures(
                  theme.textTheme.bodySmall!.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
              const SizedBox(width: AppDesignTokens.spaceMd),
              SizedBox(
                width: 72,
                child: Text(
                  formatCurrency(slice.value),
                  textAlign: TextAlign.end,
                  overflow: TextOverflow.ellipsis,
                  style: AppDesignTokens.tabularFigures(
                    theme.textTheme.bodySmall!.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
