import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/allocation_slice.dart';
import '../utils/allocation_builder.dart';
import '../utils/animation_constants.dart';
import '../utils/app_design_tokens.dart';
import '../utils/formatters.dart';

/// Donut chart rendering allocation slices with fl_chart.
class AllocationPieChart extends StatelessWidget {
  /// Creates a pie chart for the given [slices].
  const AllocationPieChart({
    super.key,
    required this.slices,
    required this.centerValue,
  });

  /// Allocation slices displayed in the chart.
  final List<AllocationSlice> slices;

  /// Total portfolio value shown in the donut center.
  final double centerValue;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final description = slices
        .map((slice) => '${slice.symbol} ${slice.percentage.toStringAsFixed(1)}%')
        .join(', ');

    return Semantics(
      label: 'Portfolio allocation chart. $description',
      child: Stack(
        alignment: Alignment.center,
        children: [
          ExcludeSemantics(
            child: AspectRatio(
              aspectRatio: AllocationChartConstants.chartAspectRatio,
              child: PieChart(
                PieChartData(
                  borderData: FlBorderData(show: false),
                  sectionsSpace: AllocationChartConstants.sectionsSpace,
                  centerSpaceRadius:
                      AllocationChartConstants.centerSpaceRadius,
                  sections: _buildSections(),
                ),
                duration: AnimationConstants.chart,
                curve: AnimationConstants.entranceCurve,
              ),
            ),
          ),
          _ChartCenterLabel(
            value: formatCurrency(centerValue),
            caption: 'Portfolio',
            theme: theme,
          ),
        ],
      ),
    );
  }

  /// Builds fl_chart section data from allocation slices.
  List<PieChartSectionData> _buildSections() {
    return slices
        .map(
          (slice) => PieChartSectionData(
            value: slice.value,
            color: slice.color,
            radius: AllocationChartConstants.sectionRadius,
            title: '',
          ),
        )
        .toList();
  }
}

class _ChartCenterLabel extends StatelessWidget {
  const _ChartCenterLabel({
    required this.value,
    required this.caption,
    required this.theme,
  });

  final String value;
  final String caption;
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          caption,
          style: theme.textTheme.labelSmall,
        ),
        const SizedBox(height: AppDesignTokens.spaceXs),
        Text(
          value,
          textAlign: TextAlign.center,
          style: AppDesignTokens.tabularFigures(
            theme.textTheme.titleSmall!,
          ),
        ),
      ],
    );
  }
}
