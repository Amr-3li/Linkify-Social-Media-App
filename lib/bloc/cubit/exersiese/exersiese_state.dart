part of 'exersiese_cubit.dart';

@immutable
sealed class ExersieseState {}

final class ExersieseInitial extends ExersieseState {}

final class ExersieseLoading extends ExersieseState {}

final class ExersieseLoaded extends ExersieseState {
  final ExersieseModel exersieses;
  ExersieseLoaded(this.exersieses);
}

final class ExersieseError extends ExersieseState {
  final String error;
  ExersieseError(this.error);
}
