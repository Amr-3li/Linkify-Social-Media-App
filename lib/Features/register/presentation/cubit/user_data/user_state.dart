part of 'user_cubit.dart';

sealed class UserState {}

final class UserInitial extends UserState {}

final class UserLoading extends UserState {}

final class UserLoaded extends UserState {
  UserModel user;
  UserLoaded(this.user);
}

final class UserError extends UserState {
  String message;
  UserError(this.message);
}

//===================current user states=======================================
final class CurrentUserLoading extends UserState {}

final class CurrentUserLoaded extends UserState {
  UserModel user;
  CurrentUserLoaded(this.user);
}

final class CurrentUserError extends UserState {
  String message;
  CurrentUserError(this.message);
}

//================get all users states============================================
final class AllUsersLoading extends UserState {}

final class AllUsersLoaded extends UserState {
  List<UserModel> users;
  AllUsersLoaded(this.users);
}

final class AllUsersError extends UserState {
  String message;
  AllUsersError(this.message);
}

//================search user states============================================
final class SearchUserLoading extends UserState {}

final class SearchUserLoaded extends UserState {
  List<UserModel> users;
  SearchUserLoaded(this.users);
}

final class SearchUserError extends UserState {
  String message;
  SearchUserError(this.message);
}
