import 'package:finview_lite/models/user_portfolio.dart';
import 'package:finview_lite/providers/portfolio_provider.dart';
import 'package:finview_lite/utils/app_themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:riverpod/misc.dart' show Override;

/// Wraps [child] in a [MaterialApp] and [ProviderScope] for widget tests.
Future<void> pumpWidgetWithProviders(
  WidgetTester tester, {
  required Widget child,
  List<Override> overrides = const [],
  ThemeData? theme,
  Size viewportSize = const Size(400, 800),
}) async {
  tester.view.physicalSize = viewportSize;
  tester.view.devicePixelRatio = 1.0;
  addTearDown(tester.view.resetPhysicalSize);
  addTearDown(tester.view.resetDevicePixelRatio);

  await tester.pumpWidget(
    ProviderScope(
      overrides: overrides,
      child: MaterialApp(
        theme: theme ?? AppThemes.light,
        home: Scaffold(body: child),
      ),
    ),
  );
}

/// Overrides [portfolioProvider] with a fixed [portfolio].
Override portfolioOverride(UserPortfolio portfolio) {
  return portfolioProvider.overrideWith(
    () => _FixedPortfolioNotifier(portfolio),
  );
}

/// Portfolio notifier that always resolves to a fixed value.
class _FixedPortfolioNotifier extends PortfolioNotifier {
  _FixedPortfolioNotifier(this._portfolio);

  final UserPortfolio _portfolio;

  @override
  Future<UserPortfolio> build() async => _portfolio;
}
