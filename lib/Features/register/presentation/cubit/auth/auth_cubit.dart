// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.imageRepo, this.user) : super(AuthInitial());
  final ImageRepo imageRepo;
  final UserModel user;
  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collRef = FirebaseFirestore.instance.collection("Users");
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
}
