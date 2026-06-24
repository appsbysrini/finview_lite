import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../models/allocation_slice.dart';
import '../utils/allocation_builder.dart';
import 'portfolio_provider.dart';

/// Allocation slices derived from the loaded portfolio holdings.
final allocationSlicesProvider = Provider<List<AllocationSlice>>((ref) {
  final portfolio = ref.watch(portfolioProvider).value;
  if (portfolio == null) {
    return const [];
  }

  return buildAllocationSlices(portfolio.holdings);
});

/// Whether the allocation chart has non-zero data to display.
final allocationHasDataProvider = Provider<bool>((ref) {
  final slices = ref.watch(allocationSlicesProvider);
  return hasAllocationData(slices);
});

/// Total current value represented across all allocation slices.
final allocationTotalValueProvider = Provider<double>((ref) {
  final slices = ref.watch(allocationSlicesProvider);
  return slices.fold<double>(0, (sum, slice) => sum + slice.value);
});
