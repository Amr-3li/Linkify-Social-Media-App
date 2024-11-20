import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/register/data/web_servecies/auth_ser.dart';

class AuthWebServiceImplement implements AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  AuthWebServiceImplement();
  @override
  Future<String> signin(String username, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: username, password: password);
    String id = userCredential.user!.uid;
    print("user id: $id");
    return id;
  }

  @override
  Future<void> signout() async {
    await auth.signOut();
  }
}
