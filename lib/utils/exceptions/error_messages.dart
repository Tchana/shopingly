import 'package:firebase_auth/firebase_auth.dart';

/// Turns any error thrown by Firebase into a message that is safe to show to the user.
String shopinglyErrorMessage(Object error) {
  if (error is FirebaseAuthException) {
    return switch (error.code) {
      'invalid-email' => 'The email address is not valid.',
      'user-disabled' => 'This account has been disabled. Please contact support.',
      'user-not-found' ||
      'wrong-password' ||
      'invalid-credential' =>
        'Incorrect email or password.',
      'email-already-in-use' => 'An account already exists for that email.',
      'weak-password' => 'Please choose a stronger password.',
      'operation-not-allowed' =>
        'Email/password sign-in is not enabled for this app yet.',
      'too-many-requests' => 'Too many attempts. Please try again later.',
      'network-request-failed' =>
        'No internet connection. Please check your network and try again.',
      'requires-recent-login' => 'Please sign in again to continue.',
      _ => 'Authentication failed (${error.code}). Please try again.',
    };
  }

  if (error is FirebaseException) {
    return switch (error.code) {
      'permission-denied' => 'You do not have permission to do that.',
      'unavailable' =>
        'The service is unavailable. Please check your connection and try again.',
      _ => 'Something went wrong (${error.code}). Please try again.',
    };
  }

  return 'Something went wrong. Please try again.';
}
