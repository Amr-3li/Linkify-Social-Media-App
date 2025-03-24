part of 'get_post_comments_cubit.dart';

@immutable
sealed class GetPostCommentsState {}

final class GetPostCommentsInitial extends GetPostCommentsState {}

final class GetPostCommentsloading extends GetPostCommentsState {}

final class GetPostCommentsSuccess extends GetPostCommentsState {
  final List<CommentModel> comments;
  GetPostCommentsSuccess(this.comments);
}

final class GetPostCommentsFailure extends GetPostCommentsState {
  final String errMessage;
  GetPostCommentsFailure(this.errMessage);
}
