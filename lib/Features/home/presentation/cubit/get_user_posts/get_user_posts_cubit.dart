import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:meta/meta.dart';

part 'get_user_posts_state.dart';

class GetUserPostsCubit extends Cubit<GetUserPostsState> {
  GetUserPostsCubit(this.postRepo) : super(GetUserPostsInitial());
  final GetPostRepo postRepo;

  Future<void> getUserPosts(String id) async {
    emit(GetUserPostsloading());
    final response = await postRepo.getUserPosts(id);
    response.fold((l) {
      emit(GetUserPostsFailure(l.errMessage));
    }, (r) {
      emit(GetUserPostsSuccess(r));
    });
  }
}
