import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkify/Features/authentication/data/web_servecies/auth_ser.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/services/sharedpreference_singelton.dart';

class AuthWebServiceImplement implements AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;

  AuthWebServiceImplement();

  @override
  Future<String> signin(String username, String password) async {
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception("User not found after sign in.");
      }
      String id = user.uid;
      SharedPreferenceSingelton.setString('uid', id);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .get()
          .then((value) {
        if (value.exists) {
          SharedPreferenceSingelton.setString(
              'userName', "${value.data()!['name']}");
          SharedPreferenceSingelton.setString(
              'userImage', value.data()!['image'] ?? "");
          SharedPreferenceSingelton.setString(
              'email', value.data()!['email'] ?? "");
        }
      });
      return id;
    } on FirebaseAuthException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw "sorry something went wrongssss";
    }
  }

  @override
  Future<void> signout() async {
    try {
      List<String> userProviders = currentUser!.providerData
          .map((userInfo) => userInfo.providerId)
          .toList();
      for (String provider in userProviders) {
        switch (provider) {
          case 'google.com':
            if (await GoogleSignIn().isSignedIn()) {
              await GoogleSignIn().signOut();
            }
            break;
          case 'password':
            break;
          case 'twitter.com':
            break;
          default:
        }
      }
      // تسجيل الخروج من Firebase Auth بعد التعامل مع الـ providers
      await auth.signOut();
      SharedPreferenceSingelton.remove('uid');
      SharedPreferenceSingelton.remove('userName');
      SharedPreferenceSingelton.remove('userImage');
      SharedPreferenceSingelton.remove('email');
    } catch (e) {
      rethrow;
    }
  }

  CollectionReference refs = FirebaseFirestore.instance.collection("users");
  @override
  Future<String> signinWithGoogle() async {
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
        'name': userCredential.user?.displayName ?? "",
        'image': userCredential.user?.photoURL ?? "",
        'isMale': true,
        'isActive': true,
        'uid': id ?? "",
        'phone': userCredential.user?.phoneNumber ?? "",
      });
    }
    SharedPreferenceSingelton.setString('uid', id!);
    SharedPreferenceSingelton.setString(
        'userName', userCredential.user!.displayName!);
    SharedPreferenceSingelton.setString(
        'userImage', userCredential.user!.photoURL!);
    SharedPreferenceSingelton.setString(
        'email', userCredential.user!.email ?? "");
    return id;
  }
}
