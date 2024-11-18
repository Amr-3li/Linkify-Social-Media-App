import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';

part 'signup_state.dart';

class SignUpCupit extends Cubit<SignUpState> {
  SignUpCupit(this.imageRepo) : super(SignUpInitial());

  final ImageRepo imageRepo;

  Future<String> uploadImageToFirebase(File image) async {
    String url = '';
    var result = await imageRepo.uploadImageToFirebase(image);
    result.fold((l) {
      emit(SignUpError(l.errMessage));
    }, (r) {
      emit(SignUpSuccess());
      url = r;
    });
    return url;
  }

  Future<void> register(UserModel user) async {
    emit(SignUpLoading());
  }
}
