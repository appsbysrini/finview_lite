import 'package:flutter/material.dart';

import '../utils/layout_constants.dart';

/// Full-screen error state shown when loading fails.
class PortfolioErrorView extends StatelessWidget {
  /// Creates an error view with the given [message].
  const PortfolioErrorView({
    super.key,
    required this.message,
    this.title = 'Unable to load portfolio',
  });

  /// Title shown above the error detail.
  final String title;

  /// Error detail shown below the title.
  final String message;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(LayoutConstants.screenPadding * 1.5),
        child: Semantics(
          liveRegion: true,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.error_outline,
                size: theme.textTheme.headlineMedium?.fontSize,
                color: theme.colorScheme.error,
                semanticLabel: 'Error',
              ),
              const SizedBox(height: LayoutConstants.sectionSpacing),
              Text(
                title,
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
      ),
    );
  }
}
