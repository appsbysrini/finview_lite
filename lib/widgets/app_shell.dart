import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/auth_provider.dart';
import '../providers/theme_provider.dart';
import '../screens/dashboard_screen.dart';
import '../screens/login_screen.dart';
import '../utils/app_themes.dart';
import '../widgets/dashboard_loading_view.dart';
import '../widgets/portfolio_error_view.dart';

/// Bootstraps theme, auth, and routes to login or dashboard.
class AppShell extends ConsumerWidget {
  /// Creates the root app shell.
  const AppShell({super.key});

  /// Resolves theme and auth state, then routes to login or dashboard.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeAsync = ref.watch(themeModeProvider);
    final authAsync = ref.watch(authProvider);

    return themeAsync.when(
      loading: () => _FinViewMaterialApp(
        home: const _BootstrapLoadingScreen(),
      ),
      error: (error, stackTrace) => _FinViewMaterialApp(
        home: PortfolioErrorView(
          title: 'Unable to start app',
          message: error.toString(),
        ),
      ),
      data: (themeMode) {
        return authAsync.when(
          loading: () => _FinViewMaterialApp(
            themeMode: themeMode,
            home: const _BootstrapLoadingScreen(),
          ),
          error: (error, stackTrace) => _FinViewMaterialApp(
            themeMode: themeMode,
            home: PortfolioErrorView(
              title: 'Unable to start app',
              message: error.toString(),
            ),
          ),
          data: (isLoggedIn) => _FinViewMaterialApp(
            themeMode: themeMode,
            home: isLoggedIn
                ? const DashboardScreen()
                : const LoginScreen(),
          ),
        );
      },
    );
  }
}

/// Internal [MaterialApp] configured with FinView themes.
class _FinViewMaterialApp extends StatelessWidget {
  /// Creates a material app with optional [themeMode] and [home].
  const _FinViewMaterialApp({
    required this.home,
    this.themeMode,
  });

  final Widget home;
  final ThemeMode? themeMode;

  /// Builds the themed [MaterialApp] shell.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinView Lite',
      debugShowCheckedModeBanner: false,
      theme: AppThemes.light,
      darkTheme: AppThemes.dark,
      themeMode: themeMode,
      home: home,
    );
  }
}

/// Placeholder screen shown while bootstrap providers are loading.
class _BootstrapLoadingScreen extends StatelessWidget {
  const _BootstrapLoadingScreen();

  /// Builds a full-screen loading scaffold.
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: DashboardLoadingView(
        message: 'Starting FinView…',
      ),
    );
  }
}
