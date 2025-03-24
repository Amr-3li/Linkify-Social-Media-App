part of 'get_user_posts_cubit.dart';

@immutable
sealed class GetUserPostsState {}

final class GetUserPostsInitial extends GetUserPostsState {}

final class GetUserPostsloading extends GetUserPostsState {}

final class GetUserPostsSuccess extends GetUserPostsState {
  final List<PostModel> posts;
  GetUserPostsSuccess(this.posts);
}

final class GetUserPostsFailure extends GetUserPostsState {
  final String errMessage;
  GetUserPostsFailure(this.errMessage);
}
