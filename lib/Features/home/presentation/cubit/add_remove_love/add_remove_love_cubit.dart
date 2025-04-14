import 'package:bloc/bloc.dart';
import 'package:linkify/core/shared_logic/data/repositories/post_control_repo.dart';
import 'package:meta/meta.dart';

part 'add_remove_love_state.dart';

class AddRemoveLoveCubit extends Cubit<AddRemoveLoveState> {
  AddRemoveLoveCubit(this.postRepo) : super(AddRemoveLoveInitial());
  final PostControlRepo postRepo;
  Future<void> addRemoveLike(String postTime, String userId) async {
    emit(AddRemoveLoveLoading());
    final response = await postRepo.addRemoveLike(postTime, userId);
    response.fold((l) {
      emit(AddRemoveLoveFailure(l.errMessage));
    }, (r) {
      emit(AddRemoveLoveSuccess());
    });
  }
}
