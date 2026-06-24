import 'package:flutter/material.dart';

/// Vertical padding around the placeholder content.
const _verticalPadding = 24.0;

/// Spacing between icon and title text.
const _iconSpacing = 12.0;

/// Placeholder shown when chart data is empty or all values are zero.
class ChartNoDataPlaceholder extends StatelessWidget {
  /// Creates a chart placeholder with a default message.
  const ChartNoDataPlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _verticalPadding),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.donut_large_outlined,
            size: theme.textTheme.headlineMedium?.fontSize,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: _iconSpacing),
          Text(
            'No Data',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _iconSpacing / 2),
          Text(
            'Allocation requires holdings with a current value.',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
