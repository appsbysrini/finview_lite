import 'package:intl/intl.dart';

/// Indian-Rupee currency formatter using the `en_IN` locale.
///
/// Constructed once as a module-level final to avoid repeated allocation.
/// Produces Indian grouping: ₹1,09,640 (lakh/crore) rather than ₹109,640.
final _inr = NumberFormat.currency(
  locale: 'en_IN',
  symbol: '₹',
  decimalDigits: 0,
);

/// Formats [value] as Indian Rupees with `en_IN` comma grouping.
///
/// Examples: 109640 → ₹1,09,640 · -800 → -₹800
String formatCurrency(double value) => _inr.format(value.round());

/// Formats a gain or loss amount with an explicit `+` prefix for gains.
///
/// Examples: 1900 → +₹1,900 · -780 → -₹780 · 0 → ₹0
String formatGainAmount(double value) {
  if (value == 0) return formatCurrency(0);
  // _inr already prepends '-' for negative values; only gains need '+'.
  if (value > 0) return '+${formatCurrency(value)}';
  return formatCurrency(value);
}

/// Formats a percentage with one decimal place and a sign for non-zero values.
///
/// Examples: 3.125 → +3.1% · -5.0 → -5.0% · 0 → 0.0%
String formatPercent(double value) {
  if (value == 0) return '0.0%';
  final prefix = value > 0 ? '+' : '';
  return '$prefix${value.toStringAsFixed(1)}%';
}

/// Formats an allocation share percentage without a sign prefix.
///
/// Example: 34.5 → 34.5%
String formatSharePercent(double value) => '${value.toStringAsFixed(1)}%';
