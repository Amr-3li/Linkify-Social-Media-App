part of 'exersiese_cubit.dart';

@immutable
sealed class ExersieseCalculatorState {}

final class ExersieseCalculatorInitial extends ExersieseCalculatorState {}

final class ExersieseCalculatorLoading extends ExersieseCalculatorState {}

final class ExersieseCalculatorLoaded extends ExersieseCalculatorState {
  final ExersieseModelCalculator exersieses;
  ExersieseCalculatorLoaded(this.exersieses);
}

final class ExersieseCalculatorError extends ExersieseCalculatorState {
  final String error;
  ExersieseCalculatorError(this.error);
}
