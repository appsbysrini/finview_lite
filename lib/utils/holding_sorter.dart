import '../models/holding.dart';
import '../providers/sort_provider.dart';

/// Returns a new list of [holdings] sorted by [sort].
List<Holding> sortHoldings(List<Holding> holdings, HoldingSort sort) {
  final sorted = List<Holding>.from(holdings);

  switch (sort) {
    case HoldingSort.byValue:
      sorted.sort((a, b) => b.currentValue.compareTo(a.currentValue));
    case HoldingSort.byGain:
      sorted.sort((a, b) => b.gainAmount.compareTo(a.gainAmount));
    case HoldingSort.byName:
      sorted.sort((a, b) => a.name.compareTo(b.name));
  }

  return sorted;
}
