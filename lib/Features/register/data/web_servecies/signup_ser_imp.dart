import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/register/data/web_servecies/signup_ser.dart';

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
      throw _handleFirebaseRegistrationError(e);
    }
  }

  //========================== another Functions ==========================

  String _handleFirebaseRegistrationError(FirebaseAuthException e) {
    switch (e.code) {
      case 'email-already-in-use':
        return 'البريد الإلكتروني مستخدم بالفعل';
      case 'invalid-email':
        return 'بريد إلكتروني غير صالح';
      case 'operation-not-allowed':
        return 'هذه العملية غير مسموح بها';
      case 'weak-password':
        return 'كلمة المرور ضعيفة، يجب أن تكون 6 أحرف على الأقل';
      case 'too-many-requests':
        return 'محاولات كثيرة، حاول لاحقاً';
      // Network-related errors
      case 'network-request-failed':
        return 'فشل الاتصال بالإنترنت';
      // Common errors that might occur during registration
      case 'invalid-verification-code':
        return 'كود التحقق غير صحيح';
      case 'invalid-verification-id':
        return 'معرف التحقق غير صحيح';
      // Firebase project configuration errors
      case 'configuration-not-found':
        return 'إعدادات التطبيق غير مكتملة';
      // Default case
      default:
        return 'حدث خطأ غير متوقع أثناء التسجيل: ${e.code}';
    }
  }
}
