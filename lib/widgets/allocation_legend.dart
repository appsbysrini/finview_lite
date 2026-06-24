import 'package:flutter/material.dart';

import '../models/allocation_slice.dart';
import '../utils/formatters.dart';

/// Size of the color swatch beside each legend item.
const _swatchSize = 12.0;

/// Horizontal spacing between swatch and legend text.
const _swatchSpacing = 8.0;

/// Vertical spacing between legend rows.
const _rowSpacing = 8.0;

/// Vertical spacing within a stacked legend item.
const _itemSpacing = 2.0;

/// Legend listing allocation symbols, values, and percentages.
class AllocationLegend extends StatelessWidget {
  /// Creates a legend for the given [slices].
  const AllocationLegend({
    super.key,
    required this.slices,
  });

  /// Allocation slices shown in the legend.
  final List<AllocationSlice> slices;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: slices.map((slice) {
        return Padding(
          padding: const EdgeInsets.only(bottom: _rowSpacing),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(top: _itemSpacing),
                child: Container(
                  width: _swatchSize,
                  height: _swatchSize,
                  decoration: BoxDecoration(
                    color: slice.color,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
              const SizedBox(width: _swatchSpacing),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      slice.symbol,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: _itemSpacing),
                    Text(
                      '${formatSharePercent(slice.percentage)} · ${formatCurrency(slice.value)}',
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }
}
