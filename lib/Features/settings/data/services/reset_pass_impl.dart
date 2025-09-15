import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/Features/settings/data/services/reset_pass.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class ResetPassImpl implements ResetPass {
  FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Future<void> resetPass() async {
    try {
      print(SharedPreferenceSingelton.getString('email'));
      await auth.sendPasswordResetEmail(
          email: SharedPreferenceSingelton.getString('email'));
    } on FirebaseAuthException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw Exception('An unexpected error occurred');
    }
  }
}
