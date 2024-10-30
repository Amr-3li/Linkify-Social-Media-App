import 'package:firebase_auth/firebase_auth.dart';

class AuthWebservice {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthWebservice();
  Future<void> signin(String username, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: username, password: password);
      if (userCredential.user != null) {
      
      }
    } catch (e) {
      print(e.toString());
    }
    
  }

  Future<bool> register(String username, String password) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: username, password: password);
      if (userCredential.user != null) {
        return true;
      }
    } catch (e) {
      return false;
    }
    return false;
  }

  Future<bool> signout() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
