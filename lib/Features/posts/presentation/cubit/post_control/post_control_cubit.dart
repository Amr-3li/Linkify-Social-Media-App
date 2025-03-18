import 'package:bloc/bloc.dart';
import 'package:linkify/Features/posts/data/model/post_model.dart';
import 'package:linkify/Features/posts/data/repository/post_repo.dart';
import 'package:meta/meta.dart';

part 'post_control_state.dart';

class PostControlCubit extends Cubit<PostControlState> {
  PostControlCubit(this.postRepo) : super(PostControlInitial());
  final PostRepo postRepo;
  Future<void> addPosts(PostModel post) async {
    emit(PostControlLoading());
    final response = await postRepo.addPost(post);
    response.fold((l) {
      emit(PostControlFailure(l.errMessage));
    }, (r) {
      emit(PostControlSuccess());
    });
  }

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
}
