import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/holding.dart';
import '../providers/return_toggle_provider.dart';
import '../providers/sort_provider.dart';
import 'empty_state.dart';
import 'holding_card.dart';
import 'return_toggle.dart';

/// Vertical spacing between major sections in the holdings list.
const _sectionSpacing = 16.0;

/// Vertical spacing between individual holding cards.
const _cardSpacing = 12.0;

/// Sorts [holdings] according to the active [HoldingSort] option.
List<Holding> sortHoldings(List<Holding> holdings, HoldingSort sort) {
  final sorted = List<Holding>.from(holdings);

  switch (sort) {
    case HoldingSort.byValue:
      sorted.sort((a, b) => b.currentValue.compareTo(a.currentValue));
    case HoldingSort.byGain:
      sorted.sort((a, b) => b.gainAmount.compareTo(a.gainAmount));
    case HoldingSort.byName:
      sorted.sort((a, b) => a.name.compareTo(b.name));
  }

  return sorted;
}

/// Section containing sort controls, return toggle, and holding cards.
class HoldingsList extends ConsumerWidget {
  /// Creates a list view for the given [holdings].
  const HoldingsList({
    super.key,
    required this.holdings,
  });

  /// Raw holdings from the loaded portfolio.
  final List<Holding> holdings;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final displayMode = ref.watch(returnToggleProvider);
    final sortedHoldings = sortHoldings(holdings, sort);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        _HoldingsListHeader(sort: sort),
        const SizedBox(height: _sectionSpacing),
        if (sortedHoldings.isEmpty)
          const EmptyStateWidget()
        else
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: sortedHoldings.length,
            separatorBuilder: (context, _) =>
                const SizedBox(height: _cardSpacing),
            itemBuilder: (context, index) {
              return HoldingCard(
                holding: sortedHoldings[index],
                displayMode: displayMode,
              );
            },
          ),
      ],
    );
  }
}

class _HoldingsListHeader extends ConsumerWidget {
  const _HoldingsListHeader({
    required this.sort,
  });

  final HoldingSort sort;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Row(
          children: [
            Text(
              'Holdings',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
            const ReturnToggle(),
          ],
        ),
        const SizedBox(height: _sectionSpacing),
        SegmentedButton<HoldingSort>(
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
      ],
    );
  }
}
