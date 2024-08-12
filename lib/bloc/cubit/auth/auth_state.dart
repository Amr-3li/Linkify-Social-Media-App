part of 'auth_cubit.dart';

@immutable
sealed class AuthState {}

final class AuthInitial extends AuthState {}
// Login states =================================================================

final class SigninLoading extends AuthState {}

final class SigninSuccess extends AuthState {}

final class SigninFailed extends AuthState {
  final String error;

  SigninFailed(this.error);
}
// Register states =================================================================

final class RegisterLoading extends AuthState {}

final class RegisterSuccess extends AuthState {}

final class RegisterFailed extends AuthState {
  final String error; 

  RegisterFailed(this.error);
}
// Logout states =================================================================

final class SignoutLoading extends AuthState {}

final class SignoutSuccess extends AuthState {}

final class SignoutFailed extends AuthState {
  final String error;

  SignoutFailed(this.error);
}

