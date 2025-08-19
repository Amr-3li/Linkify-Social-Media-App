import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:linkify/Features/authentication/data/repository/image_repo.dart';
import 'package:linkify/core/shared_logic/data/repositories/user_data_repo.dart';

part 'update_user_state.dart';

class UpdateUserCubit extends Cubit<UpdateUserState> {
  UpdateUserCubit(this.imageRepo, this.userDataRepo)
      : super(UpdateUserInitial());
  final UserDataRepo userDataRepo;
  final ImageRepo imageRepo;
  CollectionReference collRef = FirebaseFirestore.instance.collection('users');
  Future<void> updateUser(UserModel user) async {
    emit(UpdateUserImageLoading());
    final result = await userDataRepo.updateUser(user);
    result.fold((l) {
      emit(UpdateUserError(l.errMessage));
    }, (r) {
      emit(UpdateUserLoaded());
    });
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
