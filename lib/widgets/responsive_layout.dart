import 'package:flutter/material.dart';

import '../utils/layout_constants.dart';

/// Builds [mobile] or [tablet] based on available layout width.
class ResponsiveLayout extends StatelessWidget {
  /// Creates a responsive layout switcher.
  const ResponsiveLayout({
    super.key,
    required this.mobile,
    required this.tablet,
  });

  /// Widget shown when width is below [LayoutConstants.tabletBreakpoint].
  final Widget mobile;

  /// Widget shown when width is at or above [LayoutConstants.tabletBreakpoint].
  final Widget tablet;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        if (constraints.maxWidth >= LayoutConstants.tabletBreakpoint) {
          return tablet;
        }
        return mobile;
      },
    );
  }
}

/// Returns whether [width] requires stacked controls instead of a row.
bool shouldStackControls(double width) {
  return width < LayoutConstants.compactControlsBreakpoint;
}
