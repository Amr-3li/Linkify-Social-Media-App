// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:true_gym/Features/register/data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  final AuthRepository authRepository;

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collRef = FirebaseFirestore.instance.collection("Users");
  late SharedPreferences prefs;
  Future<void> signin(String email, String password) async {
    prefs = await SharedPreferences.getInstance();
    emit(SigninLoading());
    try {
      await authRepository.signin(email, password);
      prefs.setString('loging', "is logged in");
      emit(SigninSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SigninFailed(e.code));
    }
  }

  Future<void> signout() async {
    emit(SignoutLoading());
    try {
      prefs = await SharedPreferences.getInstance();
      await authRepository.signout();
      prefs.remove('loging');
      emit(SignoutSuccess());
    } on FirebaseAuthException catch (e) {
      emit(SignoutFailed(e.code));
    }
  }
}
