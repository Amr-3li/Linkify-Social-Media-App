// ignore_for_file: must_be_immutable

part of 'signup_cubit.dart';

sealed class SignUpState {}

final class SignUpInitial extends SignUpState {}

final class SignUpLoading extends SignUpState {}

final class SignUpSuccess extends SignUpState {}

final class SignUpError extends SignUpState {
  String message;
  SignUpError(this.message);
}
