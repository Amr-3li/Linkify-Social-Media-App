part of 'add_remove_love_cubit.dart';

@immutable
sealed class AddRemoveLoveState {}

final class AddRemoveLoveInitial extends AddRemoveLoveState {}

final class AddRemoveLoveLoading extends AddRemoveLoveState {}

final class AddRemoveLoveSuccess extends AddRemoveLoveState {}

final class AddRemoveLoveFailure extends AddRemoveLoveState {
  final String errMessage;
  AddRemoveLoveFailure(this.errMessage);
}
