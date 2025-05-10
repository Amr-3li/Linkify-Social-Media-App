import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:meta/meta.dart';

part 'get_post_state.dart';

class GetPostCubit extends Cubit<GetPostState> {
  GetPostCubit(this.postRepo) : super(GetPostInitial());
  final GetPostRepo postRepo;
  Future<void> getPost(PostModel post) async {
    emit(GetPostLoading());
    final response = await postRepo.getPost(post.time);
    response.fold((l) {
      emit(GetPostFailure(l.errMessage));
    }, (r) {
      emit(GetPostSuccess(r));
    });
  }
}
