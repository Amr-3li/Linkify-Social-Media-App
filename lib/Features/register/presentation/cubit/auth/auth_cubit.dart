// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit() : super(AuthInitial());
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collRef = FirebaseFirestore.instance.collection("users");
  late SharedPreferences prefs;
  Future<void> signin(String username, String password) async {
    prefs = await SharedPreferences.getInstance();
    emit(SigninLoading());
    try {
      UserCredential userCredential = await auth.signInWithEmailAndPassword(
          email: username, password: password);
      prefs.setString('id', userCredential.user!.uid);
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SigninFailed(e.code));
    }
  }

  Future<void> signout() async {
    emit(SignoutLoading());
    try {
      prefs = await SharedPreferences.getInstance();
      await auth.signOut();
      prefs.remove('id');
      emit(SignoutSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignoutFailed(e.code));
    }
  }

  Future<void> register(UserModel user) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: user.email, password: user.password);
      await collRef.doc(userCredential.user!.uid).set({
        'email': user.email,
        'fname': user.fname,
        'lname': user.lname,
        'image': user.image,
        'last_active': user.lastActive.toIso8601String(),
        'isPatient': user.isPatient,
        'weight': user.weight,
        'height': user.height,
        'isMale': user.isMale,
        'uid': userCredential.user!.uid,
        'phone': user.phone,
      });

      emit(RegisterSuccess());
    } on FirebaseException catch (e) {
      emit(RegisterFailed(e.code));
    }
  }
}
