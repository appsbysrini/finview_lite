import 'package:flutter_riverpod/legacy.dart';

/// Validation or credential error shown on the login form.
final loginErrorProvider = StateProvider<String?>(
  (ref) => null,
);

/// Whether a login attempt is currently in progress.
final loginSubmittingProvider = StateProvider<bool>(
  (ref) => false,
);
