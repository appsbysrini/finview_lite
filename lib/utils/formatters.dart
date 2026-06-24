/// Formats a numeric amount as Indian Rupees with comma grouping.
String formatCurrency(double value) {
  final sign = value < 0 ? '-' : '';
  final absolute = value.abs().round();
  return '$sign₹${_groupDigits(absolute)}';
}

/// Formats a gain or loss amount with an explicit sign prefix.
String formatGainAmount(double value) {
  if (value == 0) {
    return formatCurrency(0);
  }
  final prefix = value > 0 ? '+' : '-';
  return '$prefix${formatCurrency(value.abs())}';
}

/// Formats a percentage value with one decimal place and a sign when non-zero.
String formatPercent(double value) {
  if (value == 0) {
    return '0.0%';
  }
  final prefix = value > 0 ? '+' : '';
  return '$prefix${value.toStringAsFixed(1)}%';
}

/// Formats an allocation share percentage without a sign prefix.
String formatSharePercent(double value) {
  return '${value.toStringAsFixed(1)}%';
}

/// Inserts Indian-style comma grouping into [value] without a currency prefix.
String _groupDigits(int value) {
  final text = value.toString();
  final buffer = StringBuffer();
  final length = text.length;

  for (var index = 0; index < length; index++) {
    if (index > 0 && (length - index) % 3 == 0) {
      buffer.write(',');
    }
    buffer.write(text[index]);
  }

  return buffer.toString();
}
