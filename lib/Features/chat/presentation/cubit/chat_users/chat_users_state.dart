part of 'chat_users_cubit.dart';

@immutable
sealed class ChatUsersState {}

final class ChatUsersInitial extends ChatUsersState {}

final class ChatUsersLoading extends ChatUsersState {}

final class ChatUsersLoaded extends ChatUsersState {
  final List<UserModel> users;
  ChatUsersLoaded(this.users);
}

final class ChatUsersError extends ChatUsersState {
  final String message;
  ChatUsersError(this.message);
}
