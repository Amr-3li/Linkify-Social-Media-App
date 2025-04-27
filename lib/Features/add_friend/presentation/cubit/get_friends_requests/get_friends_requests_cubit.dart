import 'package:bloc/bloc.dart';
import 'package:linkify/Features/add_friend/data/repository/get_friends_or_requests_repo.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

part 'get_friends_requests_state.dart';

class GetFriendsRequestsCubit extends Cubit<GetFriendsRequestsState> {
  GetFriendsRequestsCubit(this.repo) : super(GetFriendsRequestsInitial());
  final GetFriendsOrRequestsRepo repo;

  Future<void> getFriendRequests() async {
    emit(GetFriendsRequestsLoading());
    final result = await repo.getFriendRequests();
    result.fold(
      (l) => emit(GetFriendsRequestsError(l.errMessage)),
      (r) => emit(GetFriendsRequestsLoaded(r)),
    );
  }
}
