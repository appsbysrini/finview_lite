import 'package:flutter/material.dart';

/// Vertical spacing between empty-state icon and title.
const _iconSpacing = 16.0;

/// Vertical spacing between title and subtitle.
const _titleSpacing = 8.0;

/// Placeholder shown when the portfolio has no holdings.
class EmptyStateWidget extends StatelessWidget {
  /// Creates an empty-state view with a default holdings message.
  const EmptyStateWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: _iconSpacing * 2),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.pie_chart_outline,
            size: theme.textTheme.headlineLarge?.fontSize,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: _iconSpacing),
          Text(
            'No holdings yet',
            style: theme.textTheme.titleMedium,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: _titleSpacing),
          Text(
            'Add investments to see them listed here.',
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
