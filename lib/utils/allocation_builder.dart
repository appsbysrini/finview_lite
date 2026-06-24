import 'package:flutter/material.dart';

import '../models/allocation_slice.dart';
import '../models/holding.dart';

/// Visual constants for allocation chart rendering.
abstract final class AllocationChartConstants {
  /// Aspect ratio for the pie chart container.
  static const chartAspectRatio = 1.0;

  /// Fixed chart height on mobile layouts.
  static const mobileChartHeight = 220.0;

  /// Inner radius for the donut chart center hole.
  static const centerSpaceRadius = 48.0;

  /// Gap between pie sections in degrees.
  static const sectionsSpace = 2.0;

  /// Default radius for pie sections.
  static const sectionRadius = 56.0;

  /// Palette used to distinguish allocation slices.
  static const palette = <Color>[
    Color(0xFF6750A4),
    Color(0xFF7D5260),
    Color(0xFF006A6A),
    Color(0xFF984061),
    Color(0xFF4A4459),
    Color(0xFF006E1C),
    Color(0xFF8C4A00),
    Color(0xFF005CB9),
  ];
}

/// Builds allocation slices from [holdings], excluding zero-value entries.
List<AllocationSlice> buildAllocationSlices(List<Holding> holdings) {
  final valuedHoldings =
      holdings.where((holding) => holding.currentValue > 0).toList();

  if (valuedHoldings.isEmpty) {
    return const [];
  }

  final totalValue = valuedHoldings.fold<double>(
    0,
    (sum, holding) => sum + holding.currentValue,
  );

  if (totalValue <= 0) {
    return const [];
  }

  return List<AllocationSlice>.generate(valuedHoldings.length, (index) {
    final holding = valuedHoldings[index];
    final percentage = (holding.currentValue / totalValue) * 100;

    return AllocationSlice(
      symbol: holding.symbol,
      name: holding.name,
      value: holding.currentValue,
      percentage: percentage,
      color: AllocationChartConstants.palette[
          index % AllocationChartConstants.palette.length],
    );
  });
}

/// Returns whether [slices] contain chartable allocation data.
bool hasAllocationData(List<AllocationSlice> slices) {
  if (slices.isEmpty) {
    return false;
  }

  return slices.any((slice) => slice.value > 0);
}
