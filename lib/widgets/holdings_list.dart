import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/holding.dart';
import '../providers/return_toggle_provider.dart';
import '../providers/sort_provider.dart';
import '../utils/holding_sorter.dart';
import '../utils/layout_constants.dart';
import 'animated_appearance.dart';
import 'empty_state.dart';
import 'holding_card.dart';
import 'return_toggle.dart';
import 'responsive_layout.dart';
import 'sort_controls.dart';

/// Vertical spacing between major sections in the holdings list.
const _sectionSpacing = 16.0;

/// Vertical spacing between individual holding cards.
const _cardSpacing = 12.0;

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
class HoldingsListHeader extends StatelessWidget {
  /// Creates the holdings section header.
  const HoldingsListHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final stackControls = shouldStackControls(constraints.maxWidth);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (stackControls)
              const _StackedHoldingsTitleRow()
            else
              const _InlineHoldingsTitleRow(),
            const SizedBox(height: _sectionSpacing),
            const SortControls(),
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
  const _StackedHoldingsTitleRow();

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
        final holding = holdings[index];
        return AnimatedAppearance(
          key: ValueKey<String>(holding.symbol),
          index: index + 2,
          child: HoldingCard(
            holding: holding,
            displayMode: displayMode,
          ),
        );
      },
    );
  }
}
