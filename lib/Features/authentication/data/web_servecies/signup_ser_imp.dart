import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/core/helper/firebase_exeption_handler.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/authentication/data/web_servecies/signup_ser.dart';

class SignupSerImplementation implements SignupService {
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collRef = FirebaseFirestore.instance.collection("users");

  @override
  Future<void> register(UserModel user) async {
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await collRef.doc(userCredential.user!.uid).set({
        'email': user.email,
        'name': user.name,
        'image': user.image,
        'isMale': user.isMale,
        'searchWords': [
          user.name.split(' ')[0].toLowerCase(),
          user.name.split(' ')[1].toLowerCase(),
          user.name.toLowerCase(),
          user.email
        ],
        'isActive': true,
        'uid': userCredential.user!.uid,
        'phone': user.phone,
      });
    } on FirebaseAuthException catch (e) {
      throw FirebaseExeptionHandler.handleFirebaseAuthError(e);
    } catch (e) {
      throw "sorry something went wrongssss";
    }
  }
}
