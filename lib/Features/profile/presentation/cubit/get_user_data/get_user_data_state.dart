part of 'get_user_data_cubit.dart';

@immutable
sealed class GetUserDataState {}

final class GetUserDataInitial extends GetUserDataState {}

final class GetUserDataLoading extends GetUserDataState {}

final class GetUserDataLoaded extends GetUserDataState {
  final UserModel user;
  GetUserDataLoaded(this.user);
}

final class GetUserDataError extends GetUserDataState {
  final String errMessage;
  GetUserDataError(this.errMessage);
}
