import 'app_design_tokens.dart';

/// Layout breakpoints and spacing shared across responsive screens.
abstract final class LayoutConstants {
  /// Minimum width in logical pixels for tablet and web layouts.
  static const tabletBreakpoint = 600.0;

  /// Standard outer padding for dashboard content.
  static const screenPadding = AppDesignTokens.spaceMd;

  /// Spacing between major dashboard sections.
  static const sectionSpacing = AppDesignTokens.spaceSection;

  /// Spacing between columns in a two-column layout.
  static const columnSpacing = AppDesignTokens.spaceLg;

  /// Width below which header controls stack vertically.
  static const compactControlsBreakpoint = 360.0;
}
