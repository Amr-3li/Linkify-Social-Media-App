// ignore_for_file: depend_on_referenced_packages

import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:image_picker/image_picker.dart';
import 'package:true_gym/Features/register/data/model/user.dart';

part 'user_state.dart';

class UserCubit extends Cubit<UserState> {
  UserCubit() : super(UserInitial());
  CollectionReference collRef = FirebaseFirestore.instance.collection('users');
  Future<void> getUserData() async {
    emit(UserLoading());
    try {
      UserModel? user = await collRef
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) =>
              UserModel.fromJson(value.data() as Map<String, dynamic>));
      if (user != null) {
        emit(UserLoaded(user));
      } else {
        emit(UserError('user not found'));
      }
    } on FirebaseAuthException catch (e) {
      emit(UserError(e.code.toString()));
    }
  }

  Future<void> updateUser(UserModel user) async {
    emit(UserLoading());
    try {
      await collRef.doc(FirebaseAuth.instance.currentUser!.uid).update({
        'fname': user.fname,
        'lname': user.lname,
        'email': user.email,
        'phone': user.phone,
        'image': user.image,
        'last_active': user.lastActive.toIso8601String(),
        'isPatient': user.isPatient,
        'weight': user.weight,
        'height': user.height,
        'isMale': user.isMale,
      });
      emit(UserLoaded(user));
    } on FirebaseAuthException catch (e) {
      emit(UserError(e.code.toString()));
    }
  }

  File? imageFile;
  Future<void> getImage() async {
    emit(UploadImageLoading());
    await ImagePicker().pickImage(source: ImageSource.gallery).then((value) {
      if (value != null) {
        imageFile = File(value.path);
        emit(UploadImageSuccess(imageFile!));
      } else {
        emit(UploadImageError('no image selected'));
      }
    });
  }
}
