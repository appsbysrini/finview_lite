import 'package:flutter/animation.dart';

/// Shared durations and curves for dashboard animations.
abstract final class AnimationConstants {
  /// Standard duration for content fade and slide transitions.
  static const medium = Duration(milliseconds: 350);

  /// Duration for pie chart scale and fade entrance.
  static const chart = Duration(milliseconds: 450);

  /// Base duration for the first holdings list item entrance.
  static const listItemBase = Duration(milliseconds: 280);

  /// Additional delay per list item for staggered entrance.
  static const listItemStagger = Duration(milliseconds: 60);

  /// Default easing curve for entrance animations.
  static const entranceCurve = Curves.easeOutCubic;

  /// Vertical slide distance for entrance animations in logical pixels.
  static const slideOffset = 12.0;

  /// Initial scale applied to the chart before it animates in.
  static const chartInitialScale = 0.92;
}
