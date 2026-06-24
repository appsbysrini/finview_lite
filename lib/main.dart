import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'screens/dashboard_screen.dart';

void main() {
  runApp(
    const ProviderScope(
      child: FinViewLiteApp(),
    ),
  );
}

/// Root application widget for FinView Lite.
class FinViewLiteApp extends StatelessWidget {
  /// Creates the app shell with Riverpod scope already applied upstream.
  const FinViewLiteApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FinView Lite',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const DashboardScreen(),
    );
  }
}
