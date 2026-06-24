import 'package:flutter/material.dart';

import '../utils/layout_constants.dart';

/// Full-screen error state shown when portfolio loading fails.
class PortfolioErrorView extends StatelessWidget {
  /// Creates an error view with the given [message].
  const PortfolioErrorView({
    super.key,
    required this.message,
  });

  /// Error detail shown below the title.
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.screenPadding * 1.5),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.error_outline,
              size: theme.textTheme.headlineMedium?.fontSize,
              color: theme.colorScheme.error,
            ),
            const SizedBox(height: LayoutConstants.sectionSpacing),
            Text(
              'Unable to load portfolio',
              style: theme.textTheme.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: LayoutConstants.sectionSpacing / 2),
            Text(
              message,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
