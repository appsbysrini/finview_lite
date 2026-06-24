import 'package:flutter/material.dart';

import 'app_design_tokens.dart';
import '../providers/return_toggle_provider.dart';
import 'formatters.dart';

/// Returns the semantic profit or loss color for [amount].
Color gainColorFor(ThemeData theme, double amount) {
  final finView = theme.finView;
  return amount >= 0 ? finView.profit : finView.loss;
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
