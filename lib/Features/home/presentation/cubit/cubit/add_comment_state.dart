part of 'add_comment_cubit.dart';

@immutable
sealed class AddCommentState {}

final class AddCommentInitial extends AddCommentState {}

final class AddCommentLoading extends AddCommentState {}

final class AddCommentFailure extends AddCommentState {
  final String errMessage;
  AddCommentFailure(this.errMessage);
}

final class AddCommentSuccess extends AddCommentState {}
