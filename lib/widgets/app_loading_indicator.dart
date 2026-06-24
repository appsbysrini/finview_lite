import 'package:flutter/material.dart';

import '../utils/app_design_tokens.dart';

/// Default size for inline loading indicators.
const _indicatorSize = 20.0;

/// Default stroke width for inline loading indicators.
const _strokeWidth = 2.0;

/// Default size for full-screen loading indicators.
const _fullScreenIndicatorSize = 32.0;

/// Compact circular progress indicator for buttons and app bars.
class AppLoadingIndicator extends StatelessWidget {
  /// Creates a loading indicator, optionally with a [message].
  const AppLoadingIndicator({
    super.key,
    this.message,
    this.fullScreen = false,
  });

  /// Optional status message shown below the spinner.
  final String? message;

  /// Whether to render a larger spinner suited for full-screen states.
  final bool fullScreen;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final size = fullScreen ? _fullScreenIndicatorSize : _indicatorSize;

    final indicator = SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        strokeWidth: fullScreen ? 2.5 : _strokeWidth,
        color: theme.colorScheme.secondary,
      ),
    );

    if (message == null) {
      return indicator;
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        indicator,
        const SizedBox(height: AppDesignTokens.spaceMd),
        Text(
          message!,
          style: theme.textTheme.bodyMedium?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
