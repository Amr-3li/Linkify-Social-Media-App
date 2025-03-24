import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:meta/meta.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit(this.postRepo) : super(GetPostsInitial());
  final GetPostRepo postRepo;

  Future<void> getAllPosts() async {
    emit(GetPostsloading());
    final response = await postRepo.getAllPosts();
    response.fold((l) {
      emit(GetPostsFailure(l.errMessage));
    }, (r) {
      emit(GetPostsSuccess(r));
    });
  }
}
