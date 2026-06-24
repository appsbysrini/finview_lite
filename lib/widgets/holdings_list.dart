import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/holding.dart';
import '../providers/return_toggle_provider.dart';
import '../providers/sort_provider.dart';
import '../utils/layout_constants.dart';
import 'animated_appearance.dart';
import 'empty_state.dart';
import 'holding_card.dart';
import 'return_toggle.dart';
import 'responsive_layout.dart';

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

    return AnimatedAppearance(
      index: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const HoldingsListHeader(),
          const SizedBox(height: _sectionSpacing),
          if (sortedHoldings.isEmpty)
            const EmptyStateWidget()
          else
            _AnimatedHoldingsCards(
              holdings: sortedHoldings,
              displayMode: displayMode,
            ),
        ],
      ),
    );
  }
}

/// Header row with responsive layout for title and controls.
class HoldingsListHeader extends ConsumerWidget {
  /// Creates the holdings section header.
  const HoldingsListHeader({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);

    return LayoutBuilder(
      builder: (context, constraints) {
        final stackControls = shouldStackControls(constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (stackControls)
              _StackedHoldingsTitleRow()
            else
              const _InlineHoldingsTitleRow(),
            const SizedBox(height: _sectionSpacing),
            SingleChildScrollView(
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
            ),
          ],
        );
      },
    );
  }
}

class _InlineHoldingsTitleRow extends StatelessWidget {
  const _InlineHoldingsTitleRow();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Flexible(
          child: Text(
            'Holdings',
            overflow: TextOverflow.ellipsis,
            style: theme.textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        const SizedBox(width: LayoutConstants.columnSpacing / 2),
        const ReturnToggle(),
      ],
    );
  }
}

class _StackedHoldingsTitleRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          'Holdings',
          style: theme.textTheme.titleLarge?.copyWith(
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: _sectionSpacing / 2),
        const Align(
          alignment: Alignment.centerLeft,
          child: ReturnToggle(),
        ),
      ],
    );
  }
}

class _AnimatedHoldingsCards extends StatelessWidget {
  const _AnimatedHoldingsCards({
    required this.holdings,
    required this.displayMode,
  });

  final List<Holding> holdings;
  final ReturnDisplayMode displayMode;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: holdings.length,
      separatorBuilder: (context, _) => const SizedBox(height: _cardSpacing),
      itemBuilder: (context, index) {
        return AnimatedAppearance(
          index: index + 2,
          child: HoldingCard(
            holding: holdings[index],
            displayMode: displayMode,
          ),
        );
      },
    );
  }
}
