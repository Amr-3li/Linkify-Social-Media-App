import 'package:bloc/bloc.dart';
import 'package:linkify/Features/profile/data/repositories/get_user_status_repo.dart';
import 'package:meta/meta.dart';

part 'get_user_status_state.dart';

class GetUserStatusCubit extends Cubit<GetUserStatusState> {
  GetUserStatusCubit(this.repo) : super(GetUserStatusInitial());
  final GetUserStatusRepo repo;
  Future<void> userStatus(String toId) async {
    emit(GetUserStatusLoading());
    final response = await repo.userStatus(toId);
    response.fold((l) {
      emit(GetUserStatusFailure(l.errMessage));
    }, (r) {
      emit(GetUserStatusLoadded(r));
    });
  }
}
