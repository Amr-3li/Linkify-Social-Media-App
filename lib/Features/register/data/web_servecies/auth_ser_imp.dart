import 'package:cloud_firestore/cloud_firestore.dart';
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

  CollectionReference refs = FirebaseFirestore.instance.collection("users");
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

    String? id = userCredential.user?.uid;
    //مهمه to ensure that the user not exist in firebase if not exist add it
    DocumentSnapshot snapshot = await refs.doc(id).get();
    var data = snapshot.data();
    if (data == null) {
      await refs.doc(userCredential.user!.uid).set({
        'email': userCredential.user?.email ?? "",
        'fname': userCredential.user?.displayName?.split(' ')[0] ?? "",
        'lname': userCredential.user?.displayName?.split(' ')[1] ?? "",
        'image': userCredential.user?.photoURL ?? "",
        'isMale': true,
        'uid': id ?? "",
        'phone': userCredential.user?.phoneNumber ?? "",
      });
    } else {
      print("the user already exist");
    }
  }
}
