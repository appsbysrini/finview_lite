import 'package:finview_lite/utils/layout_constants.dart';
import 'package:finview_lite/widgets/responsive_layout.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/widget_test_helpers.dart';

void main() {
  group('shouldStackControls', () {
    test('returns true below compact controls breakpoint', () {
      // Act
      final result =
          shouldStackControls(LayoutConstants.compactControlsBreakpoint - 1);

      // Assert
      expect(result, isTrue);
    });

    test('returns false at or above compact controls breakpoint', () {
      // Act
      final result =
          shouldStackControls(LayoutConstants.compactControlsBreakpoint);

      // Assert
      expect(result, isFalse);
    });
  });

  group('ResponsiveLayout', () {
    testWidgets('renders tablet child on wide layouts', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const ResponsiveLayout(
          mobile: Text('mobile'),
          tablet: Text('tablet'),
        ),
        viewportSize: const Size(800, 600),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('tablet'), findsOneWidget);
      expect(find.text('mobile'), findsNothing);
    });
  });
}
