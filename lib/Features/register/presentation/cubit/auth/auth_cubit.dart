// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:linkify/Features/register/data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthCubit(this.authRepository) : super(AuthInitial());
  final AuthRepository authRepository;

  FirebaseAuth auth = FirebaseAuth.instance;
  CollectionReference collRef = FirebaseFirestore.instance.collection("users");
  late SharedPreferences prefs;
  Future<void> signin(String email, String password) async {
    emit(SigninLoading());
    var result = await authRepository.signin(email, password);
    result.fold(
      (l) {
        emit(SigninFailed(l.errMessage));
      },
      (r) {
        emit(SigninSuccess());
      },
    );
  }

  Future<void> signout() async {
    emit(SignoutLoading());
    var result = await authRepository.signout();
    result.fold(
      (l) {
        emit(SignoutFailed(l.errMessage));
      },
      (r) {
        emit(SignoutSuccess());
      },
    );
  }

  Future<void> signInWithGoogle() async {
    emit(SigninWithGoogleLoading());
    var result = await authRepository.signInWithGoogle();
    result.fold(
      (l) {
        emit(SigninWithGoogleFailed(l.errMessage));
      },
      (r) {
        emit(SigninWithGoogleSuccess());
      },
    );
  }

  Future<void> resetePassword(String email) async {
    emit(ResetPasswordLoading());
    try {
      await auth.sendPasswordResetEmail(email: email);
      emit(ResetPasswordSuccess());
    } catch (e) {
      emit(ResetPasswordfaild(error: e.toString()));
    }
  }
}
