import 'package:flutter/material.dart';

import 'status_view.dart';

/// Placeholder shown when the portfolio has no holdings.
class EmptyStateWidget extends StatelessWidget {
  /// Creates an empty-state view with a default holdings message.
  const EmptyStateWidget({super.key});

  /// Builds the empty holdings placeholder via [StatusView].
  @override
  Widget build(BuildContext context) {
    return const StatusView(
      icon: Icons.pie_chart_outline_rounded,
      title: 'No holdings yet',
      message: 'Add investments to see them listed here.',
    );
  }
}
