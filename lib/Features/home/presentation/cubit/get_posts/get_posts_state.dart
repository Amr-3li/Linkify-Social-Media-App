part of 'get_posts_cubit.dart';

@immutable
sealed class GetPostsState {}

final class GetPostsInitial extends GetPostsState {}

final class GetPostsloading extends GetPostsState {}

class GetPostsSuccess extends GetPostsState {
  final List<PostModel> posts;
  final bool isLoadingMore;
  final bool hasMore;

  GetPostsSuccess({
    required this.posts,
    this.isLoadingMore = false,
    this.hasMore = true,
  });

  GetPostsSuccess copyWith({
    List<PostModel>? posts,
    bool? isLoadingMore,
    bool? hasMore,
  }) {
    return GetPostsSuccess(
      posts: posts ?? this.posts,
      isLoadingMore: isLoadingMore ?? this.isLoadingMore,
      hasMore: hasMore ?? this.hasMore,
    );
  }
}

final class GetPostsFailure extends GetPostsState {
  final String error;
  GetPostsFailure(this.error);
}
