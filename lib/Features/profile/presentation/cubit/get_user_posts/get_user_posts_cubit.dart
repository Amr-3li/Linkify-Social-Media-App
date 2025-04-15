import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/profile/data/repositories/get_user_posts_repo.dart';
import 'package:meta/meta.dart';

part 'get_user_posts_state.dart';

class GetUserPostsCubit extends Cubit<GetUserPostsState> {
  GetUserPostsCubit(this.repo) : super(GetUserPostsInitial());
  final GetUserPostsRepo repo;

  Future<void> getUserPosts(String id) async {
    emit(GetUserPostsloading());
    final result = await repo.getUserPosts(id);
    result.fold(
      (l) => emit(GetUserPostsFailure(l.errMessage)),
      (r) => emit(GetUserPostsLoaded(r)),
    );
  }
}
