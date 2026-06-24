import 'package:flutter/material.dart';

import '../providers/return_toggle_provider.dart';
import 'formatters.dart';

/// Returns the theme color used for a gain or loss [amount].
Color gainColorFor(ThemeData theme, double amount) {
  return amount >= 0 ? theme.colorScheme.primary : theme.colorScheme.error;
}

/// Formats a return value for the active [ReturnDisplayMode].
String formatReturnValue({
  required double gainAmount,
  required double gainPercent,
  required ReturnDisplayMode displayMode,
}) {
  return displayMode == ReturnDisplayMode.amount
      ? formatGainAmount(gainAmount)
      : formatPercent(gainPercent);
}
