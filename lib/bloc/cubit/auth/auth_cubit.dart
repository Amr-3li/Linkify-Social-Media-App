// ignore_for_file: depend_on_referenced_packages

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:true_gym/data/repository/auth_repo.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  AuthRepository authRepository;
  AuthCubit(this.authRepository) : super(AuthInitial());

  Future<void> signin(String username, String password) async {
    emit(SigninLoading());
    try {
      await authRepository.signin(username, password);
      emit(SigninSuccess());
    } catch (e) {
      emit(SigninFailed(e.toString()));
    }
  }

  Future<void> signout() async {
    emit(SignoutLoading());
    try {
      await authRepository.signout();
      emit(SignoutSuccess());
    } catch (e) {
      emit(SignoutFailed(e.toString()));
    }
  }

  Future<void> register(String username, String password) async {
    emit(RegisterLoading());
    try {
      await authRepository.register(username, password);
      emit(RegisterSuccess());
    } catch (e) {
      emit(RegisterFailed(e.toString()));
    }
  }
}
