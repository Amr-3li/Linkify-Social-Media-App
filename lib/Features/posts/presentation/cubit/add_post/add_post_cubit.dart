import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/posts/data/repository/add_post_repo.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this.postRepo, this.imageRepo) : super(AddPostInitial());
  final AddPostRepo postRepo;
  final ImageRepo imageRepo;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;

  Future<void> addPosts(String description, File? image) async {
    emit(AddPostLoading());
    try {
      UserModel userModel = await firestore
          .collection('users')
          .doc(user.uid)
          .get()
          .then((value) => UserModel.fromJson(value.data()!));
      if (image != null) {
        final response1 = await imageRepo.uploadImageToFirebase(image);
        response1.fold(
          (l) => emit(AddPostFailure("Can't upload image: ${l.errMessage}")),
          (r) async {
            final response = await postRepo.addPost(
              PostModel(
                time: DateTime.now().microsecondsSinceEpoch.toString(),
                description: description,
                imageUrl: r,
                userId: user.uid,
                userName: "${userModel.fname} ${userModel.lname}",
                userImage: userModel.image ?? "",
                likes: [],
                comments: [],
                shares: 0,
              ),
            );
            response.fold(
              (l) => emit(AddPostFailure("Sorry, can't post: ${l.errMessage}")),
              (r) => emit(AddPostSuccess()),
            );
          },
        );
      } else {
        final response = await postRepo.addPost(
          PostModel(
            time: DateTime.now().microsecondsSinceEpoch.toString(),
            description: description,
            imageUrl: '',
            userId: user.uid,
            userName: "${userModel.fname} ${userModel.lname}",
            userImage: userModel.image ?? "",
            likes: [],
            comments: [],
            shares: 0,
          ),
        );
        response.fold(
          (l) => emit(AddPostFailure("Sorry, can't post: ${l.errMessage}")),
          (r) => emit(AddPostSuccess()),
        );
      }
    } catch (e) {
      emit(AddPostFailure("Unexpected error: $e"));
    }
  }
}
