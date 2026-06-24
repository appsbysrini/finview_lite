import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Available sort options for the holdings list.
enum HoldingSort {
  /// Sort by current market value, highest first.
  byValue,

  /// Sort by absolute gain, highest first.
  byGain,

  /// Sort alphabetically by company name.
  byName,
}

/// Holds the currently selected holdings sort order.
class SortNotifier extends Notifier<HoldingSort> {
  /// Returns the default sort order when the provider is first watched.
  @override
  HoldingSort build() => HoldingSort.byValue;

  /// Updates the active holdings sort order.
  void setSort(HoldingSort sort) {
    state = sort;
  }
}

/// Currently selected holdings sort order.
final sortProvider = NotifierProvider<SortNotifier, HoldingSort>(
  SortNotifier.new,
);
