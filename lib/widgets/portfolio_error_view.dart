import 'package:flutter/material.dart';

import 'status_view.dart';

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

    return Semantics(
      liveRegion: true,
      child: StatusView(
        icon: Icons.error_outline_rounded,
        iconColor: theme.colorScheme.error,
        title: title,
        message: message,
      ),
    );
  }
}
