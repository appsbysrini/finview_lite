import 'package:flutter/material.dart';

import '../utils/animation_constants.dart';

/// Applies a staggered fade-and-slide entrance to [child].
class AnimatedAppearance extends StatelessWidget {
  /// Creates an entrance animation with optional [index]-based delay.
  const AnimatedAppearance({
    super.key,
    required this.child,
    this.index = 0,
    this.duration = AnimationConstants.medium,
  });

  /// Widget revealed by the entrance animation.
  final Widget child;

  /// Stagger index used to offset the animation start.
  final int index;

  /// Base duration for the entrance animation.
  final Duration duration;

  /// Builds the fade-and-slide entrance animation around [child].
  @override
  Widget build(BuildContext context) {
    final totalDuration = duration + AnimationConstants.listItemStagger * index;

    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: totalDuration,
      curve: AnimationConstants.entranceCurve,
      builder: (context, value, animatedChild) {
        return Opacity(
          opacity: value,
          child: Transform.translate(
            offset: Offset(0, AnimationConstants.slideOffset * (1 - value)),
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }
}

/// Scales and fades [child] in, suited for chart rendering.
class AnimatedChartEntrance extends StatelessWidget {
  /// Creates a chart entrance animation around [child].
  const AnimatedChartEntrance({
    super.key,
    required this.child,
  });

  /// Chart widget animated into view.
  final Widget child;

  /// Builds the scale-and-fade entrance animation around [child].
  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder<double>(
      tween: Tween<double>(begin: 0, end: 1),
      duration: AnimationConstants.chart,
      curve: AnimationConstants.entranceCurve,
      builder: (context, value, animatedChild) {
        final scale = AnimationConstants.chartInitialScale +
            ((1 - AnimationConstants.chartInitialScale) * value);

        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: scale,
            child: animatedChild,
          ),
        );
      },
      child: child,
    );
  }
}

/// Cross-fades between [child] instances when [valueKey] changes.
class AnimatedValueText extends StatelessWidget {
  /// Creates animated text that transitions when [valueKey] updates.
  const AnimatedValueText({
    super.key,
    required this.valueKey,
    required this.text,
    required this.style,
    this.textAlign,
  });

  /// Key that triggers a transition when the underlying value changes.
  final Object valueKey;

  /// Text content to display.
  final String text;

  /// Style applied to the animated text.
  final TextStyle? style;

  /// Optional text alignment.
  final TextAlign? textAlign;

  /// Builds cross-fading text that animates when [valueKey] changes.
  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: AnimationConstants.medium,
      switchInCurve: AnimationConstants.entranceCurve,
      switchOutCurve: Curves.easeInCubic,
      transitionBuilder: (child, animation) {
        return FadeTransition(
          opacity: animation,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.12),
              end: Offset.zero,
            ).animate(animation),
            child: child,
          ),
        );
      },
      child: Text(
        text,
        key: ValueKey<Object>(valueKey),
        style: style,
        textAlign: textAlign,
      ),
    );
  }
}
