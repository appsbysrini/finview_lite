import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:finview_lite/main.dart';
import 'package:finview_lite/models/holding.dart';
import 'package:finview_lite/models/user_portfolio.dart';
import 'package:finview_lite/providers/auth_provider.dart';
import 'package:finview_lite/providers/portfolio_provider.dart';
import 'package:finview_lite/providers/theme_provider.dart';

void main() {
  testWidgets('dashboard shows portfolio header when provider succeeds',
      (tester) async {
    const portfolio = UserPortfolio(
      user: 'Test User',
      portfolioValue: 100000,
      totalGain: 5000,
      holdings: [
        Holding(
          symbol: 'TCS',
          name: 'Tata Consultancy',
          units: 5,
          avgCost: 3200,
          currentPrice: 3400,
        ),
      ],
    );

    tester.view.physicalSize = const Size(400, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.resetPhysicalSize);
    addTearDown(tester.view.resetDevicePixelRatio);

    await tester.pumpWidget(
      ProviderScope(
        overrides: [
          portfolioProvider.overrideWith(
            () => _FakePortfolioNotifier(portfolio),
          ),
          authProvider.overrideWith(_FakeAuthNotifier.new),
          themeModeProvider.overrideWith(_FakeThemeModeNotifier.new),
        ],
        child: const FinViewLiteApp(),
      ),
    );
    await tester.pumpAndSettle();

    expect(find.text('Test User'), findsOneWidget);
    expect(find.text('₹100,000'), findsNWidgets(2));
    expect(find.textContaining('+₹5,000'), findsOneWidget);
    expect(find.text('Allocation'), findsOneWidget);
    expect(find.text('TCS'), findsNWidgets(2));
    expect(find.text('Tata Consultancy'), findsOneWidget);
  });
}

class _FakePortfolioNotifier extends PortfolioNotifier {
  _FakePortfolioNotifier(this._portfolio);

  final UserPortfolio _portfolio;

  @override
  Future<UserPortfolio> build() async => _portfolio;
}

class _FakeAuthNotifier extends AuthNotifier {
  @override
  Future<bool> build() async => true;
}

class _FakeThemeModeNotifier extends ThemeModeNotifier {
  @override
  Future<ThemeMode> build() async => ThemeMode.light;
}
