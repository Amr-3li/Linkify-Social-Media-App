part of 'get_user_status_cubit.dart';

@immutable
sealed class GetUserStatusState {}

final class GetUserStatusInitial extends GetUserStatusState {}

final class GetUserStatusLoading extends GetUserStatusState {}

final class GetUserStatusFailure extends GetUserStatusState {
  final String error;
  GetUserStatusFailure(this.error);
}

final class GetUserStatusLoadded extends GetUserStatusState {
  final String response;
  GetUserStatusLoadded(this.response);
}
