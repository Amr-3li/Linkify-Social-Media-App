part of 'post_control_cubit.dart';

@immutable
sealed class PostControlState {}

final class PostControlInitial extends PostControlState {}

final class PostControlLoading extends PostControlState {}

final class PostControlSuccess extends PostControlState {}

final class PostControlFailure extends PostControlState {
  final String error;
  PostControlFailure(this.error);
}
