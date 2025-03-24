import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/lover_model.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:meta/meta.dart';

part 'get_post_lovers_state.dart';

class GetPostLoversCubit extends Cubit<GetPostLoversState> {
  GetPostLoversCubit(this.postRepo) : super(GetPostLoversInitial());
  final GetPostRepo postRepo;

  Future<void> getLoversPost(String postTime) async {
    emit(GetPostLoversloading());
    final response = await postRepo.getLoversPost(postTime);
    response.fold((l) {
      emit(GetPostLoversFailure(l.errMessage));
    }, (r) {
      emit(GetPostLoversSuccess(r));
    });
  }
}
