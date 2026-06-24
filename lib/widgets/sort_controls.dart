import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/sort_provider.dart';

/// Segmented control for selecting holdings sort order.
class SortControls extends ConsumerWidget {
  /// Creates sort controls bound to [sortProvider].
  const SortControls({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<HoldingSort>(
        segments: const [
          ButtonSegment(
            value: HoldingSort.byValue,
            label: Text('Value'),
          ),
          ButtonSegment(
            value: HoldingSort.byGain,
            label: Text('Gain'),
          ),
          ButtonSegment(
            value: HoldingSort.byName,
            label: Text('Name'),
          ),
        ],
        selected: {sort},
        onSelectionChanged: (selection) {
          ref.read(sortProvider.notifier).state = selection.first;
        },
      ),
    );
  }
}
