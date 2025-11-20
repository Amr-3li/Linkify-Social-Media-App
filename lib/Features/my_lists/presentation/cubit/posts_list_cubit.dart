// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/repo/get_posts_list_repo.dart';

part 'posts_list_state.dart';

class PostsListCubit extends Cubit<PostsListState> {
  PostsListCubit(
    this.getPostsListRepo,
  ) : super(PostsListInitial());
  final GetPostsListRepo getPostsListRepo;
  final List<PostModel> savedPostsList = [];
  final List<PostModel> likedPostsList = [];
  Future<void> getSavedPostsList() async {
    emit(SavedPostsListLoading());
    final failureOrPostsList = await getPostsListRepo.getSavedPostsList();
    failureOrPostsList.fold(
        (failure) => emit(SavedPostsListError(failure.toString())),
        (postsList) => emit(SavedPostsListLoaded(postsList)));
  }

  Future<void> getLikedPostsList() async {
    emit(LikedPostsListLoading());
    final failureOrPostsList = await getPostsListRepo.getLikedPostsList();
    failureOrPostsList.fold(
      (failure) => emit(LikedPostsListError(failure.toString())),
      (postsList) => emit(LikedPostsListLoaded(postsList)),
    );
  }

  Future<List<PostModel>> refreshLikedPostsList() async {
    throw UnimplementedError();
  }
}
