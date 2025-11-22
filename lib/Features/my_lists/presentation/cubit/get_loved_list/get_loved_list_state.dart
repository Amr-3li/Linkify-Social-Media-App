part of 'get_loved_list_cubit.dart';

@immutable
sealed class GetLovedListState {}

final class GetLovedListInitial extends GetLovedListState {}

final class GetLovedListLoading extends GetLovedListState {}

final class GetLovedListLoaded extends GetLovedListState {
  GetLovedListLoaded(this.postsList);
  final List<PostModel> postsList;
}

final class GetLovedListError extends GetLovedListState {
  GetLovedListError(this.message);
  final String message;
}
