import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/repository/post_control_repo.dart';
import 'package:meta/meta.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'post_control_state.dart';

class PostControlCubit extends Cubit<PostControlState> {
  PostControlCubit(this.postRepo) : super(PostControlInitial());
  final PostControlRepo postRepo;
  SharedPreferences? prefs;

  Future<void> deletePosts(PostModel post) async {
    emit(PostControlLoading());
    final response = await postRepo.deletePost(post);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }

  Future<void> updatePosts(PostModel post) async {
    emit(PostControlLoading());
    final response = await postRepo.updatePost(post);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }

  Future<void> addRemoveLike(String postTime, String userId) async {
    emit(PostControlLoading());
    final response = await postRepo.addRemoveLike(postTime, userId);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }

  Future<void> addComment(String postTime, String comment) async {
    emit(PostControlLoading());
    prefs = await SharedPreferences.getInstance();
    final commentModel = CommentModel(
        comment: comment,
        userId: prefs!.getString("uid")!,
        postId: postTime,
        time: DateTime.now().microsecondsSinceEpoch.toString(),
        userImage: prefs!.getString("userImage")!,
        userName: prefs!.getString("userName")!);
    final response = await postRepo.addComment(postTime, commentModel);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }

  Future<void> deleteComment(String postTime, CommentModel comment) async {
    emit(PostControlLoading());
    final response = await postRepo.removeComment(postTime, comment);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }
}
