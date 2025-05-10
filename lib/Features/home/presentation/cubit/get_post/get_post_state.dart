part of 'get_post_cubit.dart';

@immutable
sealed class GetPostState {}

final class GetPostInitial extends GetPostState {}

final class GetPostLoading extends GetPostState {}

final class GetPostSuccess extends GetPostState {
  final PostModel post;
  GetPostSuccess(this.post);
}

final class GetPostFailure extends GetPostState {
  final String errMessage;
  GetPostFailure(this.errMessage);
}
