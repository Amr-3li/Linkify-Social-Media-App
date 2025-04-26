part of 'friends_cubit.dart';

@immutable
sealed class FriendsState {}

final class FriendsInitial extends FriendsState {}

final class FriendsLoading extends FriendsState {}

final class FriendsLoaded extends FriendsState {
  final List<UserModel> friends;
  FriendsLoaded(this.friends);
}

final class FriendsError extends FriendsState {
  final String error;
  FriendsError(this.error);
}
