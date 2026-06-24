import 'package:finview_lite/providers/sort_provider.dart';
import 'package:finview_lite/utils/app_themes.dart';
import 'package:finview_lite/widgets/sort_controls.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('SortControls.labelFor', () {
    test('returns labels for all sort options', () {
      expect(SortControls.labelFor(HoldingSort.byValue), 'Value');
      expect(SortControls.labelFor(HoldingSort.byGain), 'Gains');
      expect(SortControls.labelFor(HoldingSort.byName), 'Name');
    });
  });

  group('SortControls', () {
    late ProviderContainer container;

    setUp(() {
      container = ProviderContainer();
    });

    tearDown(() {
      container.dispose();
    });

    Future<void> pumpSortControls(WidgetTester tester) async {
      await tester.pumpWidget(
        UncontrolledProviderScope(
          container: container,
          child: MaterialApp(
            theme: AppThemes.light,
            home: const Scaffold(
              body: SortControls(),
            ),
          ),
        ),
      );
      await tester.pumpAndSettle();
    }

    testWidgets('renders sort icon button', (tester) async {
      await pumpSortControls(tester);

      expect(find.byIcon(Icons.sort_rounded), findsOneWidget);
      expect(find.byTooltip('Sort holdings'), findsOneWidget);
      expect(find.text('Value'), findsNothing);
      expect(find.text('Name'), findsNothing);
      expect(find.text('Gains'), findsNothing);
    });

    testWidgets('shows all sort menu items in order', (tester) async {
      await pumpSortControls(tester);

      await tester.tap(find.byIcon(Icons.sort_rounded));
      await tester.pumpAndSettle();

      expect(find.text('Value'), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
      expect(find.text('Gains'), findsOneWidget);
      expect(find.text('Units'), findsNothing);
      expect(find.text('Avg Cost'), findsNothing);
      expect(find.text('Current Price'), findsNothing);
    });

    testWidgets('updates sort provider when menu item is selected', (
      tester,
    ) async {
      await pumpSortControls(tester);

      await tester.tap(find.byIcon(Icons.sort_rounded));
      await tester.pumpAndSettle();
      await tester.tap(find.text('Gains'));
      await tester.pumpAndSettle();

      expect(container.read(sortProvider), HoldingSort.byGain);
    });

    testWidgets('shows check mark for active sort option', (tester) async {
      container.read(sortProvider.notifier).setSort(HoldingSort.byName);
      await pumpSortControls(tester);

      await tester.tap(find.byIcon(Icons.sort_rounded));
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.check), findsOneWidget);
      expect(find.text('Name'), findsOneWidget);
    });
  });
}
