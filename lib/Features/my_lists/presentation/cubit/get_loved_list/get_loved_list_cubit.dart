import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/repo/get_posts_list_repo.dart';
import 'package:meta/meta.dart';

part 'get_loved_list_state.dart';

class GetLovedListCubit extends Cubit<GetLovedListState> {
  GetLovedListCubit(this.getPostsListRepo) : super(GetLovedListInitial());
  final GetPostsListRepo getPostsListRepo;
  bool hasMore = true;
  Future<void> getLikedPostsList() async {
    final failureOrPostsList = await getPostsListRepo.getLikedPostsList();
    failureOrPostsList.fold(
      (failure) => emit(GetLovedListError(failure.toString())),
      (postsList) {
        emit(GetLovedListLoaded(postsList));
        if (postsList.isEmpty) {
          hasMore = false;
        }
      },
    );
  }

  Future<void> refresh() async {
    emit(GetLovedListLoading());
    final failureOrPostsList = await getPostsListRepo.refreshLikedPostsList();
    failureOrPostsList.fold(
      (failure) => emit(GetLovedListError(failure.toString())),
      (postsList) {
        emit(GetLovedListRefreshed(postsList));
        if (postsList.isEmpty) {
          hasMore = false;
        }
      },
    );
  }
}
