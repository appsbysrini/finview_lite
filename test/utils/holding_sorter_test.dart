import 'package:finview_lite/models/holding.dart';
import 'package:finview_lite/providers/sort_provider.dart';
import 'package:finview_lite/utils/holding_sorter.dart';
import 'package:flutter_test/flutter_test.dart';

import '../helpers/test_data.dart';

void main() {
  group('sortHoldings', () {
    late List<Holding> holdings;

    setUp(() {
      holdings = [
        TestData.infy,
        TestData.tcs,
        TestData.lossHolding,
      ];
    });

    test('sorts by current value descending', () {
      // Act
      final sorted = sortHoldings(holdings, HoldingSort.byValue);

      // Assert
      expect(sorted.map((holding) => holding.symbol).toList(),
          ['TCS', 'INFY', 'LOSS']);
    });

    test('sorts by gain amount descending', () {
      // Act
      final sorted = sortHoldings(holdings, HoldingSort.byGain);

      // Assert
      expect(sorted.first.symbol, anyOf('TCS', 'INFY'));
      expect(sorted.last.symbol, 'LOSS');
      expect(
        sorted.take(2).map((holding) => holding.symbol).toSet(),
        {'TCS', 'INFY'},
      );
    });

    test('sorts alphabetically by name ascending', () {
      // Act
      final sorted = sortHoldings(holdings, HoldingSort.byName);

      // Assert
      expect(sorted.map((holding) => holding.name).toList(), [
        'Infosys Ltd',
        'Loss Corp',
        'Tata Consultancy',
      ]);
    });

    test('returns empty list when input is empty', () {
      // Act
      final sorted = sortHoldings(const [], HoldingSort.byValue);

      // Assert
      expect(sorted, isEmpty);
    });

    test('does not mutate the original list', () {
      // Arrange
      final originalOrder = holdings.map((holding) => holding.symbol).toList();

      // Act
      sortHoldings(holdings, HoldingSort.byName);

      // Assert
      expect(
        holdings.map((holding) => holding.symbol).toList(),
        originalOrder,
      );
    });

    test('does not mutate the original list for all sort options', () {
      // Arrange
      final originalOrder = holdings.map((holding) => holding.symbol).toList();

      // Act & Assert
      for (final sort in holdingSortMenuOptions) {
        sortHoldings(holdings, sort);
        expect(
          holdings.map((holding) => holding.symbol).toList(),
          originalOrder,
        );
      }
    });

    test('returns empty list for all sort options when input is empty', () {
      for (final sort in holdingSortMenuOptions) {
        expect(sortHoldings(const [], sort), isEmpty);
      }
    });
  });
}
