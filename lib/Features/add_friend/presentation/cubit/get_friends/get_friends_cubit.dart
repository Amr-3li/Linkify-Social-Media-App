import 'package:bloc/bloc.dart';
import 'package:linkify/Features/add_friend/data/repository/get_friends_or_requests_repo.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

part 'get_friends_state.dart';

class GetFriendsCubit extends Cubit<GetFriendsState> {
  GetFriendsCubit(this.repo) : super(GetFriendsInitial());
  final GetFriendsOrRequestsRepo repo;

  Future<void> getUserFrinds() async {
    emit(GetFriendsLoading());
    final result = await repo.getUserFrinds();
    result.fold(
      (l) => emit(GetFriendsError(l.errMessage)),
      (r) => emit(GetFriendsLoaded(r)),
    );
  }
}
