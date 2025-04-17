part of 'get_search_user_cubit.dart';

@immutable
sealed class GetSearchUserState {}

final class GetSearchUserInitial extends GetSearchUserState {}

final class GetSearchUserLoading extends GetSearchUserState {}

final class GetSearchUserSuccess extends GetSearchUserState {
  final List<UserModel> users;
  GetSearchUserSuccess(this.users);
}

final class GetSearchUserError extends GetSearchUserState {
  final String message;
  GetSearchUserError(this.message);
}
