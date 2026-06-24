import 'package:flutter/material.dart';

/// Default size for inline loading indicators.
const _indicatorSize = 20.0;

/// Default stroke width for inline loading indicators.
const _strokeWidth = 2.0;

/// Compact circular progress indicator for buttons and app bars.
class AppLoadingIndicator extends StatelessWidget {
  /// Creates a small loading indicator.
  const AppLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: _indicatorSize,
      height: _indicatorSize,
      child: CircularProgressIndicator(strokeWidth: _strokeWidth),
    );
  }
}
