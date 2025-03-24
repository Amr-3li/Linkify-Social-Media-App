part of 'get_post_lovers_cubit.dart';

@immutable
sealed class GetPostLoversState {}

final class GetPostLoversInitial extends GetPostLoversState {}

final class GetPostLoversloading extends GetPostLoversState {}

final class GetPostLoversSuccess extends GetPostLoversState {
  final List<LoverModel> lovers;
  GetPostLoversSuccess(this.lovers);
}

final class GetPostLoversFailure extends GetPostLoversState {
  final String errMessage;
  GetPostLoversFailure(this.errMessage);
}
