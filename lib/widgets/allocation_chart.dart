import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/allocation_slice.dart';
import '../providers/allocation_provider.dart';
import '../utils/allocation_builder.dart';
import '../utils/layout_constants.dart';
import 'allocation_legend.dart';
import 'allocation_pie_chart.dart';
import 'chart_no_data_placeholder.dart';

/// Corner radius for the allocation card container.
const _cardRadius = 16.0;

/// Inner padding for the allocation card.
const _cardPadding = 16.0;

/// Spacing between chart and legend.
const _legendSpacing = 16.0;

/// Section showing portfolio allocation by holding value.
class AllocationChart extends ConsumerWidget {
  /// Creates an allocation chart driven by [allocationSlicesProvider].
  const AllocationChart({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final slices = ref.watch(allocationSlicesProvider);
    final hasData = ref.watch(allocationHasDataProvider);
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(_cardRadius),
        side: BorderSide(
          color: theme.colorScheme.outlineVariant,
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(_cardPadding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Allocation',
              style: theme.textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: LayoutConstants.sectionSpacing),
            if (!hasData)
              const ChartNoDataPlaceholder()
            else
              _AllocationChartContent(slices: slices),
          ],
        ),
      ),
    );
  }
}

class _AllocationChartContent extends StatelessWidget {
  const _AllocationChartContent({required this.slices});

  final List<AllocationSlice> slices;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useSideBySide =
            constraints.maxWidth >= LayoutConstants.tabletBreakpoint;

        if (useSideBySide) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: SizedBox(
                  height: AllocationChartConstants.mobileChartHeight,
                  child: AllocationPieChart(slices: slices),
                ),
              ),
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
            SizedBox(
              height: AllocationChartConstants.mobileChartHeight,
              child: AllocationPieChart(slices: slices),
            ),
            const SizedBox(height: _legendSpacing),
            AllocationLegend(slices: slices),
          ],
        );
      },
    );
  }
}
