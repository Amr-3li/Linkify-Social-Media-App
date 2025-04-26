import 'package:bloc/bloc.dart';
import 'package:linkify/Features/add_friend/data/repository/get_friends_or_requests_repo.dart';
import 'package:linkify/core/shared_logic/data/models/user.dart';
import 'package:meta/meta.dart';

part 'get_your_requests_state.dart';

class GetYourRequestsCubit extends Cubit<GetYourRequestsState> {
  GetYourRequestsCubit(this.repo) : super(GetYourRequestsInitial());
  final GetFriendsOrRequestsRepo repo;

  Future<void> getUserFrinds() async {
    emit(GetYourRequestsLoading());
    final result = await repo.getUserFrinds();
    result.fold(
      (l) => emit(GetYourRequestsError(l.errMessage)),
      (r) => emit(GetYourRequestsLoaded(r)),
    );
  }
}
