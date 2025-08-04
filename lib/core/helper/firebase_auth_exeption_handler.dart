import 'package:firebase_auth/firebase_auth.dart';

class FirebaseAuthExeptionHandler {
  static String handleFirebaseAuthError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'This email is already registered';
      case 'invalid-email':
        return 'Please enter a valid email address';
      case 'operation-not-allowed':
        return 'This operation is not allowed';
      case 'weak-password':
        return 'Password should be at least 6 characters';

      case 'user-not-found':
        return 'No account found with this email';
      case 'wrong-password':
        return 'Incorrect password';
      case 'user-disabled':
        return 'This account has been disabled';

      case 'invalid-credential':
        return 'Invalid authentication credentials';
      case 'invalid-verification-code':
        return 'Invalid verification code';
      case 'invalid-verification-id':
        return 'Invalid verification ID';
      case 'session-expired':
        return 'Session expired, please try again';

      case 'network-request-failed':
        return 'Network error, please check your connection';
      case 'too-many-requests':
        return 'Too many attempts, try again later';
      case 'internal-error':
        return 'Internal server error';

      case 'multi-factor-auth-required':
        return 'Two-factor authentication required';
      case 'second-factor-already-in-use':
        return 'This 2FA method is already registered';

      case 'provider-already-linked':
        return 'Account is already linked with this provider';
      case 'credential-already-in-use':
        return 'This credential is already associated with another account';

      case 'requires-recent-login':
        return 'Please sign in again to verify your identity';
      case 'unauthorized-domain':
        return 'Unauthorized domain for this operation';
      case 'app-not-authorized':
        return 'App not authorized to perform this action';

      case 'invalid-phone-number':
        return 'Invalid phone number format';
      case 'quota-exceeded':
        return 'SMS quota exceeded, try again later';
      case 'captcha-check-failed':
        return 'CAPTCHA verification failed';
      case 'missing-verification-code':
        return 'Verification code is required';

      case 'expired-action-code':
        return 'The action code has expired';
      case 'invalid-action-code':
        return 'Invalid verification code';

      default:
        return 'Authentication failed: ${e.code}';
    }
  }
}
