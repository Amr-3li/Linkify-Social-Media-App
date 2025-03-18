part of 'get_posts_cubit.dart';

@immutable
sealed class GetPostsState {}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsloading extends GetPostsState {}

final class GetPostsSuccess extends GetPostsState {
  final List<PostModel> posts;
  GetPostsSuccess(this.posts);
}

final class GetPostsFailure extends GetPostsState {
  final String error;
  GetPostsFailure(this.error);
}
