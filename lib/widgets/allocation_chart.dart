import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/allocation_slice.dart';
import '../providers/allocation_provider.dart';
import '../utils/allocation_builder.dart';
import '../utils/animation_constants.dart';
import '../utils/layout_constants.dart';
import 'allocation_legend.dart';
import 'allocation_pie_chart.dart';
import 'animated_appearance.dart';
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

    return AnimatedAppearance(
      index: 1,
      child: Card(
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
              AnimatedSwitcher(
                duration: AnimationConstants.medium,
                switchInCurve: AnimationConstants.entranceCurve,
                switchOutCurve: Curves.easeInCubic,
                child: hasData
                    ? _AllocationChartContent(
                        key: ValueKey<String>(
                          slices.map((slice) => slice.symbol).join(','),
                        ),
                        slices: slices,
                      )
                    : const ChartNoDataPlaceholder(
                        key: ValueKey<String>('allocation-no-data'),
                      ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _AllocationChartContent extends StatelessWidget {
  const _AllocationChartContent({
    super.key,
    required this.slices,
  });

  final List<AllocationSlice> slices;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final useSideBySide =
            constraints.maxWidth >= LayoutConstants.tabletBreakpoint;

        final chart = AnimatedChartEntrance(
          child: SizedBox(
            height: AllocationChartConstants.mobileChartHeight,
            child: AllocationPieChart(slices: slices),
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
            const SizedBox(height: _legendSpacing),
            AllocationLegend(slices: slices),
          ],
        );
      },
    );
  }
}
