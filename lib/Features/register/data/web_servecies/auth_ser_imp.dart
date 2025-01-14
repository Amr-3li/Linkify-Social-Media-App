import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
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

  @override
  Future<void> signinWithGoogle() async {
    GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
    GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
    AuthCredential credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );
    UserCredential userCredential =
        await FirebaseAuth.instance.signInWithCredential(credential);
    print(userCredential.user?.displayName);
  }
}
