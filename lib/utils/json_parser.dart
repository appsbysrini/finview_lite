/// Parses a dynamic JSON value into a [double], defaulting to [fallback].
double parseJsonDouble(dynamic value, {double fallback = 0.0}) {
  if (value == null) {
    return fallback;
  }
  if (value is num) {
    return value.toDouble();
  }
  return double.tryParse(value.toString()) ?? fallback;
}
