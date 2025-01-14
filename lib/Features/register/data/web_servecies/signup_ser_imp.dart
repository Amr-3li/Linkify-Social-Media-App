import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/web_servecies/signup_ser.dart';

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
        'fname': user.fname,
        'lname': user.lname,
        'image': user.image,
        'isMale': user.isMale,
        'uid': userCredential.user!.uid,
        'phone': user.phone,
      });
    } catch (e) {
      print(e.toString());
    }
  }
}
