import 'package:flutter/material.dart';

import 'app_loading_indicator.dart';

/// Full-screen loading state for dashboard and bootstrap flows.
class DashboardLoadingView extends StatelessWidget {
  /// Creates a centered dashboard loading view.
  const DashboardLoadingView({
    super.key,
    this.message = 'Loading portfolio…',
  });

  /// Message shown below the loading indicator.
  final String message;

  /// Builds the centered loading indicator and optional message.
  @override
  Widget build(BuildContext context) {
    return Center(
      child: AppLoadingIndicator(
        fullScreen: true,
        message: message,
      ),
    );
  }
}
