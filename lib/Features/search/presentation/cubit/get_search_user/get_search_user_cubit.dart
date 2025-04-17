import 'package:bloc/bloc.dart';
import 'package:linkify/Features/search/data/repositories/get_search_users_repo.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

part 'get_search_user_state.dart';

class GetSearchUserCubit extends Cubit<GetSearchUserState> {
  GetSearchUserCubit(this.repo) : super(GetSearchUserInitial());
  final GetSearchUsersRepo repo;

  Future<void> getUsersBySearch(String search) async {
    emit(GetSearchUserLoading());
    final failureOrUsers = await repo.getUsersBySearch(search);
    failureOrUsers.fold(
        (failure) => emit(GetSearchUserError(failure.errMessage)),
        (users) => emit(GetSearchUserSuccess(users)));
  }
}
