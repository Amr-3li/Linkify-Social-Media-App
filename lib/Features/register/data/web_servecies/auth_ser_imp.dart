import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkify/Features/register/data/web_servecies/auth_ser.dart';

class AuthWebServiceImplement implements AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  AuthWebServiceImplement();
  @override
  Future<String> signin(String username, String password) async {
    UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: username, password: password);
    String id = userCredential.user!.uid;

    return id;
  }

  @override
  Future<void> signout() async {
    try {
      List<String> userProviders = currentUser!.providerData
          .map((userInfo) => userInfo.providerId)
          .toList();

      // التعامل مع كل provider
      for (String provider in userProviders) {
        switch (provider) {
          case 'google.com':
            // تسجيل الخروج من Google
            if (await GoogleSignIn().isSignedIn()) {
              await GoogleSignIn().signOut();
            }
            break;

          // case 'facebook.com':
          //   // تسجيل الخروج من Facebook
          //   await FacebookAuth.instance.logOut();
          //   break;

          case 'password':
            // Email/Password لا يحتاج sign out منفصل لأن Firebase Auth بيتولاه
            break;

          // لو عندك providers تانية (مثل Twitter أو GitHub)
          case 'twitter.com':
            // أضف منطق تسجيل الخروج من Twitter هنا
            break;

          default:
            print("Unsupported provider: $provider");
        }
      }

      // تسجيل الخروج من Firebase Auth بعد التعامل مع الـ providers
      await auth.signOut();

      print("User signed out successfully.");
    } catch (e) {
      print('Error during sign-out: $e');
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
        'fname': userCredential.user?.displayName?.split(' ')[0] ?? "",
        'lname': userCredential.user?.displayName?.split(' ')[1] ?? "",
        'image': userCredential.user?.photoURL ?? "",
        'isMale': true,
        'isActive': true,
        'uid': id ?? "",
        'phone': userCredential.user?.phoneNumber ?? "",
      });
    }
    return id!;
  }
}
