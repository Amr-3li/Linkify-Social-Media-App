import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:meta/meta.dart';

part 'get_more_posts_state.dart';

class GetMorePostsCubit extends Cubit<GetMorePostsState> {
  GetMorePostsCubit(this.postRepo) : super(GetMorePostsInitial());
  final GetPostRepo postRepo;

  Future<void> getMyTimelinePosts() async {
    emit(GetMorePostsloading());
    final response = await postRepo.getMyTimelinePosts();
    response.fold((l) {
      emit(GetMorePostsFailure(l.errMessage));
    }, (r) {
      emit(GetMorePostsSuccess(r));
    });
  }
}
