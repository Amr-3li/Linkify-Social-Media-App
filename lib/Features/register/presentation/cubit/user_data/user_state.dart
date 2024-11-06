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

//==============image==================
final class UploadImageLoading extends UserState {}

final class UploadImageSuccess extends UserState {
  File imageFile;
  UploadImageSuccess(this.imageFile);
}

final class UploadImageError extends UserState {
  String message;
  UploadImageError(this.message);
}
