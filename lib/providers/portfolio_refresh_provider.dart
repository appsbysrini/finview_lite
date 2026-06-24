import 'package:flutter_riverpod/legacy.dart';

/// Whether a portfolio refresh simulation is currently running.
final portfolioRefreshingProvider = StateProvider<bool>(
  (ref) => false,
);
