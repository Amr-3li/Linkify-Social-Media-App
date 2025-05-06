import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/repository/get_post_repo.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:meta/meta.dart';

part 'get_posts_state.dart';

class GetPostsCubit extends Cubit<GetPostsState> {
  GetPostsCubit(this.postRepo) : super(GetPostsInitial());
  final GetPostRepo postRepo;
  List<PostModel> _allPosts = [];
  bool _isLoadingMore = false;
  bool _hasMore = true;

  List<PostModel> get posts => _allPosts;
  bool get hasMore => _hasMore;

  Future<void> loadInitialPosts() async {
    emit(GetPostsloading());
    final result = await postRepo.refreshTimeline();
    result.fold(
      (failure) => emit(GetPostsFailure(failure.errMessage)),
      (data) {
        _allPosts = data;
        _hasMore = data.length >= 5;
        emit(GetPostsSuccess(posts: _allPosts, isLoadingMore: false));
      },
    );
  }

  Future<void> refreshPosts() async {
    emit(GetPostsloading());
    final result = await postRepo.refreshTimeline();
    result.fold(
      (failure) => emit(GetPostsFailure(failure.errMessage)),
      (data) {
        _allPosts = data;
        _hasMore = data.length >= 5;
        emit(GetPostsSuccess(posts: _allPosts, isLoadingMore: false));
      },
    );
  }

  Future<void> loadMorePosts() async {
    if (_isLoadingMore || !_hasMore) return;

    _isLoadingMore = true;
    emit(GetPostsSuccess(posts: _allPosts, isLoadingMore: true));

    final result = await postRepo.getMyTimelinePosts(); // لازم ترجع بس الجديد

    result.fold(
      (failure) {
        _isLoadingMore = false;
        emit(GetPostsFailure(failure.errMessage));
      },
      (newPosts) {
        _isLoadingMore = false;

        // لو مفيش جديد خلاص مفيش حاجة نعملها
        if (newPosts.isEmpty) {
          _hasMore = false;
          emit(GetPostsSuccess(posts: _allPosts, isLoadingMore: false));
          return;
        }

        _allPosts.addAll(newPosts);
        _hasMore = newPosts.length >= 5; // عدل الرقم حسب الlimit اللي شغال بيه

        emit(GetPostsSuccess(posts: _allPosts, isLoadingMore: false));
      },
    );
  }
}
