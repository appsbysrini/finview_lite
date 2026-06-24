import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/return_toggle_provider.dart';

/// Segmented control for switching between ₹ and % return display.
class ReturnToggle extends ConsumerWidget {
  /// Creates a toggle bound to [returnToggleProvider].
  const ReturnToggle({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final displayMode = ref.watch(returnToggleProvider);

    return SegmentedButton<ReturnDisplayMode>(
      segments: const [
        ButtonSegment(
          value: ReturnDisplayMode.amount,
          label: Text('₹'),
        ),
        ButtonSegment(
          value: ReturnDisplayMode.percent,
          label: Text('%'),
        ),
      ],
      selected: {displayMode},
      onSelectionChanged: (selection) {
        ref.read(returnToggleProvider.notifier).state = selection.first;
      },
    );
  }
}
