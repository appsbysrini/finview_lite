import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/holding.dart';
import '../providers/return_toggle_provider.dart';
import '../providers/sort_provider.dart';
import '../utils/app_design_tokens.dart';
import '../utils/holding_sorter.dart';
import 'animated_appearance.dart';
import 'empty_state.dart';
import 'finview_card.dart';
import 'holding_card.dart';
import 'return_toggle.dart';
import 'section_header.dart';
import 'sort_controls.dart';

/// Section containing sort controls, return toggle, and holding rows.
class HoldingsList extends ConsumerWidget {
  /// Creates a list view for the given [holdings].
  const HoldingsList({
    super.key,
    required this.holdings,
  });

  /// Raw holdings from the loaded portfolio.
  final List<Holding> holdings;

  /// Builds the holdings section with sort controls and rows.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final sort = ref.watch(sortProvider);
    final displayMode = ref.watch(returnToggleProvider);
    final sortedHoldings = sortHoldings(holdings, sort);

    return AnimatedAppearance(
      index: 2,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SectionHeader(
            title: 'Holdings',
            trailing: const ReturnToggle(),
          ),
          const SizedBox(height: AppDesignTokens.spaceMd),
          const SortControls(),
          const SizedBox(height: AppDesignTokens.spaceMd),
          if (sortedHoldings.isEmpty)
            const EmptyStateWidget()
          else
            FinViewCard(
              padding: EdgeInsets.zero,
              child: _AnimatedHoldingsRows(
                holdings: sortedHoldings,
                displayMode: displayMode,
              ),
            ),
        ],
      ),
    );
  }
}

/// Staggered list of [HoldingCard] rows inside a grouped card.
class _AnimatedHoldingsRows extends StatelessWidget {
  /// Creates animated rows for [holdings] using [displayMode].
  const _AnimatedHoldingsRows({
    required this.holdings,
    required this.displayMode,
  });

  final List<Holding> holdings;
  final ReturnDisplayMode displayMode;

  /// Builds holding rows with staggered entrance animations.
  @override
  Widget build(BuildContext context) {
    return Column(
      children: List.generate(holdings.length, (index) {
        final holding = holdings[index];
        return AnimatedAppearance(
          key: ValueKey<String>(holding.symbol),
          index: index + 3,
          child: HoldingCard(
            holding: holding,
            displayMode: displayMode,
            showDivider: index < holdings.length - 1,
          ),
        );
      }),
    );
  }
}
