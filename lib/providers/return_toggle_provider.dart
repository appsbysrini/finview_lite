import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Display mode for per-holding return values.
enum ReturnDisplayMode {
  /// Show gain or loss as a currency amount.
  amount,

  /// Show gain or loss as a percentage.
  percent,
}

/// Holds the currently selected return display mode for holdings.
class ReturnToggleNotifier extends Notifier<ReturnDisplayMode> {
  /// Returns the default display mode when the provider is first watched.
  @override
  ReturnDisplayMode build() => ReturnDisplayMode.amount;

  /// Updates the active return display mode.
  void setDisplayMode(ReturnDisplayMode mode) {
    state = mode;
  }
}

/// Currently selected return display mode for holdings.
final returnToggleProvider =
    NotifierProvider<ReturnToggleNotifier, ReturnDisplayMode>(
  ReturnToggleNotifier.new,
);
