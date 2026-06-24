import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/allocation_slice.dart';
import '../utils/allocation_builder.dart';
import '../utils/app_design_tokens.dart';
import 'portfolio_provider.dart';
import 'theme_provider.dart';

/// Allocation slices derived from the loaded portfolio holdings.
final allocationSlicesProvider = Provider<List<AllocationSlice>>((ref) {
  final portfolio = ref.watch(portfolioProvider).value;
  if (portfolio == null) {
    return const [];
  }

  final isDark = ref.watch(isDarkModeProvider);
  final palette = isDark
      ? FinViewColors.dark.chartPalette
      : FinViewColors.light.chartPalette;

  return buildAllocationSlices(
    portfolio.holdings,
    palette: palette,
  );
});

/// Whether the allocation chart has non-zero data to display.
final allocationHasDataProvider = Provider<bool>((ref) {
  final slices = ref.watch(allocationSlicesProvider);
  return hasAllocationData(slices);
});
