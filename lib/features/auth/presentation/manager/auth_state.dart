import 'package:flutter/foundation.dart';
import '../../domain/entities/user.dart';

/// Represents the authentication state for the UI.
/// This class will be used in the future when implementing state management.
@immutable
class AuthState {
  final bool isLoading;
  final String? errorMessage;
  final User? user;

  const AuthState({
    this.isLoading = false,
    this.errorMessage,
    this.user,
  });

  bool get isAuthenticated => user != null;

  AuthState copyWith({
    bool? isLoading,
    String? errorMessage,
    User? user,
  }) {
    return AuthState(
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage ?? this.errorMessage,
      user: user ?? this.user,
    );
  }

  AuthState clearError() {
    return AuthState(
      isLoading: isLoading,
      user: user,
    );
  }
}
