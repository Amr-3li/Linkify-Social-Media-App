part of 'get_more_posts_cubit.dart';

@immutable
sealed class GetMorePostsState {}

final class GetMorePostsInitial extends GetMorePostsState {}

final class GetMorePostsloading extends GetMorePostsState {}

final class GetMorePostsSuccess extends GetMorePostsState {
  final List<PostModel> morePosts;
  GetMorePostsSuccess(this.morePosts);
}

final class GetMorePostsFailure extends GetMorePostsState {
  final String errMessage;
  GetMorePostsFailure(this.errMessage);
}
