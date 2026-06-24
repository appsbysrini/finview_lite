import 'package:flutter/material.dart';

import '../models/allocation_slice.dart';
import '../models/holding.dart';

/// Visual constants for allocation chart rendering.
abstract final class AllocationChartConstants {
  /// Aspect ratio for the pie chart container.
  static const chartAspectRatio = 1.0;

  /// Fixed chart height on mobile layouts.
  static const mobileChartHeight = 240.0;

  /// Inner radius for the donut chart center hole.
  static const centerSpaceRadius = 52.0;

  /// Gap between pie sections in degrees.
  static const sectionsSpace = 2.0;

  /// Default radius for pie sections.
  static const sectionRadius = 58.0;
}

/// Builds allocation slices from [holdings], excluding zero-value entries.
List<AllocationSlice> buildAllocationSlices(
  List<Holding> holdings, {
  required List<Color> palette,
}) {
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
      color: palette[index % palette.length],
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
