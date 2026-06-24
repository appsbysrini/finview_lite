import 'package:flutter/material.dart';

import 'status_view.dart';

/// Placeholder shown when chart data is empty or all values are zero.
class ChartNoDataPlaceholder extends StatelessWidget {
  /// Creates a chart placeholder with a default message.
  const ChartNoDataPlaceholder({super.key});

  /// Builds the embedded chart no-data placeholder.
  @override
  Widget build(BuildContext context) {
    return const StatusView(
      embedded: true,
      icon: Icons.donut_large_outlined,
      title: 'No data',
      message: 'Allocation requires holdings with a current value.',
    );
  }
}
