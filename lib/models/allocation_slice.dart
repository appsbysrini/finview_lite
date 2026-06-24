import 'package:flutter/material.dart';

/// A single slice of the portfolio allocation chart.
class AllocationSlice {
  /// Creates an [AllocationSlice] for one holding.
  const AllocationSlice({
    required this.symbol,
    required this.name,
    required this.value,
    required this.percentage,
    required this.color,
  });

  /// Ticker symbol shown in the legend.
  final String symbol;

  /// Full holding name shown as supporting text.
  final String name;

  /// Current market value represented by this slice.
  final double value;

  /// Share of total portfolio value as a percentage.
  final double percentage;

  /// Color used to render the slice and legend swatch.
  final Color color;
}
