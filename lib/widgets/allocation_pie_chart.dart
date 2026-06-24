import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

import '../models/allocation_slice.dart';
import '../utils/allocation_builder.dart';

/// Donut chart rendering allocation slices with fl_chart.
class AllocationPieChart extends StatelessWidget {
  /// Creates a pie chart for the given [slices].
  const AllocationPieChart({
    super.key,
    required this.slices,
  });

  /// Allocation slices displayed in the chart.
  final List<AllocationSlice> slices;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: AllocationChartConstants.chartAspectRatio,
      child: PieChart(
        PieChartData(
          borderData: FlBorderData(show: false),
          sectionsSpace: AllocationChartConstants.sectionsSpace,
          centerSpaceRadius: AllocationChartConstants.centerSpaceRadius,
          sections: _buildSections(),
        ),
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
