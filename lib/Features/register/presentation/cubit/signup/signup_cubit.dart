// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:true_gym/Features/register/data/model/user.dart';
import 'package:true_gym/Features/register/data/repository/image_repo.dart';
import 'package:true_gym/Features/register/data/repository/signup_repo.dart';

part 'signup_state.dart';

class SignUpCupit extends Cubit<SignUpState> {
  SignUpCupit(
    this.imageRepo,
    this.signupRepo,
  ) : super(SignUpInitial());

  final ImageRepo imageRepo;
  final SignupRepo signupRepo;

  Future<void> signup(UserModel user, File? image) async {
    emit(SignUpLoading());
    if (image != null) {
      var result = await imageRepo.uploadImageToFirebase(image);
      result.fold(
        (l) {
          emit(SignUpError(l.errMessage));
        },
        (r) async {
          var signupResult = await signupRepo.signup(user..image = r);
          signupResult.fold((left) {
            emit(SignUpError(left.errMessage));
          }, (right) {
            emit(SignUpSuccess());
          });
        },
      );
    } else {
      var signupResult = await signupRepo.signup(user);
      signupResult.fold((left) {
        emit(SignUpError(left.errMessage));
      }, (right) {
        emit(SignUpSuccess());
      });
    }
  }
}
