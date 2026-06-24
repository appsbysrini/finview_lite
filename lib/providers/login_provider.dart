import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Holds validation or credential errors shown on the login form.
class LoginErrorNotifier extends Notifier<String?> {
  /// Returns no error when the provider is first watched.
  @override
  String? build() => null;

  /// Sets or clears the login form error message.
  void setError(String? message) {
    state = message;
  }
}

/// Validation or credential error shown on the login form.
final loginErrorProvider = NotifierProvider<LoginErrorNotifier, String?>(
  LoginErrorNotifier.new,
);

/// Tracks whether a login attempt is currently in progress.
class LoginSubmittingNotifier extends Notifier<bool> {
  /// Returns false when the provider is first watched.
  @override
  bool build() => false;

  /// Updates whether a login submission is in progress.
  void setSubmitting(bool isSubmitting) {
    state = isSubmitting;
  }
}

/// Whether a login attempt is currently in progress.
final loginSubmittingProvider =
    NotifierProvider<LoginSubmittingNotifier, bool>(
  LoginSubmittingNotifier.new,
);
