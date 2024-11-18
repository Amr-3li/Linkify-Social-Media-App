import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser.dart';

class AuthWebServiceImplement implements AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthWebServiceImplement();
  @override
  Future<void> signin(String username, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: username, password: password);
      if (userCredential.user != null) {}
    } catch (e) {
      print(e.toString());
    }
  }

  @override
  Future<bool> signout() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
