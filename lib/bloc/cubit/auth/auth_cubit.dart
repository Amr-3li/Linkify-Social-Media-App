// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
      prefs!.setString('id', userCredential.user!.uid);
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SigninFailed(e.code));
    }
  }

  Future<void> signout() async {
    emit(SignoutLoading());
    try {
      await auth.signOut();
      emit(SignoutSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignoutFailed(e.code));
    }
  }

  Future<void> register(
      String username, String email, String phone, String password) async {
    emit(RegisterLoading());
    try {
      UserCredential userCredential = await auth.createUserWithEmailAndPassword(
          email: email, password: password);
      print("asdaasd" + userCredential.user!.uid);
      await collRef.doc(userCredential.user!.uid).set({
        'email': email,
        'name': username,
        'phone': phone,
      });

      emit(RegisterSuccess());
    } on FirebaseException catch (e) {
      emit(RegisterFailed(e.code));
    }
  }
}
