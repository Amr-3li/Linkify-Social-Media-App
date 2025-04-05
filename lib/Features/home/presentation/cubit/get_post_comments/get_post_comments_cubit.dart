import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/comment_model.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:meta/meta.dart';

part 'get_post_comments_state.dart';

class GetPostCommentsCubit extends Cubit<GetPostCommentsState> {
  GetPostCommentsCubit(this.postRepo) : super(GetPostCommentsInitial());
  final GetPostRepo postRepo;

  Future<void> getComments(String postTime) async {
    if (isClosed) return;
    emit(GetPostCommentsloading());
    final response = await postRepo.getComments(postTime);
    if (isClosed) return;
    response.fold((l) {
      if (!isClosed) emit(GetPostCommentsFailure(l.errMessage));
    }, (r) {
      if (!isClosed) emit(GetPostCommentsSuccess(r));
    });
  }
}
