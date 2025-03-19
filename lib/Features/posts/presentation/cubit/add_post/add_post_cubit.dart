import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:meta/meta.dart';

import 'package:linkify/Features/posts/data/model/post_model.dart';
import 'package:linkify/Features/posts/data/repository/post_repo.dart';
import 'package:linkify/Features/register/data/repository/image_repo.dart';

part 'add_post_state.dart';

class AddPostCubit extends Cubit<AddPostState> {
  AddPostCubit(this.postRepo, this.imageRepo) : super(AddPostInitial());
  final PostRepo postRepo;
  final ImageRepo imageRepo;

  FirebaseAuth auth = FirebaseAuth.instance;
  User get user => auth.currentUser!;

  Future<void> addPosts(String description, File? image) async {
    emit(AddPostLoading());
    try {
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
                likes: 0,
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
            likes: 0,
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
