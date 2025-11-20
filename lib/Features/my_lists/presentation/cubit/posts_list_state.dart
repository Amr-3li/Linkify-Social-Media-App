part of 'posts_list_cubit.dart';

@immutable
sealed class PostsListState {}

final class PostsListInitial extends PostsListState {}

// LikedPostsList States
final class LikedPostsListLoading extends PostsListState {}

final class LikedPostsListLoaded extends PostsListState {
  final List<PostModel> posts;
  LikedPostsListLoaded(this.posts);
}

final class LikedPostsListError extends PostsListState {
  final String message;
  LikedPostsListError(this.message);
}

// SavedPostsList States
final class SavedPostsListLoaded extends PostsListState {
  final List<PostModel> posts;
  SavedPostsListLoaded(this.posts);
}

final class SavedPostsListLoading extends PostsListState {}

final class SavedPostsListError extends PostsListState {
  final String message;
  SavedPostsListError(this.message);
}
