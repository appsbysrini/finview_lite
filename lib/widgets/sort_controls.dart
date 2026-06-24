import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/sort_provider.dart';
import '../utils/app_design_tokens.dart';

/// Sort menu button for selecting holdings sort order.
class SortControls extends ConsumerWidget {
  /// Creates sort controls bound to [sortProvider].
  const SortControls({super.key});

  /// Returns a user-facing label for [sort].
  static String labelFor(HoldingSort sort) {
    return switch (sort) {
      HoldingSort.byValue => 'Value',
      HoldingSort.byGain => 'Gains',
      HoldingSort.byName => 'Name',
    };
  }

  /// Builds the sort icon menu for holdings ordering.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final theme = Theme.of(context);

    return PopupMenuButton<HoldingSort>(
      tooltip: 'Sort holdings',
      initialValue: sort,
      padding: EdgeInsets.zero,
      constraints: const BoxConstraints(
        minWidth: AppDesignTokens.spaceXl,
        minHeight: AppDesignTokens.spaceXl,
      ),
      onSelected: (selectedSort) {
        ref.read(sortProvider.notifier).setSort(selectedSort);
      },
      icon: Icon(
        Icons.sort_rounded,
        size: 22,
        color: theme.colorScheme.onSurfaceVariant,
      ),
      itemBuilder: (context) {
        return holdingSortMenuOptions.map((option) {
          return PopupMenuItem<HoldingSort>(
            value: option,
            child: Row(
              children: [
                if (sort == option)
                  Icon(
                    Icons.check,
                    size: 18,
                    color: theme.colorScheme.secondary,
                  )
                else
                  const SizedBox(width: 18),
                const SizedBox(width: AppDesignTokens.spaceSm),
                Text(labelFor(option)),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}
