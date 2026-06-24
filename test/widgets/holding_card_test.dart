import 'package:finview_lite/providers/return_toggle_provider.dart';
import 'package:finview_lite/widgets/holding_card.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';
import '../helpers/widget_test_helpers.dart';

void main() {
  group('HoldingCard', () {
    testWidgets('displays symbol, name, and formatted value', (tester) async {
      // Arrange
      const holding = TestData.tcs;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingCard(
          holding: holding,
          displayMode: ReturnDisplayMode.amount,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('TCS'), findsOneWidget);
      expect(find.text('Tata Consultancy'), findsOneWidget);
      expect(find.text('₹17,000'), findsOneWidget);
    });

    testWidgets('shows gain amount in amount display mode', (tester) async {
      // Arrange
      const holding = TestData.tcs;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingCard(
          holding: holding,
          displayMode: ReturnDisplayMode.amount,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('+₹1,000'), findsOneWidget);
    });

    testWidgets('shows gain percent in percent display mode', (tester) async {
      // Arrange
      const holding = TestData.tcs;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingCard(
          holding: holding,
          displayMode: ReturnDisplayMode.percent,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('+6.3%'), findsOneWidget);
    });

    testWidgets('shows loss values for negative gain holdings', (tester) async {
      // Arrange
      const holding = TestData.lossHolding;

      // Act
      await pumpWidgetWithProviders(
        tester,
        child: const HoldingCard(
          holding: holding,
          displayMode: ReturnDisplayMode.amount,
        ),
      );
      await tester.pumpAndSettle();

      // Assert
      expect(find.text('-₹400'), findsOneWidget);
      expect(find.text('₹1,600'), findsOneWidget);
    });
  });
}
