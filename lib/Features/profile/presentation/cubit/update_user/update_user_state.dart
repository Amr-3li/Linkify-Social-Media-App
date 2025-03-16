part of 'update_user_cubit.dart';

sealed class UpdateUserState {}

final class UpdateUserInitial extends UpdateUserState {}

//=============update user data states============================================
final class UpdateUserLoading extends UpdateUserState {}

final class UpdateUserLoaded extends UpdateUserState {}

final class UpdateUserError extends UpdateUserState {
  String message;
  UpdateUserError(this.message);
}

//=============update user image states============================================
final class UpdateUserImageLoading extends UpdateUserState {}

final class UpdateUserImageLoaded extends UpdateUserState {}

final class UpdateUserImageError extends UpdateUserState {
  String message;
  UpdateUserImageError(this.message);
}
