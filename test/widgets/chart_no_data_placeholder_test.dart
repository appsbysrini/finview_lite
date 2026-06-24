import 'package:finview_lite/widgets/chart_no_data_placeholder.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/widget_test_helpers.dart';

void main() {
  group('ChartNoDataPlaceholder', () {
    testWidgets('displays no data title and helper text', (tester) async {
      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const ChartNoDataPlaceholder(),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('No Data'), findsOneWidget);
      expect(
        find.text('Allocation requires holdings with a current value.'),
        findsOneWidget,
      );
      expect(find.byIcon(Icons.donut_large_outlined), findsOneWidget);
    });
  });
}
