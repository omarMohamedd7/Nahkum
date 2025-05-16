import '../entities/user.dart';

/// Abstract repository that defines the contract for authentication operations.
/// Implementation will be provided later when connecting to a real backend.
abstract class AuthRepository {
  /// Authenticates a user with email and password
  Future<User?> signInWithEmailAndPassword(String email, String password);

  /// Authenticates a user with Google Sign-In
  Future<User?> signInWithGoogle();

  /// Logs out the current user
  Future<void> signOut();

  /// Checks if a user is currently signed in
  Future<bool> isSignedIn();

  /// Gets the current authenticated user
  Future<User?> getCurrentUser();

  /// Sends a password reset email to the specified email address
  Future<void> forgotPassword(String email);
}
