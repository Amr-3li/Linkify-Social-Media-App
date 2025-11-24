part of 'get_saved_list_cubit.dart';

@immutable
sealed class GetSavedListState {}

final class GetSavedListInitial extends GetSavedListState {}

final class GetSavedListLoading extends GetSavedListState {}

final class GetSavedListLoaded extends GetSavedListState {
  GetSavedListLoaded(this.postsList);
  final List<PostModel> postsList;
}

final class GetSavedListError extends GetSavedListState {
  GetSavedListError(this.message);
  final String message;
}

final class GetSavedListRefreshed extends GetSavedListState {
  final List<PostModel> postsList;

  GetSavedListRefreshed(this.postsList);
}
