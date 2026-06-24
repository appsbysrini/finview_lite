import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/allocation_slice.dart';
import '../providers/allocation_provider.dart';
import '../providers/portfolio_provider.dart';
import '../utils/allocation_builder.dart';
import '../utils/animation_constants.dart';
import '../utils/app_design_tokens.dart';
import '../utils/layout_constants.dart';
import 'allocation_legend.dart';
import 'allocation_pie_chart.dart';
import 'animated_appearance.dart';
import 'chart_no_data_placeholder.dart';
import 'finview_card.dart';
import 'section_header.dart';

/// Section showing portfolio allocation by holding value.
class AllocationChart extends ConsumerWidget {
  /// Creates an allocation chart driven by [allocationSlicesProvider].
  const AllocationChart({super.key});

  /// Builds the allocation section with chart or no-data placeholder.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slices = ref.watch(allocationSlicesProvider);
    final hasData = ref.watch(allocationHasDataProvider);
    final portfolio = ref.watch(portfolioProvider).value;

    return AnimatedAppearance(
      index: 1,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SectionHeader(title: 'Allocation'),
          const SizedBox(height: AppDesignTokens.spaceMd),
          FinViewCard(
            padding: const EdgeInsets.all(AppDesignTokens.spaceLg),
            child: AnimatedSwitcher(
              duration: AnimationConstants.medium,
              switchInCurve: AnimationConstants.entranceCurve,
              switchOutCurve: Curves.easeInCubic,
              child: hasData
                  ? _AllocationChartContent(
                      key: ValueKey<String>(
                        slices.map((slice) => slice.symbol).join(','),
                      ),
                      slices: slices,
                      centerValue: portfolio?.portfolioValue ?? 0,
                    )
                  : const ChartNoDataPlaceholder(
                      key: ValueKey<String>('allocation-no-data'),
                    ),
            ),
          ),
        ],
      ),
    );
  }
}

/// Responsive layout combining the pie chart and legend.
class _AllocationChartContent extends StatelessWidget {
  /// Creates chart content for [slices] with [centerValue] in the donut.
  const _AllocationChartContent({
    super.key,
    required this.slices,
    required this.centerValue,
  });

  final List<AllocationSlice> slices;
  final double centerValue;

  /// Builds side-by-side or stacked chart and legend based on width.
  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useSideBySide =
            constraints.maxWidth >= LayoutConstants.tabletBreakpoint;

        final chart = AnimatedChartEntrance(
          child: SizedBox(
            height: AllocationChartConstants.mobileChartHeight,
            child: AllocationPieChart(
              slices: slices,
              centerValue: centerValue,
            ),
          ),
        );

        if (useSideBySide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(child: chart),
              const SizedBox(width: LayoutConstants.columnSpacing),
              Expanded(
                child: AllocationLegend(slices: slices),
              ),
            ],
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            chart,
            const SizedBox(height: AppDesignTokens.spaceLg),
            AllocationLegend(slices: slices),
          ],
        );
      },
    );
  }
}
