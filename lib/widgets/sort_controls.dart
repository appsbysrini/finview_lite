import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/sort_provider.dart';
import '../utils/app_design_tokens.dart';

/// Segmented control for selecting holdings sort order.
class SortControls extends ConsumerWidget {
  /// Creates sort controls bound to [sortProvider].
  const SortControls({super.key});

  /// Builds the value, gain, and name sort segmented control.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final theme = Theme.of(context);
    final finView = theme.finView;

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: SegmentedButton<HoldingSort>(
        style: SegmentedButton.styleFrom(
          backgroundColor: theme.colorScheme.surface,
          selectedBackgroundColor: finView.surfaceMuted,
          foregroundColor: theme.colorScheme.onSurfaceVariant,
          selectedForegroundColor: theme.colorScheme.onSurface,
          side: BorderSide(color: finView.borderSubtle),
          padding: const EdgeInsets.symmetric(
            horizontal: AppDesignTokens.spaceSm,
            vertical: AppDesignTokens.spaceXs,
          ),
        ),
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
          ref.read(sortProvider.notifier).setSort(selection.first);
        },
      ),
    );
  }
}
