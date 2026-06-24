import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'widgets/app_shell.dart';

/// Application entry point; wraps the app in Riverpod.
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

  /// Builds the root widget tree inside the DevicePreview wrapper.
  @override
  Widget build(BuildContext context) {
    return DevicePreview.appBuilder(
      context,
      const AppShell(),
    );
  }
}
