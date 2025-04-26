part of 'get_your_requests_cubit.dart';

@immutable
sealed class GetYourRequestsState {}

final class GetYourRequestsInitial extends GetYourRequestsState {}

final class GetYourRequestsLoading extends GetYourRequestsState {}

final class GetYourRequestsError extends GetYourRequestsState {
  final String errMessage;
  GetYourRequestsError(this.errMessage);
}

final class GetYourRequestsLoaded extends GetYourRequestsState {
  final List<UserModel> users;
  GetYourRequestsLoaded(this.users);
}
