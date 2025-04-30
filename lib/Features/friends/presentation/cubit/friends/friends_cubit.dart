import 'package:bloc/bloc.dart';
import 'package:linkify/Features/friends/data/repository/friends_repo.dart';
import 'package:meta/meta.dart';

part 'friends_state.dart';

class FriendsCubit extends Cubit<FriendsState> {
  FriendsCubit(this.repo) : super(FriendsInitial());
  final FriendsRepo repo;
  Future<void> sendFriendRequest(String toId) async {
    final result = await repo.sendFriendRequest(toId);
    result.fold(
      (l) => emit(FriendsError(l.errMessage)),
      (r) => emit(FriendsLoaded()),
    );
  }

  Future<void> unSendFriendRequest(String toId) async {
    final result = await repo.unSendFriendRequest(toId);
    result.fold(
      (l) => emit(FriendsError(l.errMessage)),
      (r) => emit(FriendsLoaded()),
    );
  }

  Future<void> removeFriend(String toId) async {
    final result = await repo.removeFriend(toId);
    result.fold(
      (l) => emit(FriendsError(l.errMessage)),
      (r) => emit(FriendsLoaded()),
    );
  }

  Future<void> rejectFriendRequest(String fromId) async {
    final result = await repo.rejectFriendRequest(fromId);
    result.fold(
      (l) => emit(FriendsError(l.errMessage)),
      (r) => emit(FriendsLoaded()),
    );
  }

  Future<void> acceptFriendRequest(String fromId) async {
    final result = await repo.acceptFriendRequest(fromId);
    result.fold(
      (l) => emit(FriendsError(l.errMessage)),
      (r) => emit(FriendsLoaded()),
    );
  }
}
