import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:linkify/Features/register/data/web_servecies/auth_ser.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthWebServiceImplement implements AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;
  User? get currentUser => auth.currentUser;
  SharedPreferences? prefs;

  AuthWebServiceImplement();

  @override
  Future<String> signin(String username, String password) async {
    try {
      prefs = await SharedPreferences.getInstance();
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
        email: username,
        password: password,
      );
      final user = userCredential.user;
      if (user == null) {
        throw Exception("User not found after sign in.");
      }
      String id = user.uid;
      prefs!.setString('uid', id);
      await FirebaseFirestore.instance
          .collection("users")
          .doc(id)
          .get()
          .then((value) {
        if (value.exists) {
          prefs!.setString('userName', "${value.data()!['name']}");
          prefs!.setString('userImage', value.data()!['image'] ?? "");
        }
      });
      return id;
    } on FirebaseAuthException catch (e) {
      throw _handleFirebaseAuthError(e);
    } catch (e) {
      throw "sorry something went wrongssss";
    }
  }

  @override
  Future<void> signout() async {
    prefs = await SharedPreferences.getInstance();
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
      prefs!.remove('uid');
      prefs!.remove('userName');
      prefs!.remove('userImage');
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
    prefs = await SharedPreferences.getInstance();
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
    prefs!.setString('uid', id!);
    prefs!.setString('userName', userCredential.user!.displayName!);
    prefs!.setString('userImage', userCredential.user!.photoURL!);
    return id;
  }

  //===================== anuther uses functions==============================
  String _handleFirebaseAuthError(FirebaseAuthException e) {
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
