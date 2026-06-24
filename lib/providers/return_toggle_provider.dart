import 'package:flutter_riverpod/legacy.dart';

/// Display mode for per-holding return values.
enum ReturnDisplayMode {
  /// Show gain or loss as a currency amount.
  amount,

  /// Show gain or loss as a percentage.
  percent,
}

/// Currently selected return display mode for holdings.
final returnToggleProvider = StateProvider<ReturnDisplayMode>(
  (ref) => ReturnDisplayMode.amount,
);
