import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/settings/data/services/reset_pass.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class ResetPassImpl implements ResetPass {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get user => auth.currentUser;
  @override
  Future<void> resetPass(
      {required String oldPass, required String newPass}) async {
    try {
      if (user == null) {
        throw Exception('No user is currently signed in');
      }
      final String userEmail =
          SharedPreferenceSingelton.getString('email') ?? user!.email!;

      print('Resetting password for email: $userEmail');

      // Re-authenticate user with old password
      final AuthCredential credential = EmailAuthProvider.credential(
        email: userEmail,
        password: oldPass,
      );
      await user!.reauthenticateWithCredential(credential);
      await user!.updatePassword(newPass);
      SharedPreferenceSingelton.setString('email', userEmail);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }

  // Keep the existing reset password method for email reset
  Future<void> sendResetEmail() async {
    try {
      final String? email = SharedPreferenceSingelton.getString('email');
      if (email == null || email.isEmpty) {
        throw Exception('No email found in shared preferences');
      }

      print('Sending reset email to: $email');
      await auth.sendPasswordResetEmail(email: email);
    } on FirebaseAuthException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred: $e');
    }
  }
}
