import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/repository/post_control_repo.dart';
import 'package:meta/meta.dart';

part 'post_control_state.dart';

class PostControlCubit extends Cubit<PostControlState> {
  PostControlCubit(this.postRepo) : super(PostControlInitial());
  final PostControlRepo postRepo;

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

  Future<void> likePosts(PostModel post) async {
    emit(PostControlLoading());
    final response = await postRepo.likePost(post);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }

  Future<void> addComment(PostModel post) async {
    emit(PostControlLoading());
    final response = await postRepo.addComment(post);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }
}
