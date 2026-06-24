import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/app_shell.dart';

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
    return DevicePreview.appBuilder(
      context,
      const AppShell(),
    );
  }
}
