import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this.imageRepo) : super(UpdateUserInitial());
  final ImageRepo imageRepo;
  CollectionReference collRef = FirebaseFirestore.instance.collection('users');
  Future<void> updateUser(UserModel user) async {
    emit(UpdateUserImageLoading());
    try {
      await collRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'phone': user.phone,
        'image': user.image,
        'isMale': user.isMale,
      });
      emit(UpdateUserImageLoaded());
    } on FirebaseAuthException catch (e) {
      emit(UpdateUserError(e.code.toString()));
    }
  }

  updateImage(File image) async {
    emit(UpdateUserImageLoading());
    var result = await imageRepo.uploadImageToFirebase(image);
    result.fold(
      (l) {
        emit(UpdateUserImageError(l.toString()));
      },
      (r) async {
        await collRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
          'image': r,
        });
        emit(UpdateUserImageLoaded());
      },
    );
  }
}
