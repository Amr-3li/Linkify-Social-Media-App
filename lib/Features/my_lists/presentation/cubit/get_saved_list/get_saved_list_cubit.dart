import 'package:bloc/bloc.dart';
import 'package:linkify/Features/home/data/Models/post_model.dart';
import 'package:linkify/Features/my_lists/data/repo/get_posts_list_repo.dart';
import 'package:meta/meta.dart';

part 'get_saved_list_state.dart';

class GetSavedListCubit extends Cubit<GetSavedListState> {
  GetSavedListCubit(this.getPostsListRepo) : super(GetSavedListInitial());
  final GetPostsListRepo getPostsListRepo;
  Future<void> getSavedPostsList() async {
    emit(GetSavedListLoading());
    final failureOrPostsList = await getPostsListRepo.getSavedPostsList();
    failureOrPostsList.fold(
        (failure) => emit(GetSavedListError(failure.toString())),
        (postsList) => emit(GetSavedListLoaded(postsList)));
  }

  Future<void> refresh() async {
    emit(GetSavedListLoading());
    final failureOrPostsList = await getPostsListRepo.refreshSavedPostsList();
    failureOrPostsList.fold(
        (failure) => emit(GetSavedListError(failure.toString())),
        (postsList) => emit(GetSavedListLoaded(postsList)));
  }
}
