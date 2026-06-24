import 'package:flutter_riverpod/legacy.dart';

/// Available sort options for the holdings list.
enum HoldingSort {
  /// Sort by current market value, highest first.
  byValue,

  /// Sort by absolute gain, highest first.
  byGain,

  /// Sort alphabetically by company name.
  byName,
}

/// Currently selected holdings sort order.
final sortProvider = StateProvider<HoldingSort>(
  (ref) => HoldingSort.byValue,
);
