part of 'get_friends_requests_cubit.dart';

@immutable
sealed class GetFriendsRequestsState {}

final class GetFriendsRequestsInitial extends GetFriendsRequestsState {}

final class GetFriendsRequestsLoading extends GetFriendsRequestsState {}

final class GetFriendsRequestsError extends GetFriendsRequestsState {
  final String errMessage;
  GetFriendsRequestsError(this.errMessage);
}

final class GetFriendsRequestsLoaded extends GetFriendsRequestsState {
  final List<UserModel> users;
  GetFriendsRequestsLoaded(this.users);
}
