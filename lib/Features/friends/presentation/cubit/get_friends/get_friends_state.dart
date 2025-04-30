part of 'get_friends_cubit.dart';

@immutable
sealed class GetFriendsState {}

final class GetFriendsInitial extends GetFriendsState {}

final class GetFriendsLoading extends GetFriendsState {}

final class GetFriendsLoaded extends GetFriendsState {
  final List<UserModel> friends;
  GetFriendsLoaded(this.friends);
}

final class GetFriendsError extends GetFriendsState {
  final String errMessage;
  GetFriendsError(this.errMessage);
}
